Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCAFC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:05:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF55220684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="NGb2umC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF55220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qs5V3gVRzF3K7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 22:05:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NGb2umC/";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QrvT1TjPzF3Jq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 21:56:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="NGb2umC/"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QrvT0s8Yz9sRp; Thu,  4 Oct 2018 21:56:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42QrvS6VXjz9sCw;
 Thu,  4 Oct 2018 21:56:20 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538654181; bh=MVrjagpAlwh0kTcKfj5bpn3lKL2gakBXXZOfJY+zIlM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NGb2umC/akPohTGjvv1dlAnKs22OgcYJAbkM2EvI8U/PwWATFhF1q/W4m4wdcpHMI
 M4Cuv3v9eXillZFe0sOC/O1rIelGqQpkc+WgRm71RKJq66xrpqdYPS3H0jIk7163um
 UmWPFtMIS5v8PQMV7pozpSk/jV9j4R0KQ4sCevgg7XftdQw8wrErSaxOzCPViCS8u2
 MJ51q7Qwvm8luxUcGOx8ERaDNiQ1WGNXp47H2W2hI41sbB45eR3J76DgYjhJiPKE/D
 DrSXoQcYuRqYy6Udw0Dxxj2qE7dJjsN7sAp7mqd9oywHKdVS0YPYNSiMIkXCCk/JWq
 y8zA+/uD06Rvg==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v4 03/32] KVM: PPC: Book3S HV: Remove left-over code in
 XICS-on-XIVE emulation
Date: Thu,  4 Oct 2018 21:55:40 +1000
Message-Id: <1538654169-15602-4-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
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

