Date: Wed, 31 Oct 2001 20:49:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: small cleanup
In-Reply-To: <20011031084233.A18493@cpe-24-221-152-185.az.sprintbbd.net>
Message-ID: <Pine.LNX.4.33.0110312042050.1723-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Wed, 31 Oct 2001, Tom Rini wrote:

> Yes, and compiled only on CONFIG_ALL_PPC.  But the if statement will
> always be false on !CONFIG_ALL_PPC, so while the compiler will warn
> about an implicit declaration, it won't cause a link error.  Eg:
> --- 1.34/arch/ppc/kernel/pci.c  Sat Oct  6 11:16:41 2001
> +++ edited/pci.c        Wed Oct 31 08:40:26 2001
> @@ -743,6 +743,9 @@
>                 ranges += np;
>         }
>  }
> +#else
> +/* Kill a warning */
> +#define pcibios_make_OF_bus_map do { } while(0)
>  #endif /* CONFIG_ALL_PPC */
>
>  void __init

Hmm, I don't see how that is any better, but it's ok for me.

> > > This will break 4xx I think...  Can you try doing a
> > > walnut+CONFIG_405_DMA=y compile (in _devel..)
> >
> > I can try it (when I get home).
>
> Thanks.

Works fine, below is the relevant part of the patch for 2_4_devel.

> By and large we do it the way I said anyhow.  Is this in current gcc or
> when we get the precompiled headers bits?

That has nothing to do with precompiled headers, check the cpp info file
("Header Files" -> "Once-Only") for more info.

bye, Roman

--- include/asm-ppc/ibm4xx.h	Wed Oct 31 17:58:28 2001
+++ include/asm-ppc/ibm4xx.h	Wed Oct 31 20:09:35 2001
@@ -57,10 +57,6 @@
 #define PCI_DRAM_OFFSET	0
 #endif

-extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;
-extern unsigned long pci_dram_offset;
-
 /*
  * The "residual" board information structure the boot loader passes
  * into the kernel.
--- include/asm-ppc/io.h	Wed Oct 31 17:58:06 2001
+++ include/asm-ppc/io.h	Wed Oct 31 20:09:35 2001
@@ -1,12 +1,12 @@
 /*
  * BK Id: SCCS/s.io.h 1.21 10/16/01 16:44:09 %#%
  */
-#ifdef __KERNEL__
 #ifndef _PPC_IO_H
 #define _PPC_IO_H

+#ifdef __KERNEL__
+
 #include <linux/config.h>
-#include <linux/types.h>
 #include <asm/page.h>
 #include <asm/byteorder.h>

@@ -31,18 +31,19 @@
 #elif defined(CONFIG_8260)
 #include <asm/mpc8260.h>
 #elif defined(CONFIG_APUS)
-#define _IO_BASE 0
-#define _ISA_MEM_BASE 0
+#define _IO_BASE	0
+#define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #else /* Everyone else */
-extern unsigned long isa_io_base;
-extern unsigned long isa_mem_base;
-extern unsigned long pci_dram_offset;
 #define _IO_BASE	isa_io_base
 #define _ISA_MEM_BASE	isa_mem_base
 #define PCI_DRAM_OFFSET	pci_dram_offset
 #endif /* Platform-dependant I/O */

+extern unsigned long isa_io_base;
+extern unsigned long isa_mem_base;
+extern unsigned long pci_dram_offset;
+
 #if defined(CONFIG_PPC_ISERIES)
 #include <asm/iSeries.h>
 #if defined(CONFIG_PCI)
@@ -223,7 +224,6 @@
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 #endif

-#ifdef __KERNEL__
 /*
  * Map in an area of physical address space, for accessing
  * I/O devices etc.
@@ -295,11 +295,9 @@
 /*
  * Change "struct page" to physical address.
  */
-#define page_to_phys(page)	((page - mem_map) << PAGE_SHIFT)
+#define page_to_phys(page)	(((page - mem_map) << PAGE_SHIFT) + PPC_MEMSTART)
 #define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)

-#endif /* __KERNEL__ */
-
 /*
  * Enforce In-order Execution of I/O:
  * Acts as a barrier to ensure all previous I/O accesses have
@@ -450,5 +448,5 @@
 #define consistent_sync_page(pg, off, sz, rw)	do { } while (0)

 #endif /* CONFIG_NOT_COHERENT_CACHE */
-#endif /* _PPC_IO_H */
 #endif /* __KERNEL__ */
+#endif /* _PPC_IO_H */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
