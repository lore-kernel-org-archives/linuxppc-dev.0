Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BBC62BEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Dec 2004 01:04:04 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dean Hamstead <dean@bong.com.au>
In-Reply-To: <41CAB92A.4050808@bong.com.au>
References: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>
	<41CA0E0D.908@bong.com.au> <1103788847.29975.10.camel@gaston>
	<41CAB92A.4050808@bong.com.au>
Content-Type: text/plain
Date: Thu, 23 Dec 2004 15:03:00 +0100
Message-Id: <1103810580.19814.18.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-12-23 at 23:25 +1100, Dean Hamstead wrote:
> given the variety of hardware would it be worth splitting up snd-powermac?
> 
> how easily can code be used from darwin?

Code cannot be copied "as-is" but it's definitely a good source of
informations. Also, the various codec chips used on recent machines do
have publically available documentations.

What I would suggest is to split the driver for all the pre-i2s machines
(awacs, screamer & burgundy basically) from the i2s based ones (daca,
tumbler, snapper, plus the g5 new digital stuff).

The actual dbdma code for doing the actual sample transfer & buffer
management should be split in a separate file and shared by all
implementations.

For the i2s based machines, we need a better mecanism. We need, I think,
to have a file with i2s stuffs (for dealing with setting the i2s sample
format & clocks, which we don't do properly yet), separate files for the
actual codecs (either analog or digital), and a "hub" part that puts
everything together.

The thing here is we need to deal with more than one codec on the same
bus (the g5 has both a tas3004 for analog and some other digital chip
for spdif) and we need to be able to change the clock source (when a
digital input is plugged, the whole clock net is to be sourced from it).

So I would suggest writing a "generic" interface structure (a structure
with function pointers etc...) for the codecs. The "core" code would
then match against the mac-io device of the i2s bus (it will match twice
but the second bus is used only by the modem and can be ignored for now)
or with whatever snapper/tumbler/AOA device node is below. It would
decode the "reg" property in there (slightly different on the G5s) and
instanciate the i2s driver the dbdma engine (PCM) and the appropriate
set of codec's. The codecs can register their own mixer controls
individually, but the "core" stuff need to deal with clock switching.

Ben.
