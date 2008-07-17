Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080716103752.463e00cb@zod.rchland.ibm.com>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
	<20080716103752.463e00cb@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0755f39c01b1e631127095ddb3455566@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Thu, 17 Jul 2008 05:15:19 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> And then you don't need this file at all.  Just add a
>>> "amcc,canyonlands" string to your root node compatible property.
>>
>> No!  Don't do this because it is not true!

If the board actually _is_ compatible to the canyonlands board (it
only _adds_ stuff, doesn't change things or takes away things), it
is perfectly valid to declare it compatible, since it _is_.

In my opinion, for the root compatible value, it is also okay to
declare a board compatible if it is only "largely" compatible,
just has some little differences -- esp. if you're declaring a
board to be compatible to some reference design.  This does of
course have downsides as well.

> Meh. You're splitting hairs.  It _is_ true from a kernel perspective.

That doesn't matter.  The device tree describes the hardware, it doesn't
matter what the Linux kernel does.  For one thing, the kernel isn't
necessarily the only OS (or other client) to run with this DTS; also,
the kernel is a moving target, while the DTS can be burned into ROM.

>> Instead, add your board name to canyonlands.c in canyonlands_probe().
>> It's not the most scalable solution, but it keeps you from lying about
>> your hardware in the .dts file.
>
> That could also be done.  Frankly though, if you look at the existing
> board.c files in there now, none of them are special.  The device tree
> really provides the differences these days, not the C code.

Yes.  It would be more scalable if the platform probe code checks
the device tree for the features it expects (certain CPU, certain
interrupt controller, certain chipsets / bridges), instead of it
checking the root "compatible" property.

> I'm this
> || close to just killing them all and doing a 4xx_board.c file that
> does the right thing based on the few boards that have differences.

Oh, the kernel code even considers these things to be different
platforms?  Insane :-)


Segher
