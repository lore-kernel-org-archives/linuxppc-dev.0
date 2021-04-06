Return-Path: <SRS0=CtgL=JD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90949C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 04:17:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A98613A9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 04:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A98613A9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FDvQB1TzJz3bs6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Apr 2021 14:17:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=A1drlk6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=A1drlk6w; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FDvPl033Mz301m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Apr 2021 14:17:30 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4FDvPh6Sv4z9sWX; Tue,  6 Apr 2021 14:17:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1617682648; bh=qUxQWI1Lyfl3WMSy1BWYDn2XdtAZ1+8ocVY0JeagQXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A1drlk6wiQxGBTwinkK8vLfMEWhdB+EhS1fPzwHP0Mr/rsE7JuYLDVjGZKztQ8+Ua
 SAxaD1BgO+WouDJ5KULZoCkwDkjsrMT04QwRDjdlXhyjs8WfVcmedGwcTDXdzQkkRc
 6z0R+0yXqORTSthBDOJustiRhnbnOniVjF4lN+u7Ak4ctu9ecc4nPyEnJtAJPjsQV6
 5OldSWz+lkdIlQTb+mxS4hOFqpxXIuaUrFc/JOb+/xJMIs4ur/9y2JMiznDiXTpNat
 y0bEa0aj6Lpy3XEjVifxwnQuaa9uDlnBkOCfQjFL57P91SkhzEmzdWVmergEID7nqC
 CTEwQYjXcS0mA==
Date: Tue, 6 Apr 2021 14:17:22 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 09/48] powerpc/64s: remove KVM SKIP test from
 instruction breakpoint handler
Message-ID: <YGvg0jCz85Uev3cm@thinks.paulus.ozlabs.org>
References: <20210405011948.675354-1-npiggin@gmail.com>
 <20210405011948.675354-10-npiggin@gmail.com>
 <1617676583.kyex3nxmbg.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617676583.kyex3nxmbg.astroid@bobo.none>
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 06, 2021 at 12:44:45PM +1000, Nicholas Piggin wrote:
> Excerpts from Nicholas Piggin's message of April 5, 2021 11:19 am:
> > The code being executed in KVM_GUEST_MODE_SKIP is hypervisor code with
> > MSR[IR]=0, so the faults of concern are the d-side ones caused by access
> > to guest context by the hypervisor.
> > 
> > Instruction breakpoint interrupts are not a concern here. It's unlikely
> > any good would come of causing breaks in this code, but skipping the
> > instruction that caused it won't help matters (e.g., skip the mtmsr that
> > sets MSR[DR]=0 or clears KVM_GUEST_MODE_SKIP).
> > 
> >  [Paul notes: the 0x1300 interrupt was dropped from the architecture a
> >   long time ago and is not generated by P7, P8, P9 or P10.]
> > 
> > In fact it does not exist in ISA v2.01, which is the earliest supported
> > now, but did exist in 600 series designs (some of the earliest 64-bit
> > powerpcs), so it could probably be removed entirely.
> 
> Hmm, I looked at a 970 manual and that does have a 0x1300, but 2.01 
> (which it implements) does not, if I'm reading correctly. Seems strange
> the interrupt would be taken out of the architecture then implemented,
> but not mine to wonder why. Maybe I misread something.

It was probably put in at Apple's request, since they had been using
IABR and the 0x1300 interrupt on the 6xx/7xx/7xxx CPUs.

Paul.
