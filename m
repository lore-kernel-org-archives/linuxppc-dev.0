Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 6013DDDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 15:30:08 +1000 (EST)
Date: Wed, 25 Apr 2007 07:29:59 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Pradyumna Sampath <pradyumna.sampath@gmail.com>
Subject: Re: arch/powerpc for lite5200b
Message-ID: <20070425052959.GX18236@moe.telargo.com>
References: <f87351060704240431m2218910cs65510472218459b0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f87351060704240431m2218910cs65510472218459b0@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 24/04/07 17:01 +0530, Pradyumna Sampath wrote:
> Hi Everyone,
> 
> I have been trying to get the linux-2.6.20-rt3 for arch/powerpc to
> boot on my lite5200b. Here are the things that I have tried so far. I
> have a custom board based on the lite5200b and then the evaluation
> board too.
> 
> - I have a working 2.6.16-rt29 kernel compiled using ARCH=ppc for both
> these boards.
> 
> - I tried the default configs for lite5200 for both the custom board
> and the EVB. Both hang at "Transferring control to Linux (at address
> 00000000) ..."

Device tree missing?
You need to compile it with dtc, then in u-boot use something like:
bootp; tftp 0x400000 uImage.ppc; tftp 0x600000 lite5200b.dtb
set your bootargs
bootm 0x400000 - 0x600000

> 
> - I downloaded roberts
> http://www.pengutronix.de/oselas/bsp/phytec/index_en.html#phyCORE-MPC5200B-tiny
> patches, but still ended up with the same result.
> 
> I read ( http://www.nabble.com/Re%3A-MPC52xx-support-rework-for-2.6.20-p7568655.html
> )  that the arch/powerpc port for lite5200 works right out of the box.
> Am I doing something wrong ?
> 
> The one thing I am yet to try is to do a git checkout from
> git.secretlabs.ca. Unfortunately thanks to some internal firewalling
> policies I still have not been able to do that.

kernel.org tree will also work with lite5200b, if you need ethernet
download fec/bestcomm patches from Grant's tree.


	Domen
