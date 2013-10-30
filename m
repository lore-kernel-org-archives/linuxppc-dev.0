Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB7A62C0879
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:38 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 00:35:37 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E11E93578040
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:35 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UEIDep6685170
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:18:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UEZYwc011836
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:35 +1100
Subject: [RFC PATCH v5 08/12] powerpc/book3s: Flush SLB/TLBs if we get SLB/TLB
 machine check errors on power8.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 20:05:26 +0530
Message-ID: <20131030143526.26643.48803.stgit@mars>
In-Reply-To: <20131030143219.26643.24782.stgit@mars>
References: <20131030143219.26643.24782.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
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

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/mce.h  |    3 +++
 arch/powerpc/kernel/cputable.c  |    4 ++++
 arch/powerpc/kernel/mce_power.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 8157d4e..e3ffa82 100644
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
index c54188b..6c8dd5d 100644
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
index 6905473..60a217f 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -148,3 +148,37 @@ long __machine_check_early_realmode_p7(struct pt_regs *regs)
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
