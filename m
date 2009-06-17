Return-Path: <nvbolhuis@aimvalley.nl>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A0CF9B71C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 22:16:08 +1000 (EST)
Received: from smtp-vbr17.xs4all.nl (smtp-vbr17.xs4all.nl [194.109.24.37])
	by ozlabs.org (Postfix) with ESMTP id E2AF4DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 22:16:07 +1000 (EST)
Message-ID: <4A38DE83.1010405@aimvalley.nl>
Date: Wed, 17 Jun 2009 14:16:03 +0200
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>	
	<4A38AADD.3070801@aimvalley.nl>
	<c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
In-Reply-To: <c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Leon,

...

> Most designs do not care about the watchdog, or only pet in their
> non-critical paths... That's not what the watchdog is for.
> Also, I don't care about u-boot.
> 
> I care about a design where the Flash NOR could be in write mode at
> any time when the watchdog triggers, when the hardware is running
> critical software.
> No lifes in danger when it happens, only jobs, so no biggy :-)
> 


true, I was just looking from SW/u-boot perspective.
Ideally the dead-lock is prevented on board/HW level.


> 
> David has been helpful in thinking this through, but we followed-up
> offline, and we independently came up with the following design, so
> this must therefore work (disclaimer applies).
> 
> Note, it DOES require a NOR flash that has a RY/BUSY# pin.
> 
> Quoting David Hawkins, who gave a very clear explanation:
> ---
> How about using the RDY/BUSY# pin on the Flash in conjunction
> with PORESET#. If the flash is busy, then the processor gets
> PORESET#, otherwise, the HRESET# just does its normal thing.
> 
> That way PORESET# only ever asserts when you have the
> combo of the Flash being busy and HRESET# asserting.
> 
> <...>
> 
> If you have the Flash BUSY# signal, then this scheme works
> great, since using HRESET# low and BUSY# low to create a
> PORESET# source is only active until the Flash RESET#
> is asserted long enough for it to get out of the BUSY#
> state and back into read-array mode.
> ---
> 
> Kudos to David.
> 
> I'll be testing the design tomorrow on the reference board, I'll
> report results in this thread.
> 


Interesting.
Looking forward to the results.

---
N. van Bolhuis.
