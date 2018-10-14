Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229A7C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 12:42:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4CE20659
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 12:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4CE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Y1SN08yJzF3Cj
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 23:42:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Y1PG3fmGzF18l
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 23:40:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Y1PF4K0mz9s8F;
 Sun, 14 Oct 2018 23:40:01 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, mikey@neuling.org, oohall@gmail.com
Subject: Re: [PATCH 1/2] powerpc/time: Use clockevents_register_device(),
 fixing an issue with large decrementer
In-Reply-To: <20181001230105.26040-1-anton@ozlabs.org>
References: <20181001230105.26040-1-anton@ozlabs.org>
Date: Sun, 14 Oct 2018 23:39:56 +1100
Message-ID: <877eik1z37.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Anton Blanchard <anton@ozlabs.org> writes:

> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 70f145e02487..6a1f0a084ca3 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -1035,18 +1035,7 @@ static void __init set_decrementer_max(void)
>  
>  static void __init init_decrementer_clockevent(void)
>  {
> -	int cpu = smp_processor_id();
> -
> -	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
> -
> -	decrementer_clockevent.max_delta_ns =
> -		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
> -	decrementer_clockevent.max_delta_ticks = decrementer_max;
> -	decrementer_clockevent.min_delta_ns =
> -		clockevent_delta2ns(2, &decrementer_clockevent);
> -	decrementer_clockevent.min_delta_ticks = 2;
> -
> -	register_decrementer_clockevent(cpu);
> +	register_decrementer_clockevent(smp_processor_id());
>  }

This broke KVM PR :)

Because we no longer set the mult/shift in decrementer_clockevent, which
is used in kvmppc_emulate_dec().

The patch below fixes it, though it'd be nice to come up with something
cleaner eventually.

cheers


diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 6a1f0a084ca3..d21b2b88c0a7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1036,6 +1036,9 @@ static void __init set_decrementer_max(void)
 static void __init init_decrementer_clockevent(void)
 {
 	register_decrementer_clockevent(smp_processor_id());
+
+	/* Set values for KVM, see kvm_emulate_dec() */
+	decrementer_clockevent = *dec;
 }
 
 void secondary_cpu_time_init(void)

