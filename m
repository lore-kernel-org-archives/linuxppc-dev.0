Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lFdo030090@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:44 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 29/43] ppc64 boot: cleanup linker script
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Remove userland related stuff from ld.script, they are not required for zImage
use wildcards for some sections.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/zImage.lds |   59 +++------------------------------------------
 1 files changed, 5 insertions(+), 54 deletions(-)

diff -puN arch/ppc64/boot/zImage.lds~ppc64-boot-cleanup-linker-script arch/ppc64/boot/zImage.lds
--- devel/arch/ppc64/boot/zImage.lds~ppc64-boot-cleanup-linker-script	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/zImage.lds	2005-10-28 17:45:21.000000000 -0700
@@ -1,62 +1,19 @@
 OUTPUT_ARCH(powerpc:common)
-SEARCH_DIR(/lib); SEARCH_DIR(/usr/lib); SEARCH_DIR(/usr/local/lib); SEARCH_DIR(/usr/local/powerpc-any-elf/lib);
-/* Do we need any of these for elf?
-   __DYNAMIC = 0;    */
 SECTIONS
 {
-  /* Read-only sections, merged into text segment: */
-  . = + SIZEOF_HEADERS;
-  .interp : { *(.interp) }
-  .hash          : { *(.hash)      }
-  .dynsym        : { *(.dynsym)        }
-  .dynstr        : { *(.dynstr)        }
-  .rel.text      : { *(.rel.text)      }
-  .rela.text     : { *(.rela.text)     }
-  .rel.data      : { *(.rel.data)      }
-  .rela.data     : { *(.rela.data)     }
-  .rel.rodata    : { *(.rel.rodata)    }
-  .rela.rodata   : { *(.rela.rodata)   }
-  .rel.got       : { *(.rel.got)       }
-  .rela.got      : { *(.rela.got)      }
-  .rel.ctors     : { *(.rel.ctors) }
-  .rela.ctors    : { *(.rela.ctors)    }
-  .rel.dtors     : { *(.rel.dtors) }
-  .rela.dtors    : { *(.rela.dtors)    }
-  .rel.bss       : { *(.rel.bss)       }
-  .rela.bss      : { *(.rela.bss)      }
-  .rel.plt       : { *(.rel.plt)       }
-  .rela.plt      : { *(.rela.plt)      }
-  .plt : { *(.plt) }
   .text      :
   {
     *(.text)
     *(.fixup)
-    *(.got1)
   }
-  . = ALIGN(4096);
   _etext = .;
-  PROVIDE (etext = .);
-  .rodata    :
-  {
-    *(.rodata)
-    *(.rodata1)
-  }
-  .kstrtab   : { *(.kstrtab) }
-  __vermagic : { *(__vermagic) }
-  .fini      : { *(.fini)    } =0
-  .ctors     : { *(.ctors)   }
-  .dtors     : { *(.dtors)   }
-  /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
   .data    :
   {
-    *(.data)
-    *(.data1)
-    *(.sdata)
-    *(.sdata2)
-    *(.got.plt) *(.got)
-    *(.dynamic)
-    CONSTRUCTORS
+    *(.rodata*)
+    *(.data*)
+    *(.sdata*)
+    *(.got*)
   }
 
   . = ALIGN(4096);
@@ -71,20 +28,14 @@ SECTIONS
 
   . = ALIGN(4096);
   _edata  =  .;
-  PROVIDE (edata = .);
-
-  .fixup   : { *(.fixup) }
 
   . = ALIGN(4096);
   __bss_start = .;
   .bss       :
   {
-   *(.sbss) *(.scommon)
-   *(.dynbss)
+   *(.sbss)
    *(.bss)
-   *(COMMON)
   }
   . = ALIGN(4096);
   _end = . ;
-  PROVIDE (end = .);
 }
_
