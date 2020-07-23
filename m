Return-Path: <SRS0=Lnkm=BC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE8EC43446
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61507208E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2020 15:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YevgOcOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61507208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCFys6FG3zDrBc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 01:06:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=YevgOcOa; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCFpr4zlhzDqBj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 00:59:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8Gt1hFpE3q2wE3LOCsagXAgF4SokTskzV+hSBzd+h94=; b=YevgOcOaHex/SgwKEBjKklY9ML
 EOz76F9PRoMjWXYbh8Q+m/GbZsxZzpaftQUDGL6i0rkl4d3XOsti2q6zidbbAOdlaQCoDEkMbBo/3
 uibNzMdLQFmkllHyPKj3GT64ohKnBbGPeTcObiayUHZKr6mpih1MPL/xTlmXNwMkbz0YYUTrokLxc
 e+ansIggeKN0bMmp5DAW7L3MyHSOAaMAbgr26KCQ+j5BOGanY609zpdhmuxph9F1tP80dQDAtzqoT
 O61aCCCF81d39djAdwbpYFPQ/yDWx2bIuB8dtmgMTTFEzaQfBByrk9i+tOsYEg/FELh+tePD+S6hu
 wE5r4t3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jycgc-0000Ed-C9; Thu, 23 Jul 2020 14:59:06 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 01DF5983422; Thu, 23 Jul 2020 16:59:04 +0200 (CEST)
Date: Thu, 23 Jul 2020 16:59:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200723145904.GU5523@worktop.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595506730.3mvrxktem5.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 23, 2020 at 11:11:03PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
> > On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
> > 
> >> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> >> index 3a0db7b0b46e..35060be09073 100644
> >> --- a/arch/powerpc/include/asm/hw_irq.h
> >> +++ b/arch/powerpc/include/asm/hw_irq.h
> >> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
> >>  #define powerpc_local_irq_pmu_save(flags)			\
> >>  	 do {							\
> >>  		raw_local_irq_pmu_save(flags);			\
> >> -		trace_hardirqs_off();				\
> >> +		if (!raw_irqs_disabled_flags(flags))		\
> >> +			trace_hardirqs_off();			\
> >>  	} while(0)
> >>  #define powerpc_local_irq_pmu_restore(flags)			\
> >>  	do {							\
> >> -		if (raw_irqs_disabled_flags(flags)) {		\
> >> -			raw_local_irq_pmu_restore(flags);	\
> >> -			trace_hardirqs_off();			\
> >> -		} else {					\
> >> +		if (!raw_irqs_disabled_flags(flags))		\
> >>  			trace_hardirqs_on();			\
> >> -			raw_local_irq_pmu_restore(flags);	\
> >> -		}						\
> >> +		raw_local_irq_pmu_restore(flags);		\
> >>  	} while(0)
> > 
> > You shouldn't be calling lockdep from NMI context!
> 
> After this patch it doesn't.

You sure, trace_hardirqs_{on,off}() calls into lockdep. (FWIW they're
also broken vs entry ordering, but that's another story).

> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
> context though, for some reason.

Hurpm, not sure.. I'll have to go grep arch code now :/ The generic NMI
code didn't touch that stuff.

Argh, yes, there might be broken there... damn! I'll go frob around.
