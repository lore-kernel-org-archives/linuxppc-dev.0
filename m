Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "aun.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 119C567A79
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2005 03:17:23 +1100 (EST)
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16935.14471.919379.826792@alkaid.it.uu.se>
Date: Thu, 3 Mar 2005 17:17:11 +0100
To: paulus@samba.org, geert@linux-m68k.org
Cc: linuxppc-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] gcc4 fix for <asm-m68k/setup.h>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gcc4 generates compile errors when it sees declarations
of arrays of incomplete element types. <asm-m68k/setup.h>
has one such declaration, which unfortunately breaks ppc32
since <asm-ppc/setup.h> #includes <asm-m68k/setup.h>.

The fix in this case is to simply move the array declaration
to after the corresponding element type declaration.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -rupN linux-2.6.11/include/asm-m68k/setup.h linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h
--- linux-2.6.11/include/asm-m68k/setup.h	2004-12-25 12:16:22.000000000 +0100
+++ linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h	2005-03-02 19:36:26.000000000 +0100
@@ -362,12 +362,13 @@ extern int m68k_is040or060;
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and used) */
 extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
 };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
