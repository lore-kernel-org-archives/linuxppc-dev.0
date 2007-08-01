Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13B8EDDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 03:43:09 +1000 (EST)
Message-ID: <46B0C624.2070000@freescale.com>
Date: Wed, 01 Aug 2007 12:43:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH] MPC832x_RDB: update dts to use spi, register mmc_spi
	stub
References: <20070726135738.GB5643@localhost.localdomain>
	<7BACDD73-9097-4139-8331-A1A14A6134D0@kernel.crashing.org>
	<20070727114559.GB11463@localhost.localdomain>
	<20070727164047.GB26893@ld0162-tx32.am.freescale.net>
	<dfa3ff8d8c6af28003c7f9f831371358@kernel.crashing.org>
In-Reply-To: <dfa3ff8d8c6af28003c7f9f831371358@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> For some buses, there is a "slot-names" property; some (non-core)
> bindings seem to define a "location" property.
> 
> For "random" human-readable labelling, i.e. not corresponding to
> physical markings on the hardware, I recommend you look for a
> matching entry in /aliases.

Aliases could work, but are awkward to use for the purposes I'm thinking 
of (giving the OS a name to present to the user in association with a 
device).  They're more suited to interactive OF use where the device 
tree is being directly referenced by the user.

Plus, you're then restricted to valid property names for the alias, 
whereas with a label property you could use any string, including spaces 
and such.

>  It won't ever be _exactly_ what you
> want though, the Linux device namespace is separate from the
> device tree.

That's Linux's choice.  Nothing stops it from showing device tree labels 
  to the user in various situations -- what got me thinking about this 
was that apparently ALSA lets the driver pass an arbitrary string to 
identify the device, and it seemed that such a device-tree-derived label 
would be the most useful to the user.  To use aliases for that, it'd 
have to get the full path to the audio node, compare it to each alias, 
and hope it finds one and only one, and that that alias was intended to 
be a user label and not something else.

-Scott
