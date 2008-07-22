Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id B6CC5DE151
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 00:25:37 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so407202yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 07:25:35 -0700 (PDT)
Message-ID: <9e4733910807220725o41939c60l7f07d30577be7dc8@mail.gmail.com>
Date: Tue, 22 Jul 2008 10:25:35 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: radeonfb, dedicate memory to something else
In-Reply-To: <4885A2C2.4060603@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48830D56.2080704@genesi-usa.com>
	<9e4733910807200826m22b676aewa89de8df9fd6da33@mail.gmail.com>
	<48859AD2.6050404@genesi-usa.com>
	<1216716723.15900.128.camel@thor.sulgenrain.local>
	<4885A2C2.4060603@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	=?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@tungstengraphics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/22/08, Matt Sealey <matt@genesi-usa.com> wrote:
> Michel D=E4nzer wrote:
>
> > On Tue, 2008-07-22 at 09:31 +0100, Matt Sealey wrote:
> >
> > > or other graphics drivers can be told "please only use the first 32MB=
"
> and
> > > then either manually or automatically, map the rest as ramdisk.
> > >
> >
> > You can limit the amount of video RAM used by X using the VideoRam
> > directive in xorg.conf(5).
> >
>
>
>  Is it safe to poke around in radeon_identify_vram and maybe supply a ker=
nel
>  argument videomem=3D32M and let it check, if it's bigger, then limit it,=
 and
>  if not, keep the old size in rinfo->video_ram?
>
>  Can/could this be moved to all relevant framebuffer drivers?
>
>
> > GART doesn't have anything to do with this. I suspect he was thinking o=
f
> > the PCI BARs not covering all video RAM.
> >
>
>  That's certainly not the case here.

Yes, I'm forgetting how graphics work. If you can map all of VRAM into
the PCI address space then you don't have to worry about sharing the
window with X.

>  Ah okay. So now.. how do we do this for framebuffers?

My memory is suspect, but first you would need to make sure all of
VRAM is mapped. Then there is a value in fb that says how much of the
VRAM it is using.  Anything above the max is fair game if X isn't
running. Note that the amount of VRAM in use by fbdev is a function of
which display mode it is in.

>
>  --
>  Matt Sealey <matt@genesi-usa.com>
>  Genesi, Manager, Developer Relations
>


--=20
Jon Smirl
jonsmirl@gmail.com
