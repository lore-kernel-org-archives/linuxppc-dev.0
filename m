Return-Path: <vitb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6BD61B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 06:56:15 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A793CDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Sep 2009 06:56:13 +1000 (EST)
Date: Wed, 2 Sep 2009 00:49:28 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: [RFC][POWERPC] WDT: added support for the WDT Chain driver.
Message-ID: <20090902004928.132974c9@vitb-lp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Heiko Schocher <hs@denx.de>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


From: Heiko Schocher <hs@denx.de>

[POWERPC] WDT: added support for the WDT Chain driver.

    This new driver implements a character device with major number 10
    and minor number 130.  It is a software abstraction of the hardware
    watchdog with two different APIs.  While the driver periodically
    triggers the hardware watchdog, the software can setup independent
    timeout periods.

    More info in Documentation/watchdog/wdt_chain.txt

    Signed-off-by: Heiko Schocher <hs@denx.de>
    Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---
This code was (and is) originally residing in DENX public git repo. I
think it would be useful upstream, to prevent reinventing the same
thing. 

The BSP files are optional but included so that to keep consistency
with original patch. Direct immr dereference will not work now of
course, but I'd like to know if the entire idea and common stuff look
OK for mainline, before adding anything ontop.

TIA

 Documentation/watchdog/00-INDEX          |    2 
 Documentation/watchdog/wdt_chain.txt     |  200 ++++++
 drivers/watchdog/Kconfig                 |   11 
 drivers/watchdog/Makefile                |    3 
 drivers/watchdog/wdt_chain_hwl_mpc82xx.c |  102 +++
 drivers/watchdog/wdt_chain_hwl_mpc8xx.c  |  148 ++++
 drivers/watchdog/wdt_chains.c            | 1013
 ++++++++++++++++++++++++++++++
 include/linux/wdt_chains.h               |  102 +++ 8 files changed,
 1581 insertions(+), 0 deletions(-) create mode 100644
 Documentation/watchdog/wdt_chain.txt create mode 100644
 drivers/watchdog/wdt_chain_hwl_mpc82xx.c create mode 100644
 drivers/watchdog/wdt_chain_hwl_mpc8xx.c create mode 100644
 drivers/watchdog/wdt_chains.c create mode 100644
 include/linux/wdt_chains.h


diff --git a/Documentation/watchdog/00-INDEX
b/Documentation/watchdog/00-INDEX index c3ea47e..f8e1ad7 100644
--- a/Documentation/watchdog/00-INDEX
+++ b/Documentation/watchdog/00-INDEX
@@ -8,3 +8,5 @@ watchdog-api.txt
 	- description of the Linux Watchdog driver API.
 wdt.txt
 	- description of the Watchdog Timer Interfaces for Linux.
+wdt_chain.txt
+	- description of the Watchdog Chain Timer Interfaces for Linux.
diff --git a/Documentation/watchdog/wdt_chain.txt
b/Documentation/watchdog/wdt_chain.txt new file mode 100644
index 0000000..78cf4cb
--- /dev/null
+++ b/Documentation/watchdog/wdt_chain.txt
@@ -0,0 +1,200 @@
+Last Reviewed: 29/08/2008
+
+	WDT Watchdog CHAIN Timer Interfaces For The Linux Operating
System
+		Heiko Schocher <hs@denx.de>
+
+driver implements a character device with major number 10 and minor
+number 130.  It is a software abstraction of the hardware watchdog
+with two different APIs.  While the driver periodically triggers the
+hardware watchdog, the software can setup independent timeout periods.
+
+"REGULAR API"
+The regular API provides a facility to setup a watchdog behaviour
+shared by all processes using the driver.  This interface uses read(2),
+write(2) and the first two ioctl(2) calls listed below.  The
+parameterless ioctl(2) calls select the operational mode of the
+driver, which can be
+	open-only
+or
+	always.
+
+In open-only mode, the watchdog will not expire if the device file is
+not opened by any process, while in always mode the behaviour is
+independent of the device file being opened.
+
+Reading from the device file will return an unsigned integer denoting
+the number of seconds left till the watchdog expires.  Writing an
+unsigned integer to the device file will set the expiration period in
+seconds.  Note that the hardware watchdog will be triggered
+independently with a configurable period.  See the section
+CONFIGURATION for details.
+
+An expiration of the watchdog will trigger a hard-reset of the machine.
+
+"CHAIN API"
+The second API, which is implemented only through calls to ioctl(2),
+can be used to register configurable
+	watchdog chains
+from either user or kernel space.  A watchdog chain is identified by
+an unsigned integer and can contain up to three action stages.
+
+"time interval"	in seconds and an "action"
+
+is associated with each stage.  When the chain is not reset before the
+interval elapses, the associated action is triggered and the chain
+moves on to the next stage.
+
+A chain can request to kill the registering process if the interval
+elapses.  In this case a restarted process can register with the
+driver giving the same identifier and reset the chain.  This is the
+main reason why there is no association between chains and processes
+or open device files.
+
+For a detailed description of the possible chain configurations, see
+the description of the WDT_CHAIN_REGISTER ioctl call.
+
+Note that when mixing the two interfaces, the second API takes
+precedence.  That is, expiry of the interval set by writing to the
+device file while a chain is registered, will not trigger any actions.
+
+Also note that the default operational mode of the driver,
+i.e. open-only or always can only be configured in the source-code.
+
+IOCTLS
+
+  WDT_CHAIN_OPEN_ONLY
+    This parameterless call selects the "open-only"
+    operational mode of the driver as described above.
+
+
+  WDT_CHAIN_ALWAYS
+    Also a parameterless call, this sets the driver to the "always"
+    operational mode.
+
+
+  WDT_CHAIN_REGISTER
+    This and the two following ioctls constitute the "chain interface"
+    described above.  The parameter given to the call is a pointer to a
+    structure with the following layout:
+
+    typedef struct wdt_chain_param {
+      unsigned chainid;
+      unsigned long timer_count[3];
+      int action[3];
+      int signal;
+    } wdt_chain_param_t;
+
+  Each stage is configured with entries in the arrays
+    "timer_count"
+  and
+    "action."
+
+  The timer_count contains the length of the interval in seconds
+  while action contains one of the constants
+
+  WDT_CHAIN_ACTION_SIGNAL, WDT_CHAIN_ACTION_KILL,
+  WDT_CHAIN_ACTION_REBOOT
+  and
+  WDT_CHAIN_ACTION_RESET.
+
+  A timer_count of zero signals the end of the chain.
+
+  The ACTION_SIGNAL will send the configurable signal with number
+  "signal" to the registering process, while ACTION_KILL signals
SIGKILL which
+  can not be caught by the registered process.
+
+  ACTION_REBOOT tries a soft reboot and ACTION_RESET
+  triggers a hard-reset of the machine.
+
+  When stages of the chain are to be left unused, they should be filled
+  with zero entries.
+
+  Note that internally a hard-reset stage is appended as a stop entry
+  ensuring a chain will never exceed its stages.
+
+
+WDT_CHAIN_RESET
+  This call resets the chain denoted by the unsigned integer passed to
+  it.  When reset, a chain will expire beginning with stage zero again.
+
+
+WDT_CHAIN_UNREGISTER
+  As closing the device file will not have any effect on chains, a
+  process must unregister a chain if the service is no longer needed.
+  This can be done with this ioctl taking an unsigned integer as a
+  parameter denoting the chain to be unregistered.
+
+
+"IOCTL RESULT VALUES"
+On successful completion, the above calls to ioctl(2) return 0.  When
+invalid parameters are provided or an error occurs, a negative value
+will be returned and "errno" set accordingly.  Specifically
+"EINVAL, EFAULT, ENOMEM"
+can be returned.
+
+
+"KERNEL INTERFACE"
+Modules can also register with the chain API of the watchdog driver.
+This the three functions (wdt_chain_register_mon_chain,
wdt_chain_reset_mon_chain +and wdt_chain_unregister_mon_chain) are
exported from the driver. The +first function takes one argument,
namely a pointer to a "wdt_chain_param" +structure. The other two calls
take a pointer to an unsigned integer as a +parameter, namely the chain
id of the chain to be reset or unregistered. +
+
+CONFIGURATION
+The driver is configurable through parameters passed to the driver
+through the Linux commandline as
+
+"wdt_chain=<opts>".
+
+Multiple options can be seperated by commas, as usual.
+
+timeout:<n>
+  will set the expiry period of the regular driver API to <n> seconds.
+
+period:<n>
+  sets the period with which the hardware watchdog is triggered to <n>
+  jiffies.  This usually means 1/100th of a second.
+
+off
+  will disable the software APIs of the driver but still trigger the
+  hardware watchdog as described previously.
+
+
+EXAMPLE
+The following code snippet registers a watchdog chain whose first
+stage will expire after 3 seconds and send the SIGUSR1 signal to the
+process.  When 5 seconds after this the chain is not reset, the
+machine will do a hard-reset.
+
+  wdt_chain_param_t param;
+
+  /* Setup signal handling */
+  signal(SIGUSR1, got_signal);
+
+  param.chainid=823;
+  param.timer_count[0]=3;
+  param.action[0]=WDT_CHAIN_ACTION_SIGNAL;
+  param.signal=SIGUSR1;
+  param.timer_count[1]=5;
+  param.action[1]=WDT_CHAIN_ACTION_RESET;
+
+  /* Register chain */
+  ioctl(fd, WDT_CHAIN_REGISTER, &param);
+  ..
+  /* Reset chain    */
+  ioctl(fd, WDT_CHAIN_RESET, &param.chainid);
+
+
+FILES
+ /dev/watchdog
+
+SUPPORTED HARDWARE
+  The Hardwaredependent functions are seperated, so that it should be
+  easy to support new Hardware. Actual the following Hardware are
supported: +
+  Hardware		File
+  MPC82XX		wdt_chain_hwl_mpc82xx.c
+  MPC8XX		wdt_chain_hwl_mpc8xx.c
+
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b1ccc04..0908c64 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -831,6 +831,17 @@ config 8xxx_WDT
 
 	  For BookE processors (MPC85xx) use the BOOKE_WDT driver
instead. 
+config WDT_CHAIN
+	tristate "WDT Chain"
+
+config WDT_CHAIN_HWL_MPC8XX
+	tristate "WDT CHAIN Hardwarelayer for MPC8xx"
+	depends on WDT_CHAIN && PPC_8xx
+
+config WDT_CHAIN_HWL_MPC82XX
+	tristate "WDT CHAIN Hardwarelayer for MPC82xx"
+	depends on WDT_CHAIN
+
 config MV64X60_WDT
 	tristate "MV64X60 (Marvell Discovery) Watchdog Timer"
 	depends on MV64X60
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 3d77429..ce08a34 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -120,6 +120,9 @@ obj-$(CONFIG_8xxx_WDT) += mpc8xxx_wdt.o
 obj-$(CONFIG_MV64X60_WDT) += mv64x60_wdt.o
 obj-$(CONFIG_PIKA_WDT) += pika_wdt.o
 obj-$(CONFIG_BOOKE_WDT) += booke_wdt.o
+obj-$(CONFIG_WDT_CHAIN) += wdt_chains.o
+obj-$(CONFIG_WDT_CHAIN_HWL_MPC8XX) += wdt_chain_hwl_mpc8xx.o
+obj-$(CONFIG_WDT_CHAIN_HWL_MPC82XX) += wdt_chain_hwl_mpc82xx.o
 
 # PPC64 Architecture
 obj-$(CONFIG_WATCHDOG_RTAS) += wdrtas.o
diff --git a/drivers/watchdog/wdt_chain_hwl_mpc82xx.c
b/drivers/watchdog/wdt_chain_hwl_mpc82xx.c new file mode 100644
index 0000000..e4a50f2
--- /dev/null
+++ b/drivers/watchdog/wdt_chain_hwl_mpc82xx.c
@@ -0,0 +1,102 @@
+/*
+ * (C) Copyright Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/wdt_chains.h>
+#include <asm/cpm2.h>
+
+#ifdef DEBUG
+# define debugk(fmt, args...) printk(fmt, ##args)
+#else
+# define debugk(fmt, args...)
+#endif
+
+
+int wdt_chain_hwl_start(void)
+{
+	return 0;
+}
+
+int wdt_chain_hwl_stop(void)
+{
+	return 0;
+}
+
+/***********************************************************************
+F* Function:     int __init wdt_hwl_init (void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  int
+P*                - 0 success
+P*                  -ENXIO  The watchdog is not enabled by firmware
+ *
+Z* Intention:    Initialize the Hardwaredependent functions for the WDT
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+#define MPC82XX_SYPCR_SWE	0x00000004 +#define
MPC82XX_SYPCR_SWRI	0x00000002 +#define MPC82XX_SYPCR_SWP
0x00000001 +
+int __init wdt_hwl_init(void)
+{
+	/* using MPC82XX internal WDT */
+	debugk("%s: SYPCR=0x%x\n", __func__,
+
cpm2_immr->im_siu_conf.siu_82xx.sc_sypcr);
+	debugk("%s: Should be 0x02 (Hardreset) | 0x01 prescaled | \
+						0x04 active\n",
__func__);
+	if ((cpm2_immr->im_siu_conf.siu_82xx.sc_sypcr &
MPC82XX_SYPCR_SWE)
+							!=
MPC82XX_SYPCR_SWE) {
+		printk("WDT not enabled by firmware, SYPCR=0x%x\n",
+			cpm2_immr->im_siu_conf.siu_82xx.sc_sypcr);
+		return -ENXIO;
+	}
+
+	/* trigger now */
+	cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0x556C;
+	cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0xAA39;
+	return 0;
+}
+
+/***********************************************************************
+F* Function:	 void wdt_hwl_reset (void) P*A*Z*
+ *
+P* Parameters:	 none
+P*
+P* Returnvalue:	 none
+ *
+Z* Intention:	 Reset the hardware watchdog.
+ *
+D* Design:	 wd@denx.de
+C* Coding:	 wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+void wdt_hwl_reset(void) +{
+	cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0x556C;
+	cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0xAA39;
+/*	debugk ("%s: WDT serviced\n", __FUNCTION__); */
+}
+EXPORT_SYMBOL(wdt_hwl_reset);
+
diff --git a/drivers/watchdog/wdt_chain_hwl_mpc8xx.c
b/drivers/watchdog/wdt_chain_hwl_mpc8xx.c new file mode 100644
index 0000000..32abefb
--- /dev/null
+++ b/drivers/watchdog/wdt_chain_hwl_mpc8xx.c
@@ -0,0 +1,148 @@
+/*
+ * (C) Copyright Heiko Schocher <hs@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>			/* for character
devices	*/ +#include <linux/version.h>
+#include <linux/init.h>			/* for
__initfunc		*/ +#include
<linux/slab.h>			/* for kmalloc and friends
*/ + +#include <linux/wdt_chains.h>
+#include <asm/8xx_immap.h>
+#include <asm/mpc8xx.h>
+
+#ifdef CONFIG_8xx
+static immap_t *immr;	/* pointer to register-structure */
+#endif
+
+#ifdef DEBUG
+# define debugk(fmt, args...) printk(fmt, ##args)
+#else
+# define debugk(fmt, args...)
+#endif
+
+
+int wdt_chain_hwl_start(void)
+{
+	return 0;
+}
+
+int wdt_chain_hwl_stop(void)
+{
+	return 0;
+}
+
+#define IMAP_ADDR_CHAIN 0xf0000000
+/***********************************************************************
+F* Function:     int __init wdt_hwl_init (void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  int
+P*                - 0 success
+P*                  -ENXIO  (LWMON) The watchdog is not enabled by
firmware
+ *
+Z* Intention:    Initialize the Hardwaredependent functions for the WDT
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+int __init wdt_hwl_init(void) +{
+	/* get pointer for SYPCR and SWSR */
+	if (!immr)
+		immr = (immap_t *) IMAP_ADDR_CHAIN;
+
+	debugk("%s: SYPCR=0x%x\n", __func__,
immr->im_siu_conf.sc_sypcr); +
+#ifndef	CONFIG_LWMON	/* LWMON uses external MAX708TESA
watchdog */
+	if ((immr->im_siu_conf.sc_sypcr & 0x00000004) == 0) {
+		printk("WDT_8xx: SWT not enabled by firmware,
SYPCR=0x%x\n",
+			immr->im_siu_conf.sc_sypcr);
+		return -ENXIO;
+	}
+#endif
+
+#ifdef CONFIG_LWMON	/* LWMON uses external MAX708TESA watchdog
*/ +
+	immr->im_ioport.iop_padat ^= 0x0100;
+
+#else			/* use MPC8xx internal SWT */
+	/* set SYPCR[SWRI]...wdt-timeout causes reset */
+	immr->im_siu_conf.sc_sypcr |= (
+				0x00000002	/* SWRI - SWT causes
HRESET  */
+				|
+				0x00000001	/* SWP  - activate
prescaler */
+				|
+				0xFFFF0000	/* SWTC - max. timer
count   */
+				);
+
+	debugk("%s: SYPCR=0x%x\n", __func__,
immr->im_siu_conf.sc_sypcr); +
+	/* trigger now */
+	immr->im_siu_conf.sc_swsr = 0x556C;
+	immr->im_siu_conf.sc_swsr = 0xAA39;
+#endif
+
+	return 0;
+}
+
+/***********************************************************************
+F* Function:	 void wdt_hwl_reset (void) P*A*Z*
+ *
+P* Parameters:	 none
+P*
+P* Returnvalue:	 none
+ *
+Z* Intention:	 Reset the hardware watchdog.
+ *
+D* Design:	 wd@denx.de
+C* Coding:	 wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+void wdt_hwl_reset(void) +{
+	immap_t *imap = (immap_t *) IMAP_ADDR_CHAIN;
+#if defined(CONFIG_LWMON)
+	/*
+	 * The LWMON board uses a MAX706TESA Watchdog
+	 * with the trigger pin connected to port PA.7
+	 *
+	 * The port has already been set up in the firmware,
+	 * so we just have to toggle it.
+	 */
+	imap->im_ioport.iop_padat ^= 0x0100;
+	/*
+	 * Do NOT add a call to "debugk()" here;
+	 * it would be called TOO often.
+	 */
+#else
+	/*
+	 * All other boards use the MPC8xx Internal Watchdog
+	 */
+	imap->im_siu_conf.sc_swsr = 0x556C;
+	imap->im_siu_conf.sc_swsr = 0xAA39;
+	debugk("%s: WDT serviced\n", __func__);
+#endif /* CONFIG_LWMON */
+}
+EXPORT_SYMBOL(wdt_hwl_reset);
+
diff --git a/drivers/watchdog/wdt_chains.c
b/drivers/watchdog/wdt_chains.c new file mode 100644
index 0000000..e7a5054
--- /dev/null
+++ b/drivers/watchdog/wdt_chains.c
@@ -0,0 +1,1013 @@
+/*
+ * (C) Copyright 2000
+ * Jorg Haider, SIEMENS AG
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * (C) 2008 Heiko Scocher, hs@denx.de -- ported for 2.6
+ *                                       seperated Hardwarelayer, now
not
+ *                                       only for MPC8xx.
+ * (C) 2002 Detlev Zundel, dzu@denx.de -- Added "watchdog chains"
+ * (C) 2001 Wolfgang Denk, wd@denx.de -- Cleanup, Modifications for
2.4 kernels
+ * (C) 2001 Wolfgang Denk, wd@denx.de -- Adaption for MAX706TESA
Watchdog
+ * (C) 2001 Steven Hein,  ssh@sgi.com -- Added timeout configuration
option
+ * (C) 2001 Robert Enzinger, Robert.Enzinger.extern@icn.siemens.de,
+ *		-- added ioctl() for dynamic configuration
+ *
+M* Modul:         wdt_mpc8xx.c
+M*
+M* Content:       Linux kernel driver for the watchdog.
+ *
+ */
+
+/*---------------------------- Headerfiles
----------------------------*/ +#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>			/* for character
devices	*/ +#include <linux/miscdevice.h>		/*
driver is a misc device	*/ +#include <linux/version.h>
+#include <linux/init.h>			/* for
__initfunc		*/ +#include
<linux/spinlock.h>		/* for spinlocks                */
+#include <linux/list.h>			/* for linked-list
macros       */ +#include <linux/sched.h> +#include
<linux/slab.h>			/* for kmalloc and friends
*/ +#include <linux/reboot.h>		/* for
sys_reboot               */ +#include <linux/wdt_chains.h> +#include
<linux/uaccess.h>		/* for put_user
*/ + +/*----------------- Local vars, datatypes and macros
------------------*/ +/* #define DEBUG	1	//	*/
+
+#ifdef DEBUG
+# define debugk(fmt, args...) printk(fmt, ##args)
+#else
+# define debugk(fmt, args...)
+#endif
+
+#define	WDT_VERSION	"0.6"	/* version of this
device driver	*/ +
+#ifdef	CONFIG_CHAIN_WDT_TIMEOUT
+#define TIMEOUT_VALUE CONFIG_CHAIN_WDT_TIMEOUT	/* configurable
timeout	*/ +#else
+#define TIMEOUT_VALUE 300	/* reset after five minutes = 300
seconds*/ +#endif
+
+#ifdef CONFIG_CHAIN_WDT_TIMEOUT_OPEN_ONLY
+static int timeout_open_only = 1;
+#else
+static int timeout_open_only;
+#endif
+
+/*
+ * The shortest watchdog period of all boards is (so far) approx. 1
sec,
+ * thus re-trigger watchdog by default every 500 ms = HZ / 2,
+ * except for the LWMON board, which needs 50ms = HZ / 20.
+ * The default can be overwritten using a boot argument.
+ *
+ * The external interface is in seconds, but internal all calculation
+ * is done in jiffies.
+ */
+#ifdef	CONFIG_TRIGGER_PERIOD
+# define TRIGGER_PERIOD   (CONFIG_TRIGGER_PERIOD)
+#else
+# define TRIGGER_PERIOD   (HZ/2)
+#endif
+
+typedef struct monitored_chain {
+	struct list_head list;
+	unsigned int chainid;
+	pid_t pid;
+	int escalation;
+	unsigned long expires;
+	unsigned long timer_count[4];
+	int action[4];
+	int signal;
+} monitored_chain_t;
+
+static struct list_head mon_list;
+static spinlock_t mon_lock;	/* lock for the monitored chain
list */ +static int mon_chains;
+
+struct timer_list wd_timer;	/* structure for timer
administration */ +static unsigned long wdt_chain_dummy;
+
+/*
+ * Watchdog active? When disabled, it will get re-triggered
+ * automatically without timeout, so it appears to be switched off
+ * although actually it is still running.
+ */
+static int enabled = 1;
+
+static unsigned long timer_count = TIMEOUT_VALUE *
HZ;	/*remaining time*/ +static unsigned long timer_period =
TRIGGER_PERIOD;	/*period to trigger WD*/ +
+static int device_open;	/* to implement "run while open"
mode	*/ +
+
+/*------------------------- Extern prototypes
-------------------------*/ +extern inline void sync(void);
+extern long sys_reboot(int, int, unsigned int, void *);
+/*----------------------- Interface prototypes
------------------------*/ +void wdt_chain_handler(unsigned long);
+/*------------------------- Local prototypes
--------------------------*/ +static int wdt_chain_open(struct inode *,
struct file *); +static int wdt_chain_release(struct inode *, struct
file *); +static ssize_t wdt_chain_read(struct file *, char *, size_t,
loff_t *); +static ssize_t wdt_chain_write(struct file *, const char *,
size_t, loff_t *); +static int wdt_chain_ioctl(struct inode *, struct
file *,
+			     unsigned int, unsigned long);
+
+static int register_mon_chain(wdt_chain_param_t *, int);
+/*---------------------Kernel interface prototypes
--------------------*/ +int
wdt_chain_register_mon_chain(wdt_chain_param_t *); +int
wdt_chain_unregister_mon_chain(unsigned int); +int
wdt_chain_reset_mon_chain(int); +static int process_mon_chains(void);
+static monitored_chain_t *find_mon_chain_by_chainid(unsigned int);
+static void insert_mon_chain(monitored_chain_t *);
+#ifdef MODULE
+static void free_mon_list(void);
+#endif
+
+const struct file_operations wdt_chain_ops = {
+	.owner = THIS_MODULE,
+	.open = wdt_chain_open,
+	.release = wdt_chain_release,
+	.read = wdt_chain_read,
+	.write = wdt_chain_write,
+	.ioctl = wdt_chain_ioctl,
+};
+
+static struct miscdevice wdt_miscdev =	/* driver is a misc
device */ +{
+	WATCHDOG_MINOR,
+	"watchdog",
+	&wdt_chain_ops
+};
+
+/*
----------------------------------------------------------------------
*/ +int __init wdt_chain_init(void) +{
+	int rc;
+
+	rc = wdt_hwl_init();
+	debugk("WDT_CHAIN HWL init: %d\n", rc);
+
+	if (rc)
+		return rc;
+
+	/* register misc device */
+	rc = misc_register(&wdt_miscdev);
+	if (rc < 0) {
+		printk("%s: failed with %d\n", __func__, rc);
+		return rc;
+	}
+
+	debugk("WDT_CHAIN registered: major=%d minor=%d\n",
+		MISC_MAJOR, WATCHDOG_MINOR);
+
+	INIT_LIST_HEAD(&mon_list);
+	spin_lock_init(&mon_lock);
+
+	init_timer(&wd_timer);		/* initialize
timer-structure...*/
+	wd_timer.function = wdt_chain_handler;
+	wd_timer.data = (unsigned long) &wdt_chain_dummy;
+	wd_timer.expires = jiffies + timer_period;
+
+	debugk("%s: watchdog timer initialized - timer_count = %d \
+		 period = %d\n",
+		__func__, timer_count / HZ, HZ / timer_period);
+
+	add_timer(&wd_timer);			/* ...and
activate timer */ +
+	debugk("%s: timer activated\n", __func__);
+
+	pr_info("WDT_CHAIN: Software Watchdog Timer version "
WDT_VERSION); +
+	if (enabled)
+		pr_info(", timeout %ld sec.\n", timer_count / HZ);
+	else
+		pr_info(" (disabled)\n");
+	return 0;
+}
+fs_initcall(wdt_chain_init);
+
+/***********************************************************************
+F* Function:     int __init wdt_chain_setup (char *options) P*A*Z*
+ *
+P* Parameters:   char *options
+P*                - Options to parse
+P*
+P* Returnvalue:  int
+P*                - 0 is always returned
+ *
+Z* Intention:    Parse the options passed on the linux command line
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+int __init wdt_chain_setup(char *options) +{
+	while (options && *options) {
+		if (strncmp(options, "off", 3) == 0) {
+			options += 3;
+			enabled = 0;
+			if (*options != ',')
+				return 0;
+			options++;
+		}
+
+		if (strncmp(options, "timeout:", 8) == 0) {
+			options += 8;
+			if (!*options)
+				return 0;
+
+			timer_count = HZ * strict_strtoul(options,
&options, 0);
+			if (*options != ',')
+				return 0;
+			options++;
+		}
+
+		if (strncmp(options, "period:", 7) == 0) {
+			options += 7;
+			if (!*options)
+				return 0;
+
+			timer_period = strict_strtoul(options,
&options, 0);
+			if (*options != ',')
+				return 0;
+			options++;
+		}
+	}
+
+	return 0;
+}
+__setup("wdt_chain=", wdt_chain_setup);
+
+
+/***********************************************************************
+F* Function:     static int wdt_chain_open (struct inode *inode,
+F*                                           struct file *filp) P*A*Z*
+ *
+P* Parameters:   struct inode *inode
+P*                - Inode of the device file being opened
+P*               struct file *file
+P*                - Passed by the kernel, but not used
+P*
+P* Returnvalue:  int - 0 success
+P*                    <0 Errorcondition, which can be
+P*                     -ENXIO  Watchdog is not enabled
+ *
+Z* Intention:    This function is called by the kernel when a device
file +Z*               for the driver is opened by open(2).
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+static int wdt_chain_open(struct inode *inode, struct file *filp) +{
+	debugk("ENTER %s (%p, %p)\n", __func__, inode, filp);
+
+	if (!enabled)		/* user interface disabled */
+		return -ENXIO;
+
+	device_open++;			/* increment usage
counter */
+	debugk("%s: WDT is open\n", __func__);
+	return 0;
+}
+
+
+/***********************************************************************
+F* Function:     static int wdt_chain_release (struct inode *inode,
+F*                                              struct file *filp)
P*A*Z*
+ *
+P* Parameters:   struct inode *inode
+P*                - Inode of the device file being closed
+P*               struct file *file
+P*                - Passed by the kernel, but not used
+P*
+P* Returnvalue:  int
+P*                - 0 is always returned
+ *
+Z* Intention:    This function is called by the kernel when a device
file +Z*               of the driver is closed with close(2).
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+static int wdt_chain_release(struct inode *inode, struct file *filp) +{
+	debugk("ENTER %s (%p, %p)\n", __func__, inode, filp);
+
+	device_open--;			/* decrement usage
counter */
+	debugk("%s: WDT is closed.\n", __func__);
+
+	return 0;
+}
+
+
+/***********************************************************************
+F* Function:     static ssize_t wdt_chain_read (struct file *filp,
char *buffer,
+				size_t length, loff_t *offset) P*A*Z*
+ *
+P* Parameters:   struct file *file
+P*                - Passed by the kernel, pointer to the file structure
+P*                  for the device file
+P*               char *buf
+P*                - Pointer to buffer in userspace
+P*               size_t count
+P*                - Number of bytes to read
+P*               loff_t *ppos
+P*                - Offset for the read - ignored.
+P*
+P* Returnvalue:  int
+P*                 - >0 number of bytes read, i.e. 4
+P*                   <0 Errorcondition, which can be
+P*                    -EINVAL  When trying to read fewer bytes than the
+P*                             rest counter occupies, i.e.
sizeof(unsigned) +P*                    -EFAULT  A user-provided
pointer is invalid
+ *
+Z* Intention:    Read the rest counter from the device.
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+static ssize_t wdt_chain_read(struct file *filp, char *buffer,
+				size_t length,   loff_t *offset)
+{
+	unsigned int rest_count = timer_count / HZ;
+	int rc;
+
+	debugk("ENTER %s (%p, %p, %d, %p)\n",
+		__func__, filp, buffer, length,  offset);
+
+	if (length < sizeof(rest_count)) {
+		debugk("wdt_chain_release/kernel: invalid argument\n");
+
+		return -EINVAL;
+	}
+	/* copy value into userspace */
+	rc = put_user(rest_count, (int *) buffer);
+	if (rc)
+		return rc;
+
+	debugk("%s: rest_count=%i\n", __func__, rest_count);
+
+	return sizeof(rest_count);	/* read always exactly 4
bytes */ +}
+
+
+/***********************************************************************
+F* Function:     static ssize_t wdt_chain_write (struct file *filp,
const char *buffer,
+ *			size_t length, loff_t *offset) P*A*Z*
+ *
+P* Parameters:   struct file *file
+P*                - Passed by the kernel, pointer to the file structure
+P*                  for the device file
+P*               char *buf
+P*                - Pointer to buffer in userspace
+P*               size_t count
+P*                - Number of bytes to write
+P*               loff_t *ppos
+P*                - Offset for the write - ignored.
+P*
+P* Returnvalue:  int
+P*                 - >0 number of bytes actually written, i.e. 4
+P*                   <0 Errorcondition, which can be
+P*                    -EINVAL  When trying to write more or less than 4
+P*                             bytes, i.e. sizeof(unsigned)
+P*                    -EFAULT  A user-provided pointer is invalid
+ *
+Z* Intention:    Set the rest counter to the value provided by the user
+Z*               process interpreted as a number of seconds.
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+static ssize_t wdt_chain_write(struct file *filp, const char *buffer,
+				 size_t length, loff_t *offset)
+{
+	int error;
+	unsigned int new_count;
+
+	debugk("ENTER %s (%p, %p, %d, %p)\n",
+		__func__, filp, buffer, length,  offset);
+
+	if (length != sizeof(new_count)) {
+		debugk("%s: invalid length (%d instead of %d)\n",
+			__func__, length, sizeof(new_count));
+
+		return -EINVAL;
+	}
+
+	/* copy count value into kernel space */
+	error = get_user(new_count, (int *)buffer);
+	if (error != 0) {
+		debugk("%s: get_user failed: rc=%d\n",
+			__func__, error);
+
+		return error;
+	}
+
+	timer_count = HZ * new_count;
+
+	return sizeof(new_count);
+}
+
+/***********************************************************************
+F* Function:     static int wdt_chain_ioctl (struct inode *node,
struct file *filp,
+		unsigned int cmd, unsigned long arg) P*A*Z*
+ *
+P* Parameters:   struct inode *inode
+P*                - Passed by the kernel, inode of the device file
being +P*                  operated on
+P*               struct file *file
+P*                - Passed by the kernel, but not used
+P*               unsigned int cmd
+P*                - ioctl command number
+P*               unsigned long arg
+P*                - Pointer to arguments cast to unsigned long.
+P*                  The actual parameter depends on the command, see
+P*                  wdt_mpc8xx(4).
+P*
+P* Returnvalue:  int
+P*                 - 0 => success
+P*                  <0 Errorcondition, which can be
+P*                  -EINTR  the call was interrupted
+P*                  -EFAULT the pointer passed as arg is invalid
+P*                  -EINVAL a parameter was invalid
+ *
+Z* Intention:    This is the entry point for the ioctl() commands.
+Z*               For a detailed description see the man-page
wdt_mpc8xx(4).
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+static int wdt_chain_ioctl(struct inode *node, struct file *filp,
+			     unsigned int cmd, unsigned long arg)
+{
+	wdt_chain_param_t param;
+	int chainid;
+	int	res;
+
+	switch (cmd) {
+	case WDT_CHAIN_OPEN_ONLY:
+		timeout_open_only = 1;
+		break;
+	case WDT_CHAIN_ALWAYS:
+		timeout_open_only = 0;
+		break;
+	case WDT_CHAIN_REGISTER:
+		if (copy_from_user(&param, (void *)arg, sizeof(param)))
+			return -EFAULT;
+		res = register_mon_chain(&param, 1);
+		return res;
+		break;
+	case WDT_CHAIN_RESET:
+		if (copy_from_user(&chainid, (void *)arg,
sizeof(chainid)))
+			return -EFAULT;
+		return wdt_chain_reset_mon_chain(chainid);
+		break;
+	case WDT_CHAIN_UNREGISTER:
+		if (copy_from_user(&chainid, (void *)arg,
sizeof(chainid)))
+			return -EFAULT;
+		return wdt_chain_unregister_mon_chain(chainid);
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+#ifdef MODULE
+
+/***********************************************************************
+F* Function:     int init_module (void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  int
+P*                - see wdt_chain_init()
+ *
+Z* Intention:    This is a wrapper function for the module
initialization +Z*               simply calling wdt_chain_init().
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+int init_module(void) +{
+	debugk("%s: initialize WDT_CHAIN\n", __func__);
+
+	return wdt_chain_init();
+}
+
+
+/***********************************************************************
+F* Function:     void cleanup_module (void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  none
+ *
+Z* Intention:    Cleanup and shutdown the driver to allow unloading
+Z*               of the module.
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+void cleanup_module(void) +{
+	debugk("%s: cleanup WDT_CHAIN\n", __func__);
+
+	del_timer(&wd_timer);
+	free_mon_list();
+
+	misc_deregister(&wdt_miscdev);
+}
+
+#endif	/* MODULE */
+
+/***********************************************************************
+F* Function:     void wdt_chain_handler (unsigned long ptr) P*A*Z*
+ *
+P* Parameters:   unsigned long ptr
+P*                - Parameter passed in from the timer invocation,
ignored +P*
+P* Returnvalue:  none
+ *
+Z* Intention:    This is the core functionality of the watchdog.  It is
+Z*               called from the timer wd_timer and handles the
necessary +Z*               processing, including resetting the
hardware watchdog. +Z*               When chains are registered, they
override the +Z*               default behaviour and are processed in
process_mon_chains().
+ *
+D* Design:       Haider / wd@denx.de
+C* Coding:       Haider / wd@denx.de
+V* Verification: wd@denx.de / dzu@denx.de
+
***********************************************************************/
+void wdt_chain_handler(unsigned long ptr) +{
+
+	debugk("%s: timer_count=%d jiffies active chains: %d\n",
+					__func__, timer_count,
mon_chains); +
+	if ((timer_count == 0) && enabled) {	/* try "graceful"
shutdown */
+		pr_info("WDT_CHAIN: Reset system...\n");
+		machine_restart(NULL);
+	}
+
+	if ((timer_count > 0) || (!enabled)) {
+
+		/* execute WDT service sequence */
+		wdt_hwl_reset();
+
+		wd_timer.expires = jiffies + timer_period;
+		add_timer(&wd_timer);	/* ...re-activate timer */
+
+		/*
+		 * process the monitor list
+		 */
+		process_mon_chains();
+
+		/*
+		 * don't timeout if disabled
+		 */
+		if (!enabled)
+			return;
+
+		/*
+		 * don't timeout if new interface is used or if device
+		 * is not opened
+		 */
+		if ((timeout_open_only && (!device_open)) ||
mon_chains)
+			return;
+
+		/* decrement variable for timer-control */
+		if (timer_count > timer_period)
+			timer_count -= timer_period;
+		else
+			timer_count = 0;
+
+		if (timer_count <= 0)
+			pr_info("WDT_CHAIN: watchdog about to
expire\n"); +
+	}
+
+	return;
+}
+
+/***********************************************************************
+F* Function:     static int register_mon_chain(wdt_chain_param_t
*param, +F*                                             int userproc)
P*A*Z*
+ *
+P* Parameters:   wdt_chain_param_t *param
+P*                - The parameters for the chain to be registered.
+P*                  Unused stages should be cleared with 0's.
+P*               int userproc
+P*                - Flag whether we are called from user or kernel
space +P*
+P* Returnvalue:  int
+P*                - 0  success
+P*                  -EINVAL  invalid parameters
+P*                  -ENOMEM  out of memory
+ *
+Z* Intention:    This is the main interface to register a watchdog
chain +Z*               either from userspace throught ioctl() or from
kernel +Z*               space through the wrapper function
+Z*               wdt_mpc8x_register_mon_chain().
+Z*               Re-registering an existing chain is explicitely ok, as
+Z*               a restarted process has to go through this.  This
+Z*               effectively resets the corresponding chain.
+Z*               For a detailed description of the parameters, see the
+Z*               wdt_mpc8xx(4) manpage.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+static int register_mon_chain(wdt_chain_param_t *param, int userproc)
+{
+	monitored_chain_t *entry;
+	int result = 0, i;
+
+	/* Before kmallocing storage we first check the parameters */
+	for (i = 0; (i < 3) && (param->timer_count[i]); i++)
+		if ((param->action[i] < WDT_CHAIN_ACTION_NO) ||
+		    (param->action[i] > WDT_CHAIN_ACTION_RESET))
+			return -EINVAL;
+
+	debugk("%s: registering CHAIN monitor\n", __func__);
+
+	spin_lock(&mon_lock);
+	entry = find_mon_chain_by_chainid(param->chainid);
+	if (entry == NULL) {
+		/* New chain-id so allocate list entry */
+		entry = kmalloc(sizeof(monitored_chain_t), GFP_KERNEL);
+		if (entry == NULL) {
+			result = -ENOMEM;
+			goto out;
+		}
+
+		/* Copy request data to internal format */
+		if (userproc)
+			entry->pid = current->pid;
+		else
+			entry->pid = 0;
+		entry->chainid = param->chainid;
+		entry->signal = param->signal;
+		for (i = 0; i < 2 ; i++) {
+			if (param->action[i] != 0) {
+				entry->timer_count[i] =
param->timer_count[i];
+				entry->action[i] = param->action[i];
+			} else {
+				/* Fill with stop entries */
+				entry->timer_count[i] = 2;
+				entry->action[i] =
WDT_CHAIN_ACTION_RESET;
+			}
+		}
+
+		/* This is a final stop entry */
+		entry->timer_count[3] = 2;
+		entry->action[3] = WDT_CHAIN_RESET;
+
+		/* Initialize internal data */
+		entry->escalation = 0;
+		entry->expires = jiffies + HZ * entry->timer_count[0];
+		insert_mon_chain(entry);
+		mon_chains++;
+	} else {
+		/* Re-registering of active monitor */
+		entry->pid = current->pid;
+		entry->escalation = 0;
+		entry->expires = jiffies + HZ * entry->timer_count[0];
+		entry->escalation = 0;
+		list_del(&entry->list);
+		insert_mon_chain(entry);
+	}
+
+ out:
+	spin_unlock(&mon_lock);
+
+	return result;
+}
+
+/*
+ * The next three functions form the external interface for kernel
modules
+ */
+
+/***********************************************************************
+F* Function:     int wdt_chain_register_mon_chain(wdt_chain_param_t
*param) P*A*Z*
+ *
+P* Parameters:   wdt_chain_param_t *param
+P*
+P* Returnvalue:  int
+P*                - See description of register_mon_chain()
+ *
+Z* Intention:    This is only a wrapper function around
register_mon_chain() +Z*               exported to the kernel name
space.  It only augments the +Z*               parameter with a flag
informing register_mon_chain() that +Z*               it was called
through this interface and not from a +Z*               user space
program.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de:
+V* Verification: wd@denx.de
+
***********************************************************************/
+int wdt_chain_register_mon_chain(wdt_chain_param_t *param) +{
+	return register_mon_chain(param, 0);
+}
+EXPORT_SYMBOL(wdt_chain_register_mon_chain);
+
+/***********************************************************************
+F* Function:     int wdt_chain_unregister_mon_chain(unsigned int
chainid) P*A*Z*
+ *
+P* Parameters:   unsigned int chainid
+P*                - The id of the chain to unregister
+P*
+P* Returnvalue:  int
+P*                - 0 The chain was unregistered successfully
+P*                  -EINVAL  The chainid is unknown
+ *
+Z* Intention:    When the watchdog functionality is no longer needed,
+Z*               chains can be unregistered through this call.
+Z*               The function is called through the ioctl() mechanism
+Z*               or directly from other kernel proper, as it is
exported.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+int wdt_chain_unregister_mon_chain(unsigned int chainid) +{
+	monitored_chain_t *entry = find_mon_chain_by_chainid(chainid);
+
+	if (entry == NULL)
+		return -EINVAL;
+
+	debugk("%s: CHAIN unregistering monitor for id %d\n",
+					__func__, entry->chainid);
+
+	spin_lock(&mon_lock);
+
+	list_del(&entry->list);
+	kfree(entry);
+	mon_chains--;
+
+	spin_unlock(&mon_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(wdt_chain_unregister_mon_chain);
+
+/***********************************************************************
+F* Function:     int wdt_chain_reset_mon_chain(int chainid) P*A*Z*
+ *
+P* Parameters:   int chainid
+P*                - The id of the chain to reset
+P*
+P* Returnvalue:  int
+P*                - 0 The chain was reset suiccessfully
+P*                 <0 Errorcondition, which can be
+P*                  -EINVAL The supplied id is unknown.
+ *
+Z* Intention:    This function resets a chain to its initial state.
+Z*               The function is called through the ioctl() mechanism
+Z*               to reset or trigger a chain or directly from other
+Z*               kernel proper, as it is exported.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+int wdt_chain_reset_mon_chain(int chainid) +{
+	monitored_chain_t *entry;
+	int result = 0;
+
+	debugk("%s: CHAIN monitor reset for id %d\n", __func__,
chainid); +
+	spin_lock(&mon_lock);
+
+	entry = find_mon_chain_by_chainid(chainid);
+	if (entry == NULL) {
+		result = -EINVAL;
+		goto out;
+	}
+	entry->escalation = 0;
+	entry->expires = jiffies + HZ * entry->timer_count[0];
+	list_del(&entry->list);
+	insert_mon_chain(entry);
+
+ out:
+	spin_unlock(&mon_lock);
+
+	return result;
+}
+EXPORT_SYMBOL(wdt_chain_reset_mon_chain);
+
+#ifdef MODULE
+/***********************************************************************
+F* Function:     static void free_mon_list(void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  none
+ *
+Z* Intention:    This function frees the entire kmalloc'ed list of
+Z*               monitored chains in case the module is unloaded.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+static void free_mon_list(void) +{
+	struct list_head *ptr, *n;
+	monitored_chain_t *entry;
+
+	debugk("%s: CHAIN freeing monitor list\n", __func__);
+
+	spin_lock(&mon_lock);
+
+	for (ptr = mon_list.next, n = ptr->next; ptr != &mon_list; ptr
= n) {
+		entry = list_entry(ptr, monitored_chain_t, list);
+		kfree(entry);
+	}
+
+	spin_unlock(&mon_lock);
+}
+#endif
+
+/***********************************************************************
+F* Function:     static int process_mon_chains(void) P*A*Z*
+ *
+P* Parameters:   none
+P*
+P* Returnvalue:  int
+P*                - 0 if the function returns at all
+ *
+Z* Intention:    This is the core function of the chain functionality.
+Z*               The list with the monitored chain is processed and
+Z*               expired entries handled appropriately by stepping up
+Z*               the escalation ladder.  The escalation actions are
+Z*               triggered from here.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+static int process_mon_chains(void) +{
+	struct list_head *ptr;
+	monitored_chain_t *entry;
+	int sig;
+
+	spin_lock(&mon_lock);
+
+	for (ptr = mon_list.next; ptr != &mon_list; ptr = ptr->next) {
+		entry = list_entry(ptr, monitored_chain_t, list);
+		if (entry->expires <= jiffies) {
+			debugk("%s: WDT_CHAIN monitor expired for id
%d\n",
+						__func__,
entry->chainid);
+			switch (entry->action[entry->escalation]) {
+			case WDT_CHAIN_ACTION_SIGNAL:
+				debugk("WDT_CHAIN: sending user signal
\
+					for key %d...\n",
entry->chainid);
+				sig = (entry->signal) ?
entry->signal : SIGTERM;
+				if (entry->pid)
+					kill_proc_info(sig,
+						SEND_SIG_PRIV,
entry->pid);
+				break;
+
+			case WDT_CHAIN_ACTION_KILL:
+				debugk("WDT_CHAIN: sending KILL signal
\
+					for key %d...\n",
entry->chainid);
+				if (entry->pid) {
+					pid_t pid = entry->pid;
+				/* Deregister the monitor chain in
release ! */
+					kill_proc_info(SIGKILL,
+							SEND_SIG_PRIV,
pid);
+				}
+				break;
+
+			case WDT_CHAIN_ACTION_REBOOT:
+				spin_unlock(&mon_lock);
+
wdt_chain_unregister_mon_chain(entry->chainid);
+				pr_info("WDT_CHAIN: Rebooting system \
+						for key %d...\n",
+
entry->chainid);
+				sys_reboot(LINUX_REBOOT_MAGIC1,
+					   LINUX_REBOOT_MAGIC2,
+					   LINUX_REBOOT_CMD_RESTART,
NULL);
+				break;
+
+			case WDT_CHAIN_ACTION_RESET:
+				pr_info("WDT_CHAIN: Resetting system \
+					for key %d...\n",
entry->chainid);
+				machine_restart(NULL);
+				break;
+
+			default:
+				debugk("WDT_CHAIN: undefined action
%d\n",
+
entry->action[entry->escalation]);
+				break;
+			}
+			entry->escalation++;
+			entry->expires = jiffies + HZ *
+				entry->timer_count[entry->escalation];
+			list_del(&entry->list);
+			insert_mon_chain(entry);
+		} else
+			/* The list is sorted, so we can stop here */
+			break;
+	}
+
+	spin_unlock(&mon_lock);
+
+	return 0;
+}
+
+/***********************************************************************
+F* Function:     static monitored_chain_t
*find_mon_chain_by_chainid(unsigned int id) P*A*Z*
+ *
+P* Parameters:   unsigned int id
+P*                - The ID of the chain to find
+P*
+P* Returnvalue:  monitored_chain_t *
+P*                - The entry for the chain with id id, or NULL if not
+P*                  found
+ *
+Z* Intention:    Find an entry in the list of monitored chains by
+Z*               searching for a specified id.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+static monitored_chain_t *find_mon_chain_by_chainid(unsigned int id) +{
+	struct list_head *ptr;
+	monitored_chain_t *entry;
+
+	for (ptr = mon_list.next; ptr != &mon_list; ptr = ptr->next) {
+		entry = list_entry(ptr, monitored_chain_t, list);
+		if (entry->chainid == id)
+			return entry;
+	}
+	return NULL;
+}
+
+/***********************************************************************
+F* Function:     static void insert_mon_chain(monitored_chain_t *new)
P*A*Z*
+ *
+P* Parameters:   monitored_chain_t *new
+P*                - The entry to insert into the list
+P*
+P* Returnvalue:  none
+ *
+Z* Intention:    Insert an entry for a monitor chain at the correct
+Z*               position into the module-global list.  Keeping the
+Z*               list sorted with respect to the expiratoin avoids
+Z*               unneccessary processing.
+ *
+D* Design:       dzu@denx.de
+C* Coding:       dzu@denx.de
+V* Verification: wd@denx.de
+
***********************************************************************/
+static void insert_mon_chain(monitored_chain_t *new) +{
+	struct list_head *ptr;
+	monitored_chain_t *entry;
+
+	for (ptr = mon_list.next; ptr != &mon_list; ptr = ptr->next) {
+		entry = list_entry(ptr, monitored_chain_t, list);
+		if (entry->expires >= new->expires) {
+			list_add(&new->list, ptr);
+			return;
+		}
+	}
+	list_add_tail(&new->list, &mon_list);
+}
diff --git a/include/linux/wdt_chains.h b/include/linux/wdt_chains.h
new file mode 100644
index 0000000..8202a4f
--- /dev/null
+++ b/include/linux/wdt_chains.h
@@ -0,0 +1,102 @@
+/*
+ * (C) Copyright 2000
+ * Jorg Haider, SIEMENS AG
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ * (C) 2002 Detlev Zundel, dzu@denx.de - Added "watchdog chains"
+ * (C) 2001 Wolfgang Denk, wd@denx.de - Cleanup, Modifications for 2.4
kernels
+ * (C) 2001 Wolfgang Denk, wd@denx.de - Adaption for MAX706TESA
Watchdog
+ * (C) 2001 Steven Hein,  ssh@sgi.com - Added timeout configuration
option
+ */
+
+/*
+ * The purpose of this header file is to provide an interface for the
+ * driver of the watchdog chain timer wdt_chain. In essence this
interface
+ * consists of the three macros WDT_CHAIN_INIT, WDT_CHAIN_SERVICE,
+ * WDT_CHAIN_CLOSE, and its functionality is described as follows:
+ *
+ * WDT_CHAIN_INIT:      opens the driver and initializes the timer to
+ *                      300 seconds;
+ *
+ * WDT_CHAIN_SERVICE:   writes the value defined by the macro
+ *                      WDT_CHAIN_DEF_SERVICE_TIME to the variable,
+ *                      which serves as a timer counter;
+ *
+ * WDT_CHAIN_CLOSE:     closes the watchdog driver;
+ *
+ * Finally there is a macro called WDT_CHAIN_SET_SERVICE_TIME(sec)
+ * for altering the value written to the timer counter to a value,
+ * which is specified by sec.
+ */
+
+
+#ifndef _wdt_chain_h
+#define _wdt_chain_h
+
+typedef struct	wdt_chain_param {
+	unsigned chainid;
+	unsigned long timer_count[3];
+	int action[3];
+	int signal;
+} wdt_chain_param_t;
+
+/* Constants for the action[] fields */
+#define WDT_CHAIN_ACTION_NO	0
+#define WDT_CHAIN_ACTION_SIGNAL	1
+#define WDT_CHAIN_ACTION_KILL	2
+#define WDT_CHAIN_ACTION_REBOOT	3
+#define WDT_CHAIN_ACTION_RESET	4
+
+#define	WDT_CHAIN_IOCTL_BASE	'W'
+
+#define WDT_CHAIN_OPEN_ONLY	_IO(WDT_CHAIN_IOCTL_BASE, 0)
+#define WDT_CHAIN_ALWAYS	_IO(WDT_CHAIN_IOCTL_BASE, 1)
+#define WDT_CHAIN_REGISTER	_IOW(WDT_CHAIN_IOCTL_BASE, 2,
wdt_chain_param_t) +#define WDT_CHAIN_RESET
_IOW(WDT_CHAIN_IOCTL_BASE, 3, int) +#define WDT_CHAIN_UNREGISTER
_IOW(WDT_CHAIN_IOCTL_BASE, 4, int) +
+#ifndef	__KERNEL__
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <linux/ioctl.h>
+
+#define WDT_CHAIN_DEVICE "/dev/watchdog"
+#define WDT_CHAIN_DEF_SERVICE_TIME 300
+
+int wdt_chain_fd;
+int wdt_chain_value = WDT_CHAIN_DEF_SERVICE_TIME;
+
+#define WDT_CHAIN_INIT (wdt_chain_fd = open(WDT_CHAIN_DEVICE, O_RDWR,
0)) +
+#define WDT_CHAIN_SET_SERVICE_TIME(sec) wdt_chain_value = (sec);
+
+#define WDT_CHAIN_SERVICE write(wdt_chain_fd, (char *)
&wdt_chain_value, \
+
sizeof(wdt_chain_value)) +
+#define WDT_CHAIN_CLOSE close(wdt_chain_fd)
+
+#else
+
+extern	int wdt_chain_hwl_start(void);
+extern	int wdt_chain_hwl_stop(void);
+extern	int wdt_hwl_init(void);
+extern	void wdt_hwl_reset(void);
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _wdt_chain_h */
