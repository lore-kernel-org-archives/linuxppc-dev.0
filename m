Return-Path: <timur.tabi@gmail.com>
Received: from mail-pz0-f185.google.com (mail-pz0-f185.google.com
	[209.85.222.185]) by ozlabs.org (Postfix) with ESMTP id 6991DB7D2D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 01:15:19 +1000 (EST)
Received: by pzk15 with SMTP id 15so175192pzk.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 08:15:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100430121947.1d265ca6@wker>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Fri, 30 Apr 2010 10:08:45 -0500
Message-ID: <x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Apr 30, 2010 at 5:19 AM, Anatolij Gustschin <agust@denx.de> wrote:

>> How about just doing this?
>>
>> .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_diu,
>
> I thought it should be prepared for adding other code here.
> mpc5121_ads_init_early() is generic and could contain other
> things as well. I would vote for current version.

Do you have any plans to add any additional code?   If not, then I say
skip the middle-man.  If someone ever needs to do more, he can always
put that function back.

>> I'm pretty sure the compiler will optimize this to:
>>
>> =A0 =A0 temp =3D (1000000000000UL / pixclock);
>>
>> so you may as well do it that way.
>
> ??
> 1000000000000 is _not_ UL, but UUL.

That's what I meant.  Actually, I think it's ULL.  Regardless, I think
the compiler will see the  "1000000000 ... * 1000" and just combine
them together.  You're not actually outsmarting the compiler.

>> > + =A0 =A0 =A0 err =3D 100000000;
>>
>> Why do you assign err to this arbitrary value?
>
> Dunno. It is Freescale's code and I do not have time to check
> and understand each bit of it and to explain it.

*sigh*  You're not the first person to modify the DIU driver without
understanding what it all does.  I suspect that the original author
should have done this:

    err =3D -1;

because he wanted it to be the largest possible integer.

>> Do you really need to use reserve_bootmem? =A0Have you tried kmalloc or
>> alloc_pages_exact()?
>
> Yes. No, it is too early to use them here.

There was a recent change in the kernel that allows kmalloc to work
earlier than before.  Take a look at commit
85355bb272db31a3f2dd99d547eef794805e1319 ("powerpc: Fix mpic alloc
warning").

>> > + =A0 =A0 =A0 mode =3D in_be32(diu_reg + 0x1c);
>> > + =A0 =A0 =A0 if (mode !=3D 1) {
>>
>> How can in_be32() return a -1?
>
> It is a 1, not -1. I will use appropriate macro here and also
> change to use a struct instead of adding offset to register base.

Sorry, I misread the code.  I could have sworn it read "mode !=3D -1"

--=20
Timur Tabi
Linux kernel developer at Freescale
