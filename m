Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E81AA2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:50:05 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 15 Nov 2012 14:49:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAF4daod64422010
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:39:36 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAF4nx2X028238
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 15:49:59 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/7] powerpc: Define differences between doorbells on book3e
 and book3s
Date: Thu, 15 Nov 2012 15:49:44 +1100
Message-Id: <1352954990-2858-2-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
References: <1352954990-2858-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

There are a few key differences between doorbells on server compared
with embedded that we care about on Linux, namely:

- We have a new msgsndp instruction for directed privileged doorbells.
  msgsnd is used for directed hypervisor doorbells.
- The tag we use in the instruction is the Thread Identification
  Register of the recipient thread (since server doorbells can only
  occur between threads within a single core), and is only 7 bits wide.
- A new message type is introduced for server doorbells (none of the
  existing book3e message types are currently supported on book3s).

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Tested-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/dbell.h      |   15 +++++++++++++++
 arch/powerpc/include/asm/ppc-opcode.h |    3 +++
 arch/powerpc/include/asm/reg.h        |    1 +
 arch/powerpc/kernel/dbell.c           |    4 ++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 607e4ee..3b33856 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -28,8 +28,23 @@ enum ppc_dbell {
 	PPC_G_DBELL = 2,	/* guest doorbell */
 	PPC_G_DBELL_CRIT = 3,	/* guest critical doorbell */
 	PPC_G_DBELL_MC = 4,	/* guest mcheck doorbell */
+	PPC_DBELL_SERVER = 5,	/* doorbell on server */
 };
 
+#ifdef CONFIG_PPC_BOOK3S
+
+#define PPC_DBELL_MSGTYPE		PPC_DBELL_SERVER
+#define SPRN_DOORBELL_CPUTAG		SPRN_TIR
+#define PPC_DBELL_TAG_MASK		0x7f
+
+#else /* CONFIG_PPC_BOOK3S */
+
+#define PPC_DBELL_MSGTYPE		PPC_DBELL
+#define SPRN_DOORBELL_CPUTAG		SPRN_PIR
+#define PPC_DBELL_TAG_MASK		0x3fff
+
+#endif /* CONFIG_PPC_BOOK3S */
+
 extern void doorbell_cause_ipi(int cpu, unsigned long data);
 extern void doorbell_exception(struct pt_regs *regs);
 extern void doorbell_setup_this_cpu(void);
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index e434d8b..45fd394 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -100,6 +100,7 @@
 #define PPC_INST_MFSPR_PVR		0x7c1f42a6
 #define PPC_INST_MFSPR_PVR_MASK		0xfc1fffff
 #define PPC_INST_MSGSND			0x7c00019c
+#define PPC_INST_MSGSNDP		0x7c00011c
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_POPCNTB		0x7c0000f4
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
@@ -224,6 +225,8 @@
 					___PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					___PPC_RB(b))
+#define PPC_MSGSNDP(b)		stringify_in_c(.long PPC_INST_MSGSNDP | \
+					___PPC_RB(b))
 #define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
 					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1b853f7..736c6af 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -483,6 +483,7 @@
 #ifndef SPRN_PIR
 #define SPRN_PIR	0x3FF	/* Processor Identification Register */
 #endif
+#define SPRN_TIR	0x1BE	/* Thread Identification Register */
 #define SPRN_PTEHI	0x3D5	/* 981 7450 PTE HI word (S/W TLB load) */
 #define SPRN_PTELO	0x3D6	/* 982 7450 PTE LO word (S/W TLB load) */
 #define SPRN_PURR	0x135	/* Processor Utilization of Resources Reg */
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index a892680..9ebbc24 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -21,7 +21,7 @@
 #ifdef CONFIG_SMP
 void doorbell_setup_this_cpu(void)
 {
-	unsigned long tag = mfspr(SPRN_PIR) & 0x3fff;
+	unsigned long tag = mfspr(SPRN_DOORBELL_CPUTAG) & PPC_DBELL_TAG_MASK;
 
 	smp_muxed_ipi_set_data(smp_processor_id(), tag);
 }
@@ -30,7 +30,7 @@ void doorbell_cause_ipi(int cpu, unsigned long data)
 {
 	/* Order previous accesses vs. msgsnd, which is treated as a store */
 	mb();
-	ppc_msgsnd(PPC_DBELL, 0, data);
+	ppc_msgsnd(PPC_DBELL_MSGTYPE, 0, data);
 }
 
 void doorbell_exception(struct pt_regs *regs)
-- 
1.7.10.4
