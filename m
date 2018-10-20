Return-Path: <SRS0=IXoQ=NA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64231C67863
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 09:57:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD7421476
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 09:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="moN6I8qN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD7421476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42cdVk0K4xzF33P
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 20:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="moN6I8qN";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42cdS65RmdzF31V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 20:55:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="moN6I8qN"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42cdS64kXcz9sCm; Sat, 20 Oct 2018 20:55:02 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42cdS64BR6z9sCt; Sat, 20 Oct 2018 20:55:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1540029302; bh=oqhZiYBBct14AT27BQObH6fHkGa9lEW36BuSNpIydWA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=moN6I8qNuTtvKrjG2Wf3qGNbq2ysw2pDQcsYj4bnO9ViULRdeVkBNWMV/bFrLB82p
 s6cQ6LSHRwstHjLWInwQFsl7KI3OhHtWVrq9/IE7EuF2LM7RAN6KjQzIP/ksGmwBH3
 mnV909ZB5WMXLFj20Y6Ea3pZsDB6XX8fY8ZbpmQybXJ2oV3ib9LpIzHrQS3ak56g+H
 IoCDQEoJNU40BeqtxnJTYm/x25QzfdPLIBiLaC2sdnxIwPEKpb09z80vW9Qt1b0SYe
 J0qJXHaTpz1WHVKyVzwXTg7aIyFPhRsM4CKi+nqeLZsE50UrvAno/H4YS0hoTldpf4
 x/+Fde4Hwdt5g==
Date: Sat, 20 Oct 2018 20:54:55 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH v2] KVM: PPC: Use exported tb_to_ns() function in decrementer
 emulation
Message-ID: <20181020095455.GA12489@blackberry>
References: <20181019100722.GB6230@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019100722.GB6230@blackberry>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This changes the KVM code that emulates the decrementer function to do
the conversion of decrementer values to time intervals in nanoseconds
by calling the tb_to_ns() function exported by the powerpc timer code,
in preference to open-coded arithmetic using values from the
decrementer_clockevent struct.  Similarly, the HV-KVM code that did
the same conversion using arithmetic on tb_ticks_per_sec also now
uses tb_to_ns().

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
v2: don't delete the second do_div in kvmppc_emulate_dec(), we need it.

 arch/powerpc/kvm/book3s_hv.c | 3 +--
 arch/powerpc/kvm/emulate.c   | 7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index bf8def2..d65b961 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2337,8 +2337,7 @@ static void kvmppc_set_timer(struct kvm_vcpu *vcpu)
 		kvmppc_core_prepare_to_enter(vcpu);
 		return;
 	}
-	dec_nsec = (vcpu->arch.dec_expires - now) * NSEC_PER_SEC
-		   / tb_ticks_per_sec;
+	dec_nsec = tb_to_ns(vcpu->arch.dec_expires - now);
 	hrtimer_start(&vcpu->arch.dec_timer, dec_nsec, HRTIMER_MODE_REL);
 	vcpu->arch.timer_running = 1;
 }
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index fa888bf..9f5b8c0 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -61,11 +61,10 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 
 	dec_time = vcpu->arch.dec;
 	/*
-	 * Guest timebase ticks at the same frequency as host decrementer.
-	 * So use the host decrementer calculations for decrementer emulation.
+	 * Guest timebase ticks at the same frequency as host timebase.
+	 * So use the host timebase calculations for decrementer emulation.
 	 */
-	dec_time = dec_time << decrementer_clockevent.shift;
-	do_div(dec_time, decrementer_clockevent.mult);
+	dec_time = tb_to_ns(dec_time);
 	dec_nsec = do_div(dec_time, NSEC_PER_SEC);
 	hrtimer_start(&vcpu->arch.dec_timer,
 		ktime_set(dec_time, dec_nsec), HRTIMER_MODE_REL);
-- 
2.7.4

