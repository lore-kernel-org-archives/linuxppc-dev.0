Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 838BEB6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Aug 2009 23:41:52 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HDdiUs022594
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 07:39:44 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HDfe8x204638
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 07:41:40 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HDfeH2021243
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 07:41:40 -0600
Date: Mon, 17 Aug 2009 09:41:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix __flush_icache_range on 44x
Message-ID: <20090817134136.GB8710@zod.rchland.ibm.com>
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

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 15f28e0..c9805a4 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -346,6 +346,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 2:	icbi	0,r6
 	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	2b
+#ifdef CONFIG_44x
+	iccci	r0, r0
+#endif
 	sync				/* additional sync needed on g4 */
 	isync
 	blr
