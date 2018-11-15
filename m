Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34696C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:47:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86ED2083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86ED2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wh2V1WQpzF3dv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:46:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wgyj385SzF3QC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:43:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42wgyg73pyz9s3x;
 Thu, 15 Nov 2018 23:43:39 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Powerpc/perf: Wire up PMI throttling
In-Reply-To: <20181114141425.1892-1-ravi.bangoria@linux.ibm.com>
References: <20181114141425.1892-1-ravi.bangoria@linux.ibm.com>
Date: Thu, 15 Nov 2018 23:43:39 +1100
Message-ID: <8736s2v7d0.fsf@concordia.ellerman.id.au>
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
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, paulus@samba.org, ebiederm@xmission.com,
 muriloo@linux.ibm.com, leitao@debian.org, naveen.n.rao@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:

> Commit 14c63f17b1fde ("perf: Drop sample rate when sampling is too
> slow") introduced a way to throttle PMU interrupts if we're spending
> too much time just processing those. Wire up powerpc PMI handler to
> use this infrastructure.

To be clear we have throttling of the *rate* of interrupts, but this
adds throttling based on the *time taken* to process the interrupts. Or
at least that's my understanding?

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 9a86572db1ef..44f85fa22356 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched/clock.h>
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/pkeys.h>
> @@ -1803,9 +1804,12 @@ void vsx_unavailable_tm(struct pt_regs *regs)
>  
>  void performance_monitor_exception(struct pt_regs *regs)
>  {
> +	u64 start_clock;
>  	__this_cpu_inc(irq_stat.pmu_irqs);
>  
> +	start_clock = sched_clock();
>  	perf_irq(regs);
> +	perf_sample_event_took(sched_clock() - start_clock);
>  }

Despite the name, perf_irq() may not actually be the perf IRQ handler :)

It's a function pointer which might call perf or might call oprofile, or
a dummy handler.

I don't think we should be calling perf_sample_event_took() if we're not
actually using perf, that is wasteful at best.

So the timing logic should go in the perf specific handler I think.
ie. perf_event_interrupt().

cheers
