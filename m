Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2A0A267BD5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Dec 2006 04:59:57 +1100 (EST)
Date: Fri, 15 Dec 2006 11:59:02 -0600
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Message-ID: <20061215115902.688f1a34@pb15>
In-Reply-To: <B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
References: <20061213190408.1d4ddd93.kim.phillips@freescale.com>
	<B38E3DDE-A18F-4319-A968-B0C22C001391@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2006 10:09:09 -0600 Kumar Gala <galak@kernel.crashing.org> wrote:

> > +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
> > +extern ulong ds1374_get_rtc_time(void);
> > +extern int ds1374_set_rtc_time(ulong);
> > +
> > +static int __init mpc83xx_rtc_hookup(void)
> > +{
> > +	struct timespec tv;
> > +
> > +	ppc_md.get_rtc_time = ds1374_get_rtc_time;
> > +	ppc_md.set_rtc_time = ds1374_set_rtc_time;
> > +
> > +	tv.tv_nsec = 0;
> > +	tv.tv_sec = (ppc_md.get_rtc_time) ();
> > +	do_settimeofday(&tv);
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(mpc83xx_rtc_hookup);
> > +#endif  
> 
> This is sort of evil and we need to clean it up, but we have some  
> time for 2.6.21.  Does the MPC832x MDS have the DS1374?

s/sort of/pure/

Something like this should work just as well. Seems to work fine on my
system here (that has a DS1338, i.e. ds1307 driver).

Let me know if it works on 83xx and I'll post it with a signed-off-line.



-Olof




Index: linux-2.6/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -600,6 +600,12 @@ config PPC_TODC
 	---help---
 	  This adds support for many TODC/RTC chips.
 
+config PPC_GENRTC
+	bool "Generic RTC support"
+	help
+	  This adds support for using regular RTC registered with the RTC
+	  framework as the main clock on powerpc.
+
 endmenu
 
 source arch/powerpc/platforms/embedded6xx/Kconfig
Index: linux-2.6/arch/powerpc/sysdev/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/Makefile
+++ linux-2.6/arch/powerpc/sysdev/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_PPC_GENRTC)	+= genrtc.o
 obj-$(CONFIG_PPC_TODC)		+= todc.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
Index: linux-2.6/arch/powerpc/sysdev/genrtc.c
===================================================================
--- /dev/null
+++ linux-2.6/arch/powerpc/sysdev/genrtc.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/time.h>
+#include <linux/device.h>
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+static struct class_device *rtc_dev;
+
+static void genrtc_set_rtc_time_work(void *arg);
+
+static struct rtc_time delayed_tm;
+static struct workqueue_struct *rtc_workqueue;
+static DECLARE_WORK(rtc_work, genrtc_set_rtc_time_work, &delayed_tm);
+
+static void genrtc_set_rtc_time_work(void *arg)
+{
+	struct rtc_time *tm = arg;
+	rtc_set_time(rtc_dev, tm);
+}
+
+static int genrtc_set_rtc_time(struct rtc_time *tm)
+{
+	if (in_interrupt()) {
+		/* Can't access RTC with interrupts off, since some of
+		 * the drivers might sleep. Delay the setting with a
+		 * work queue.
+		 */
+		memcpy(&delayed_tm, tm, sizeof(struct rtc_time));
+		queue_work(rtc_workqueue, &rtc_work);
+		return 0;
+	} else
+		return rtc_set_time(rtc_dev, tm);
+}
+
+static void genrtc_get_rtc_time(struct rtc_time *tm)
+{
+	rtc_read_time(rtc_dev, tm);
+}
+
+static int __init genrtc_rtc_hookup(void)
+{
+	/* Don't init if the platform has already set up rtc functions. */
+	if (ppc_md.get_rtc_time || ppc_md.set_rtc_time)
+		return -1;
+
+	rtc_dev = rtc_class_open("rtc0");
+
+	if (!rtc_dev) {
+		printk("genrtc_rtc_hookup: Failed to open rtc0\n");
+		return -1;
+	}
+
+	ppc_md.get_rtc_time = genrtc_get_rtc_time;
+	ppc_md.set_rtc_time = genrtc_set_rtc_time;
+
+	return 0;
+}
+late_initcall(genrtc_rtc_hookup);
+
