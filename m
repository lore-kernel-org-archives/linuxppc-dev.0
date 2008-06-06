Return-Path: <jyoung5@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9099DE2DB
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 02:37:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m56Gba1G026960
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 12:37:36 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m56GbZ6I200342
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 12:37:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m56GbZHA010039
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 12:37:35 -0400
Received: from [9.53.41.205] (thinkpadL.austin.ibm.com [9.53.41.205])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m56GbZo3010015
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 12:37:35 -0400
Subject: [v3] Fix definitions for dbcr0, dbcr1, & dbcr2 register for bookE
	processors
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 11:37:34 -0500
Message-Id: <1212770254.9674.2.camel@thinkpadL>
Mime-Version: 1.0
Reply-To: jyoung5@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates: Made names match BookeE names in BookeE spec, Added comment that DBCR0_RST* was not followed in fsl.
         * Did not get a chance to add missing entries for other cases with DBCR1 & DBCR0 .. but if anyone
           would like to add them, that would be awsome!

Taken from the PowerPC ISA BookIII-E specifies that DBCR0 is different  for all others that are not ppc405 chips. So I have now chnaged the conditional to reflect this. Also added definitions needed for DBCR1 & DBCR2.

Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
--- a/include/asm-powerpc/reg_booke.h
+++ b/include/asm-powerpc/reg_booke.h
@@ -253,6 +253,7 @@
 #define ESR_BO		0x00020000	/* Byte Ordering */
 
 /* Bit definitions related to the DBCR0. */
+#if defined(CONFIG_40x)
 #define DBCR0_EDM	0x80000000	/* External Debug Mode */
 #define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
 #define DBCR0_RST	0x30000000	/* all the bits in the RST field */
@@ -275,6 +276,52 @@
 #define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
 #define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+#elif defined(CONFIG_BOOKE)
+#define DBCR0_EDM	0x80000000	/* External Debug Mode */
+#define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
+/* DBCR0_RST* is 44x specific and not followed in fsl booke */
+#define DBCR0_RST	0x30000000	/* all the bits in the RST field */
+#define DBCR0_RST_SYSTEM 0x30000000	/* System Reset */
+#define DBCR0_RST_CHIP	0x20000000	/* Chip Reset */
+#define DBCR0_RST_CORE	0x10000000	/* Core Reset */
+#define DBCR0_RST_NONE	0x00000000	/* No Reset */
+#define DBCR0_ICMP	0x08000000	/* Instruction Completion */
+#define DBCR0_IC	DBCR0_ICMP
+#define DBCR0_BRT	0x04000000	/* Branch Taken */
+#define DBCR0_BR	DBCR0_BRT
+#define DBCR0_IRPT	0x02000000	/* Exception Debug Event */
+#define DBCR0_EDE	DBCR0_IRPT
+#define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
+#define DBCR0_IAC1	0x00800000	/* Instr Addr compare 1 enable */
+#define DBCR0_IA1	DBCR0_IAC1
+#define DBCR0_IAC2	0x00400000	/* Instr Addr compare 2 enable */
+#define DBCR0_IA2	DBCR0_IAC2
+#define DBCR0_IAC3	0x00200000	/* Instr Addr compare 3 enable */
+#define DBCR0_IA3	DBCR0_IAC3
+#define DBCR0_IAC4	0x00100000	/* Instr Addr compare 4 enable */
+#define DBCR0_IA4	DBCR0_IAC4
+#define DBCR0_DAC1R	0x00080000	/* DAC 1 Read enable */
+#define DBCR0_DAC1W	0x00040000	/* DAC 1 Write enable */
+#define DBCR0_DAC2R	0x00020000	/* DAC 2 Read enable */
+#define DBCR0_DAC2W	0x00010000	/* DAC 2 Write enable */
+#define DBCR0_RET	0x00008000	/* Return Debug Event */
+#define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+#endif
+
+#if defined(CONFIG_BOOKE)
+/* Bit definitions related to the DBCR1. */
+#define DBCR1_IAC12M	0x00800000	/* Instr Addr 1-2 range enable */
+#define DBCR1_IAC12MX	0x00C00000	/* Instr Addr 1-2 range eXclusive */
+#define DBCR1_IAC12AT	0x00010000	/* Instr Addr 1-2 range Toggle */
+#define DBCR1_IAC34M	0x00000080	/* Instr Addr 3-4 range enable */
+#define DBCR1_IAC34MX	0x000000C0	/* Instr Addr 3-4 range eXclusive */
+#define DBCR1_IAC34AT	0x00000001	/* Instr Addr 3-4 range Toggle */
+
+/* Bit definitions related to the DBCR2. */
+#define DBCR2_DAC12M	0x00800000	/* DAC 1-2 range enable */
+#define DBCR2_DAC12MX	0x00C00000	/* DAC 1-2 range eXclusive */
+#define DBCR2_DAC12A	0x00200000	/* DAC 1-2 Asynchronous */
+#endif
 
 /* Bit definitions related to the TCR. */
 #define TCR_WP(x)	(((x)&0x3)<<30)	/* WDT Period */
