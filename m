Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18745DDE37
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:31:27 +1100 (EST)
Date: Fri, 21 Dec 2007 11:31:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 0/4] arch/powerpc support for SBC8560 board
Message-ID: <20071221173106.GB6977@ld0162-tx32.am.freescale.net>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<AD8BE998-401D-4109-8DD0-F26760C0E980@kernel.crashing.org>
	<20071221033815.GA13921@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221033815.GA13921@windriver.com>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 20, 2007 at 10:38:15PM -0500, Paul Gortmaker wrote:
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

We should probably add a parent-is-compatible-with-"simple-bus" check, to
avoid needing to extend this hack even further.

> > Out of interest how exactly are the duart's wired on the 8560.  Are they 
> > off localbus?
> 
> The board has a bunch of stuff hanging off of CS5 -- an RTC, a 7 segment
> display, an EEPROM, some BCSR-like registers, and of course the two
> UARTs which are supposed to be 16C2550.  According to TFM, an EPM7128
> PLD is responsible for mashing/sub-decoding this all onto/off of CS5.
> CS3 and CS4 are the LB-SDRAM.

I'd put these devices under a /localbus node.

-Scott
