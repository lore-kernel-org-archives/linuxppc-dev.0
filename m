Return-Path: <apw@shadowen.org>
Received: from localhost.localdomain (81-179-233-34.dsl.pipex.com
	[81.179.233.34]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32A5368850
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2005 06:44:38 +1100 (EST)
Date: Tue, 29 Nov 2005 19:20:55 +0000
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051129192055.GA28298@shadowen.org>
References: <438B5523.40903@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc-dev@ozlabs.org, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] powerpc ppc32 clean up available memory models
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, attempt #2 at cleaning up the memory models for powerpc/ppc32.
Made it very explicit which combinations require FLATMEM and left
the defaults alone for SPARSEMEM.  Seems to do what I expect.

Comments.

-apw

=== 8< ===
powerpc: ppc32 clean up available memory models

Clean up the currently available memory models for ppc32 under
the powerpc architecture.  We need FLATMEM for ppc32 enable it.
SPARSEMEM is not parameterised for ppc32 so disable that.  Take this
opportunity to clean up white space for FLATMEM_ENABLE.

Against 2.6.15-rc3 with Anton's flatmem disable patch.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff -upN reference/arch/powerpc/Kconfig current/arch/powerpc/Kconfig
--- reference/arch/powerpc/Kconfig
+++ current/arch/powerpc/Kconfig
@@ -578,11 +578,12 @@ config ARCH_SELECT_MEMORY_MODEL
 	depends on PPC64
 
 config ARCH_FLATMEM_ENABLE
-       def_bool y
-       depends on PPC64 && !NUMA
+	def_bool y
+	depends on (PPC64 && !NUMA) || PPC32
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
+	depends on PPC64
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
