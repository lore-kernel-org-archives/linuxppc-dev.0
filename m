Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B598DDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 04:04:58 +1100 (EST)
Date: Mon, 1 Dec 2008 09:04:55 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: "Hommel, Thomas (GE EntSol,
	Intelligent Platforms)" <Thomas.Hommel@gefanuc.com>
Subject: Re: DMA from memory to local bus
Message-ID: <20081201170455.GB32299@ovro.caltech.edu>
References: <62DDBB9E5E23CC4A929EE46F9427CEAF01654DD8@BUDMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62DDBB9E5E23CC4A929EE46F9427CEAF01654DD8@BUDMLVEM04.e2k.ad.ge.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 28, 2008 at 03:04:04PM +0100, Hommel, Thomas (GE EntSol, Intelligent Platforms) wrote:
> 
> Hi all,
> I'm currently developing a driver and want to make use of the DMA
> offload engine. Data has to be transferred from memory to a device on
> the local bus and vice versa.
> At a first look, the function dma_async_memcpy_buf_to_buf() seemed to be
> suitable, but it does not translate addresses correctly. Both addresses
> are treated as if they were in memory.
> In my configuration, the buffer is located in memory, but the device's
> I/O space is mapped into vmalloc space via ioremap(). How can I access
> the I/O space corectly from the DMA controller? I also checked the
> return of virt_to_phys() and this does not deliver the correct physical
> address.
> The board is based on MPC8641D and I'm using the on-chip DMA engine.
> 

Check out my PCINet driver, posted here previously. It does something
similar.

It uses the PowerPC DMA controller to transfer all of the data around.
You probably need to use dma_map_single() to get the physical address of
your memory to give it to the DMA controller.

Ira
