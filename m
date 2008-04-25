Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9389DDEB99
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 23:45:39 +1000 (EST)
Received: from kiwi.ptxnet.pengutronix.de ([10.1.0.84])
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <sha@pengutronix.de>) id 1JpOF4-0006rU-Me
	for linuxppc-dev@ozlabs.org; Fri, 25 Apr 2008 15:45:34 +0200
Received: from sha by kiwi.ptxnet.pengutronix.de with local (Exim 4.69)
	(envelope-from <sha@pengutronix.de>) id 1JpOHV-0002pW-9P
	for linuxppc-dev@ozlabs.org; Fri, 25 Apr 2008 15:48:05 +0200
Date: Fri, 25 Apr 2008 15:48:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] add Phytec pcm030 board support
Message-ID: <20080425134805.GP6692@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add board support for the Phytec pcm030 mpc5200b based board. It
does not need any platform specific fixups and as such is handled
as a mpc5200 simple platform.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/powerpc/boot/dts/pcm030.dts             |  363 ++++++++
 arch/powerpc/configs/52xx/pcm030_defconfig   | 1109 +++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 
 3 files changed, 1473 insertions(+)

Index: linux-2.6-powerpc/arch/powerpc/boot/dts/pcm030.dts
===================================================================
--- /dev/null
+++ linux-2.6-powerpc/arch/powerpc/boot/dts/pcm030.dts
@@ -0,0 +1,363 @@
+/*
+ * phyCORE-MPC5200B-tiny (pcm030) board Device Tree Source
+ *
+ * Copyright 2006 Pengutronix
+ * Sascha Hauer <s.hauer@pengutronix.de>
+ * Copyright 2007 Pengutronix
+ * Juergen Beisert <j.beisert@pengutronix.de>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "phytec,pcm030";
+	compatible = "phytec,pcm030";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5200@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <0x4000>;	/* L1, 16K          */
+			i-cache-size = <0x4000>;	/* L1, 16K          */
+			timebase-frequency = <0>;	/* From Bootloader  */
+			bus-frequency = <0>;		/* From Bootloader  */
+			clock-frequency = <0>;		/* From Bootloader  */
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x04000000>;	/* 64MB */
+	};
+
+	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc5200b-immr";
+		ranges = <0x0 0xf0000000 0x0000c000>;
+		bus-frequency = <0>;		/* From bootloader */
+		system-frequency = <0>;		/* From bootloader */
+
+		cdm@200 {
+			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
+			reg = <0x200 0x38>;
+		};
+
+		mpc5200_pic: interrupt-controller@500 {
+			/* 5200 interrupts are encoded into two levels; */
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			device_type = "interrupt-controller";
+			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
+			reg = <0x500 0x80>;
+		};
+
+		timer@600 {	/* General Purpose Timer */
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <0>;
+			reg = <0x600 0x10>;
+			interrupts = <0x1 0x9 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl,has-wdt;
+		};
+
+		timer@610 {	/* General Purpose Timer */
+			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
+			cell-index = <1>;
+			reg = <0x610 0x10>;
+			interrupts = <0x1 0xa 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		gpt2: timer@620 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <2>;
+			reg = <0x620 0x10>;
+			interrupts = <0x1 0xb 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt3: timer@630 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <3>;
+			reg = <0x630 0x10>;
+			interrupts = <0x1 0xc 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt4: timer@640 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <4>;
+			reg = <0x640 0x10>;
+			interrupts = <0x1 0xd 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt5: timer@650 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <5>;
+			reg = <0x650 0x10>;
+			interrupts = <0x1 0xe 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt6: timer@660 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <6>;
+			reg = <0x660 0x10>;
+			interrupts = <0x1 0xf 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpt7: timer@670 { /* General Purpose Timer in GPIO mode */
+			compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
+			cell-index = <7>;
+			reg = <0x670 0x10>;
+			interrupts = <0x1 0x10 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		rtc@800 {	// Real time clock
+			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
+			device_type = "rtc";
+			reg = <0x800 0x100>;
+			interrupts = <0x1 0x5 0x0 0x1 0x6 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		can@900 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			cell-index = <0>;
+			interrupts = <0x2 0x11 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x900 0x80>;
+		};
+
+		can@980 {
+			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
+			cell-index = <1>;
+			interrupts = <0x2 0x12 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x980 0x80>;
+		};
+
+		gpio_simple: gpio@b00 {
+			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
+			reg = <0xb00 0x40>;
+			interrupts = <0x1 0x7 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpio_wkup: gpio-wkup@c00 {
+			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
+			reg = <0xc00 0x40>;
+			interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		spi@f00 {
+			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			reg = <0xf00 0x20>;
+			interrupts = <0x2 0xd 0x0 0x2 0xe 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		usb@1000 {
+			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
+			reg = <0x1000 0xff>;
+			interrupts = <0x2 0x6 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		dma-controller@1200 {
+			device_type = "dma-controller";
+			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
+			reg = <0x1200 0x80>;
+			interrupts = <0x3 0x0 0x0  0x3 0x1 0x0  0x3 0x2 0x0  0x3 0x3 0x0
+			              0x3 0x4 0x0  0x3 0x5 0x0  0x3 0x6 0x0  0x3 0x7 0x0
+			              0x3 0x8 0x0  0x3 0x9 0x0  0x3 0xa 0x0  0x3 0xb 0x0
+			              0x3 0xc 0x0  0x3 0xd 0x0  0x3 0xe 0x0  0x3 0xf 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		xlb@1f00 {
+			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
+			reg = <0x1f00 0x100>;
+		};
+
+		ac97@2000 { /* PSC1 in ac97 mode */
+			device_type = "sound";
+			compatible = "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
+			cell-index = <0>;
+			reg = <0x2000 0x100>;
+			interrupts = <0x2 0x2 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		/* PSC2 port is used by CAN1/2 */
+
+		serial@2400 { /* PSC3 in UART mode */
+			device_type = "serial";
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			port-number = <0>;
+			cell-index = <2>;
+			reg = <0x2400 0x100>;
+			interrupts = <0x2 0x3 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		/* PSC4 is ??? */
+
+		/* PSC5 is ??? */
+
+		serial@2c00 { /* PSC6 in UART mode */
+			device_type = "serial";
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			port-number = <1>;
+			cell-index = <5>;
+			reg = <0x2c00 0x100>;
+			interrupts = <0x2 0x4 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		ethernet@3000 {
+			device_type = "network";
+			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
+			reg = <0x3000 0x400>;
+			local-mac-address = [00 00 00 00 00 00];
+			interrupts = <0x2 0x5 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			phy-handle = <&phy0>;
+		};
+
+		mdio@3000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
+			reg = <0x3000 0x400>;	/* fec range, since we need to setup fec interrupts */
+			interrupts = <0x2 0x5 0x0>;	/* these are for "mii command finished", not link changes & co. */
+			interrupt-parent = <&mpc5200_pic>;
+
+			phy0:ethernet-phy@0 {
+				device_type = "ethernet-phy";
+				reg = <0x0>;
+			};
+		};
+
+		ata@3a00 {
+			device_type = "ata";
+			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
+			reg = <0x3a00 0x100>;
+			interrupts = <0x2 0x7 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+		};
+
+		i2c@3d00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			cell-index = <0>;
+			reg = <0x3d00 0x40>;
+			interrupts = <0x2 0xf 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+		};
+
+		i2c@3d40 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
+			cell-index = <1>;
+			reg = <0x3d40 0x40>;
+			interrupts = <0x2 0x10 0x0>;
+			interrupt-parent = <&mpc5200_pic>;
+			fsl5200-clocking;
+			rtc@51 {
+				device_type = "rtc";
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+			};
+			/* FIXME: EEPROM */
+		};
+
+		sram@8000 {
+			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram","sram";
+			reg = <0x8000 0x4000>;
+		};
+
+		/* This is only an example device to show the usage of gpios. It maps all available
+		 * gpios to the "gpio-provider" device.
+		 */
+		gpio {
+			compatible = "gpio-provider";
+
+						    /* mpc52xx		exp.con		patchfield */
+			gpios = <&gpio_wkup	0 0 /* GPIO_WKUP_7	11d		jp13-3     */
+				 &gpio_wkup	1 0 /* GPIO_WKUP_6	14c			   */
+				 &gpio_wkup	6 0 /* PSC2_4		43c		x5-11	   */
+				 &gpio_simple	2 0 /* IRDA_1		24c		x7-6	set GPS_PORT_CONFIG[IRDA] = 0 */
+				 &gpio_simple	3 0 /* IRDA_0				x8-5	set GPS_PORT_CONFIG[IRDA] = 0 */
+				 &gpt2		0 0 /* timer2		12d		x4-4	   */
+				 &gpt3		0 0 /* timer3		13d		x6-4	   */
+				 &gpt4		0 0 /* timer4		61c		x2-16	   */
+				 &gpt5		0 0 /* timer5		44c		x7-11	   */
+				 &gpt6		0 0 /* timer6		60c		x8-15	   */
+				 &gpt7		0 0 /* timer7		36a		x17-9	   */
+				 >;
+		};
+	};
+
+	pci@f0000d00 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
+		reg = <0xf0000d00 0x100>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <0xc000 0x0 0x0 0x1 &mpc5200_pic 0x0 0x0 0x3 /* 1st slot */
+				 0xc000 0x0 0x0 0x2 &mpc5200_pic 0x1 0x1 0x3
+				 0xc000 0x0 0x0 0x3 &mpc5200_pic 0x1 0x2 0x3
+				 0xc000 0x0 0x0 0x4 &mpc5200_pic 0x1 0x3 0x3
+
+				 0xc800 0x0 0x0 0x1 &mpc5200_pic 0x1 0x1 0x3 /* 2nd slot */
+				 0xc800 0x0 0x0 0x2 &mpc5200_pic 0x1 0x2 0x3
+				 0xc800 0x0 0x0 0x3 &mpc5200_pic 0x1 0x3 0x3
+				 0xc800 0x0 0x0 0x4 &mpc5200_pic 0x0 0x0 0x3>;
+		clock-frequency = <0>; // From boot loader
+		interrupts = <0x2 0x8 0x0 0x2 0x9 0x0 0x2 0xa 0x0>;
+		interrupt-parent = <&mpc5200_pic>;
+		bus-range = <0 0>;
+		ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x20000000
+			  0x02000000 0x0 0xa0000000 0xa0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xb0000000 0x0 0x01000000>;
+	};
+};
Index: linux-2.6-powerpc/arch/powerpc/configs/52xx/pcm030_defconfig
===================================================================
--- /dev/null
+++ linux-2.6-powerpc/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -0,0 +1,1109 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.25
+# Fri Apr 25 14:46:54 2008
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_ALTIVEC is not set
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
+CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DEFAULT_UIMAGE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION="trunk"
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_KPROBES is not set
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_CLASSIC_RCU=y
+
+#
+# Platform support
+#
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_MPC512x is not set
+# CONFIG_PPC_MPC5121 is not set
+# CONFIG_MPC5121_ADS is not set
+CONFIG_PPC_MPC52xx=y
+CONFIG_PPC_MPC5200_SIMPLE=y
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_MPC5200_BUGFIX is not set
+# CONFIG_PPC_PMAC is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_EMBEDDED6xx is not set
+# CONFIG_IPIC is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_PPC_BESTCOMM=y
+CONFIG_PPC_BESTCOMM_ATA=y
+CONFIG_PPC_BESTCOMM_FEC=y
+CONFIG_PPC_BESTCOMM_GEN_BD=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+# CONFIG_SCHED_HRTICK is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+# CONFIG_PREEMPT_RCU is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_IOMMU_HELPER is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_HAS_WALK_MEMORY=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_KEXEC is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_GENERIC_ISA_DMA=y
+# CONFIG_PPC_INDIRECT_PCI is not set
+CONFIG_FSL_SOC=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0xc0000000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_OF_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x0
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=1
+# CONFIG_MTD_PHYSMAP_OF is not set
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=m
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_SCSI_PROC_FS is not set
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=m
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=m
+# CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_FSL is not set
+CONFIG_ATA_SFF=y
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+CONFIG_PATA_MPC52xx=m
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NINJA32 is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_NS87415 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
+# CONFIG_PATA_PLATFORM is not set
+# CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
+CONFIG_FEC_MPC52xx=y
+CONFIG_FEC_MPC52xx_MDIO=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_MPC52xx=y
+CONFIG_SERIAL_MPC52xx_CONSOLE=y
+CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=9600
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+CONFIG_SENSORS_EEPROM=m
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_EHCI_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=m
+# CONFIG_USB_OHCI_HCD_PPC_SOC is not set
+CONFIG_USB_OHCI_HCD_PPC_OF=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
+# CONFIG_USB_OHCI_HCD_PCI is not set
+CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
+CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
+# CONFIG_USB_OHCI_LITTLE_ENDIAN is not set
+# CONFIG_USB_UHCI_HCD is not set
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=m
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+# CONFIG_USB_MON is not set
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
+# CONFIG_EDAC is not set
+CONFIG_RTC_LIB=m
+CONFIG_RTC_CLASS=m
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+CONFIG_RTC_DRV_PCF8563=m
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_DMADEVICES is not set
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=m
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=m
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=m
+CONFIG_FS_MBCACHE=m
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_CODEPAGE=850
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_CRYPTO is not set
+CONFIG_PPC_CLOCK=y
+CONFIG_PPC_LIB_RHEAP=y
Index: linux-2.6-powerpc/arch/powerpc/platforms/52xx/mpc5200_simple.c
===================================================================
--- linux-2.6-powerpc.orig/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ linux-2.6-powerpc/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -51,6 +51,7 @@ static void __init mpc5200_simple_setup_
 /* list of the supported boards */
 static char *board[] __initdata = {
 	"promess,motionpro",
+	"phytec,pcm030",
 	"schindler,cm5200",
 	"tqc,tqm5200",
 	NULL

-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-
