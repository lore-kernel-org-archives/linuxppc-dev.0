Return-Path: <jjdanimoth@gmail.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) by ozlabs.org (Postfix) with ESMTP id B16D0B6EF1
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 03:12:21 +1000 (EST)
Received: by wyb32 with SMTP id 32so27378wyb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 10:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1279037396.515.19.camel@thor.local>
References: <AANLkTikdlwl6VxdbkHP0TveQ3SPO0w4RD-onoG3QPyCO@mail.gmail.com>
	<1279030767.515.15.camel@thor.local>
	<AANLkTilk4-gIiJPQb5aqZ5v4YvgzsddexnsmrFBER5HO@mail.gmail.com>
	<1279033177.515.16.camel@thor.local>
	<AANLkTik154EFPIzMZy5v-Mj6mhWt-hCaFYvLPi5oLWFD@mail.gmail.com>
	<1279037396.515.19.camel@thor.local>
From: jjDaNiMoTh <jjdanimoth@gmail.com>
Date: Tue, 13 Jul 2010 19:05:32 +0200
Message-ID: <AANLkTikR0HRoBawbUJyS_cEkhEu9Sj6q8hR2F0v6CLDK@mail.gmail.com>
Subject: Re: 2.6.35-rc4 ppc crash when loading radeon modeset=1
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, xorg-driver-ati@lists.x.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/7/13 Michel D=C3=A4nzer <michel@daenzer.net>:
[cut]
> Are you looking at the right log file, not the one from the new X server
> after the reboot?
Yes, I looked to .old, when referring to Xorg.0.log.

> Maybe you could post the full dmesg, Xorg.0.log and X server stderr
> output (should be captured in the gdm/kdm log file) from trying with
> modeset=3D1.
>
>> At this time, I think it isn't a kernel problem, am I right?
>
> With modeset=3D1 it most likely is a kernel (configuration) problem.

So, I've now the acceleration. The main problem was radeon.agpmode,
setting it to -1 (and removing all files in xorg.conf.d related to
radeon) fixes all issue (also the freeze on glxgears). Now I have
~1500 FPS, and I'm fine with it (before I got 100 FPS).

I get the acceleration also with a non-KMS capable kernel, so I think
we got the point. I will add the option to modprobe.conf for archPPC.

I tried a program which use a lot opengl, the only thing I see is
ERROR: GL error 1282
ERROR: Ignoring 1 openGL errors

but the topic-error is fixed.

Thank you.
