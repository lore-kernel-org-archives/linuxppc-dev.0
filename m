From: Keith Owens <kaos@ocs.com.au>
To: torvalds@transmeta.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-test5 ppc patch
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Aug 2000 22:48:17 +1000
Message-ID: <32155.965306897@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Linus, please apply, against 2.4.0-test5.  arch/ppc/vmlinux.lds does
not explicitly define the .krstrtab and __ksymtab sections.  It just so
happens that the linker does it anyway by some black magic, but it is
better to be consistent with other architectures and make the sections
explicit.

The lack of explicit sections makes it look like ppc does not support
modules.

Index: 0-test5.1/arch/ppc/vmlinux.lds
--- 0-test5.1/arch/ppc/vmlinux.lds Fri, 26 May 2000 13:10:01 +1000 kaos (linux-2.4/o/c/47_vmlinux.ld 1.1 644)
+++ 0-test5.1(w)/arch/ppc/vmlinux.lds Thu, 03 Aug 2000 22:44:03 +1000 kaos (linux-2.4/o/c/47_vmlinux.ld 1.1 644)
@@ -41,6 +41,7 @@
     *(.rodata)
     *(.rodata1)
   }
+  .kstrtab   : { *(.kstrtab) }
   .fini      : { *(.fini)    } =0
   .ctors     : { *(.ctors)   }
   .dtors     : { *(.dtors)   }
@@ -63,6 +64,10 @@
   __start___ex_table = .;
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;

   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
