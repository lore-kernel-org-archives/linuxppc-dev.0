Date: Wed, 25 Jun 2003 03:01:08 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: rowejames@acmsystems.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: PCI DMA support on the MPC8250
Message-ID: <3EFFFCC6@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jim,
I am working on a MPC8245, and I had the same problem. There is no support in
Linux for CPU initiated DMA. The pci_consistent_alloc functions and all others
related to DMA like pci_sync_single have nothing to do with DMA. Their only
job is to keep a block of memory synchronized with the cache or disable the
use of cache with it.
But the DMA transfers are working and are 5 time faster. You must only program
them. It is just 5 registers to configure. You buffers in RAM must be
allocated with consistent_alloc to avoid caching on them and you must always
write physical addresses in the DMA registers( use virt_to_phys).
Note For  PCI addresses virt_to_phys doesn't work well. You must take the
addresses from the "remap" function code. I did it and it works very well.

A good advice : Try to reduce the setup code for the DMA to a maximum.
Otherwise you won't gain anything for small blocks (setup time > memcpy time
).

Or if you Firewire chip support DMA use the DMA ability of your Firewire chip.

Good luck


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
