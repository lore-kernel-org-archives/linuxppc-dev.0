Return-Path: <timur.tabi@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 9FCEDB7D1C
	for <linuxppc-dev@ozlabs.org>; Sat,  1 May 2010 04:19:17 +1000 (EST)
Received: by pvh11 with SMTP id 11so19367pvh.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 11:19:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100430162254.GA24285@schlenkerla.am.freescale.net>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
	<20100430121947.1d265ca6@wker>
	<x2ned82fe3e1004300808q757826cs864ac1c7c082f81@mail.gmail.com>
	<20100430162254.GA24285@schlenkerla.am.freescale.net>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Fri, 30 Apr 2010 13:18:46 -0500
Message-ID: <r2sed82fe3e1004301118xc52b46cfi879de534283fd51@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Apr 30, 2010 at 11:22 AM, Scott Wood <scottwood@freescale.com> wrot=
e:

>> That's what I meant. =A0Actually, I think it's ULL. =A0Regardless, I thi=
nk
>> the compiler will see the =A0"1000000000 ... * 1000" and just combine
>> them together. =A0You're not actually outsmarting the compiler.
>
> The compiler will do no such thing. =A0That's a valid transformation when
> doing pure math, but not when working with integers.

I ran some tests, and it appears you're right.  I doesn't make a lot
of sense to me, but whatever.

However, "(1000000000 / pixclock) * 1000" produces a result that's
less accurate than "1000000000000ULL / pixclock".  Unfortunately, that
math caused a linker problem with __udivdi3 when I tried it, so maybe
you can use do_div() instead?

>> =A0 =A0 err =3D -1;
>>
>> because he wanted it to be the largest possible integer.
>
> -1 is not the largest possible integer. =A0LONG_MAX, perhaps?

What, you don't like implicit casting of -1 to an unsigned? :-)

Since err is a long integer, LONG_MAX is the better choice.

--=20
Timur Tabi
Linux kernel developer at Freescale
