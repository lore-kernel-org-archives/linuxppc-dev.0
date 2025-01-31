Return-Path: <linuxppc-dev+bounces-5754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4021C02190
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jan 2025 16:55:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl28531KQz30TM;
	Sat,  1 Feb 2025 03:55:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738342533;
	cv=none; b=ck3dua/gnOUyrW1+2vj1sT3II4RBX7F9SupflBsTHiekG/g546Lhmp5tzaOTRxv643pSuNeLqh4nRQV7+c+a+gQpf9IcFmbbMOaTrDz94JIshiSt9xGa1phQzFHKFaJh/KfHbQ9mV+6zRRmNHXVVxa4foUjPn5yX6k5zYw/M93/5kDD/30EMxJY41KzUn93NdUgUSs9hXTSEN9v/tQuvF1s0oWiWTvPQbUOOmH9yrLs/7CsNRzv2idLxCocrvyqfrIPhAuHBXfJvDCkKTGQasC35EJvB/P5aN2FRtSTJk6VW17PaDrgAz4GkhvmIHiMB3eZKw6vcaGfj7mk+1xWfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738342533; c=relaxed/relaxed;
	bh=b7B1cZ6XugqLPnnsj+KRW4DMvdl3bIpZvHg1tiZPOjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMYs/YA7XNA6VBf1vj5g8cVQUJJxBGS4ivQaZ67a5B18A3mQLJBcu8o/qjHBNlGd4Toav7U7gTpMsJCr/+vFv2VlSdIZdxiiF9UPYY/Ylbk9yWDgoIIW6eDC1N3wuJsMcU/k1MK/09Wu/lw1s+HcPL4UgNWd461rN2GQ7RsQRxT7s513CyZBR3FXMd+90HM3EAhJ4Uroybm8W7ybLZw8otHdeWK2qD7DUYsXsOeLd8don6PMoE4RWiP66J4YKEmTyjaXpcSJn+9z85ApGwGBlMdmFJW+0IXR4iVfRmFGX2Z5KGfqKMQIo2Jh2hYFLDDHohPS1dBWXMGvNJX8d4xt6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yl2842C1zz2yMh
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 03:55:32 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50VGrTOU028470;
	Fri, 31 Jan 2025 10:53:29 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 50VGrTCr028469;
	Fri, 31 Jan 2025 10:53:29 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Fri, 31 Jan 2025 10:53:29 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/microwatt: Device-tree updates
Message-ID: <20250131165329.GC20626@gate.crashing.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org> <Z5lfmZtfHD7t2IvK@thinks.paulus.ozlabs.org> <D7ECKPNWAU7O.39PRDJ4PIG0P9@gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7ECKPNWAU7O.39PRDJ4PIG0P9@gmail.com>
User-Agent: Mutt/1.4.2.3i

On Wed, Jan 29, 2025 at 04:36:14PM +1000, Nicholas Piggin wrote:
> On Wed Jan 29, 2025 at 8:52 AM AEST, Paul Mackerras wrote:
> > Microwatt now implements ISA v3.1 (SFFS compliancy subset), including
> > prefixed instructions, scv/rfscv, and the FSCR, HFSCR, TAR, and CTRL
> > registers.  The privileged mode of operation is now hypervisor mode
> > and there is no privileged non-hypervisor mode; the MSR[HV] bit is
> > forced to 1.
> 
> Cool. Lots of development in microwatt.
> 
> Come to think of it we should have put a broadcast-tlbie feature
> in there and you wouldn't need the other patch. That can go on
> the todo list I guess.
> 
> system-call-vectored was available in ISA v3.0. Not that we do much
> with it at the moment IIRC, but there were dreams of wiring it in for
> compat guests. With that fixed,

This patch says 2.07 for it (if that is what 2070 mens(if that is what
2070 means).  Something's not right :-)

> > +			system-call-vectored {
> > +				isa = <2070>;
> > +				usable-privilege = <7>;
> > +				os-support = <1>;
> > +				fscr-bit-nr = <12>;
> > +				hwcap-bit-nr = <52>;
> >  			};


Segher

