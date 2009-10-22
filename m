Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id 12EFDB7BB8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 05:15:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device Tree Corrupted after unflatten_device_tree()
Date: Thu, 22 Oct 2009 11:14:34 -0700
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB8C@exchtxus2.HSTX.global.vpn>
In-Reply-To: <20091021221033.GB12560@yookeroo.seuss>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB88@exchtxus2.HSTX.global.vpn>
	<1256079691.8902.3.camel@concordia>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3FB5BB8B@exchtxus2.HSTX.global.vpn>
	<20091021221033.GB12560@yookeroo.seuss>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, David/Michael,

Great great finding! I added halting FEC (the Ethernet controller in
MPC866)=20
in platforms_fixups() and the problem disappears.

Thank you very much!

Lixin

-----Original Message-----
From: David Gibson [mailto:david@gibson.dropbear.id.au]=20
Sent: Wednesday, October 21, 2009 6:11 PM
To: Lixin Yao
Cc: michael@ellerman.id.au; linuxppc-dev@lists.ozlabs.org
Subject: Re: Device Tree Corrupted after unflatten_device_tree()

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

--=20
David Gibson			| I'll have my music baroque, and my
code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_
_other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
