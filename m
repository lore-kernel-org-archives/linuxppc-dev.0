Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 067A967C3A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 08:30:28 +1100 (EST)
Message-ID: <457F1F6E.4020502@freescale.com>
Date: Tue, 12 Dec 2006 15:30:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
In-Reply-To: <1165890570.11914.5.camel@localhost.localdomain>
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

Benjamin Herrenschmidt wrote:
> Well, either you want all freescale boards have one platform.
> in which case you write one ppc_md() structure, call it
> mpc83xx_fslboards or something like that, and have a probe routine that
> test for all matches, or create as many ppc_md structures as you have
> boards each with it's own probe().
> 
> The point here is that other developpers making their own mpc83xx based
> boards will not want to use your ppc_md.

They *may* not want to (and they certainly shouldn't be forced to), but 
some may not want to define a new ppc_md (or modify a probe function) 
for every new board if all of the differences are encapsulated in the 
device tree.  I thought one of the main goals of having a device tree is 
that if it's done right, the kernel need not know about every single 
model of board, just the different components that a device tree can 
specify.

If a board has truly board-specific logic that needs custom code in the 
kernel itself (rather than the bootloader), then it can go in as a 
driver with a device tree node (this should be done with the BCSR stuff 
where needed).

What about something like the original patch, but with "mpc83xx-generic" 
(or similar) as the compatible match?  This would address the "matches 
everything with mpc83xx in it" concern, without requiring kernel changes 
when a new device tree is all that's really needed, and without 
requiring non-freescale boards to have something like "fslboards" in the 
  compatible property just in order to use generic platform 
initialization code *if they want to*.  Once the BCSR and RTC stuff is 
(re)moved, there's really not much of anything fslboard-specific in there.

More generally (and longer-term), what about a completely generic 
platform init file that implements the "booting-without-of.txt" 
platform?  That is, a string that can be placed in the compatible 
property, regardless of board or CPU, in order to assert that nothing 
board-specific has to be done other than as specified by the device 
tree.  The model property could still hold the actual board ID if needed 
to present to the user, or for matching a more specialized machine 
description if problems arise and the device tree cannot be easily 
changed (the generic probe could be arranged to run last).

Alternately, just allow the kernel to boot without finding a matching 
probe, if generic code is able to extract enough information from the 
device tree for generic versions of any non-optional ppc_md functions to 
work.  If a probe does match, then it can fill in any ppc_md fields it 
wants to override (and/or do special initialization, etc).  ppc_md 
fields can also be filled in by CPU-specific code, or by drivers the 
device tree instantiates.

-Scott
