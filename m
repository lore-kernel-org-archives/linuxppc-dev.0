Date: Fri, 24 Sep 1999 22:22:14 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] Paul's rsync kernel compile fix
Message-ID: <19990924222214.A7489@io.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii

I've been compiling Paul's rsync kernel on my PowerBook G3 and I've
prepared a patch that blocks out some undeclared (and reference)
variable initializations in linux/arch/ppc/kernel/pmac_setup.c.  A quick
look at the other ????_setup.c (prep, chrp, apus) shows this might also
be useful there, but I didn't run through the compiles to check.

Has everyone else had the same problem compiling these kernels?  

This is the first time I've dug around in "kernel" kernel stuff,
and I think I'm clear on why these variables really don't mean
anything, but I could always be wrong.  :)

-- 
Shaw Terwilliger (sterwill@io.nu)

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pmac_setup.c.diff"

--- pmac_setup.c.orig	Fri Sep 24 18:27:25 1999
+++ pmac_setup.c	Fri Sep 24 18:29:27 1999
@@ -594,9 +594,15 @@
 	/* isa_io_base gets set in pmac_find_bridges */
 	isa_mem_base = PMAC_ISA_MEM_BASE;
 	pci_dram_offset = PMAC_PCI_DRAM_OFFSET;
+
+	/* These three variables don't seem to be used in pmac_setup.c and 
+	   aren't declared anywhere.  Do we need them at all?  They're 
+	   declared "unsigned long" in arch/ppc/kernel/setup.c */
+/*
 	ISA_DMA_THRESHOLD = ~0L;
 	DMA_MODE_READ = 1;
 	DMA_MODE_WRITE = 2;
+*/
 
 	ppc_md.setup_arch     = pmac_setup_arch;
 	ppc_md.setup_residual = NULL;

--EeQfGwPcQSOJBaQU--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
