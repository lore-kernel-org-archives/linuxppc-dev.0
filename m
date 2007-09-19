Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8A09DDEE8
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 05:13:04 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8JJD0UO027546
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:13:00 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8JJCxG6477736
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 13:13:00 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8JJCwZc022426
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 13:12:59 -0600
Date: Wed, 19 Sep 2007 14:12:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070919141249.61e6dc81@weaponx.rchland.ibm.com>
In-Reply-To: <46F16CC9.3010003@ru.mvista.com>
References: <46F16CC9.3010003@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 19 Sep 2007 22:39:05 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> I've observed kernel crashes on Sequoia board several times.
> Kernel often crashes with high network/memory loads.
> This is due to 440EPx h/w issue.
> 
> According to the errata:
> CHIP_8: Incorrect Write to DDR SDRAM.
> Category: 3
> Overview:
> The write address can be corrupted during writes to DDR SDRAM when write 
> pipelining is enabled on PLB0. The probability of encountering the 
> problem increases with the amount of back-pressure applied by the SDRAM.
> Impact: Data can be written to the wrong address in SDRAM.
> Workaround:
> Disable write pipelining to DDR SDRAM by setting PLB4A0_ACR[WRP] = 0. 
> Only primary write transfers are broadcast and the write address 
> corruption is avoided.

Ew.  That sounds nasty.

> Disabling write pipelining really helps.
> Josh, David, what is the right place to put this workaround to?
> 
> Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
> arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
> or
> should this be done in
> arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch() 
> with dcr_map, dcr_read/write stuff?

Hm, do you happen to know if AMCC is going to release a newer revision
of 440EPx with that fixed?  If so, we should probably do it
conditionally based off of PVR.

As for where to do it, I'd rather it be in sequoia_setup_arch() than
the bootwrapper.  Eventually bootloaders like U-Boot will take a raw
vmlinux so the wrapper won't even be there anymore.

I don't see any reason to use the dcr_map stuff either.  Just check the
PVR, check if the PLB is already set up correctly, and if not set it
with the regular mfdcr/mtdcr functions.  And a comment about why that's
being done would be good.

That's my $0.02 anyway.

josh
