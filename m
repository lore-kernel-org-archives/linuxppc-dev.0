Return-Path: <jyoung5@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8024CDDE06
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 08:26:51 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m54MQl7o012209
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 18:26:47 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m54MQkSQ101212
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 16:26:46 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m54MQkUU021600
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 16:26:46 -0600
Received: from [9.67.175.64] (wecm-9-67-175-64.wecm.ibm.com [9.67.175.64])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m54MQjNg021548
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 16:26:46 -0600
Subject: [PATCH] Fix definitions for dbcr0, dbcr1, & dbcr2 register for
	bookE processors
From: Jerone Young <jyoung5@us.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 04 Jun 2008 17:26:44 -0500
Message-Id: <1212618404.7128.2.camel@thinkpadL>
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

Taken from the PowerPC ISA BookIII-E specifies that DBCR0 is different
for all others that are not ppc405 chips. So I have now chnaged the
conditional to reflect this. Also added definitions needed for DBCR1 &
DBCR2.

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
@@ -275,6 +276,46 @@
 #define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
 #define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
 #define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+#elif defined(CONFIG_BOOKE)
+#define DBCR0_EDM	0x80000000	/* External Debug Mode */
+#define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
+#define DBCR0_RST	0x30000000	/* all the bits in the RST field */
+#define DBCR0_RST_SYSTEM 0x30000000	/* System Reset */
+#define DBCR0_RST_CHIP	0x20000000	/* Chip Reset */
+#define DBCR0_RST_CORE	0x10000000	/* Core Reset */
+#define DBCR0_RST_NONE	0x00000000	/* No Reset */
+#define DBCR0_IC	0x08000000	/* Instruction Completion */
+#define DBCR0_BT	0x04000000	/* Branch Taken */
+#define DBCR0_EDE	0x02000000	/* Exception Debug Event */
+#define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
+#define DBCR0_IA1	0x00800000	/* Instr Addr compare 1 enable */
+#define DBCR0_IA2	0x00400000	/* Instr Addr compare 2 enable */
+#define DBCR0_IA3	0x00200000	/* Instr Addr compare 3 enable */
+#define DBCR0_IA4	0x00100000	/* Instr Addr compare 4 enable */
+#define DBCR0_DAC1R	0x00080000	/* DAC 1 Read enable */
+#define DBCR0_DAC1W	0x00040000	/* DAC 1 Write enable */
+#define DBCR0_DAC2R	0x00020000	/* DAC 2 Read enable */
+#define DBCR0_DAC2W	0x00010000	/* DAC 2 Write enable */
+#define DBCR0_RET	0x00008000	/* Return Debug Event */
+#define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+#endif
+
+/* Bit definitions related to the DBCR1. */
+#if defined(CONFIG_BOOKE)
+#define DBCR1_IA12	0x00800000	/* Instr Addr 1-2 range enable */
+#define DBCR1_IA12X	0x00C00000	/* Instr Addr 1-2 range eXclusive */
+#define DBCR1_IA12T	0x00010000	/* Instr Addr 1-2 range Toggle */
+#define DBCR1_IA34	0x00000080	/* Instr Addr 3-4 range enable */
+#define DBCR1_IA34X	0x000000C0	/* Instr Addr 3-4 range eXclusive */
+#define DBCR1_IA34T	0x00000001	/* Instr Addr 3-4 range Toggle */
+#endif
+
+/* Bit definitions related to the DBCR2. */
+#if defined(CONFIG_BOOKE)
+#define DBCR2_DAC12	0x00800000	/* DAC 1-2 range enable */
+#define DBCR2_DAC12X	0x00C00000	/* DAC 1-2 range eXclusive */
+#define DBCR2_DAC12A	0x00200000	/* DAC 1-2 Asynchronous */
+#endif
 
 /* Bit definitions related to the TCR. */
 #define TCR_WP(x)	(((x)&0x3)<<30)	/* WDT Period */
