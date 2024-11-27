Return-Path: <linuxppc-dev+bounces-3592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E21BD6D242
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2024 21:48:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzCkb5n02z2xgX;
	Thu, 28 Nov 2024 08:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732744135;
	cv=none; b=XiiLhbZEz4hz0pWCHC0XM+Yma6wRPWXK2q7pi0KG9SwqK03RbI9z3FcFyA0nqNmagQr7cG0UYWVI0nTUZSbN6/GUefRIsoTA1+pmdtvXNnVfzL5o8tRge01XaRs+7xZdDquHVnHVuZZGnQJknDgoxov3RN1RkZD1tk6asOHbsno74w+SK9Gzsh7Nz962gRj0mjQOstIrMUgdTS2novoODq4VHbfMsOfADKT5zo1gvWqDaIe7U+RHJWfJ1MmNUT/mkHuEQf2NzJUGEIcSAOWu/S/3/yHI1chcfJvm21jN1lOgbM2ZLOQXBKKMEeB1fod9DCU+YStc9quYplXSgdTFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732744135; c=relaxed/relaxed;
	bh=E6tRho8tA+722BVRYh8v1ckQ9sII/It1+3QdCE4fbN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTuAroXfNfbI0TcZmT7pSBze4EK7b9EKYhcRjrsob39VdcSQnbFFHKPc7lNsNVIo9ALE9s7RY0RZea1t/YWbJkQbD8b0xbROnQGDcosWzEGbOjnOOrNQ54Kdg6Lc1WFp70yC4zN1eUmWiu4YyasT3osT0xEc2GutjOz9dAcQguKXFlnC+y5UTcpiZVuMNAwUtYLPSZLHivKLkre5D1mMl0iFqa0PkD+4vf1rKYucNAyt6YLscMlK+vA+y9TmnK0Fv8zOedCpbYe+NHy32yWTpCCwfK2N9q6oLXguEutmrkp/c5qPGgOx9dw0xwyYkHOc9IDVEApAjU6KQK2EVUj4Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XzCkZ2ctnz2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Nov 2024 08:48:52 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4ARLgWel027899;
	Wed, 27 Nov 2024 15:42:33 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4ARLgW3R027898;
	Wed, 27 Nov 2024 15:42:32 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 27 Nov 2024 15:42:32 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>, linuxppc-dev@lists.ozlabs.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
Message-ID: <20241127214232.GQ29862@gate.crashing.org>
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au> <87plmi7jjz.fsf@mpe.ellerman.id.au>
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
In-Reply-To: <87plmi7jjz.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i

On Tue, Nov 26, 2024 at 02:36:32PM +1100, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > "Rob Herring (Arm)" <robh@kernel.org> writes:
> >> While OpenFirmware originally allowed walking parent nodes and default
> >> root values for #address-cells and #size-cells, FDT has long required
> >> explicit values. It's been a warning in dtc for the root node since the
> >> beginning (2005) and for any parent node since 2007. Of course, not all
> >> FDT uses dtc, but that should be the majority by far. The various
> >> extracted OF devicetrees I have dating back to the 1990s (various
> >> PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
> >
> > I have various old device trees that have been given to me over the
> > years, and as far as I can tell they all have these properties (some of
> > them are partial trees so it's hard to be 100% sure).
> >
> > So LGTM.
> 
> Turns out I was wrong.
> 
> The warning about #size-cells hits on some powermacs, possible fixup
> patch here:
> 
>   https://lore.kernel.org/linuxppc-dev/20241126025710.591683-1-mpe@ellerman.id.au/

The Open Firmware specification is extremely clear that a "missing"
"#size-cells" property means this bus has the default value of 1.

https://www.openfirmware.info/data/docs/of1275.pdf (page 186).

DTC or FDT might want to do things differently, but expecting decades
older stuff to conform to its ill-conceived unnecessarily super wordy
stuff is, well, not a plan that is likely to work very well :-)


Segher

