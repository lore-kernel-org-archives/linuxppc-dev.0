Message-Id: <200009122044.WAA00841@piglet.grunz.lu>
Date: Tue, 12 Sep 2000 22:44:54 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: sysctl support for ICTC
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-968791500=:761"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-968791500=:761
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

As an exercise ;-), I've added sysctl support for controlling and
displaying the contents of the G3 (and G4?) ICTC register.

What this register does: it slows down the rate at which instruction are
taken out of the L1 instruction cache for execution. Bit 31 (lowets bit)
enables the feature, the next 8 bits (23-31) define the number of clock
cycles to wait between instruction fetches.

Why it is useful: when combined with DPM (dynamic power management), the
effect of reducing the instrucion fetch rate is that DPM will more often
shut down the various execution units while being idle, thus reducing
power consumption and heat dissipation. This is good for battery life in
portable applications, since there's less power consumed in the
processor, and the fan can stay off (if combined with temperature
monitoring).

So, managing ICTC could be part of an intelligent apmd-style daemon
specifically for PPC.

If anyone wants to go ahead and implement that daemon, attached is the
ICTC part already ;-) It's a patch against kernel.org 2.2.17. It is
nothing intelligent, rather a copy of the existing l2cr support. It adds
an entry under the proc filesystem:

[mlan@piglet ~]$  cat /proc/sys/kernel/ictc
Instruction Cache Throttling Control:

0x0000000a:  disabled, delay: 5 clock cycles.

New values can be written thus:

[root@piglet /home/mlan]# echo 10 >/proc/sys/kernel/ictc


Have fun!

Michel

PS Also posted on sourceforge.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-968791500=:761
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="ictc.diff"

--- linux-2.2.17-pristine/kernel/sysctl.c	Thu Sep  7 19:49:43 2000
+++ linux-2.2.17/kernel/sysctl.c	Tue Sep 12 20:37:08 2000
@@ -59,6 +59,8 @@
 extern unsigned long htab_reclaim_on, zero_paged_on, powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);
 #endif

 #ifdef CONFIG_BSD_PROCESS_ACCT
@@ -199,6 +201,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
 	 0644, NULL, &proc_dol2crvec},
+	{KERN_PPC_ICTC, "ictc", NULL, 0,
+	 0644, NULL, &proc_doictcvec},
 #endif
 	{KERN_CTLALTDEL, "ctrl-alt-del", &C_A_D, sizeof(int),
 	 0644, NULL, &proc_dointvec},
--- linux-2.2.17-pristine/include/linux/sysctl.h	Thu Sep  7 19:49:42 2000
+++ linux-2.2.17/include/linux/sysctl.h	Tue Sep 12 20:36:06 2000
@@ -106,6 +106,7 @@
 	KERN_SYSRQ=38,		/* int: Sysreq enable */
 	KERN_SHMALL=41,		/* int: maximum size of shared memory */
 	KERN_SPARC_STOP_A=44,	/* int: Sparc Stop-A enable */
+	KERN_PPC_ICTC=45,	/* ictc register on PPC */
 };


--- linux-2.2.17-pristine/arch/ppc/kernel/ppc_htab.c	Thu Sep  7 20:35:30 2000
+++ linux-2.2.17/arch/ppc/kernel/ppc_htab.c	Tue Sep 12 22:32:16 2000
@@ -35,6 +35,8 @@
 static long long ppc_htab_lseek(struct file * file, loff_t offset, int orig);
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp);

 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
@@ -530,7 +532,7 @@
 		  void *buffer, size_t *lenp)
 {
 	int vleft, first=1, len, left, val;
-	#define TMPBUFLEN 256
+	#define TMPBUFLEN 512
 	char buf[TMPBUFLEN], *p;
 	static const char *sizestrings[4] = {
 		"unknown size", "256KB", "512KB", "1MB"
@@ -596,20 +598,118 @@
 			if (!first)
 				*p++ = '\t';
 			val = _get_L2CR();
-			p += sprintf(p, "%08x: ", val);
-			p += sprintf(p, " %s",
-				     (val&0x80000000)?"enabled":"disabled");
-			p += sprintf(p,",%sparity",(val&0x40000000)?"":"no ");
-			p += sprintf(p, ",%s", sizestrings[(val >> 28) & 3]);
-			p += sprintf(p, ",%s", clockstrings[(val >> 25) & 7]);
-			p += sprintf(p, ",%s", typestrings[(val >> 23) & 0x2]);
-			p += sprintf(p,"%s",(val>>22)&1?"":",data only");
-			p += sprintf(p,"%s",(val>>20)&1?",ZZ enabled":"");
-			p += sprintf(p,",%s",(val>>19)&1?"write-through":"copy-back");
-			p += sprintf(p,",%sns hold", holdstrings[(val>>16)&3]);
-
-			p += sprintf(p,"\n");
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", (val >> 31) & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", %sparity", (val>>30)&1 ? "" : "no ");
+			p += sprintf(p, ", %s", sizestrings[(val >> 28) & 3]);
+			p += sprintf(p, ", %s", clockstrings[(val >> 25) & 7]);
+			p += sprintf(p, ", %s", typestrings[(val >> 23) & 2]);
+			p += sprintf(p, "%s", (val>>22)&1 ? ", data only" : "");
+			p += sprintf(p, "%s", (val>>20)&1 ? ", ZZ enabled": "");
+			p += sprintf(p, ", %s", (val>>19)&1 ? "write-through" :
+					"copy-back");
+			p += sprintf(p, "%s", (val>>18)&1 ? ", testing" : "");
+			p += sprintf(p, ", %sns hold",holdstrings[(val>>16)&3]);
+			p += sprintf(p, "%s", (val>>15)&1 ? ", DLL slow" : "");
+			p += sprintf(p, "%s", (val>>14)&1 ? ", diff clock" :"");
+			p += sprintf(p, "%s", (val>>13)&1 ? ", DLL bypass" :"");

+			p += sprintf(p, "\n");
+
+			len = strlen(buf);
+			if (len > left)
+				len = left;
+			if(copy_to_user(buffer, buf, len))
+				return -EFAULT;
+			left -= len;
+			buffer += len;
+			break;
+		}
+	}
+
+	if (!write && !first && left) {
+		if(put_user('\n', (char *) buffer))
+			return -EFAULT;
+		left--, buffer++;
+	}
+	if (write) {
+		p = (char *) buffer;
+		while (left) {
+			char c;
+			if(get_user(c, p++))
+				return -EFAULT;
+			if (!isspace(c))
+				break;
+			left--;
+		}
+	}
+	if (write && first)
+		return -EINVAL;
+	*lenp -= left;
+	filp->f_pos += *lenp;
+	return 0;
+}
+
+int proc_doictcvec(ctl_table *table, int write, struct file *filp,
+		  void *buffer, size_t *lenp)
+{
+	int vleft, first=1, len, left, val;
+	#define TMPBUFLEN 128
+	char buf[TMPBUFLEN], *p;
+
+	if ( ((_get_PVR() >> 16) != 8) && ((_get_PVR() >> 16) != 12))
+		return -EFAULT;
+
+	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	vleft = table->maxlen / sizeof(int);
+	left = *lenp;
+
+	for (; left /*&& vleft--*/; first=0) {
+		if (write) {
+			while (left) {
+				char c;
+				if(get_user(c,(char *) buffer))
+					return -EFAULT;
+				if (!isspace(c))
+					break;
+				left--;
+				((char *) buffer)++;
+			}
+			if (!left)
+				break;
+			len = left;
+			if (len > TMPBUFLEN-1)
+				len = TMPBUFLEN-1;
+			if(copy_from_user(buf, buffer, len))
+				return -EFAULT;
+			buf[len] = 0;
+			p = buf;
+			if (*p < '0' || *p > '9')
+				break;
+			val = simple_strtoul(p, &p, 0);
+			len = p-buf;
+			if ((len < left) && *p && !isspace(*p))
+				break;
+			buffer += len;
+			left -= len;
+			_set_ICTC(val);
+
+		} else {
+			p = buf;
+			if (!first)
+				*p++ = '\t';
+			val = _get_ICTC();
+			p += sprintf(p, "Instruction Cache Throttling Control:\n\n");
+			p += sprintf(p, "0x%08x: ", val);
+			p += sprintf(p, " %s", val & 1 ? "enabled" :
+				     	"disabled");
+			p += sprintf(p, ", delay: %d clock cycles.\n",
+					(val >> 1) & 255 );
 			len = strlen(buf);
 			if (len > left)
 				len = left;

--134458388-1804289383-968791500=:761--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
