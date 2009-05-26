Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 14EAADDFF8
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 05:04:53 +1000 (EST)
Received: by qyk34 with SMTP id 34so6693397qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 12:04:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1C3230.8030009@freescale.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>
	<4A1C16DF.9090802@freescale.com> <4A1C20EA.5080603@freescale.com>
	<4A1C3059.40303@freescale.com> <4A1C3230.8030009@freescale.com>
Date: Tue, 26 May 2009 15:04:50 -0400
Message-ID: <9e4733910905261204p565529b0n953719f4d1c6339@mail.gmail.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
From: Jon Smirl <jonsmirl@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@freescale.com>,
	smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 2:17 PM, Timur Tabi <timur@freescale.com> wrote:
> Geoff Thorpe wrote:
>
>> rc =3D spin_event_timeout((ret =3D in_be32(x) & 0x14), ...);
>
> It's an interesting idea, but I have two problems with it:
>
> 1) This approach is that it depends on the internals of the macro. =A0Tha=
t is, you're sneaking in an assignment in the hopes that the code will beha=
ve properly. =A0You see that the current code evaluates the condition only =
once, so it works. =A0The code will look like this:
>
> 2) Unlike the wait_event_xxx macros, I believe that the actual evaluated =
expression is important to the caller. =A0So 90% of the time, the caller is=
 going to pass in "ret =3D (condition)", which means it makes more sense to=
 have this as a built-in feature of the macro.

The only time you need the result is when you are waiting on multiple
bits. I don't think looping while waiting on multiple bits is the
common case.

> So if you're okay with v9 of the patch, please ACK it.

I'll ACK ths so that I can get my driver in. But every time I used
this function I got it wrong on the first try. This is going to be a
source of bugs.


>
> --
> Timur Tabi
> Linux kernel developer at Freescale
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
