Return-Path: <adrian@rhlx01.hs-esslingen.de>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rhlx01.hs-esslingen.de", Issuer "HE CA - G02" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0281DE12F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 02:56:07 +1100 (EST)
Date: Wed, 14 Jan 2009 16:56:02 +0100
From: Adrian Reber <adrian@lisas.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Add support to access the flash on SLOF based
	systems
Message-ID: <20090114155602.GA19277@lisas.de>
References: <1231601482-28123-1-git-send-email-adrian@lisas.de>
	<c613a7e0a88e249894bafe6d2183fbf2@bga.com>
	<20090110195040.GA19945@lisas.de>
	<6550a303b71331432a805ad98ca38103@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6550a303b71331432a805ad98ca38103@bga.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2009 at 09:51:23AM -0600, Milton Miller wrote:
> Is SLOF just exposing the user image part of the flash device?  Or is it 
> the raw flash device?

SLOF is exposing the raw flash device.

> I need to keep this quick, but am intrested in a few more details.  My  
> first reaction is its yet another random misc-device, but I confess to  
> having written one for internal consumption.  But as a misc device it  
> will need to go through lkml review to be merged.

I had a look at mtd and it was pretty easy to get it to do the same
thing as my misc-device was doing with only 5 lines changed in
drivers/mtd/maps/physmap_of.c

So thanks for pointing me in that direction. What would be now the best
way to include the SLOF flash properly into the mtd driver?

Should I add additional code to physmap_of.c to detect the flash and
then use a hardcoded layout for the partition? Because SLOF is missing
all the necessary properties in the flash device node. Or should I add
the missing properties in prom_init.c in a fixup_device_tree_slof()
function? Both versions would lead to the same result but I am unsure
about which approach is the better one.

		Adrian
