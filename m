Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 712BA2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Dec 2004 04:33:12 +1100 (EST)
Message-ID: <41B9DB6A.1070809@icarus.com>
Date: Fri, 10 Dec 2004 09:22:50 -0800
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
References: <3506EDCDEC47904CBE6FD2E1DEEA89840205BCAA@fs5.airspan.com>
	<20041210100958.C31319@home.com>
In-Reply-To: <20041210100958.C31319@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Colin Wernham <CWernham@Airspan.com>, linuxppc-embedded@ozlabs.org
Subject: Re: PPC4XX DMA polarity bug in linuxppc-2.6.9
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Matt Porter wrote:
| On Fri, Dec 10, 2004 at 09:09:39AM -0000, Colin Wernham wrote:

|>Is there anyone else using the PPC4XX DMA?
|
|
| Yes, I've used this library code for simple memory<->memory DMA
| tests to verify that programmed and SG mode work. For more common
| setups like peripheral driven DMA from the EBC, I've simply programmed
| the DMA engine directly.  This library doesn't seem to simplify anything
| for me in those cases (it's just a thin wrapper around registers) so
| I find it easier to program the DMA engine regs directly within the
| driver that is making use of a channel. I've been keeping it around
| since apparently a lot of people make use of it in hopes that
| somebody might take the time to improve it.

I found the library as thin and undocumented, and didn't seem to
actually solve any problems. Certainly not mine. So I wrote my
own.

I haven't isolated it into its own module yet, as I got to the point
where it's working for my client driver, and didn't submit it as
there is some driver for some oddball hardware that seems to use
the existing library, and this would clash.

Here's the header file for my functions, in case this piques any
interest.

/*
~ * Copyright (c) 2004 Picture Elements, Inc.
~ *    Stephen Williams (steve@icarus.com)
~ *
~ *    This source code is free software; you can redistribute it
~ *    and/or modify it in source code form under the terms of the GNU
~ *    General Public License as published by the Free Software
~ *    Foundation; either version 2 of the License, or (at your option)
~ *    any later version.
~ *
~ *    This program is distributed in the hope that it will be useful,
~ *    but WITHOUT ANY WARRANTY; without even the implied warranty of
~ *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
~ *    GNU General Public License for more details.
~ *
~ *    You should have received a copy of the GNU General Public License
~ *    along with this program; if not, write to the Free Software
~ *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
~ */
#ident "$Id: jsedma.h,v 1.3 2004/08/09 19:04:07 steve Exp $"

# include  <linux/module.h>
# include  <linux/kernel.h>
# include  <asm/uaccess.h>

/*
~ * This module provides a reuseable interface to IBM PPC405GP(r) DMA
~ * controllers. It allows clients to request a suitable controller, to
~ * set up an operation, and see the transaction through. The general
~ * order of events is to:
~ *
~ *  map your user data with the map_user_kiobuf function.
~ *
~ *  Use jsedma_chain_from_kiobuf to turn that map into a string of DMA
~ *  chain cells.
~ *
~ *  Select a DMA controller to use with jsedma_alloc_controller().
~ *
~ *  Start the operation with jsedma_start_chain(...)
~ *
~ *  Wait for it to finish with jsedma_wait_interruptible(...)
~ *
~ *  Then release everything when done.
~ */

/*
~ * Allocate an available DMA controller that has been set up for
~ * memory-to-memory transfers. There may be as many as 4 of
~ * these. The return value is >= 0 if a controller is allocated, or <0
~ * on error.
~ *
~ * When done, release the controller.
~ */
extern int jsedma_alloc_controller(void);
extern void jsedma_free_controller(int dmanr);

/*
~ * Allocate a DMA chain based on the mapped kiobuf. Free the chain
~ * when the DMA in use is completed. This may allocate consistent
~ * pages, so be careful where you use it. Free the chain when you are
~ * done with it.
~ *
~ * The direction is either PCI_DMA_TODEVICE or PCI_DMA_FROMDEVICE.
~ *
~ * WARNING: Just like with pci_map_single, the memory of the iobuf
~ * should not be touched between the creation of this chain and the
~ * completion of the transfer. This function flushes caches (if
~ * needed) so if you touch buffers during the transfer, data can be
~ * lost.
~ *
~ * The jsedma_chain is an opaque type.
~ */
extern struct jsedma_chain* jsedma_chain_from_kiobuf(phys_addr_t dest,
						     struct kiobuf*iobuf,
						     int direction);
extern void jsedma_chain_free(struct jsedma_chain*chp);

/*
~ * Start a DMA of the chain on the specified DMA controller. The
~ * controller should be allocated, and the target address mapped.
~ */
extern int jsedma_start_chain(int dmanr, struct jsedma_chain*chn);

/*
~ * Wait for the channel to be done. When it is done, this function
~ * returns 0. If there is an error, or the wait is interrupted, return
~ * an error code <0.
~ */
extern int jsedma_wait_interruptible(int dmanr);

/*
~ * $Log: jsedma.h,v $
~ * Revision 1.3  2004/08/09 19:04:07  steve
~ *  Use DMA controller to read from frame memory.
~ *
~ * Revision 1.2  2004/05/05 17:39:51  steve
~ *  Make sure caching does not get in the way of transfer.
~ *
~ * Revision 1.1  2004/04/17 02:20:42  steve
~ *  Make frame output use PPC DMA controllers.
~ *
~ */


- --
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBudtprPt1Sc2b3ikRAn2VAJ9zFcfBN5/lBgs/iV++OwQuSwuFGQCgp9CC
c+1dmQF0GoZcuslUCPn23oU=
=cUut
-----END PGP SIGNATURE-----
