Return-Path: <michel@tungstengraphics.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id A295CDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 18:52:10 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so1534208fke.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 01:52:08 -0700 (PDT)
Subject: Re: radeonfb, dedicate memory to something else
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48859AD2.6050404@genesi-usa.com>
References: <48830D56.2080704@genesi-usa.com>
	<9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>
	<48859AD2.6050404@genesi-usa.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 22 Jul 2008 10:52:03 +0200
Message-Id: <1216716723.15900.128.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-22 at 09:31 +0100, Matt Sealey wrote:
> Jon Smirl wrote:
> > On 7/20/08, Matt Sealey <matt@genesi-usa.com> wrote:
> >> Hi guys,
> >>
> >>  I know this isn't a PPC question, but since some of the RadeonFB developers
> >>  live here I thought best (and it's about a PPC platform).
> >>
> >>  Is there any way to hack up the RadeonFB driver - or anything related - to
> >>  reserve portions of the memory for a "fake" MTD or so, and still use the
> >>  Radeon as a graphics device? What I am talking about basically is turning
> >>  a 64MB Radeon card into a 32MB Radeon card, or a 128MB one into a 64MB
> >>  card..
> > 
> > Somebody write this long ago. Maybe around 2000. That's all I
> > remember. I think they made the video memory into a ram disk.
> 
> Yeah making it into a ramdisk precludes the use of the card as a video card
> though.. this is what I am trying to get around. If fbdev and X can cooperate
> on believing that a 64MB card is a 32MB card, then the upper 32MB can be used
> to attach the MTD "ram" driver at a certain address (maybe we can even make a
> hacky stub driver that recognizes this configuration based on OF tree..)
> 
> There are obvious limitations in that the Pegasos/Efika firmware only will
> map 128MB of video memory, and the PCI BAR is limited to 256MB chunks anyway,
> but that shouldn't matter. I just wonder, how it can be done that radeonfb
> or other graphics drivers can be told "please only use the first 32MB" and
> then either manually or automatically, map the rest as ramdisk.

You can limit the amount of video RAM used by X using the VideoRam
directive in xorg.conf(5).


> > I believe there is more to it, the GART window may be smaller than the
> > total RAM on the card. You need to use the GART to map in the
> > appropriate pieces.
> 
> The problem here is the PCI bus on the Efika is a PCI bus, with an AGP
> riser. It doesn't add any AGP functionality like real GART on the host
> controller side, so there is nothing to map system memory into AGP's
> view of the system.. it always confused me how "pcigart" is meant to
> work and how an AGP GART does anything different to how PCI works in
> the first place (the documentation/spec doesn't make it that clear in
> my opinion :)

GART doesn't have anything to do with this. I suspect he was thinking of
the PCI BARs not covering all video RAM.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
