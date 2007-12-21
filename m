Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Dec 2007 14:59:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
Message-ID: <20071221035952.GB5930@localhost.localdomain>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<AD8BE998-401D-4109-8DD0-F26760C0E980@kernel.crashing.org>
	<20071221033815.GA13921@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221033815.GA13921@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 10:38:15PM -0500, Paul Gortmaker wrote:
> In message: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
> on 20/12/2007 Kumar Gala wrote:
> 
> >> 3) Add device tree source for Wind River SBC8560 board
> >>
> >> This is probably the most interesting part of the group, given that the
> >> board doesn't use the CPM2 to provide the serial console.  I've made a
> >> duart dts entry that is kind of similar to what is done for the tsi108
> >> on the mpc7448/hpc-ii board, and made sure that the serial had their
> >> parent marked as "soc" (found out the hard way that UARTs were ignored
> >> as possible consoles unless they were soc or tsi108 children...)
> >>
> >> b/arch/powerpc/boot/dts/sbc8560.dts |  203 
> >> +++++++++++++++++++++++++++++++++++-
> >
> > we need to figure out to fix this so we don't need the parent marked as 
> > 'soc'.
> 
> Here is my interpretation of what is happening here -- we come in via
> find_legacy_serial_ports() to pick a console port.  It grabs "chosen"
> to get np stdout, and then checks the parent of the 16550 compat ports
> against the following, requiring at least one of them to match:
> 
> 	parent->type == "soc" ? add_legacy_soc_port()
> 
> 	parent->type == "isa" ? add_legacy_isa_port()
> 
> 	parent->type == "tsi-bridge" ? add_legacy_soc_port()
> 
> 	parent->type == "opb" ? add_legacy_soc_port()
> 
> No match means no serial console, it seems.

Not necessarily.  If the port is picked up by the of_serial driver it
should work.  The drawback is that the console will be initialized
rather late by this method.

>  I figured that parent == "soc"
> was the lesser lie to choose from, but I'm open to an alternate approach 
> that is less apt to make David go "ewww" (an understandable
> reaction...).

Lying in the device tree like this is just bad.  Adding another case
to legacy_serial for your specific case would be ugly but infinitely
preferable to mislabelling the node with type "doc".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
