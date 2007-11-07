Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Nov 2007 17:17:02 +1100
Subject: [PATCH] ppc64: Fix si_addr value on low level hash failures
Message-Id: <20071107061732.8A5B4DDDFE@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If the low level MMU hash table insertion returns an error (which
can happen in some rare circumstances when the hypervisor refuses
the insertion of a PTE, typically if you try to access junk via
/dev/mem), the generated signal had an incorrect si_addr value due
to a bug in the assembly, which was loading it as a 32 bits quantity
instead of a 64 bits quantity.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/head_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-work/arch/powerpc/kernel/head_64.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/head_64.S	2007-11-07 17:14:14.000000000 +1100
+++ linux-work/arch/powerpc/kernel/head_64.S	2007-11-07 17:14:16.000000000 +1100
@@ -936,7 +936,7 @@ handle_page_fault:
  */
 12:	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	lwz	r4,_DAR(r1)
+	ld	r4,_DAR(r1)
 	bl	.low_hash_fault
 	b	.ret_from_except
 
