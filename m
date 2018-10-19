Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9ABECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:09:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D26221470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 10:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="oMI7Y8t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D26221470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42c1qR1rB0zF3ZF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 21:09:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="oMI7Y8t8";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42c1mt0sNPzDrDg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 21:07:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="oMI7Y8t8"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42c1ms5mBnz9sj4; Fri, 19 Oct 2018 21:07:25 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42c1ms540cz9sDX; Fri, 19 Oct 2018 21:07:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1539943645; bh=0eHO2Wmc7CupXpP9PN2V8DAMr7huM0vPQf7eRVHAWKw=;
 h=Date:From:To:Cc:Subject:From;
 b=oMI7Y8t8Zzg5aUhbekkxFmamCeFdH1i0GyMecODysj1NT03BFjq36PTLTaJFLXflc
 CxuENTBz0CpoyUOyzaUpMtFw6vBDW91TKPuMRSbdrIJos6uTdOFf4QQXUS7e/ce5qM
 gzSXqwQPuhstcZ7B1SNEz32yXNsHMyedQSLXP7c7NlBMPRGS158JqwIUDLvf59V8kC
 DaYxXv2gGsTr1edpbrSv2YjU8Trt8DMRRK85/OHp99KbOQmmjsuLA+O//D01f+DTeJ
 PITgNkK4nU4a/yuXxWe9yvsj/t7F8GQYKXp5R83RJffL65vcc3SrMpHdREjp6+wkZo
 HSpqAWPbbgXYA==
Date: Fri, 19 Oct 2018 21:07:22 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Use exported tb_to_ns() function in decrementer
 emulation
Message-ID: <20181019100722.GB6230@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 arch/powerpc/kvm/book3s_hv.c | 3 +--
 arch/powerpc/kvm/emulate.c   | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

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
index fa888bf..7a7c348 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -62,11 +62,9 @@ void kvmppc_emulate_dec(struct kvm_vcpu *vcpu)
 	dec_time = vcpu->arch.dec;
 	/*
 	 * Guest timebase ticks at the same frequency as host decrementer.
-	 * So use the host decrementer calculations for decrementer emulation.
+	 * So use the host timebase calculations for decrementer emulation.
 	 */
-	dec_time = dec_time << decrementer_clockevent.shift;
-	do_div(dec_time, decrementer_clockevent.mult);
-	dec_nsec = do_div(dec_time, NSEC_PER_SEC);
+	dec_nsec = tb_to_ns(dec_time);
 	hrtimer_start(&vcpu->arch.dec_timer,
 		ktime_set(dec_time, dec_nsec), HRTIMER_MODE_REL);
 	vcpu->arch.dec_jiffies = get_tb();
-- 
2.7.4

