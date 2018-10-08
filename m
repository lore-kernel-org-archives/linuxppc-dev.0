Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DFC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:59:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B420B2086D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="edoMGaY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B420B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T8p75894zF3BY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:59:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="edoMGaY3";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89g62jxzF37f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="edoMGaY3"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89g4HgYz9sD2; Mon,  8 Oct 2018 16:31:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89f4pDPzB2xn;
 Mon,  8 Oct 2018 16:31:34 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976694; bh=//z0WiNPH6z7x3wLOT+RyPmo/bgSmijz3OrychlYapw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=edoMGaY38DcdYdp7ARFSnbULDPbFWrJ2e1LuyQzzkjsk5WhkdEVd5PDtbrebdDwt2
 csNF7OnvE43aA4u4WX0XljSjBeGPh8AsfoBVEmgZ78Ol+P7bXWwUGHgUToXLEXciv7
 8/UjMmLA58Ble/mIDh3y/os2vv7sTL+7HEbQEjQTwbxSCs4Wco4QQ7dG7hXZMBRxxp
 zqNfHolIITvURH2YJnqn7ystfS7oY3rZ5QOqZhv9aJU7ZiUdBb0Z73n6v8PyRGFvb3
 QesmghkM1kiSZbEcfvJgpi/C1lwslwwTx0cFfwypKCpYrL/qA/NG1VWwvv4gSlukxk
 LnvioL2q315lw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 10/33] KVM: PPC: Book3S HV: Handle hypervisor instruction
 faults better
Date: Mon,  8 Oct 2018 16:30:56 +1100
Message-Id: <1538976679-1363-11-git-send-email-paulus@ozlabs.org>
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

Currently the code for handling hypervisor instruction page faults
passes 0 for the flags indicating the type of fault, which is OK in
the usual case that the page is not mapped in the partition-scoped
page tables.  However, there are other causes for hypervisor
instruction page faults, such as not being to update a reference
(R) or change (C) bit.  The cause is indicated in bits in HSRR1,
including a bit which indicates that the fault is due to not being
able to write to a page (for example to update an R or C bit).
Not handling these other kinds of faults correctly can lead to a
loop of continual faults without forward progress in the guest.

In order to handle these faults better, this patch constructs a
"DSISR-like" value from the bits which DSISR and SRR1 (for a HISI)
have in common, and passes it to kvmppc_book3s_hv_page_fault() so
that it knows what caused the fault.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/reg.h | 1 +
 arch/powerpc/kvm/book3s_hv.c   | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index e5b314e..6fda746 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -766,6 +766,7 @@
 #define SPRN_HSRR0	0x13A	/* Save/Restore Register 0 */
 #define SPRN_HSRR1	0x13B	/* Save/Restore Register 1 */
 #define   HSRR1_DENORM		0x00100000 /* Denorm exception */
+#define   HSRR1_HISI_WRITE	0x00010000 /* HISI bcs couldn't update mem */
 
 #define SPRN_TBCTL	0x35f	/* PA6T Timebase control register */
 #define   TBCTL_FREEZE		0x0000000000000000ull /* Freeze all tbs */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0c1dd76..e310117 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1188,7 +1188,10 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	case BOOK3S_INTERRUPT_H_INST_STORAGE:
 		vcpu->arch.fault_dar = kvmppc_get_pc(vcpu);
-		vcpu->arch.fault_dsisr = 0;
+		vcpu->arch.fault_dsisr = vcpu->arch.shregs.msr &
+			DSISR_SRR1_MATCH_64S;
+		if (vcpu->arch.shregs.msr & HSRR1_HISI_WRITE)
+			vcpu->arch.fault_dsisr |= DSISR_ISSTORE;
 		r = RESUME_PAGE_FAULT;
 		break;
 	/*
-- 
2.7.4

