Date: Mon, 27 Nov 2000 14:23:18 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Hadess <hadess@writeme.com>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Avery Pennarun <apenwarr@worldvisions.ca>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <Pine.LNX.4.10.10011231439040.3480-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10011271404350.16628-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It seems this apm-pmud glue library would solve our problem in user space
> entirely (except for apps that directly cat /proc/apm). The battery status
> commands to the PMU are sent via /dev/adb and I'm not sure how this can
> be safely done from kernel code.

My contribution to kernel bloat ... untested except on Lombard, the 3400
code needs testing and perhaps some work. Overall the code looks pretty
ugly, take it as a proof of concept only and improve as desired. Patch is
against 2.2.18-stable, the proc_register probably needs changing for 2.4.

Result: The vanilla gnome battery_applet now works for me (TM).

	Michael

--- include/linux/proc_fs.h.org	Sun Nov 26 23:05:16 2000
+++ include/linux/proc_fs.h	Sun Nov 26 23:05:40 2000
@@ -50,6 +50,7 @@
 	PROC_PARPORT,
 	PROC_PPC_HTAB,
 	PROC_STRAM,
+	PROC_APM,
 	PROC_SOUND,
 	PROC_MTRR, /* whether enabled or not */
 	PROC_FS
--- drivers/macintosh/via-pmu.c.org	Thu Nov 23 21:23:58 2000
+++ drivers/macintosh/via-pmu.c	Mon Nov 27 14:18:49 2000
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/proc_fs.h>
 #include <linux/miscdevice.h>
 #include <linux/blkdev.h>
 #include <linux/pci.h>
@@ -135,6 +136,7 @@
 static int pmu_set_backlight_enable(int on, int level, void* data);
 #ifdef CONFIG_PMAC_PBOOK
 static void pmu_pass_intr(unsigned char *data, int len);
+static int pmu_get_proc_info(char *buf, char **start, off_t fpos, int length, int dummy);
 #endif

 static struct adb_controller	pmu_controller = {
@@ -331,6 +333,15 @@
 	} while (pmu_state != idle);
 }

+int pmu_get_proc_info(char *, char **, off_t, int, int);
+
+static struct proc_dir_entry proc_apm_info = {
+	PROC_APM, 3, "apm",
+	S_IFREG | S_IRUGO, 1, 0, 0,
+	0, &proc_array_inode_operations,
+	pmu_get_proc_info
+};
+
 static int __openfirmware
 init_pmu()
 {
@@ -372,6 +383,9 @@
 			pmu_poll();
 	}

+#ifdef CONFIG_PMAC_PBOOK
+	proc_register(&proc_root, &proc_apm_info);
+#endif
 	return 1;
 }

@@ -1911,6 +1925,247 @@
 {
 	if (via)
 		misc_register(&pmu_device);
+}
+
+#define APM_CRITICAL		10
+#define APM_LOW			30
+
+static char			driver_version[] = "1.13";	/* no spaces */
+
+static int
+pmu_get_proc_info(char *buf, char **start, off_t fpos, int length, int dummy)
+{
+	char *		p;
+	unsigned short  battery_status = 0xff;
+	unsigned short  battery_flag   = 0xff;
+	int		percentage     = -1;
+	int             time_units     = -1;
+	char            *units         = "?";
+	unsigned short  fake_apm_bios_info_version = (1<<8);
+	unsigned short  fake_apm_bios_info_flags   = 0x0a;
+	int charging, timeleft;
+	int pwr, vb, i, j, len=0, cnt=0;
+
+	struct adb_request req;
+
+	if (vias == NULL)
+		return 0;
+
+	if (pmu_kind == PMU_KEYLARGO_BASED)
+		return 0;
+
+	/*
+	 * The following code has been adapted from the pmud source by Stephan Leemburg.
+	 * It's a bit lengthy and could perhaps be shortened. 3400 code needs testing.
+	 */
+	if (pmu_kind == PMU_OHARE_BASED) {
+		/* 3400: use extended battery request (6b) */
+
+		int pcharge, charge=0;
+		int current=0;
+		int lrange[] = {   0,  275,  850, 1680, 2325,
+				2765, 3160, 3500, 3830, 4115,
+				4360, 4585, 4795, 4990, 5170,
+				5340, 5510, 5710, 5930, 6150,
+				6370, 6500
+				};
+
+		/* assemble request */
+		req.nbytes = 1;
+		req.done = NULL;
+		req.data[0] = PMU_BATTERY_STATE;
+		memset(&req.reply[0], 0, sizeof(req.reply));
+		req.reply_len = 0;
+		req.reply_expected = 1;
+
+		if (pmu_queue_request(&req) != 0) {
+			printk(KERN_ERR "pmu_get_battery_info: pmu_queue_request failed\n");
+			return 0;
+		}
+
+		while (!req.complete)
+			pmu_poll();
+
+		if (!req.reply_len) {
+			printk(KERN_ERR "pmu_get_battery_info: no reply\n");
+			return 0;
+		}
+#ifdef DEBUG_APM
+		printk("pmu_getinfo: reply len %d, data: ", req.reply_len);
+		for (i=0; i<req.reply_len; i++)
+			printk("%x ", req.reply[i]);
+		printk("\n");
+#endif
+		pwr = req.reply[0] & 1;			/* AC indicator */
+		charging = req.reply[0] & 2;
+		vb = (req.reply[1] << 8) + req.reply[2];	/* battery voltage */
+
+		if (!pwr) {
+			if (req.reply[5] > 200)
+		    		vb += ((req.reply[5] - 200) * 15) / 100;
+		} else if (charging)
+			vb -= 10;
+
+		i = (330 - vb) / 10;
+		j = (330 - vb);
+
+		if (i <= 0)
+			charge = 0;
+		else if (i >= 21)
+			charge = 6500;
+		else
+			charge = ((lrange[i+1]-lrange[i])*(j-(10*i))+10*lrange[i])/10;
+		charge = (10000 - charge / 65) / 100;
+
+		if (req.reply[0]&0x40) {
+			pcharge = (req.reply[6] << 8) + req.reply[7];//pcharge
+			if (pcharge > 6500)
+				pcharge = 6500;
+			pcharge = (10000 - pcharge / 65) / 100;
+			if (pcharge < charge)
+				charge = pcharge;
+		}
+		current=req.reply[5];
+		if (!pwr && (current > 0))
+			timeleft = (int)((charge * 274) / current) * 60;
+
+		percentage = charge;
+		if (percentage > 100)
+			percentage = 100;
+	} else {
+		/* wallstreet/lombard, use smart battery request (6f) */
+
+		signed short batt[5], batt1, batt2;
+		unsigned char par;
+		int charge, current, ndata;
+
+		pwr = 0;
+		charge = current = 0;
+		batt1 = batt2 = 0;
+
+		for (i = 0; i < 2; ++i) {
+			par = i + 1;
+
+			/* assemble request */
+			req.nbytes = 2;
+			req.done = NULL;
+			req.data[0] = PMU_SMART_BATT;
+			req.data[1] = par;
+			memset(&req.reply[0], 0, sizeof(req.reply));
+			req.reply_len = 0;
+			req.reply_expected = 1;
+			if (pmu_queue_request(&req) != 0) {
+				printk(KERN_ERR "pmu_get_battery_info: pmu_queue_request failed\n");
+				return 0;
+			}
+
+			while (!req.complete)
+				pmu_poll();
+
+			if (!req.reply_len) {
+				printk(KERN_ERR "pmu_get_battery_info: no reply\n");
+				return 0;
+			}
+#ifdef DEBUG_APM
+			printk("pmu_getinfo (%d): reply len %d, data: ", par, req.reply_len);
+			for (ii=0; ii<req.reply_len; ii++)
+				printk("%x ", req.reply[ii]);
+			printk("\n");
+#endif
+			/* PMU sent length byte; clear */
+			ndata        = req.reply[0];
+			req.reply[0] = 0;
+			memset(&batt[0], 0, sizeof(batt));
+			memcpy(&batt[0], &req.reply[0], req.reply_len);
+#ifdef DEBUG_APM
+			if (ndata > 0) {
+				printk("pmu_getinfo (%d): batt[] = ", par);
+				for (ii=0; ii<ndata; ii++)
+					printk("%d ", batt[ii]);
+				printk("\n");
+			}
+#endif
+			pwr |= batt[0] & 1;
+
+			if (batt[0] & 4) {
+				/* battery present */
+				charge += batt[1];
+				current += batt[3];
+				if (!i) {
+					batt1 = batt[1];
+					batt2 = batt[2];
+				} else {
+					batt1 += batt[1];
+					batt2 += batt[2];
+				}
+				percentage  = batt1 * 100;
+				percentage /= batt2 ? batt2 : 1;
+#ifdef DEBUG_APM
+				printk("pmu_getinfo: battery %d batt1 %d batt2 %d current %d\n",
+					par, batt[1], batt[2], batt[3]);
+#endif
+			}
+		}
+		/* charging flag valid and charging battery? */
+		charging = batt[0] & 0x02;
+		if (current < 0)
+			timeleft = charge * 3552 / -current;
+	}
+
+	/* compile apm pseudo info */
+	time_units = pwr ? 0 : timeleft;
+	units="sec";
+	if (timeleft > 600) {
+		time_units /= 60;
+		units = "min";
+	}
+	if (percentage <= APM_CRITICAL) {
+		battery_status = 0x02;
+		battery_flag  = 0x04;
+	} else if (percentage <= APM_LOW) {
+		battery_status = 0x01;
+		battery_flag  = 0x02;
+	} else {
+		battery_status = 0x00;
+		battery_flag  = 0x01;
+	}
+	if (charging) {
+		battery_status = 0x03;
+		battery_flag  |= 0x08;
+	}
+
+	/* Arguments, with symbols from linux/apm_bios.h. See arch/i386/kernel/apm.c */
+
+	p = buf;
+	len += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+		     driver_version,
+		     (fake_apm_bios_info_version >> 8) & 0xff,
+		     fake_apm_bios_info_version & 0xff,
+		     fake_apm_bios_info_flags,
+		     pwr,
+		     battery_status,
+		     battery_flag,
+		     percentage,
+		     time_units,
+		     units);
+
+	if (len >= fpos) {
+		if (start && !*start) {
+			*start = buf + fpos;
+			cnt = len - fpos;
+		} else {
+			cnt += len;
+		}
+	}
+	return (length > cnt) ? cnt : length;
+}
+
+/* wrapper for hardcoding proc entry in fs/proc/array.c */
+int get_pmuinfo(char *buf)
+{
+	if (pmu_kind == PMU_UNKNOWN)
+		return 0;
+	return pmu_get_proc_info(buf, NULL, 0, 256, 0);
 }
 #endif /* CONFIG_PMAC_PBOOK */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
