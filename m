Date: Wed, 7 May 2003 00:50:14 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Callebaut Benoit <callebaut@mailandnews.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: What kind of Linux address must I use to set the SAR reg. of the DMA ctrl ?
Message-ID: <20030507005014.A28258@home.com>
References: <3EC0E6EE@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EC0E6EE@mailandnews.com>; from callebaut@mailandnews.com on Wed, May 07, 2003 at 02:52:06AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 07, 2003 at 02:52:06AM -0400, Callebaut Benoit wrote:
>
> Hello,
> I am writing the code to start a DMA transfer with the built-in DMA controller
> of the MPC8245. The purpose is to do Memory to PCI transfers. The PCI part
> seems to be OK ( memory of the device is written) the the source address seems
> to be wrong since I read 0XFFFFFFFF as data in the device. I tried with bus
> and physical address (using virt_to_bus & virt_to_phys functions) but this
> doesn't give good results.
> So I ask myself which kind of linux address must I use to configure the SAR
> register of the Dual channel DMA controller ?

Well, there's no special "linux address".  The DMA controller takes
a physical address.  I think you are specifically asking about
configuring the source address register when doing a Mem->PCI
transfer.  In that case, if you are using lowmem system memory as
the source address, then virt_to_phys will generate the correct
physical system memory address.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
