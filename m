Date: Sat, 6 Jan 2001 16:09:17 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Holzt <kju@fqdn.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Bugs in 2.4.0-ac2 in ppc
Message-ID: <20010106160917.K556@opus.bloom.county>
References: <20010105210627.D1095@fqdn.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="R3G7APHDIzY6R/pk"
In-Reply-To: <20010105210627.D1095@fqdn.org>; from kju@fqdn.org on Fri, Jan 05, 2001 at 09:06:28PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 05, 2001 at 09:06:28PM +0100, Michael Holzt wrote:

>  - And third the worst problem: Since one of the latest test series
>    kernels i'm unable to use modules:

Ok, the attached patch (going into the 2_4 and 2_5 bk trees, so it will
eventually hit Linus or Alan) should fix it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.diff"

===== arch/ppc/kernel/Makefile 1.1 vs edited =====
--- 1.1/arch/ppc/kernel/Makefile	Sat Jan  6 00:30:07 2001
+++ edited/arch/ppc/kernel/Makefile	Sat Jan  6 16:00:25 2001
@@ -35,6 +35,7 @@
 					process.o signal.o bitops.o ptrace.o \
 					ppc_htab.o semaphore.o syscalls.o  \
 					align.o setup.o
+obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_POWER4)		+= xics.o
 obj-$(CONFIG_PCI)		+= pci.o pci-dma.o
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
@@ -62,8 +63,7 @@
 					feature.o pmac_pci.o chrp_setup.o \
 					chrp_time.o chrp_pci.o 	open_pic.o \
 					indirect_pci.o i8259.o prep_pci.o \
-					prep_time.o prep_nvram.o ppc_ksyms.o \
-					prep_setup.o
+					prep_time.o prep_nvram.o prep_setup.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_GEMINI)		+= gemini_prom.o gemini_pci.o gemini_setup.o \
 					open_pic.o
===== arch/ppc/kernel/ppc_ksyms.c 1.2 vs edited =====
--- 1.2/arch/ppc/kernel/ppc_ksyms.c	Sat Jan  6 14:21:00 2001
+++ edited/arch/ppc/kernel/ppc_ksyms.c	Sat Jan  6 16:03:40 2001
@@ -337,9 +337,11 @@
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
 EXPORT_SYMBOL(mmu_context_overflow);
+#if !defined(CONFIG_8xx) && !defined(CONFIG_4xx)
 extern long *intercept_table;
-extern long *ret_from_intercept;
 EXPORT_SYMBOL(intercept_table);
+#endif
+extern long *ret_from_intercept;
 EXPORT_SYMBOL(ret_from_intercept);

 #ifdef CONFIG_MOL

--R3G7APHDIzY6R/pk--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
