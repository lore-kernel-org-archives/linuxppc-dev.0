Date: Tue, 17 Sep 2002 16:16:51 -0700
From: Matt Porter <porter@cox.net>
To: Waqar Ahmad <wahmad@snowshore.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problem with pci_alloc_consistent (it does work)
Message-ID: <20020917161651.B22545@home.com>
References: <200209171824.g8HIOaS17677@flyingfox.snowshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200209171824.g8HIOaS17677@flyingfox.snowshore.com>; from wahmad@snowshore.com on Tue, Sep 17, 2002 at 02:24:35PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 17, 2002 at 02:24:35PM -0400, Waqar Ahmad wrote:
> Found the problem I was using phys_to_virt(..) to convert the
> physical address to virtual. Once I fixed that everything seems
> to be working now. so

Anybody confused by this should read and understand
Documentation/IO-mapping.txt.  virt_to_phys/phys_to_virt
and virt_to_bus/bus_to_virt are only defined for usage on
system memory.  This means statically mapped kernel memory.
The only way to reliably (cross platform) get a physical
address from pci_alloc_consistent is to hold on to your
dma_handle.  This has been covered a number of times on lkml
with DavidM and might even be in the current DMA-mapping.txt
by now...but I doubt it. :)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
