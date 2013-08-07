Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D88AE2C0386
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:42:00 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 19:38:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2C4AA2CE8053
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:39:09 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r779NSJX59179010
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:23:28 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r779d8HB018195
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:39:08 +1000
Subject: [RFC PATCH 6/9] powerpc: Flush SLB/TLBs if we get SLB/TLB machine
 check errors on power8.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 15:09:04 +0530
Message-ID: <20130807093904.5389.62166.stgit@mars.in.ibm.com>
In-Reply-To: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This patch handles the memory errors on power8. If we get a machine check
exception due to SLB or TLB errors, then flush SLBs/TLBs and reload SLBs to
recover.

I do not have access to power8 box, hence this patch haven't been tested
yet.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h  |    3 +++
 arch/powerpc/kernel/cputable.c  |    4 ++++
 arch/powerpc/kernel/mce_power.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index ba19073..6866062 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -64,4 +64,7 @@
 					 P7_DSISR_MC_SLB_MULTIHIT | \
 					 P7_DSISR_MC_SLB_MULTIHIT_PARITY)
 
+#define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
+					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
+
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c28cc2c..0195358 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -74,6 +74,7 @@ extern void __restore_cpu_a2(void);
 extern void __flush_tlb_power7(unsigned long inval_selector);
 extern void __flush_tlb_power8(unsigned long inval_selector);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
+extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -462,6 +463,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.flush_tlb		= __flush_tlb_power8,
+		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
 	{	/* Power7 */
@@ -521,6 +523,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.flush_tlb		= __flush_tlb_power8,
+		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
 	{	/* Power8 */
@@ -540,6 +543,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.flush_tlb		= __flush_tlb_power8,
+		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
 	{	/* Cell Broadband Engine */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 645d722..949d102 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -151,3 +151,37 @@ long __machine_check_early_realmode_p7(struct pt_regs *regs)
 	/* TODO: Decode machine check reason. */
 	return handled;
 }
+
+static long mce_handle_ierror_p8(uint64_t srr1)
+{
+	long handled = 0;
+
+	handled = mce_handle_common_ierror(srr1);
+
+	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
+		flush_and_reload_slb();
+		handled = 1;
+	}
+	return handled;
+}
+
+static long mce_handle_derror_p8(uint64_t dsisr)
+{
+	return mce_handle_derror(dsisr, P8_DSISR_MC_SLB_ERRORS);
+}
+
+long __machine_check_early_realmode_p8(struct pt_regs *regs)
+{
+	uint64_t srr1;
+	long handled = 1;
+
+	srr1 = regs->msr;
+
+	if (P7_SRR1_MC_LOADSTORE(srr1))
+		handled = mce_handle_derror_p8(regs->dsisr);
+	else
+		handled = mce_handle_ierror_p8(srr1);
+
+	/* TODO: Decode machine check reason. */
+	return handled;
+}
