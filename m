Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCE27B6EED
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Aug 2010 08:49:27 +1000 (EST)
Subject: Re: Relocating bootwrapper causes kernel panic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20100805134654.70f8f787@schlenkerla.am.freescale.net>
References: <AANLkTi=x-EA59xfn_r5xMuJL6mufObSvSSEOeY9KTjQS@mail.gmail.com>
	<AANLkTin3u=U-L2grncS_UtWqkGnb9bNUy4a4nqkRhQQ9@mail.gmail.com>
	<AANLkTikS3f8q+Kuq8aYX1vhRotfSMHN_S+qKPwrfDn2j@mail.gmail.com>
	<20100805123725.63d009b1@schlenkerla.am.freescale.net>
	<AANLkTinqLCvRii4zCArHG=whHa0H6bparf=5sUkGDUTw@mail.gmail.com>
	<20100805134654.70f8f787@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 07 Aug 2010 08:49:18 +1000
Message-ID: <1281134958.2168.39.camel@pasglop>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

\
> Probably.  You won't have any page tables yet, much less an entry for
> the device tree.
> 
> > >> I think the cause is clear now. But how to fix it? Two questions:
> > >> 2. If the DTLB miss exception handler is not the right guy to load a
> > >> proper TLB entry, how can I set one entry based on the link_address
> > >> and the address of the flat dt blob?
> > >
> > > Given how early in the boot process it is, it's probably going to need
> > > to be handled specially.
> > 
> > What APIs can I use to set up DTLBs?
> 
> I don't think there is one that works on 8xx.  You'll could hack up
> initial_mmu, or else write some C code to insert an 8xx TLB entry.

Yup, I think he just ends up getting out of the initial mapping which is
smallish on 8xx, no ? Might be worth sticking in one more entry during
boot...

Ben.
