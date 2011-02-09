Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3DC81B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Feb 2011 04:03:31 +1100 (EST)
Date: Wed, 9 Feb 2011 09:03:27 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH 1/2] misc: add CARMA DATA-FPGA Access Driver
Message-ID: <20110209170327.GA21766@ovro.caltech.edu>
References: <1297121021-3522-2-git-send-email-iws@ovro.caltech.edu>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC45@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC45@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2011 at 04:30:23PM -0000, David Laight wrote:
>  
> > This driver allows userspace to access the data processing 
> > FPGAs on the OVRO CARMA board. It has two modes of operation:
> > 
> > 1) random access
> > 
> > This allows users to poke any DATA-FPGA registers by using mmap to map
> > the address region directly into their memory map.
> 
> I needed something similar, but used pread() and pwrite()
> to request the transfers.
> While this does require a system call per transfer, it allows
> the driver to use dma (if available) to speed up the request.
> In my case doing single cycle transfers would be too slow.
> 

We initially started with a read()/write() interface for individual
register reads and writes, just like you describe. It turned out that
mmap was plenty fast for our use. I made the decision to ditch all of
the extra code needed to setup and execute the DMA for the much simpler
mmap code.

In our case, going all the way through the DMA engine code just to
transfer 4 bytes is overkill. The local bus is already quite fast, and
we can increase the clock speed if needed.

Ira
