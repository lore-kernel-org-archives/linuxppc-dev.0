Return-Path: <j.borkhuis@dutchspace.nl>
Message-ID: <46C56DCB.2000809@dutchspace.nl>
Date: Fri, 17 Aug 2007 11:43:39 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH]ppc: fix unalligned PCI BAR-mapping
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

The following patch makes sure that all areas referred to through a BAR 
register in a PCI device are aligned on a PAGE_SIZE boundary.
When looking at the result of the PCI initialization, the BAR registers 
are filled with values that make sure the areas are directly adjacent. 
This is a problem when trying to map these memory areas into user space 
(using mmap). Mmap will only map pages, so to access the mapped area the 
user must know the offset of the BAR register within the page.
When comparing this to the i386 architecture, the areas are aligned on 
boundaries.

The following patch makes sure that all BAR areas are aligned on page 
boundaries, by rounding down the address to the next page boundary. BAR 
areas are mapped from the top down, so by just masking with 
~(PAGE_SIZE-1) the address is aligned with the page.

This is the first time I propose a patch for the Linux kernel, so please 
help me if I do something wrong here, or (in case this patch is 
acceptable) how to get this into the kernel tree.

Kind regards,
    Johan Borkhuis

=======================
diff -u linux-org/arch/ppc/syslib/pci_auto.c 
linux/arch/ppc/syslib/pci_auto.c
--- linux-org/arch/ppc/syslib/pci_auto.c    2007-01-14 
02:26:54.000000000 +0100
+++ linux/arch/ppc/syslib/pci_auto.c    2007-08-17 11:19:25.000000000 +0200
@@ -87,7 +87,7 @@
         bar_size = ~(bar_response & addr_mask) + 1;
 
         /* Allocate a base address */
-        bar_value = (*upper_limit - bar_size) & ~(bar_size - 1);
+        bar_value = ((*upper_limit - bar_size) & ~(bar_size - 1)) & 
~(PAGE_SIZE-1);
 
         /* Write it out and update our limit */
         early_write_config_dword(hose,
