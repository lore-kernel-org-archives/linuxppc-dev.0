Return-Path: <linuxppc-dev+bounces-5761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F40C0218F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Feb 2025 01:42:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YlFrX2Q6Pz3089;
	Sat,  1 Feb 2025 12:42:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738374172;
	cv=none; b=eRCu6UoZKKMfjP9U2ZJB6+S35ARZA+4aBr+Qske8R13vogdW6W/2uX5CfN8fAqCITqoWWr8o+XfQR8bJ7CpFWSpcmMr4e4JhQq6ZcmZs5384tAEuOrSc0JruL9QXBGpUuTqtrd1qwe1PQWSakloXeryJtm9on3UF95nBwj2S87A5TJ8jRdSY7aG3MU6NOJaTEux0NtAKERYs789dtlUq3gMHtspk5KPZVD0/BYbVv4UzGUuiArpxYVfA8c6U6v0KXlAXrhJefx8HtXtdSFNcbpt1k2ZDbN37vPED6ZHS/3Rnz7cHeVtTg4hRV2JbhkFJoxx6/x4AAReig2GMECQ3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738374172; c=relaxed/relaxed;
	bh=jfTX5N+JozVInSGryKZii/Pu/Wo6REO7I+jxm8oFruQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKuK1jufqsWDmccU+LZZJlvh9ApNcJ72fY9MSmpUbMb0J2iOdL5S6e7/b/Y/rJ1WbwMwLUdbpNJFzQadCHnR9XyAZlLRrNGddeJL4qy5FzGD6D0ZgufwMtHbZ34ZaMj6TvFaV7Jzvz1wXrFOqQycrYWfn9D1w2KPpy/SoX51McRk08lcLwH+imk8W0kFWAbKoQmgv1JSinFyLAvDKSMIHWk5YgFwuuiNDG/8BPEsnN67K4ZD6Sme5HYFOqk65IFoyXuHksuqIivyL6wQDttT3wyuuKiOOVxSsJtvLnLAYnMGWhJ7bnx3Ph/Y6LJ2T/+yutkqkY3bY8Biki5HSWStUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=B63dI5Ci; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=B63dI5Ci;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YlFrW6B0qz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 12:42:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1738374157;
	bh=jfTX5N+JozVInSGryKZii/Pu/Wo6REO7I+jxm8oFruQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B63dI5CigvvVphfB6egfdH1IAUf8ujFXZ+CnYF+xHGZoSWWXi5+26JTqyZ1rCbvma
	 TvAEDArWzNtaVz28nasH83jIUEa0vNtv8rD4eKZjSysrU/irU8rXCO7ADcQDtg1t/T
	 jj/OWhw61TGS/+z2PDxx23rN+yHTCZXFlwHIjkH17EdvDlbm7FYbqJ5SnaYqWlNSzR
	 KMnZSuwj9L7CGi+823e6g0iAq84/QpcqA3siw6NbB9SXd5hmArl1fu3hnKuOBv/iHq
	 YJm3ZBFWu3lvZPj/VlS/Usf4tzekbGn9mCg7HyO3hpnHl2YTu1t8+aq602irfPaqw2
	 mVj9ea+f/uXyw==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4YlFrF4VmHz4wcf; Sat,  1 Feb 2025 12:42:37 +1100 (AEDT)
Date: Sat, 1 Feb 2025 12:41:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] powerpc/microwatt: Define an idle power-save function
Message-ID: <Z517wNTEaMBINMw4@thinks.paulus.ozlabs.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org>
 <Z5lfyDQbGjxYT_eF@thinks.paulus.ozlabs.org>
 <D7EBXLB9JMZU.2T4WD5BP9C1GD@gmail.com>
 <20250131163255.GA20626@gate.crashing.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131163255.GA20626@gate.crashing.org>

On Fri, Jan 31, 2025 at 10:32:55AM -0600, Segher Boessenkool wrote:
> On Wed, Jan 29, 2025 at 04:06:03PM +1000, Nicholas Piggin wrote:
> > Does wait cause MSR[EE] to be set? If not, do you need to use
> > prep_irq_for_idle_irqsoff() here maybe?
> 
> Assuming this does implement the standard ISA 2.03 wait instruction

ISA 2.03?  I don't have a copy of 2.03.  I looked in 2.04 and the wait
instruction there has a different extended opcode from the ISA 3.0/3.1
wait instruction.  Why is ISA 2.03 at all relevant to anything here?
In any case, the description of the wait instruction in 2.04 doesn't
actually say that it waits for anything other than all previous
instructions being finished.

> (and it better), this does not do anything other than to stop fetching
> and execution until some later event happens.
> 
> What values of the WC field does uwatt implement?

Just WC=0; for other values it's a no-op.  (Which is still arguably
correct given that execution is allowed to resume when an
implementation-dependent event occurs; P9 for instance just stops for
a few microseconds, if I recall correctly, for any WC value.)

Paul.

