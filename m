Return-Path: <jimix@watson.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC8B4679E0
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 04:48:01 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k77IlteC025006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Aug 2006 14:47:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k77Ilt99142582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Aug 2006 14:47:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k77IltIm010161
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Aug 2006 14:47:55 -0400
Received: from kmac.watson.ibm.com (kmac.watson.ibm.com [9.2.208.86])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k77IltHc010073
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Aug 2006 14:47:55 -0400
Received: from jimix by kmac.watson.ibm.com with local (Exim 4.62)
	(envelope-from <jimix@kmac.watson.ibm.com>) id 1G9jpY-0004Nv-2d
	for linuxppc-dev@ozlabs.org; Sun, 06 Aug 2006 10:42:16 -0400
From: Jimi Xenidis <jimix@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] Debugging with a HW probe.
Message-Id: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
Date: Sun, 06 Aug 2006 10:42:16 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On the XenPPC project we've been playing around with using GDB to
source debug Linux (and Xen) using a RiscWatch HW probe.

On IBM POWER4 and greater processors (and possibly POWER3 and *Star)
there is an instruction called ATTN (asm (".long 0x200")) that will
have the process call out to the HW probe.  This instruction is used
by RiscWatch software to set "soft breakpoints".

We have found it useful to teach xmon to make this call so we can then
debug the SW thru the probe. Is this useful to anyone else?

Below is a quick attempt at a formalized patch, tho' I am torn between
making it ATTN specific or just making a generic HW Probe Service.

All comments welcome.

BTW: We even have some python that will let GDB "talk to" a RiscWatch
     probe and fully source-level debug a Linux kernel (even the
     initial relocatable parts with a few tricks), this code is
     currently part of the our Xen tree (you need mercurial to get
     it):
       http://xenbits.xensource.com/ext/xenppc-unstable.hg

     The python is self contained and in:
       tools/gpproxy



-JX
----

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 8d48e9e..b84f03d 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -82,6 +82,13 @@ config XMON_DEFAULT
 	  xmon is normally disabled unless booted with 'xmon=on'.
 	  Use 'xmon=off' to disable xmon init during runtime.
 
+config XMON_ATTN
+       bool "Use Support Processor Attention Instruction"
+       depends on XMON && PPC64
+       help
+         If you have a hardware probe attached to your processor you
+         can 'contact' it with a the 'A' command at the xmon prompt.
+
 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
 	depends on PPC64
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4735b41..ea1d732 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -37,6 +37,7 @@ #include <asm/cputable.h>
 #include <asm/rtas.h>
 #include <asm/sstep.h>
 #include <asm/bug.h>
+#include <asm/firmware.h>
 
 #ifdef CONFIG_PPC64
 #include <asm/hvcall.h>
@@ -175,7 +176,12 @@ #define isalnum(c)	(('0' <= (c) && (c) <
 #define isspace(c)	(c == ' ' || c == '\t' || c == 10 || c == 13 || c == 0)
 
 static char *help_string = "\
-Commands:\n\
+Commands:\n"
+#ifdef CONFIG_XMON_ATTN
+  "\
+  A     Get the attention of the hardware probe, assuming you have one\n"
+#endif
+  "\
   b	show breakpoints\n\
   bd	set data breakpoint\n\
   bi	set instruction breakpoint\n\
@@ -223,6 +229,70 @@ #endif
 
 static struct pt_regs *xmon_regs;
 
+#ifdef CONFIG_XMON_ATTN
+static int xmon_hw_probe_enabled;
+/* try to keep this funtion from being inlined so its easier to move
+ * around the ATTN instruction */
+static noinline void xmon_hw_probe(void)
+{
+	if (!xmon_hw_probe_enabled)
+		return;
+	ATTN();
+}
+static void xmon_en_hw_probe(int enable)
+{
+	ulong hid0;
+	int threaded = 0;
+
+	/* hopefully the hypervisor has set us up */
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		return;
+	/* should this be a feature? */
+	switch (PVR_VER(mfspr(SPRN_PVR))) {
+	default:
+		return;
+
+	case PV_POWER4:
+	case PV_POWER4p:
+	case PV_POWER5:
+	case PV_POWER5p:
+	case PV_BE:
+		/* stop both threads */
+		threaded = 1;
+	case PV_SSTAR:		
+	case PV_970:
+	case PV_970FX:
+	case PV_970MP:
+		break;
+	}
+	hid0 = mfspr(SPRN_HID0);
+	if (enable) {
+		/* make sure that on threaded processors we stop both
+		 * threads */
+		hid0 |= HID0_ATTN | (threaded ? HID0_QATTN : 0);
+		xmon_hw_probe_enabled = 1;
+	} else {
+		/* only turn the feature off */
+		hid0 &= ~HID0_ATTN;
+		xmon_hw_probe_enabled = 0;
+	}
+	/* many processors require the following sequence */
+	asm volatile(
+		"sync\n"
+		"mtspr     %1, %0\n"
+		"mfspr     %0, %1\n"
+		"mfspr     %0, %1\n"
+		"mfspr     %0, %1\n"
+		"mfspr     %0, %1\n"
+		"mfspr     %0, %1\n"
+		"mfspr     %0, %1\n"
+		"isync" : "=&r" (hid0) : "i" (SPRN_HID0), "0" (hid0):
+		"memory");
+}
+#else
+#define xmon_en_hw_probe(x)
+#endif
+
 static inline void sync(void)
 {
 	asm volatile("sync; isync");
@@ -834,6 +904,11 @@ #ifdef CONFIG_PPC_STD_MMU
 			dump_segments();
 			break;
 #endif
+#ifdef CONFIG_XMON_ATTN
+		case 'A':
+			xmon_hw_probe();
+			break;
+#endif
 		default:
 			printf("Unrecognized command: ");
 		        do {
@@ -2565,6 +2640,7 @@ void xmon_init(int enable)
 		__debugger_dabr_match = NULL;
 		__debugger_fault_handler = NULL;
 	}
+	xmon_en_hw_probe(enable);
 	xmon_map_scc();
 }
 
diff --git a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
index 2ea66ac..33a7922 100644
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index bd467bf..ce82965 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -207,6 +207,8 @@ #define SPRN_EAR	0x11A		/* External Addr
 #define SPRN_HASH1	0x3D2		/* Primary Hash Address Register */
 #define SPRN_HASH2	0x3D3		/* Secondary Hash Address Resgister */
 #define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
+#define HID0_QATTN	(1UL<<35)	/* Sup. Proc. attn insn all threads */
+#define HID0_ATTN	(1UL<<32)	/* Sup. Proc. attn insn */
 #define HID0_EMCP	(1<<31)		/* Enable Machine Check pin */
 #define HID0_EBA	(1<<29)		/* Enable Bus Address Parity */
 #define HID0_EBD	(1<<28)		/* Enable Bus Data Parity */
diff --git a/include/asm-powerpc/xmon.h b/include/asm-powerpc/xmon.h
index 43f7129..cd8f48e 100644
--- a/include/asm-powerpc/xmon.h
+++ b/include/asm-powerpc/xmon.h
@@ -8,5 +8,12 @@ extern int xmon(struct pt_regs *excp);
 extern void xmon_printf(const char *fmt, ...);
 extern void xmon_init(int);
 
+/*
+ * Support Processor Attention Instruction introduced in POWER
+ * architecture processors as of RS64, tho may not be supported by
+ * POWER 3.
+ */
+#define ATTN() asm volatile(".long 0x00000200; nop")
+
 #endif
 #endif
