Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C5EC4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE5460EE0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ACE5460EE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gpsfj0Bxyz3bX7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 23:42:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=atpg2+FV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=atpg2+FV; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gpsdx525bz2yMg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 23:42:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gpsds5RqWz9sW5;
 Tue, 17 Aug 2021 23:42:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629207730;
 bh=edfSa1Zuc6lNmt+pQYtASDYDt9CbykZRaD2bDnH6dL4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=atpg2+FV/S3/HX08R+m/rK4j3EgEZmUyGYcYmlga0bGJA0vXE0qo896hR7TQGMAYW
 RdM+Fh3w9tmYMCe2I/g7uarDD0yzUHCmbVxrahSAFgU7o/hbNGG6YeByRrUcJgeMqw
 GAUdTHa6txeS1ygU0jRcnSPK9430P7OFw6N9sCtSnJJrldbTLDGXJDJwYcyZmoH4t6
 eIMdgL2tnnJTgoPyneehZvqxwdQcxrV8vTKmGUfQms6uI3V3Ear4yaCHrN+n9aFCOr
 cfokj49jhD/O4eUS9DzCAhKzZxnAp91neef81QU9hoPHkJmW81s8lxSHg/jIgCnIDx
 MeeMpuyWrk05g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 2/4] powerpc/64s/perf: add power_pmu_running to query
 whether perf is being used
In-Reply-To: <20210816072953.1165964-3-npiggin@gmail.com>
References: <20210816072953.1165964-1-npiggin@gmail.com>
 <20210816072953.1165964-3-npiggin@gmail.com>
Date: Tue, 17 Aug 2021 23:42:05 +1000
Message-ID: <87y290fas2.fsf@mpe.ellerman.id.au>
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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:

> Interrupt handling code would like to know whether perf is enabled, to
> know whether it should enable MSR[EE] to improve PMI coverage.
>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h |  2 ++
>  arch/powerpc/perf/core-book3s.c   | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 21cc571ea9c2..2d5c0d3ccbb6 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -306,6 +306,8 @@ static inline bool lazy_irq_pending_nocheck(void)
>  	return __lazy_irq_pending(local_paca->irq_happened);
>  }
>  
> +bool power_pmu_running(void);
> +
>  /*
>   * This is called by asynchronous interrupts to conditionally
>   * re-enable hard interrupts after having cleared the source
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index bb0ee716de91..76114a9afb2b 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -2380,6 +2380,19 @@ static void perf_event_interrupt(struct pt_regs *regs)
>  	perf_sample_event_took(sched_clock() - start_clock);
>  }
>  
> +bool power_pmu_running(void)
> +{
> +	struct cpu_hw_events *cpuhw;
> +
> +	/* Could this simply test local_paca->pmcregs_in_use? */

I think it could, except that it's under an ifdef:

#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
	u8 pmcregs_in_use;		/* pseries puts this in lppaca */
#endif

cheers
