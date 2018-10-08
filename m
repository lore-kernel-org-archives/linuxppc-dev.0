Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9AFC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:21:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F0820841
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="lD/RLIcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F0820841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9HL0rfDzF3Dw
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:21:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lD/RLIcU";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89w4WcvzF37n
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="lD/RLIcU"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89w2nMMzB4NT; Mon,  8 Oct 2018 16:31:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89v2wp9z9sj2;
 Mon,  8 Oct 2018 16:31:47 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976707; bh=WwD5MLH2ANOX2Y8esOjMfBuaSZoYTlo2VIaBLD/D5eY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lD/RLIcUid41ao0l5IaImoqu2aynwG0452dSUzGc5JQNbkQNHO/EtdSH+uH4uL3n9
 6v45j3CzTeKaGmgvyD3faaUHv56+ptcpAxMOY8jR3lpEX8Fj9GefIlRNvPSa8ssYk0
 UaFgL6Egej9U0YMZ5X4ReNvKA9EH6pCP834OwLkWP9241yNeJCdq/ReX3HRbBjtwnH
 cbD3lgOdeCbUxNoEZKrfYbXiCYM+qP2EvsUG/mv14y1OIvShyBkv6sM2Mzpbd6IR2P
 JPprI0sjTJe4EeWcYI7msIXQYD9oWzAkPwJCQQSwqKkMI35gwqlgERa9fss4lyYKY8
 525xCHkaaVleA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 19/33] KVM: PPC: Book3S HV: Use XICS hypercalls when
 running as a nested hypervisor
Date: Mon,  8 Oct 2018 16:31:05 +1100
Message-Id: <1538976679-1363-20-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds code to call the H_IPI and H_EOI hypercalls when we are
running as a nested hypervisor (i.e. without the CPU_FTR_HVMODE cpu
feature) and we would otherwise access the XICS interrupt controller
directly or via an OPAL call.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c         |  7 +++++-
 arch/powerpc/kvm/book3s_hv_builtin.c | 44 +++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/book3s_hv_rm_xics.c |  8 +++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d58a4a6..dd84252 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -173,6 +173,10 @@ static bool kvmppc_ipi_thread(int cpu)
 {
 	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 
+	/* If we're a nested hypervisor, fall back to ordinary IPIs for now */
+	if (kvmhv_on_pseries())
+		return false;
+
 	/* On POWER9 we can use msgsnd to IPI any cpu */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		msg |= get_hard_smp_processor_id(cpu);
@@ -5173,7 +5177,8 @@ static int kvmppc_book3s_init_hv(void)
 	 * indirectly, via OPAL.
 	 */
 #ifdef CONFIG_SMP
-	if (!xive_enabled() && !local_paca->kvm_hstate.xics_phys) {
+	if (!xive_enabled() && !kvmhv_on_pseries() &&
+	    !local_paca->kvm_hstate.xics_phys) {
 		struct device_node *np;
 
 		np = of_find_compatible_node(NULL, NULL, "ibm,opal-intc");
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index ccfea5b..a71e2fc 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -231,6 +231,15 @@ void kvmhv_rm_send_ipi(int cpu)
 	void __iomem *xics_phys;
 	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
 
+	/* For a nested hypervisor, use the XICS via hcall */
+	if (kvmhv_on_pseries()) {
+		unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+		plpar_hcall_raw(H_IPI, retbuf, get_hard_smp_processor_id(cpu),
+				IPI_PRIORITY);
+		return;
+	}
+
 	/* On POWER9 we can use msgsnd for any destination cpu. */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		msg |= get_hard_smp_processor_id(cpu);
@@ -460,12 +469,19 @@ static long kvmppc_read_one_intr(bool *again)
 		return 1;
 
 	/* Now read the interrupt from the ICP */
-	xics_phys = local_paca->kvm_hstate.xics_phys;
-	rc = 0;
-	if (!xics_phys)
-		rc = opal_int_get_xirr(&xirr, false);
-	else
-		xirr = __raw_rm_readl(xics_phys + XICS_XIRR);
+	if (kvmhv_on_pseries()) {
+		unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+		rc = plpar_hcall_raw(H_XIRR, retbuf, 0xFF);
+		xirr = cpu_to_be32(retbuf[0]);
+	} else {
+		xics_phys = local_paca->kvm_hstate.xics_phys;
+		rc = 0;
+		if (!xics_phys)
+			rc = opal_int_get_xirr(&xirr, false);
+		else
+			xirr = __raw_rm_readl(xics_phys + XICS_XIRR);
+	}
 	if (rc < 0)
 		return 1;
 
@@ -494,7 +510,13 @@ static long kvmppc_read_one_intr(bool *again)
 	 */
 	if (xisr == XICS_IPI) {
 		rc = 0;
-		if (xics_phys) {
+		if (kvmhv_on_pseries()) {
+			unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+			plpar_hcall_raw(H_IPI, retbuf,
+					hard_smp_processor_id(), 0xff);
+			plpar_hcall_raw(H_EOI, retbuf, h_xirr);
+		} else if (xics_phys) {
 			__raw_rm_writeb(0xff, xics_phys + XICS_MFRR);
 			__raw_rm_writel(xirr, xics_phys + XICS_XIRR);
 		} else {
@@ -520,7 +542,13 @@ static long kvmppc_read_one_intr(bool *again)
 			/* We raced with the host,
 			 * we need to resend that IPI, bummer
 			 */
-			if (xics_phys)
+			if (kvmhv_on_pseries()) {
+				unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+				plpar_hcall_raw(H_IPI, retbuf,
+						hard_smp_processor_id(),
+						IPI_PRIORITY);
+			} else if (xics_phys)
 				__raw_rm_writeb(IPI_PRIORITY,
 						xics_phys + XICS_MFRR);
 			else
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 8b9f356..b3f5786 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -767,6 +767,14 @@ static void icp_eoi(struct irq_chip *c, u32 hwirq, __be32 xirr, bool *again)
 	void __iomem *xics_phys;
 	int64_t rc;
 
+	if (kvmhv_on_pseries()) {
+		unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+		iosync();
+		plpar_hcall_raw(H_EOI, retbuf, hwirq);
+		return;
+	}
+
 	rc = pnv_opal_pci_msi_eoi(c, hwirq);
 
 	if (rc)
-- 
2.7.4

