Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 09C11DE016
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:03:03 +1000 (EST)
Received: by qyk34 with SMTP id 34so6616804qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 11:03:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A1C20EA.5080603@freescale.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>
	<4A1C16DF.9090802@freescale.com> <4A1C20EA.5080603@freescale.com>
Date: Tue, 26 May 2009 13:56:31 -0400
Message-ID: <9e4733910905261056v7a1a8e77ie6f273820ce1fd3e@mail.gmail.com>
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

On Tue, May 26, 2009 at 1:03 PM, Timur Tabi <timur@freescale.com> wrote:
> Geoff Thorpe wrote:
>
>> So from this user's perspective (FWIW), it would come as a surprise if
>> the return value reflected the evaluated expression rather than what
>> happened w.r.t. the spin/timeout.
>
> It shouldn't come as a surprise because I've thoroughly documented the be=
havior. =A0I also think returning the actual value of the expression is bet=
ter than a return code. =A0Remember, the primary purpose of this macro is t=
o wait for a hardware register to change. =A0Contrast this to wait_event_xx=
x, which usually queries a variable. =A0Therefore, the hardware register ma=
y set multiple bits. =A0For instance, you could do this:
>
> ret =3D spin_event_timeout(in_be32(x) & 0x14, ...);
>
> if (ret & 0x10)
> =A0 =A0 =A0 =A0do something here
>
> if (ret & 0x04)
> =A0 =A0 =A0 =A0do something else here

If (ret =3D=3D 0)
    timeout_happened;

That's the part that looks wrong.

>
> I think the ability to do this is more important than making the code as =
similar as possible to wait_event_xxx.

Why not this?

rc =3D spin_event_timeout(result =3D (in_be32(x) & 0x14), ...);
if (rc)
   timeout_happened;

if (result & 0x10)
       do something here

if (result & 0x04)
       do something else here


Then if I don't care about the result (which I think is the common case)...

rc =3D spin_event_timeout(in_be32(x) & 0x14, ...);
if (rc)
   timeout_happened;



>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>



--=20
Jon Smirl
jonsmirl@gmail.com
