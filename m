Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B08C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 04:21:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BE5206DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 04:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WH64YnKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BE5206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQfmB6dx3zDqPc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 14:21:30 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQfjg2Z8wzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2020 14:19:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.a=rsa-sha256 header.s=201602 header.b=WH64YnKM; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BQfjf3pLbz9sTS; Tue, 11 Aug 2020 14:19:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597119558;
 bh=2NZiS/B9GDmUuTZl+DIdhj2fNIhZ6RGfvaIFICHqFSM=;
 h=From:To:Cc:Subject:Date:From;
 b=WH64YnKMptRO4Eox2YloZbysBg7ADBHWYMCYZMpjNkFkZ7mEP/KxNx5G3tL1CKXQu
 uhBEtjcHOmb30U2vTPlkz9eIoTSffzJN8sLu7PUF5NjsEsY4f3vQru3UoQGzwgIqFU
 0ONoy5meOvv+eWlw4dGBg3SCcKueEgHNmY1/1gNM=
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc: kvm: Increase HDEC threshold to enter guest
Date: Tue, 11 Aug 2020 14:08:34 +1000
Message-Id: <20200811040834.45930-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Before entering a guest, we need to set the HDEC to pull us out again
when the guest's time is up.  This needs some care, though, because the
HDEC is edge triggered, which means that if it expires before entering the
guest, the interrupt will be lost, meaning we stay in the guest
indefinitely (in practice, until the the hard lockup detector pulls us out
with an NMI).

For the POWER9, independent threads mode specific path, we attempt to
prevent that, by testing time has already expired before setting the HDEC
in kvmhv_load_regs_and_go().  However, that doesn't account for the case
where the timer expires between that test and the actual guest entry.
Preliminary instrumentation suggests that can take as long as 1.5µs under
certain load conditions, and simply checking the HDEC value we're going to
load is positive isn't enough to guarantee that leeway.

That test here is sometimes masked by a test in kvmhv_p9_guest_entry(), its
caller.  That checks that the remaining time is at 1µs.  However as noted
above that doesn't appear to be sufficient in all circumstances even
from the point HDEC is set, let alone this earlier point.

Therefore, increase the threshold we check for in both locations to 4µs
(2048 timebase ticks).  This is a pretty crude approach, but it addresses
a real problem where guest load can trigger a host hard lockup.

We're hoping to refine this in future by gathering more data on exactly
how long these paths can take, and possibly by moving the check closer to
the actual guest entry point to reduce the variance.  Getting the details
for that might take some time however.

NOTE: For reasons I haven't yet tracked down yet, I haven't actually
managed to reproduce this on current upstream.  I have reproduced it on
RHEL kernels without obvious differences in this area.  I'm still trying
to determine what the cause of that difference is, but I think it's worth
applying this change as a precaution in the interim.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 0f83f39a2bd2..65a92dd890cb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3435,7 +3435,7 @@ static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
 	unsigned long host_pidr = mfspr(SPRN_PID);
 
 	hdec = time_limit - mftb();
-	if (hdec < 0)
+	if (hdec < 2048)
 		return BOOK3S_INTERRUPT_HV_DECREMENTER;
 	mtspr(SPRN_HDEC, hdec);
 
@@ -3564,7 +3564,7 @@ int kvmhv_p9_guest_entry(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	dec = mfspr(SPRN_DEC);
 	tb = mftb();
-	if (dec < 512)
+	if (dec < 2048)
 		return BOOK3S_INTERRUPT_HV_DECREMENTER;
 	local_paca->kvm_hstate.dec_expires = dec + tb;
 	if (local_paca->kvm_hstate.dec_expires < time_limit)
-- 
2.26.2

