Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [PATCH RFC v5] net: add PCINet driver
Date: Tue, 13 Jan 2009 13:02:52 +1030
References: <20090107195052.GA24981@ovro.caltech.edu>
	<20090108192716.GA19863@ovro.caltech.edu>
	<20090108215127.GA28935@ovro.caltech.edu>
In-Reply-To: <20090108215127.GA28935@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901131302.52754.rusty@rustcorp.com.au>
Cc: arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, shemminger@vyatta.com,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 09 January 2009 08:21:27 Ira Snyder wrote:
> Rusty, since you wrote the virtio code, can you point me at the things I
> would need to implement to use virtio over the PCI bus.
> 
> The guests (PowerPC computers running Linux) are PCI cards in the host
> system (an Intel Pentium3-M system). The guest computers can access all
> of the host's memory. The guests provide a 1MB (movable) window into
> their memory.
> 
> The PowerPC computers also have a DMA controller, which I've used to get
> better throughput from my driver. I have a way to create interrupts to
> both the host and guest systems.
> 
> I've read your paper titled: "virtio: Towards a De-Facto Standard For
> Virtual I/O Devices"
> 
> If I read that correctly, then I should implement all of the functions
> in struct virtqueue_ops appropriately, and the existing virtio drivers
> should just work. The only concern I have there is how to make guest ->
> host transfer use the DMA controller. I've done all programming of it
> from the guest kernel, using the Linux DMAEngine API.

Hi Ira,

   Interesting system: the guest being able to access the host's memory but not (fully) vice-versa makes this a little different from the current implementations where that was assumed.  virtio assumes that the guest will publish buffers and someone else (ie. the host) will access them.

   > Are there any other implementations other than virtio_ring?

   There were some earlier implementations, but they were trivial.  And not particularly helpful in your case.

In summary, yes, it should work quite nicely, but rather than publishing the buffers to the host, the host will need to tell the guest where it wants them transferred (possibly using that 1M window, and a notification mechanism).  That will be the complex part I think.

Cheers,
Rusty.
