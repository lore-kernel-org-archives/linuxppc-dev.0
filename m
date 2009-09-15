Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B613BB6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 01:32:36 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8FFPZLB017060
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 11:25:35 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8FFWW4T251710
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 11:32:32 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8FFWVUj028319
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2009 11:32:31 -0400
Date: Tue, 15 Sep 2009 11:32:20 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: RFC: delete UART current-speed from 4xx DTS?
Message-ID: <20090915153220.GG12372@zod.rchland.ibm.com>
References: <20090915143135.GA7015@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090915143135.GA7015@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2009 at 10:31:36AM -0400, Paul Gortmaker wrote:
>One of the guys here was getting a messed up console on a bamboo board
>(on linux boot), which he traced to the fact that the default dts has a
>9600 baudrate coded into it (board was running 115k2, not 9600).  Either
>deleting the line, or replacing the 9600 with zero fixed the problem.

Once booted, was there a valid current-speed property in /proc/device-tree
for the serial node?  I'm curious if U-Boot created it, or if the kernel
just used whatever baud was present already.

When I did the bamboo port a while ago, I recall having issues with either
a missing clock-frequency or current-speed (or both perhaps) and the bootloader
on the board was the original PIBS.  It might have been an issue with PIBS
but I'm guessing the rest of the 4xx boards copied from either Ebony or
Bamboo in their ports and hence contain that property.

>Looking at the Fsl boards, it seems that 99% of them don't list any
>current-speed at all.  I'm willing to whip up a patch to delete them

I think 99% of them use U-Boot, which should fix things up either way.

>from the various boards, but I thought I'd check 1st to see if there was
>some other reasoning/input.  I suppose one could argue that u-boot
>should be replacing the 9600 with 115k2 on the fly, but if the explicit
>specification isn't helping anyone, then it probably just makes sense to
>delete them anyway, I figured.

Yeah, that's probably valid.  I'd be happy to test on the set of boards I
have.

>Here is the subset of boards I was considering deleting the lines from:
>
>   bamboo.dts ebony.dts hcu4.dts holly.dts katmai.dts sam440ep.dts
>   sequoia.dts taishan.dts walnut.dts yosemite.dts

I can test bamboo with PIBS, ebony, holly (which isn't 4xx even though it's
a tree name) with PIBS, sequoia, taishan, yosemite, and walnut.  Perhaps a few
of the 405 boards I have as well.

It's easy enough for me to whip up a patch, and since I'll be testing either
way I'd be happy to do that if you'd like.

josh
