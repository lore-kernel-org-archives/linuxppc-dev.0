Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9BE22DDE39
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:24:13 +1000 (EST)
In-Reply-To: <46B0C624.2070000@freescale.com>
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<20070727164047.GB26893@ld0162-tx32.am.freescale.net>
	<dfa3ff8d8c6af28003c7f9f831371358@kernel.crashing.org>
	<46B0C624.2070000@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <846a10d04d901f23a54f9266eee781d6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Mon, 6 Aug 2007 20:24:01 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> For some buses, there is a "slot-names" property; some (non-core)
>> bindings seem to define a "location" property.
>> For "random" human-readable labelling, i.e. not corresponding to
>> physical markings on the hardware, I recommend you look for a
>> matching entry in /aliases.
>
> Aliases could work, but are awkward to use for the purposes I'm 
> thinking of (giving the OS a name to present to the user in 
> association with a device).

Sure; it's just one thing a platform driver could use.

> Plus, you're then restricted to valid property names for the alias, 
> whereas with a label property you could use any string, including 
> spaces and such.

Spaces in a device name are a bad idea anyway ;-)

>>  It won't ever be _exactly_ what you
>> want though, the Linux device namespace is separate from the
>> device tree.
>
> That's Linux's choice.  Nothing stops it from showing device tree 
> labels  to the user in various situations -- what got me thinking 
> about this was that apparently ALSA lets the driver pass an arbitrary 
> string to identify the device, and it seemed that such a 
> device-tree-derived label would be the most useful to the user.

Yeah.  The platform code has the final responsibility for those
names, it can use whatever mechanism is appropriate for that
platform.

> To use aliases for that, it'd have to get the full path to the audio 
> node, compare it to each alias, and hope it finds one and only one,

This would of course be split off into a nice prom.c utility
function, so it isn't much code, just a function call.

> and that that alias was intended to be a user label and not something 
> else.

Hey at least they're all printable :-)


Segher
