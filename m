Subject: Adding the missing kernel symbol table
To: linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
Date: Wed, 19 Apr 2000 18:18:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000419081848.469B2506F0@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi gang,

Here's a simple patch to add the kernel symbol table, required to build for
modules. It's present in other architectures, but missing in PowerPC:

Index: arch/ppc/vmlinux.lds
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 vmlinux.lds
--- arch/ppc/vmlinux.lds	1999/12/30 05:56:15	1.1.1.1
+++ arch/ppc/vmlinux.lds	2000/04/19 08:16:45
@@ -64,6 +64,10 @@
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;

+  __start___ksymtab = .;        /* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
