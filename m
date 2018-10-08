Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27787C00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:42:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EC02077C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 05:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="emeMinMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EC02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T8QN3xvWzF38v
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 16:42:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="emeMinMD";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89Z1NyVzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="emeMinMD"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89Z0bKDz9sCr; Mon,  8 Oct 2018 16:31:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89Y5Pkwz9sj3;
 Mon,  8 Oct 2018 16:31:29 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976689; bh=MVrjagpAlwh0kTcKfj5bpn3lKL2gakBXXZOfJY+zIlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=emeMinMD5Dki0gnGtGhXyFuYKrQonGxQobHqdtPEC4/vqCqsV2cBJlUJtrEmO5GYc
 yysho+FZ2hDCSldMgYPLauEBl+1mOGaxraNGvVtFpLLlNm+S1z6IJB9lel5CWCQS8y
 UbXLFWptmMKqiOy+9HsEP/Rj+JZCCB/RdFKllM4yywYbE8X56qmVBs4NThzmY0QUmH
 t2erdgyGaDbFR5a3Aq58hN8bqHN/vxWvb6lvsEUNoDEnTBZUsW1cAfZT8gJlJ8WWGg
 xkMIW/LP+Zo+XSUv9izwNXtPX5SkVO2gyH34VQV42XGGQlIlgX/VSGD27msd9mGby4
 zUKNYQvjwr98A==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 03/33] KVM: PPC: Book3S HV: Remove left-over code in
 XICS-on-XIVE emulation
Date: Mon,  8 Oct 2018 16:30:49 +1100
Message-Id: <1538976679-1363-4-git-send-email-paulus@ozlabs.org>
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

