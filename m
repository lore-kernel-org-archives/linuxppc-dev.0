Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Oct 2009 09:10:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Lixin Yao <Lixin.Yao@HSTX.com>
Subject: Re: Device Tree Corrupted after unflatten_device_tree()
Message-ID: <20091021221033.GB12560@yookeroo.seuss>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB88@exchtxus2.HSTX.global.vpn>
	<1256079691.8902.3.camel@concordia>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB8B@exchtxus2.HSTX.global.vpn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB8B@exchtxus2.HSTX.global.vpn>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2009 at 10:43:55AM -0700, Lixin Yao wrote:
> When corrupted, curtain blocks of 64 bytes are messed up.
> This is a screen dump of a good unflattened device at beginning:

[snip]
> When corrupted, it becomes following, note the 64 bock at 0x03ffdf00
> is messed up. And this kind of corruptions occur several times

[snip]
> 03ffdf00 : ffffffff ffff000c db055be0 08060001  ..........[.....
> 03ffdf10 : 08000604 0001000c db055be0 ac141001  ..........[.....
> 03ffdf20 : 00000000 0000ac14 10530000 10530000  .........S...S..
> 03ffdf30 : 08000604 0001000c 36681bfe f874c01e  ........6h...t..

Uh, oh.  That looks like a broadcast ethernet packet (ARP,
specifically).  Looks like a network device used by the firmware
hasn't been quiesced properly before booting the kernel and is DMAing
stuff straight on top of kernel memory.  You'll probably need a hook
in the bootwrapper to shut down the ethernet.

There are some examples of this in arch/powerpc/boot already - look
for ibm4xx_quiesce_eth().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
