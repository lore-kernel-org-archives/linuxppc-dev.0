Return-Path: <blofeldus@yahoo.com>
Received: from web53508.mail.yahoo.com (web53508.mail.yahoo.com
	[206.190.37.69]) by ozlabs.org (Postfix) with SMTP id C2D4D67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 04:56:51 +1000 (EST)
Message-ID: <20050621185649.49623.qmail@web53508.mail.yahoo.com>
Date: Tue, 21 Jun 2005 11:56:48 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
To: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Allow Lite5200 w/o PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
 I tried to compile for the icecube w/o PCI to match a custom board,
but get many errors:

arch/ppc/platforms/built-in.o(.init.text+0x66): In function
`platform_init':
arch/ppc/platforms/lite5200.c:204: undefined reference to `isa_io_base'
arch/ppc/platforms/built-in.o(.init.text+0x76):arch/ppc/platforms/lite5200.c:204:
undefined reference to `isa_io_base'
arch/ppc/platforms/built-in.o(.init.text+0x82):arch/ppc/platforms/lite5200.c:205:
undefined reference to `isa_mem_base'
arch/ppc/platforms/built-in.o(.init.text+0x8a):arch/ppc/platforms/lite5200.c:205:
undefined reference to `isa_mem_base'
arch/ppc/mm/built-in.o(.text+0xe92): In function `ioport_map':
arch/ppc/mm/pgtable.c:266: undefined reference to `isa_io_base'
arch/ppc/mm/built-in.o(.text+0xe96):arch/ppc/mm/pgtable.c:266:
undefined reference to `isa_io_base'
arch/ppc/mm/built-in.o(.text+0x117e): In function `__ioremap':
arch/ppc/mm/pgtable.c:188: undefined reference to `isa_mem_base'
arch/ppc/mm/built-in.o(.text+0x1182):arch/ppc/mm/pgtable.c:188:
undefined reference to `isa_mem_base'
drivers/built-in.o(.text+0x42a): In function `vgacon_set_cursor_size':
include/asm/io.h:294: undefined reference to `isa_io_base'
drivers/built-in.o(.text+0x436):include/asm/io.h:294: undefined
reference to `isa_io_base'
drivers/built-in.o(.text+0x57e): In function `vgacon_set_origin':
include/asm/io.h:312: undefined reference to `isa_io_base'
drivers/built-in.o(.text+0x586):include/asm/io.h:312: undefined
reference to `isa_io_base'
drivers/built-in.o(.text+0x60e): In function `vga_set_palette':
drivers/video/console/vgacon.c:514: undefined reference to
`isa_io_base'
drivers/built-in.o(.text+0x6ba):include/asm/io.h:294: more undefined
references to `isa_io_base' follow
drivers/built-in.o(.text+0x282d2): In function `dma_pool_alloc':
include/asm/io.h:398: undefined reference to `pci_dram_offset'
drivers/built-in.o(.text+0x282d6):include/asm/io.h:398: undefined
reference to `pci_dram_offset'
drivers/built-in.o(.init.text+0x2f2): In function `vgacon_startup':
include/asm/io.h:309: undefined reference to `isa_io_base'
drivers/built-in.o(.init.text+0x302):include/asm/io.h:309: undefined
reference to `isa_io_base'
make: *** [.tmp_vmlinux1] Error 1


This patch fixes it for me, but I don't know if this is the correct
solution.

Signed Off By: Roger Blofeld <blofeldus@yahoo.com>
-roger


diff --git a/arch/ppc/platforms/lite5200.c
b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -194,9 +200,11 @@ platform_init(unsigned long r3, unsigned
        /* BAT setup */
        mpc52xx_set_bat();
 
+#ifdef CONFIG_PCI
        /* No ISA bus by default */
        isa_io_base             = 0;
        isa_mem_base            = 0;
+#endif
 
        /* Powersave */
        /* This is provided as an example on how to do it. But you
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -26,6 +26,8 @@
 
 #if defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
+#elif defined(CONFIG_PPC_MPC52xx)
+#include <asm/mpc52xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_8260)
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -28,6 +28,15 @@
 struct pt_regs;
 #endif /* __ASSEMBLY__ */
 
+#ifdef CONFIG_PCI
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define _IO_BASE        0
+#define _ISA_MEM_BASE   0
+#define PCI_DRAM_OFFSET 0
+#endif
 
 /*
========================================================================
*/
 /* PPC Sys devices definition                                         
     */



		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html
