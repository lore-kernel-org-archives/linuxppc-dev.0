Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EF869B7D30
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 02:22:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3UGMu98000047
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 09:22:56 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3UGWTPB023113
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 11:32:30 -0500 (CDT)
Date: Fri, 30 Apr 2010 11:22:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-ID: <20100430162254.GA24285@schlenkerla.am.freescale.net>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 10:08:45AM -0500, Timur Tabi wrote:
> On Fri, Apr 30, 2010 at 5:19 AM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> >> How about just doing this?
> >>
> >> .init_early             = mpc512x_init_diu,
> >
> > I thought it should be prepared for adding other code here.
> > mpc5121_ads_init_early() is generic and could contain other
> > things as well. I would vote for current version.
> 
> Do you have any plans to add any additional code?   If not, then I say
> skip the middle-man.  If someone ever needs to do more, he can always
> put that function back.
> 
> >> I'm pretty sure the compiler will optimize this to:
> >>
> >>     temp = (1000000000000UL / pixclock);
> >>
> >> so you may as well do it that way.
> >
> > ??
> > 1000000000000 is _not_ UL, but UUL.
> 
> That's what I meant.  Actually, I think it's ULL.  Regardless, I think
> the compiler will see the  "1000000000 ... * 1000" and just combine
> them together.  You're not actually outsmarting the compiler.

The compiler will do no such thing.  That's a valid transformation when
doing pure math, but not when working with integers.

> >> > +       err = 100000000;
> >>
> >> Why do you assign err to this arbitrary value?
> >
> > Dunno. It is Freescale's code and I do not have time to check
> > and understand each bit of it and to explain it.
> 
> *sigh*  You're not the first person to modify the DIU driver without
> understanding what it all does.  I suspect that the original author
> should have done this:
> 
>     err = -1;
> 
> because he wanted it to be the largest possible integer.

-1 is not the largest possible integer.  LONG_MAX, perhaps?

-Scott
