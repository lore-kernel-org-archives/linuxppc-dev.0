Return-Path: <rolandd@cisco.com>
Received: from ams-iport-1.cisco.com (ams-iport-1.cisco.com [144.254.224.140])
	by ozlabs.org (Postfix) with ESMTP id 3E2AE684C7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 14:20:38 +1000 (EST)
In-Reply-To: <200510112120.uRMHJGVEYMzhUHUq@cisco.com>
Date: Tue, 11 Oct 2005 21:20:30 -0700
Message-Id: <200510112120.yAT5Bly2IvRrBVKp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: mporter@kernel.crashing.org
From: Roland Dreier <rolandd@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/4] [PPC32] Dump error status for both PLB segments on 440SP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The PowerPC 440SP SoC has two Processor Local Bus (PLB) segments (a
high-throughput segment and a low-latency segment).  Fix our PLB
register definitions to cope with this, and add code to dump the
status of both segments when a machine check occurs.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 arch/ppc/syslib/ibm44x_common.c |   11 +++++++++++
 include/asm-ppc/ibm44x.h        |   20 +++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletions(-)

applies-to: 7a040884fca44f844bfa3063e93174d52633deda
7ae3c6cee4067379f718576833b4dfecc5a35b86
diff --git a/arch/ppc/syslib/ibm44x_common.c b/arch/ppc/syslib/ibm44x_common.c
index 7612e06..457e67e 100644
--- a/arch/ppc/syslib/ibm44x_common.c
+++ b/arch/ppc/syslib/ibm44x_common.c
@@ -181,9 +181,20 @@ void __init ibm44x_platform_init(void)
 /* Called from MachineCheckException */
 void platform_machine_check(struct pt_regs *regs)
 {
+#ifdef CONFIG_440SP
+    	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x%08x\n",
+	       mfdcr(DCRN_PLB0_BEARH), mfdcr(DCRN_PLB0_BEARL),
+	       mfdcr(DCRN_PLB0_ACR), mfdcr(DCRN_PLB0_BESRH),
+	       mfdcr(DCRN_PLB0_BESRL));
+    	printk("PLB1: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x%08x\n",
+	       mfdcr(DCRN_PLB1_BEARH), mfdcr(DCRN_PLB1_BEARL),
+	       mfdcr(DCRN_PLB1_ACR), mfdcr(DCRN_PLB1_BESRH),
+	       mfdcr(DCRN_PLB1_BESRL));
+#else
     	printk("PLB0: BEAR=0x%08x%08x ACR=  0x%08x BESR= 0x%08x\n",
 		mfdcr(DCRN_PLB0_BEARH), mfdcr(DCRN_PLB0_BEARL),
 		mfdcr(DCRN_PLB0_ACR),  mfdcr(DCRN_PLB0_BESR));
+#endif
 	printk("POB0: BEAR=0x%08x%08x BESR0=0x%08x BESR1=0x%08x\n",
 		mfdcr(DCRN_POB0_BEARH), mfdcr(DCRN_POB0_BEARL),
 		mfdcr(DCRN_POB0_BESR0), mfdcr(DCRN_POB0_BESR1));
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index 197a9ff..4ee1e33 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -302,13 +302,31 @@
 #define MALOBISR_CH0		0x80000000	/* EOB channel 1 bit */
 #define MALOBISR_CH2		0x40000000	/* EOB channel 2 bit */
 
-/* 440GP/GX PLB Arbiter DCRs */
+#if defined(CONFIG_440SP)
+/* 440SP PLB Arbiter DCRs */
+#define DCRN_PLB_REVID	       0x080		/* PLB Revision ID */
+#define DCRN_PLB_CCR	       0x088		/* PLB Crossbar Control */
+
+#define DCRN_PLB0_ACR	       0x081		/* PLB Arbiter Control */
+#define DCRN_PLB0_BESRL	       0x082		/* PLB Error Status */
+#define DCRN_PLB0_BESRH	       0x083		/* PLB Error Status */
+#define DCRN_PLB0_BEARL	       0x084		/* PLB Error Address Low */
+#define DCRN_PLB0_BEARH	       0x085		/* PLB Error Address High */
+
+#define DCRN_PLB1_ACR		0x089		/* PLB Arbiter Control */
+#define DCRN_PLB1_BESRL		0x08a		/* PLB Error Status */
+#define DCRN_PLB1_BESRH		0x08b		/* PLB Error Status */
+#define DCRN_PLB1_BEARL		0x08c		/* PLB Error Address Low */
+#define DCRN_PLB1_BEARH		0x08d		/* PLB Error Address High */
+#else
+* 440GP/GX PLB Arbiter DCRs */
 #define DCRN_PLB0_REVID		0x082		/* PLB Arbiter Revision ID */
 #define DCRN_PLB0_ACR		0x083		/* PLB Arbiter Control */
 #define DCRN_PLB0_BESR		0x084		/* PLB Error Status */
 #define DCRN_PLB0_BEARL		0x086		/* PLB Error Address Low */
 #define DCRN_PLB0_BEAR		DCRN_PLB0_BEARL	/* 40x compatibility */
 #define DCRN_PLB0_BEARH		0x087		/* PLB Error Address High */
+#endif
 
 /* 440GP/GX PLB to OPB bridge DCRs */
 #define DCRN_POB0_BESR0		0x090
---
0.99.8.GIT
