Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE528B70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 20:09:23 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 0B566DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 20:09:22 +1000 (EST)
Received: by yxe37 with SMTP id 37so194652yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 03:09:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A38AADD.3070801@aimvalley.nl>
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
	<4A38AADD.3070801@aimvalley.nl>
Date: Wed, 17 Jun 2009 12:09:21 +0200
Message-ID: <c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,

On Wed, Jun 17, 2009 at 10:35 AM, Norbert van
Bolhuis<nvbolhuis@aimvalley.nl> wrote:
> Hi Leon,
>
> I doubt if there are working designs for this.
> ...
> In u-boot the watchdog (if enabled with CONFIG_WATCHDOG) is normally
> strobed in the decrementer interrupt routine (timer_interrupt). So
> I guess there's not a big chance it triggers a reset.
> ...
>
Most designs do not care about the watchdog, or only pet in their
non-critical paths... That's not what the watchdog is for.
Also, I don't care about u-boot.

I care about a design where the Flash NOR could be in write mode at
any time when the watchdog triggers, when the hardware is running
critical software.
No lifes in danger when it happens, only jobs, so no biggy :-)


David has been helpful in thinking this through, but we followed-up
offline, and we independently came up with the following design, so
this must therefore work (disclaimer applies).

Note, it DOES require a NOR flash that has a RY/BUSY# pin.

Quoting David Hawkins, who gave a very clear explanation:
---
How about using the RDY/BUSY# pin on the Flash in conjunction
with PORESET#. If the flash is busy, then the processor gets
PORESET#, otherwise, the HRESET# just does its normal thing.

That way PORESET# only ever asserts when you have the
combo of the Flash being busy and HRESET# asserting.

<...>

If you have the Flash BUSY# signal, then this scheme works
great, since using HRESET# low and BUSY# low to create a
PORESET# source is only active until the Flash RESET#
is asserted long enough for it to get out of the BUSY#
state and back into read-array mode.
---

Kudos to David.

I'll be testing the design tomorrow on the reference board, I'll
report results in this thread.


Regards / Groeten,
-- 
Leon
