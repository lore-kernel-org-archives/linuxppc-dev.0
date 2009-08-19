Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6CCD9B7B5C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 00:28:53 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7JEMf5J007478
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 10:22:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7JEST8m1052788
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 10:28:30 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7JESGa5025902
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2009 08:28:17 -0600
Date: Wed, 19 Aug 2009 10:27:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2] powerpc: Fix __flush_icache_range on 44x
Message-ID: <20090819142753.GD2530@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ptrace POKETEXT interface allows a process to modify the text pages of
a child process being ptraced, usually to insert breakpoints via trap
instructions.  The kernel eventually calls copy_to_user_page, which in turn
calls __flush_icache_range to invalidate the icache lines for the child
process.

However, this function does not work on 44x due to the icache being virtually
indexed.  This was noticed by a breakpoint being triggered after it had been
cleared by ltrace on a 440EPx board.  The convenient solution is to do a
flash invalidate of the icache in the __flush_icache_range function.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
I tested this on powerpc-next this morning using the same testcase as before.

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 15f28e0..da9c0c4 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -342,10 +342,17 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	sync				/* wait for dcbst's to get to ram */
+#ifndef CONFIG_44x
 	mtctr	r4
 2:	icbi	0,r6
 	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	2b
+#else
+	/* Flash invalidate on 44x because we are passed kmapped addresses and
+	   this doesn't work for userspace pages due to the virtually tagged
+	   icache.  Sigh. */
+	iccci	0, r0
+#endif
 	sync				/* additional sync needed on g4 */
 	isync
 	blr
