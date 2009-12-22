Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2CC37B7BC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:12:18 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 21E37BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:12:13 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/13] mpc52xx: add mpc5200-localplus-test LocalPlus test
	driver
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220812.12676.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:12:12 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The original version was done by Grant Likely. This is a modified
version using the platform LocalPlus driver.

Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 drivers/misc/mpc5200-localplus-test.c |  879 +++++++++++++++++++++++++++++=
++++
 1 files changed, 879 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/mpc5200-localplus-test.c

diff --git a/drivers/misc/mpc5200-localplus-test.c b/drivers/misc/mpc5200-l=
ocalplus-test.c
new file mode 100644
index 0000000..dcfb282
=2D-- /dev/null
+++ b/drivers/misc/mpc5200-localplus-test.c
@@ -0,0 +1,879 @@
+/*
+ * LocalPlusBus performance tests.
+ *
+ * Copyright (C) Secret Lab Technologies Ltd. 2008-2009
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * This file implements a set of LocalPlus bus performance tests when using
+ * direct Programmed IO (PIO), the LocalPlus FIFO, and when using the
+ * Bestcomm DMA engine to transfer data.  It can be compiled into the
+ * kernel or loaded as a module.
+ *
+ * The test module is controlled via files in the sysfs filesystem.
+ * Special control files are created in
+ * /sys/devices/platform/lpbtest.0 which control the tests and report
+ * the results. Test parameters are set by writing values into the
+ * parameter files (blocksize, blockcount, bpt, period, and type).
+ * The test is started and stopped with the 'action' file.  Results
+ * are retrieved by reading the contents of the 'results' file.
+ *
+ * The following parameters can be modified:
+ * blocksize: number of bytes to transfer in each block.
+ * blockcount: number of blocks to transfer per timer tick.
+ * period: period of timer or distance (leading '+') in jiffies
+ *         ("[1-9]{1,}j") or microseconds.  Every timer tick will
+ *         start a new transfer of data blocks. If this value is 0,
+ *         new transfers will be started as quickly as possible using
+ *         a tasklet.
+ * type: type of test; may be 'ram', 'fifo' or 'bcom'.
+ * chipselect: chipselect to use for transfer
+ *
+ * The first test copies contents of an LPB address range using a memcpy.
+ * Usage:
+ * $ echo ram > /sys/devices/platform/lpbtest.0/type
+ * $ echo start > /sys/devices/platform/lpbtest.0/action
+ * $ sleep 5s
+ * $ echo stop > /sys/devices/platform/lpbtest.0/action
+ *
+ * The second test copies contents of an LPB range to RAM using the
+ * LocalPlus FIFO. The FIFO ISR copies each packet from the FIFO to RAM.
+ * Usage:
+ * $ echo fifo > /sys/devices/platform/lpbtest.0/type
+ * $ echo start > /sys/devices/platform/lpbtest.0/action
+ * $ sleep 5s
+ * $ echo stop > /sys/devices/platform/lpbtest.0/action
+ *
+ * The third test copies contents of an LPB range to RAM using both the FI=
=46O
+ * and the Bestcomm DMA engine.
+ *
+ * Usage:
+ * $ echo bcom > /sys/devices/platform/lpbtest.0/type
+ * $ echo start > /sys/devices/platform/lpbtest.0/action
+ * $ sleep 5s
+ * $ echo stop > /sys/devices/platform/lpbtest.0/action
+ *
+ * All sysfs entries can be read by using cat <parameter>
+ * e.g. cat /sys/devices/platform/lpbtest.0/type will show the test type
+ *
+ * The following is a useful command to dump out all the state of the modu=
le:
+ * $ grep '' *
+ *
+ */
+
+// #define DEBUG
+
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/mempool.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <sysdev/bestcomm/bestcomm.h>
+#include <sysdev/bestcomm/gen_bd.h>
+#include <sysdev/bestcomm/bestcomm_priv.h>
+#include <asm/page.h>
+#include <asm/time.h>
+#include <asm/cacheflush.h>
+#include <asm/div64.h>
+
+MODULE_AUTHOR("Steven Cavanagh <scavan...@secretlab.ca>");
+MODULE_LICENSE("GPL");
+
+
+#define DRVNAME "lpbtest"
+
+#define LPBTEST_FLASH_BASE_ADDR		(0xff000000)
+#define LPBTEST_FLASH_SIZE		(0x01000000)	/* 16 MiB */
+
+#define LPBTEST_BLOCK_SIZE_MIN		4
+#define LPBTEST_BLOCK_SIZE_MAX		(0x20000)	/* 128 KiB */
+
+#define LPBTEST_JIFFIES_MIN		0
+
+/* Address of SCLPC relative to MBAR
+ *
+ * TODO: move to OF tree?
+ */
+#define MPC52xx_SCLPC_OFFSET		0x3C00
+
+
+/**
+ * lpbtest - Private driver data
+ * @lpb_regs_base: pointer to the LPB's registers
+ * @irq: IRQ of this LPB FIFO
+ * @dev: struct device pointer
+ */
+struct lpbtest {
+	struct device *dev;
+
+	/* sysfs attributes */
+	int action;
+	size_t type;
+	int write;		/* true for write test */
+	size_t blockcount;
+	size_t blocksize;
+	unsigned long period;	/* in jiffies */
+	int period_us;		/* true: period is in us, false: in jiffies */
+	int period_delta;	/* true: period is time between the
+				 * transactions, false: tme between
+				 * start of two transactions */
+	unsigned int chipselect;
+	int verify;
+
+	spinlock_t lock;
+
+	void *ram_virt;
+
+	void *dev_virt;
+	phys_addr_t dev_phys;
+
+	struct mpc52xx_lpbfifo_request req;
+
+	/* Timeslice timer */
+	struct timer_list timer;
+	unsigned long tnext;		/* next deadline; in jiffies */
+
+	/* Statistics */
+	unsigned long irq_time;
+	unsigned long timer_time;
+	unsigned long bcom_time;
+	unsigned long start_time;
+	unsigned long stop_time;
+	unsigned long long data_read;
+	int overrun_count;
+
+	/* state variables */
+	size_t next_block;	/* Number of next block to send. If
+				 * this is >=3D blockcount, then all the
+				 * transfers are finished */
+
+	size_t rcvd_blocks;	/* Number of blocks received. */
+};
+
+/* Helper functions to test selected behaviour */
+static inline int lpbtest_isfifo(struct lpbtest *priv)
+{
+	return priv->type =3D=3D 1;
+}
+
+
+static void lpbtest_stop(struct lpbtest *priv)
+{
+	priv->stop_time =3D get_tbl();
+	dev_dbg(priv->dev, "%s() stop_time=3D%lu\n", __FUNCTION__, priv->stop_tim=
e);
+}
+
+
+static inline unsigned long lpbtest_period_in_jiffies(struct lpbtest *priv)
+{
+	return priv->period_us ? usecs_to_jiffies(priv->period) : priv->period;
+}
+
+
+/* Start timer. In case finished is false this routine is called at
+ * the start of a transfer, if finished is true at the end of a
+ * transfer.
+ *
+ * In the first case we only start the timer if a period >
+ * LPBTEST_PERIOD_ISO_LIMIT is set, in the second case we only start
+ * the timer if a period <=3D LPBTEST_PERIOD_ISO_LIMIT is set.
+ */
+static void lpbtest_start_timer(struct lpbtest *priv, int finished)
+{
+	int ret;
+	if (finished) {
+		if (priv->period_delta) {
+			priv->tnext =3D lpbtest_period_in_jiffies(priv);
+#if LPBTEST_JIFFIES_MIN
+			if (priv->tnext < LPBTEST_JIFFIES_MIN)
+				priv->tnext =3D LPBTEST_JIFFIES_MIN;
+#endif
+			priv->tnext +=3D jiffies;
+			ret =3D mod_timer(&priv->timer, priv->tnext);
+			dev_dbg(priv->dev, "%s(%d): j=3D%lu tnext=3D%lu r=3D%d\n", __FUNCTION__=
, finished, jiffies, priv->tnext, ret);
+			return;
+		}
+	}
+	else {
+		if (!priv->period_delta) {
+			priv->tnext +=3D lpbtest_period_in_jiffies(priv);
+			/* dev_dbg(dev, "%s: jiffies=3D%lu time=3D%lu\n", __FUNCTION__, jiffies=
, priv->tnext); */
+			if (time_is_before_jiffies(priv->tnext)) {
+				dev_err(priv->dev, "Timeslice overrun by %i us; aborting\n",
+					jiffies_to_usecs(jiffies - priv->tnext));
+				lpbtest_stop(priv);
+				return;
+			}
+
+			ret =3D mod_timer(&priv->timer, priv->tnext);
+			dev_dbg(priv->dev, "%s(%d): j=3D%lu tnext=3D%lu r=3D%d\n", __FUNCTION__=
, finished, jiffies, priv->tnext, ret);
+			return;
+		}
+	}
+
+	dev_dbg(priv->dev, "%s(%d): j=3D%lu no action\n", __FUNCTION__, finished,=
 jiffies);
+}
+
+static inline int lpbtest_check_stop(struct device *dev)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	dev_dbg(dev, "%s()\n", __FUNCTION__);
+
+	if (!priv->action) {
+		lpbtest_stop(priv);
+		return 1;
+	}
+
+	return 0;
+}
+
+
+static void lpbtest_read_channels_to_ram(unsigned long _dev)
+{
+	struct device *dev =3D (struct device *)_dev;
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	int i;
+
+	dev_dbg(dev, "%lu: %s()\n", jiffies, __FUNCTION__);
+
+	if (!lpbtest_check_stop(dev)) {
+		const unsigned long tstart =3D get_tbl();
+
+		lpbtest_start_timer(priv, 0);
+
+		/* Assume, that all channels have data available */
+		for (i =3D 0; i < priv->blockcount; i++) {
+			memcpy(priv->ram_virt, priv->dev_virt, priv->blocksize);
+			priv->data_read +=3D priv->blocksize;
+		}
+
+		priv->timer_time +=3D get_tbl() - tstart;
+
+		lpbtest_start_timer(priv, 1);
+	}
+}
+
+
+static void lpbtest_fifo_done(struct mpc52xx_lpbfifo_request *req)
+{
+	struct lpbtest *priv =3D req->priv;
+
+	// dev_info(priv->dev, "%s()\n", __FUNCTION__);
+
+	if (priv->verify) {
+		if (memcmp(priv->ram_virt, priv->dev_virt, priv->blocksize)) {
+			print_hex_dump(KERN_INFO, "RAM: ", DUMP_PREFIX_OFFSET,
+				       16, sizeof(uint32_t),
+				       priv->ram_virt, priv->blocksize, 0);
+			print_hex_dump(KERN_INFO, "DEV: ", DUMP_PREFIX_OFFSET,
+				       16, sizeof(uint32_t),
+				       priv->dev_virt, priv->blocksize, 0);
+		}
+		else {
+			/* dev_info(priv->dev, "memcmp OK\n"); */
+		}
+	}
+
+	lpbtest_start_timer(priv, 1);
+}
+
+
+static void lpbtest_do_next_transfer(struct lpbtest *priv)
+{
+	dev_dbg(priv->dev, "%s()\n", __FUNCTION__);
+
+	if (priv->next_block < priv->blockcount) {
+
+		int err;
+		struct mpc52xx_lpbfifo_request *req =3D &priv->req;
+
+		memset(req, 0, sizeof(*req));
+		req->cs =3D priv->chipselect;
+		req->offset =3D priv->dev_phys - LPBTEST_FLASH_BASE_ADDR;
+		req->data =3D priv->ram_virt;
+		req->size =3D priv->blocksize;
+		req->pos =3D 0;
+		req->flags =3D MPC52XX_LPBFIFO_FLAG_NO_INCREMENT;
+		req->flags |=3D priv->write ? MPC52XX_LPBFIFO_FLAG_WRITE : MPC52XX_LPBFI=
=46O_FLAG_READ;
+		if (lpbtest_isfifo(priv))
+			req->flags |=3D MPC52XX_LPBFIFO_FLAG_NO_DMA;
+		req->callback =3D lpbtest_fifo_done;
+		req->priv =3D priv;
+
+		priv->next_block++;
+		dev_dbg(priv->dev, "%s: next_block=3D%zu\n", __FUNCTION__, priv->next_bl=
ock);
+
+		memset(priv->ram_virt, 0x55, priv->blocksize);
+		err =3D mpc52xx_lpbfifo_submit(req);
+		if (err) {
+			dev_err(priv->dev, "cannot submit FIFO request: %d\n", err);
+			lpbtest_stop(priv);
+		}
+	}
+}
+
+static void lpbtest_read_channels(unsigned long _dev)
+{
+	struct device *dev =3D (struct device *)_dev;
+
+	dev_dbg(dev, "%lu: %s()\n", jiffies, __FUNCTION__);
+
+	if (!lpbtest_check_stop(dev)) {
+		struct lpbtest *priv =3D dev_get_drvdata(dev);
+		const unsigned long tstart =3D get_tbl();
+
+		lpbtest_start_timer(priv, 0);
+
+		/* This line is the FIFO throttle, the faster the next packet
+		 * is cleared, the faster the FIFO can be read and filled by
+		 * the IRQ.  The ISR will stop handling the FIFO, when all the
+		 * channels have been read.
+		 */
+		priv->next_block =3D priv->rcvd_blocks =3D 0;
+		// dev_dbg(dev, "%s: next_block=3D%zu\n", __FUNCTION__, priv->next_block=
);
+		lpbtest_do_next_transfer(priv);
+
+		priv->timer_time +=3D get_tbl() - tstart;
+	}
+}
+
+
+static const struct lpbtest_type {
+	char *name;
+	void (*test_timer)(unsigned long);
+} lpbtest_type[] =3D {
+	{
+		.name =3D "ram",
+		.test_timer =3D lpbtest_read_channels_to_ram,
+	},
+	{
+		.name =3D "fifo",
+		.test_timer =3D lpbtest_read_channels,
+	},
+	{
+		.name =3D "bcom",
+		.test_timer =3D lpbtest_read_channels,
+	}
+};
+
+/* ---------------------------------------------------------------------
+ * sysfs interfaces
+ * --------------------------------------------------------------------- */
+static ssize_t lpbtest_set_type(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	const char *name;
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(lpbtest_type); i++) {
+		name =3D lpbtest_type[i].name;
+
+		if (count < strlen(name))
+			continue;
+
+		if (strncmp(buf, name, strlen(name)) =3D=3D 0) {
+			priv->type =3D i;
+			return count;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t lpbtest_show_type(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", lpbtest_type[priv->type].name);
+}
+
+static ssize_t lpbtest_set_dir(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	if (strncmp(buf, "read", strlen("read")) =3D=3D 0) {
+		priv->write =3D 0;
+	}
+	else if (strncmp(buf, "write", strlen("write")) =3D=3D 0) {
+		priv->write =3D 1;
+	}
+	else {
+		dev_err(dev, "Usage: echo [read,write] > dir\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t lpbtest_show_dir(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%s\n", priv->write ? "write" : "read");
+}
+
+static ssize_t lpbtest_set_action(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	const struct lpbtest_type *type =3D &lpbtest_type[priv->type];
+	int oldaction =3D priv->action;
+
+	if (strncmp(buf, "start", strlen("start")) =3D=3D 0) {
+		priv->action =3D 1;
+	}
+	else if (strncmp(buf, "stop", strlen("stop")) =3D=3D 0) {
+		priv->action =3D 0;
+	}
+	else {
+		dev_err(dev, "Usage: echo [start,stop] > action\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%s: action=3D%d->%d\n", __FUNCTION__, oldaction, priv->acti=
on);
+
+	if (oldaction !=3D priv->action) {
+		oldaction =3D priv->action;
+
+		if (priv->action) {
+			init_timer(&priv->timer);
+			priv->timer.function =3D type->test_timer;
+			priv->timer.data =3D (unsigned long)dev;
+
+			priv->next_block =3D priv->rcvd_blocks =3D 0;
+			priv->irq_time =3D 0;
+			priv->timer_time =3D 0;
+			priv->bcom_time =3D 0;
+			priv->stop_time =3D priv->start_time =3D get_tbl();
+			priv->data_read =3D 0;
+			priv->overrun_count =3D 0;
+
+			/* Map the device */
+			priv->dev_virt =3D ioremap(priv->dev_phys, LPBTEST_BLOCK_SIZE_MAX);
+			if (!priv->dev_virt) {
+				dev_err(dev, "Error mapping device\n");
+				return -ENOMEM;
+			}
+
+			printk(KERN_INFO "Started %s test, blocksize=3D0x%zx\n", type->name, pr=
iv->blocksize);
+
+			/* Set the expiration time for the timer. */
+			priv->tnext =3D jiffies + 1;
+			mod_timer(&priv->timer, priv->tnext);
+
+		}
+		else {
+			del_timer_sync(&priv->timer);
+			lpbtest_stop(priv);
+
+			printk(KERN_INFO "Stopped %s test, blocksize=3D0x%zx\n", type->name, pr=
iv->blocksize);
+		}
+	}
+
+	return count;
+}
+
+static ssize_t lpbtest_show_action(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	char *action;
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	action =3D (priv->action =3D=3D 1) ? "start" : "stop";
+	return sprintf(buf, "%s\n", action);
+}
+
+/*
+ * Export a blockcount attr
+ */
+static ssize_t lpbtest_set_blockcount(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (strict_strtoul(buf, 10, &temp))
+		return -EINVAL;
+	priv->blockcount =3D temp;
+
+	return count;
+}
+
+static ssize_t lpbtest_show_blockcount(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%zu\n", priv->blockcount);
+}
+
+/*
+ * Export a blocksize attr
+ */
+static ssize_t lpbtest_set_blocksize(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (strict_strtoul(buf, 0, &temp))
+		return -EINVAL;
+
+	if (temp < LPBTEST_BLOCK_SIZE_MIN || temp > LPBTEST_BLOCK_SIZE_MAX)
+		return -EINVAL;
+
+	priv->blocksize =3D temp;
+	return count;
+}
+
+static ssize_t lpbtest_show_blocksize(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%zu\n", priv->blocksize);
+}
+
+static ssize_t lpbtest_set_period(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	unsigned long temp;
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	const char *pb =3D buf;
+	char *pe;
+
+	priv->period_delta =3D 0;
+	if (*pb =3D=3D '+') {
+		priv->period_delta =3D 1;
+		pb++;
+	}
+	temp =3D simple_strtoul(pb, &pe, 10);
+	if (buf =3D=3D pe) {
+		dev_err(dev, "period \"%s\" empty?\n", buf);
+		return -EINVAL;
+	}
+
+	if (*pe =3D=3D 'j') {
+		priv->period_us =3D 0;
+	}
+	else if (isspace(*pe) || *pe =3D=3D '\0') {
+		priv->period_us =3D 1;
+	}
+	else {
+		dev_err(dev, "period \"%s\" invalid\n", buf);
+		return -EINVAL;
+	}
+
+	priv->period =3D temp;
+	dev_dbg(dev, "period \"%s\" =3D %s%lu %s\n",
+		buf,
+		priv->period_delta ? "+" : "", temp,
+		priv->period_us ? "us" : "j");
+
+	return count;
+}
+
+static ssize_t lpbtest_show_period(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%s%lu%s\n",
+		       priv->period_delta ? "+" : "",
+		       priv->period,
+		       priv->period_us ? "" : "j");
+}
+
+static ssize_t lpbtest_set_cs(struct device *dev, struct device_attribute =
*attr,
+			      const char *buf, size_t count)
+{
+	unsigned long temp;
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	if (strict_strtoul(buf, 0, &temp))
+		return -EINVAL;
+
+	if (temp > 7)
+		return -EINVAL;
+
+	priv->chipselect =3D temp;
+	return count;
+}
+
+static ssize_t lpbtest_show_cs(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%u\n", priv->chipselect);
+}
+
+static ssize_t lpbtest_set_baseaddr(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	unsigned long temp;
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	if (strict_strtoul(buf, 0, &temp))
+		return -EINVAL;
+
+	priv->dev_phys =3D temp;
+	return count;
+}
+
+static ssize_t lpbtest_show_baseaddr(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%llx\n", (unsigned long long) priv->dev_phys);
+}
+
+static ssize_t lpbtest_set_verify(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (strict_strtoul(buf, 10, &temp))
+		return -EINVAL;
+
+	priv->verify =3D temp;
+	return count;
+}
+
+static ssize_t lpbtest_show_verify(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	return sprintf(buf, "%d\n", priv->verify);
+}
+
+static ssize_t lpbtest_show_results(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+	int c;
+	unsigned long systime;
+	unsigned long realtime;
+	unsigned int utilization;
+	unsigned long rate;
+	unsigned long netrate;
+	unsigned long long tmp;
+
+	realtime =3D priv->stop_time - priv->start_time;
+	systime =3D priv->timer_time + priv->irq_time + priv->bcom_time;
+
+	if (!realtime) {
+		realtime =3D get_tbl() - priv->start_time;
+	}
+
+	if (realtime) {
+		tmp =3D systime * 10000ULL;
+		do_div(tmp, realtime);
+		utilization =3D tmp;
+
+		tmp =3D priv->data_read;
+		tmp *=3D tb_ticks_per_usec;
+		tmp *=3D 100;
+		do_div(tmp, realtime);
+		rate =3D tmp;
+	}
+	else {
+		utilization =3D 0;
+		rate =3D 0;
+	}
+
+	if (systime) {
+		tmp =3D priv->data_read;
+		tmp *=3D tb_ticks_per_usec;
+		tmp *=3D 100;
+		do_div(tmp, systime);
+		netrate =3D tmp;
+	}
+	else {
+		netrate =3D 0;
+	}
+
+	c =3D sprintf(buf,      "real\t\t:\t%10lu ticks\t%9lu us\n",
+		    realtime, realtime / tb_ticks_per_usec);
+	c +=3D sprintf(buf + c, "sys\t\t:\t%10lu ticks\t%9lu us\n",
+		     systime, systime / tb_ticks_per_usec);
+	c +=3D sprintf(buf + c, "timer\t\t:\t%10lu ticks\t%9lu us\n",
+		     priv->timer_time, priv->timer_time / tb_ticks_per_usec);
+	c +=3D sprintf(buf + c, "fifo irq\t:\t%10lu ticks\t%9lu us\n",
+		     priv->irq_time, priv->irq_time / tb_ticks_per_usec);
+	c +=3D sprintf(buf + c, "bcom irq\t:\t%10lu ticks\t%9lu us\n",
+		     priv->bcom_time, priv->bcom_time / tb_ticks_per_usec);
+	c +=3D sprintf(buf + c, "overruns\t:\t%10u\n", priv->overrun_count);
+	c +=3D sprintf(buf + c, "%%CPU\t\t:\t%10u.%.2u %%\n",
+		     utilization / 100, utilization % 100);
+	c +=3D sprintf(buf + c, "byte count\t:\t%10llu\n", priv->data_read);
+	c +=3D sprintf(buf + c, "net data rate\t:\t%10lu.%.2lu MB/s\n",
+		     rate / 100, rate % 100);
+	c +=3D sprintf(buf + c, "max data rate\t:\t%10lu.%.2lu MB/s\n",
+		     netrate / 100, netrate % 100);
+
+	return c;
+}
+
+static struct device_attribute lpbtest_attrib[] =3D {
+	__ATTR(action, S_IWUSR | S_IRUGO,
+	       lpbtest_show_action, lpbtest_set_action),
+	__ATTR(blockcount, S_IWUSR | S_IRUGO,
+	       lpbtest_show_blockcount, lpbtest_set_blockcount),
+	__ATTR(blocksize, S_IWUSR | S_IRUGO,
+	       lpbtest_show_blocksize, lpbtest_set_blocksize),
+	__ATTR(period, S_IWUSR | S_IRUGO,
+	       lpbtest_show_period, lpbtest_set_period),
+	__ATTR(chipselect, S_IWUSR | S_IRUGO,
+	       lpbtest_show_cs, lpbtest_set_cs),
+	__ATTR(baseaddr, S_IWUSR | S_IRUGO,
+	       lpbtest_show_baseaddr, lpbtest_set_baseaddr),
+	__ATTR(verify, S_IWUSR | S_IRUGO,
+	       lpbtest_show_verify, lpbtest_set_verify),
+	__ATTR(type, S_IWUSR | S_IRUGO,
+	       lpbtest_show_type, lpbtest_set_type),
+	__ATTR(dir, S_IWUSR | S_IRUGO,
+	       lpbtest_show_dir, lpbtest_set_dir),
+	__ATTR(results, S_IWUSR | S_IRUGO,
+	       lpbtest_show_results, NULL),
+};
+
+static void lpbtest_cleanup_sysfs(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(lpbtest_attrib); i++)
+		device_remove_file(dev, &lpbtest_attrib[i]);
+}
+
+static int lpbtest_setup(struct device *dev)
+{
+	struct lpbtest *priv =3D dev_get_drvdata(dev);
+
+	/* Allocate a destination buffer */
+	priv->ram_virt =3D kzalloc(LPBTEST_BLOCK_SIZE_MAX, GFP_KERNEL);
+	if (!priv->ram_virt) {
+		dev_err(dev, "Error allocating test buffer\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __devinit lpbtest_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct lpbtest *priv;
+
+	int ret =3D 0, i;
+
+	/* Allocate and initialize the driver private data */
+	priv =3D kzalloc(sizeof *priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev =3D dev;
+	priv->blockcount =3D 16;
+	priv->blocksize =3D MPC52xx_SCLPC_FIFO_SIZE;
+	priv->period  =3D 20000;
+	priv->period_us =3D 1;
+	priv->period_delta =3D 0;
+	priv->dev_phys =3D LPBTEST_FLASH_BASE_ADDR;
+
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(pdev, priv);
+
+	ret =3D lpbtest_setup(dev);
+	if (ret) {
+		dev_err(dev, "lpbtest_setup() error\n");
+		return ret;
+	}
+
+	/* Register the SYSFS files */
+	for (i =3D 0; i < ARRAY_SIZE(lpbtest_attrib); i++) {
+		ret =3D device_create_file(dev, &lpbtest_attrib[i]);
+		if (ret) {
+			dev_err(dev, "error creating sysfs files (%d)\n", ret);
+			lpbtest_cleanup_sysfs(pdev);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int __devexit lpbtest_remove(struct platform_device *pdev)
+{
+	struct lpbtest *priv =3D platform_get_drvdata(pdev);
+
+	lpbtest_cleanup_sysfs(pdev);
+
+	del_timer(&priv->timer);
+
+	kfree(priv->ram_virt);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct platform_driver lpbtest_driver =3D {
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name  =3D DRVNAME,
+	},
+	.probe  =3D lpbtest_probe,
+	.remove =3D __devexit_p(lpbtest_remove),
+};
+
+static struct platform_device *lpbtest_pdev;
+
+
+static int __init lpbtest_init(void)
+{
+	int rc;
+
+	printk(KERN_INFO "%s init\n", DRVNAME);
+
+	lpbtest_pdev =3D platform_device_register_simple(DRVNAME, 0, NULL, 0);
+	if (!lpbtest_pdev) {
+		pr_err("%s: error registering test device\n", DRVNAME);
+		return -ENOMEM;
+	}
+
+	rc =3D platform_driver_register(&lpbtest_driver);
+	if (rc)
+		platform_device_unregister(lpbtest_pdev);
+	return rc;
+}
+
+static void lpbtest_exit(void)
+{
+	platform_device_unregister(lpbtest_pdev);
+	platform_driver_unregister(&lpbtest_driver);
+}
+
+module_init(lpbtest_init);
+module_exit(lpbtest_exit);
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
