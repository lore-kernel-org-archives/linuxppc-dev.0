Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDF2C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6202206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 11:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ujc1ovqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6202206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pcl25gL5zDrBy
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 21:44:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ujc1ovqk";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSC5DYtzF35t
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Ujc1ovqk"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSC1l91z9snk; Tue,  2 Oct 2018 21:31:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSB4mDCz9t0P;
 Tue,  2 Oct 2018 21:31:54 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479915; bh=MVrjagpAlwh0kTcKfj5bpn3lKL2gakBXXZOfJY+zIlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ujc1ovqkfsF3ikUuyQuOZp75hb7pcjuLiJ180ENUdI5mgRSg6uDU6zqtgf58vTYEL
 BwApnlDWUdnCmx5ATwsOv1jSUxruCVeKGXk5yP6sat18/LGjQSqeVhZP8XTGe7gtnT
 Ax/r88CfEBUif2tDactftLA3BEC8oRWdIgLl8KPpbQSGdtHUkBgKtmBC3hD8msNuRz
 YzHk+meTtBw5cXSJy2wWZXNiG27LnWkRBj2M96iT9QBA0niSL0w6ibfmWP2zcVi9ek
 QCuKXKc2tOeTEBNG+kR4fsduHHN1u9r8h33L40ukuE8ZQYx9aMfVXKOy3b8UZeHELO
 rpjCEcGHObnyg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 03/33] KVM: PPC: Book3S HV: Remove left-over code in
 XICS-on-XIVE emulation
Date: Tue,  2 Oct 2018 21:31:02 +1000
Message-Id: <1538479892-14835-4-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
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

This removes code that clears the external interrupt pending bit in
the pending_exceptions bitmap.  This is left over from an earlier
iteration of the code where this bit was set when an escalation
interrupt arrived in order to wake the vcpu from cede.  Currently
we set the vcpu->arch.irq_pending flag instead for this purpose.
Therefore there is no need to do anything with the pending_exceptions
bitmap.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_xive_template.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 203ea65..033363d 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -280,14 +280,6 @@ X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm_vcpu *vcpu)
 	/* First collect pending bits from HW */
 	GLUE(X_PFX,ack_pending)(xc);
 
-	/*
-	 * Cleanup the old-style bits if needed (they may have been
-	 * set by pull or an escalation interrupts).
-	 */
-	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions))
-		clear_bit(BOOK3S_IRQPRIO_EXTERNAL,
-			  &vcpu->arch.pending_exceptions);
-
 	pr_devel(" new pending=0x%02x hw_cppr=%d cppr=%d\n",
 		 xc->pending, xc->hw_cppr, xc->cppr);
 
-- 
2.7.4

