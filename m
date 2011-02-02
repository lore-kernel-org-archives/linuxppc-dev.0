Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D187B70E7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 08:40:50 +1100 (EST)
Subject: Re: BootX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Feb 2011 08:40:42 +1100
Message-ID: <1296682842.2349.730.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-02-02 at 13:36 -0600, kevin diggs wrote:
> Hi,
> 
> FYI:
> 
> I have narrowed this down to drivers/scsi/mesh.c (the root disk
> controller for the PowerMac 8600). I have compiled everything else for
> 2.6.36 with 4.3.5, including modules. With a 4.1.2 compiled mesh.c the
> beast boots. I am using it to post this follow up.

That's interesting... That driver is really nasty, we probably have a
bug in it that's exposed by optimizations done by more recent compilers
but it's not going to be trivial to figure out I'm afraid. I at least
have very dim memories of mesh and how it operates...

One thing to be careful of with Mesh is that the DMA engine, while
supposedly cache coherent, has shown in the past to have issues when
DMA'ing to unaligned memory locations. This shouldn't be a problem with
normal block transfers but we may have to be careful with things like
inquiry, mode pages, sense requests etc...

Ben.

> kevin
> 
> > On Sat, Jan 22, 2011 at 12:24 PM, kevin diggs <diggskevin38@gmail.com> wrote:
> >> Hi,
> >>
> >> If I enable SMP then I can build a 2.6.28 kernel with gcc 4.3.5 that
> >> WILL boot on the PowerMac8600 (single 750GX). The previously mentioned
> >> G4 that runs is a dual cpu beast and thus also runs SMP.
> >>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
