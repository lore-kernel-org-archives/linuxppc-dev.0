Return-Path: <tnt@246tNt.com>
Received: from outmx019.isp.belgacom.be (outmx019.isp.belgacom.be
	[195.238.2.200])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF8FA689E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 07:44:35 +1100 (EST)
Received: from outmx019.isp.belgacom.be (localhost [127.0.0.1])
	by outmx019.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id jBKKiT6N000755
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Dec 2005 21:44:30 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <9.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
In-Reply-To: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
References: <0.20051220_213752_1ebc_tnt@patchsend.246tNt.com>
Date: Tue, 20 Dec 2005 21:44:34 +0100 (CET)
Cc: Tom Rini <trini@kernel.crashing.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 9/9] ppc32: Allows compilation of a MPC52xx kernel without
	PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Allows compilation of a MPC52xx kernel without PCI

Some custom cards might not need PCI, without this patch,
compilation fails.

Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

---
commit 181a39c878aab09ba95bfd9396e8c7d7004f4c4e
tree 42106141a8a50c521a8d169bb6b364d78401e15d
parent ebf0598ce7564d4c1db16d995e609923bbb2eba8
author Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 21:27:54 +0100
committer Sylvain Munaut <tnt@246tNt.com> Sun, 18 Dec 2005 21:27:54 +0100

 arch/ppc/platforms/lite5200.c |    2 ++
 include/asm-ppc/io.h          |    2 ++
 include/asm-ppc/mpc52xx.h     |   11 +++++++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
index d44cc99..7ed52dc 100644
--- a/arch/ppc/platforms/lite5200.c
+++ b/arch/ppc/platforms/lite5200.c
@@ -196,8 +196,10 @@ platform_init(unsigned long r3, unsigned
 	mpc52xx_set_bat();
 
 	/* No ISA bus by default */
+#ifdef CONFIG_PCI
 	isa_io_base		= 0;
 	isa_mem_base		= 0;
+#endif
 
 	/* Powersave */
 	/* This is provided as an example on how to do it. But you
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 84ac6e2..df9cf6e 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -27,6 +27,8 @@
 
 #if defined(CONFIG_4xx)
 #include <asm/ibm4xx.h>
+#elif defined(CONFIG_PPC_MPC52xx)
+#include <asm/mpc52xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
 #elif defined(CONFIG_8260)
diff --git a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
index 04d5630..a055e07 100644
--- a/include/asm-ppc/mpc52xx.h
+++ b/include/asm-ppc/mpc52xx.h
@@ -29,6 +29,17 @@ struct pt_regs;
 #endif /* __ASSEMBLY__ */
 
 
+#ifdef CONFIG_PCI
+#define _IO_BASE	isa_io_base
+#define _ISA_MEM_BASE	isa_mem_base
+#define PCI_DRAM_OFFSET	pci_dram_offset
+#else
+#define _IO_BASE	0
+#define _ISA_MEM_BASE	0
+#define PCI_DRAM_OFFSET	0
+#endif
+
+
 /* ======================================================================== */
 /* PPC Sys devices definition                                               */
 /* ======================================================================== */
