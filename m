Date: Fri, 28 Jan 2000 10:47:10 +0100
From: Christophe Lizzi <lizzi@csti.fr>
Message-Id: <200001280947.KAA09960@devl58>
To: linuxppc-dev@lists.linuxppc.org
Subject: PREP memory layout and PCI transactions
Cc: plaurent@csti.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I'm currently porting a third-party RAID driver from ix86 to LinuxPPC.
The target is an MTX board with 32 Mbytes of RAM, running a 2.2.10 kernel.

The driver requests the device to fill some memory locations in kernel
space via DMA. This works just fine when such memory locations come
from pages allocated by get_free_page() or kmalloc().

However, this fails when these locations come from the *static* data
of the module, or from pages allocated by vmalloc().

Specifically, the pages returned by get_free_page() or kmalloc() are located
around kernel virtual addresses C1xxxxxx (bus addresses 81xxxxxx), while the
static data in question and the pages returned by vmalloc() are located
behind virtual addresses C4xxxxxx (bus addresses 84xxxxxx).

The PCI analyser sees on the PCI bus a memory write transaction initiated
by the device to such an 84xxxxxx address in memory. We can observe that this
transaction is never completed because the DEVSEL signal on the bus is not
asserted during the correct 5 clock time interval. The transaction is then
terminated as with a master-abort termination, meaning that this address
is not known by the memory controler as an address that can be accessed
from the PCI bus.

Is this a feature, a known restriction, or a bug? Maybe a register
describing the accessible address range from the bus is not correctly
initialised into the Falcon chip?

Thanks for your attention and time,

--Christophe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
