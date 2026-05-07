Return-Path: <linuxppc-dev+bounces-20560-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BB2CD3442
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 08:53:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB5dF33QSz2yrD;
	Thu, 07 May 2026 18:53:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778144017;
	cv=none; b=R1FcWRhJIVkfNJQECk+TKTa5/llyc9FNJnuAG/Wh2aevFEQKtj94QKporjh4eIJ+aESamRRtRqKr3XCpk5VLgYiJCVbOt4QKMQy4FTplHOEfDqoFt43xGX99dMiA6ZDPXBIh3e5iiFNEr9Xsx3sHXDKoSu/vYcfvrFwafG+FSaLU8MnxCaisddy5+ylIDaw1+/wB/Ba2AOR3BuK73qIv7HlW8O4iRFKW7ZG4SEOquQmAl3arsBMuoCUTj6x+tXCrak0Yy78PKTTKMafiISbe53/psVwo1yhkg3FCxBsJQk/VxrEppcIOeeRUgNQGG1l/hsQZy+fSTKpx2pdfvG9WGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778144017; c=relaxed/relaxed;
	bh=Y8ne7xpa9LsN7xc+BxVnbbvrLZcFgy7WlFP1JNtx6Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0ibVhO77LhiKIZRCdChaZ4oghIGcfAvVDWlRv+9/OD+Q9DMtjmny2m05bKDV5cxOgfEJHOthZRrvCvf2P9BxUCK9d2WmuWUKOhSBa3MV/pD9+5lSGwaAkpAs1xzuRtosJVGklIY4lr/+CqtyBD17wMvY7Y40+TycdNDAPkgs986UbTyehzK3sW3NJUuWw5YoyMuGFrkJZlx8PAd7yJn98RFINK+imyQ6voB1oa8ajyprBhuB5pLumZ/rqn+4++wXBmVlVLVUhNcc2Ep5RHunXGENfJV9H7f5dbyq4vEoYXYRHJBj2MAkQmrktavRvWhfsS8BXZQYYrk1GHy7pD8zQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB5dC3b3Yz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 18:53:34 +1000 (AEST)
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6478qxBc509569;
	Thu, 7 May 2026 03:52:59 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 6478qrOV509556;
	Thu, 7 May 2026 03:52:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 7 May 2026 03:52:53 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
Message-ID: <afxS5S86eynCQaTd@gate>
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
 <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>
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
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a28c484-5500-4b68-b837-28d30648e592@kernel.org>

On Wed, May 06, 2026 at 09:41:51PM +1000, Michael Ellerman wrote:
> Sorry it didn't get picked up.
> 
> I don't have any G5s anymore,

I don't have any functioning ones either :-(

> but the ones I did have used the other
> windfarm drivers so I never hit this.

Yeah, the oldest PowerMac G5 and RackMac were not super big sellers
either, relatively to the newer models.  And of course all Apple
hardware of the time (as well as all by other manufacturers) had failing
power supplies, so there "naturally" be fewer working machines over\
time.  Problems that solve themselves!

> You might be the last person on earth booting Linux on those :)

Booting, yes, but it won't run for even a minute ;-)

> > diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
> > index 04bbb37f5978..f74ccc06f4c1 100644
> > --- a/arch/powerpc/configs/g5_defconfig
> > +++ b/arch/powerpc/configs/g5_defconfig
> > @@ -85,6 +85,8 @@ CONFIG_PMAC_SMU=y
> >   CONFIG_MAC_EMUMOUSEBTN=y
> >   CONFIG_WINDFARM=y
> >   CONFIG_WINDFARM_PM81=y
> > +CONFIG_WINDFARM_PM72=y
> > +CONFIG_WINDFARM_RM31=y
> >   CONFIG_WINDFARM_PM91=y
> >   CONFIG_WINDFARM_PM112=y
> >   CONFIG_WINDFARM_PM121=y
> > 
> 
> Ack, LGTM.
> 
> Maddy can you pick this one up for next?

Is this all supported models?  Might be better to do that immediately,
not wait for patches to trickle in over the years :-)

Thanks everyone!


Segher

