Date: Mon, 31 Jan 2000 16:23:17 -0500 (EST)
From: "Kevin M. Myer" <kevin_myer@elanco.k12.pa.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: devel kernels 2.3.41
In-Reply-To: <389537D2.D4642F0A@wanadoo.fr>
Message-ID: <Pine.LNX.4.20.0001311609090.2282-100000@marble.elanco.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 31 Jan 2000, Martin Costabel wrote:

>
> The 2.3.41 final kernel is broken on most non-intel architectures (dma
> code changed completely). I would think (and hope) the PPC kernel
> developers are too busy fixing this right now to answer your question.

I poked around a bit and found I could at least get around the compile
problem at the beginning with the following simple patch:

--- linux/include/asm-ppc/types.h.old   Mon Jan 31 16:07:01 2000
+++ linux/include/asm-ppc/types.h       Mon Jan 31 16:03:28 2000
@@ -41,6 +41,10 @@

 #define BITS_PER_LONG 32

+/* Dma addresses are 32-bits wide for now.  */
+
+typedef u32 dma_addr_t;
+
 #endif /* __KERNEL__ */

 #endif

In init/main.c, it included linux/pci.h, in which the struct pci_dev has a
new member "dma_mask".  This is of type dma_addr_t, which is defined for
i386 and sparc64 but no other architectures that I can tell.

That at least got me around the initial compile problem.  I'm working on
an Apple Network Server with a somewhat less than vanilla 2.3.41 so I'm
not sure if it compiles and boots fully (seeing as I've goofed up some
code for the secondary PCI bus on the ANS and it won't compile fully).

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
