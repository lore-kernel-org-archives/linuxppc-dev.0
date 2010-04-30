Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 72427B7D2F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 03:00:54 +1000 (EST)
Date: Fri, 30 Apr 2010 19:00:51 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-ID: <20100430190051.3a5ba058@wker>
In-Reply-To: <x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	John Rigby <jrigby@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 30 Apr 2010 10:08:45 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Fri, Apr 30, 2010 at 5:19 AM, Anatolij Gustschin <agust@denx.de> wrote:
>=20
> >> How about just doing this?
> >>
> >> .init_early =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D mpc512x_init=
_diu,
> >
> > I thought it should be prepared for adding other code here.
> > mpc5121_ads_init_early() is generic and could contain other
> > things as well. I would vote for current version.
>=20
> Do you have any plans to add any additional code?   If not, then I say
> skip the middle-man.  If someone ever needs to do more, he can always
> put that function back.

Currently I do not have such plans. Ok will skip them.

...
> >> Do you really need to use reserve_bootmem? =C2=A0Have you tried kmallo=
c or
> >> alloc_pages_exact()?
> >
> > Yes. No, it is too early to use them here.
>=20
> There was a recent change in the kernel that allows kmalloc to work
> earlier than before.  Take a look at commit
> 85355bb272db31a3f2dd99d547eef794805e1319 ("powerpc: Fix mpic alloc
> warning").

Thanks. Sorry for my wrong answer above, now I remember the logic
behind this and will try to explain. Actually the reason I do not
use kmalloc() here is that I do not want to _copy_ bitmap data to
newly allocated frame buffer area (It will negatively affect boot
time). Instead I reserve the already configured frame buffer area
so that it won't be destroyed. The starting address of the area
to reserve and also the lenght is passed to reserve_bootmem().
This is the real reason for using reserve_bootmem() here.
I could alloc new bitmap area using allocators, but then I have
to copy the bitmap data (splash image) to newly allocated area
and have to re-configure the descriptors to display from new
bitmap buffer.

Anatolij
