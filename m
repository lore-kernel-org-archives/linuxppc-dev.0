Return-Path: <dgibson@ozlabs.org>
Date: Fri, 18 Jul 2008 13:47:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Message-ID: <20080718034727.GF18748@yookeroo.seuss>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <93c791ba2d4ce372589da84acd14a15c@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 17, 2008 at 11:14:11AM -0500, Milton Miller wrote:
> On Thu Jul 17 at 23:22:28 EST in 2008, Guillaume Dargaud wrote:
[snip]
>> Maybe the main() of the kernel can receive argv/argc the usual way,  
>> and I
>> just need to call "0x400000(argc, argv);" but I have no idea if that  
>> works.
>
> Ahh ... you are still on ppc.   Please note that we just merged
> the removal of arch/ppc, everyone needs to use powerpc now.  The
> good news is: its easier to state the requirements, and its
> easier to share the code in vmlinux.  The bad news is you have to
> follow the rules for passing data to the kernel.  Its not hard.
> We have defined a data structure that is parsed to become a tree
> of data describing the machine, and based the contents on open
> firmware.  We call this the flattened device tree.

Your firmware doesn't have to deal with this though, although it can.
It's perfectly acceptable - in fact I'd mildly recommend it over doing
this in the firmware - to instead have the kernel's zImage wrapper
supply the flattened device tree, folding information it needs to get
from the firmware into it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
