Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 930B11A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 04:28:24 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 22966140321
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 04:28:24 +1100 (AEDT)
Date: Wed, 9 Mar 2016 18:28:21 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: [PATCH 1/2] ppc64le live patch: clear out storage location(s) in
 mini stack frame
Message-ID: <20160309172821.GC27913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This can be applied on top of Petr Mladek's v4 rework of the ppc64le
live patching. Inspired by Balbir Singh's v5, information about the
callee's r2 is stored in a "reserved" 32 bit location in the caller's
stack frame, instead of 64 bits in the newly created mini frame 24(r1).

It only needs to work for a local call, when caller's TOC == callee's
TOC, and along with the return address (LR) it's all within a 4GiB
range (+-31 bits). If the original call already was global, we are
allowed to restore any nonsense into r2, because the global caller
will restore its TOC anyway from the ABI compliant location 24(r1)
right after return.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---

This is only the preparation for dumping the mini stack frame.
It shouldn't break anything, bisecting-wise.

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1284,8 +1284,9 @@ ftrace_call:
 	 * lr and LRSAVE(r1) contain the address of klp_return_helper.
 	 * We loaded ctr with the address of the patched function earlier
 	 */
+	subf    r0, r0, r2      /* Calculate offset from current TOC to LR */
+	stw     r0, 12(r1)      /* and save it in CR+4 */      
 	stdu	r1, -32(r1)	/* open new mini stack frame */
-	std	r2, 24(r1)	/* save TOC now, unconditionally. */
 	bl	5f
 5:	mflr	r12
 	addi	r12, r12, (klp_return_helper + 4 - .)@l
@@ -1323,9 +1324,10 @@ _GLOBAL(ftrace_stub)
  * maybe inserting a klp_return_helper frame or not.
 */
 klp_return_helper:
-	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
 	addi r1, r1, 32		/* destroy mini stack frame */
+	lwa     r2, 12(r1)      /* Load from CR+4, offset of TOC w.r.t LR */
 	ld	r0, LRSAVE(r1)	/* get the real return address */
+	add     r2, r2, r0      /* Add the current LR to offset */
 	mtlr	r0
 	blr
 #endif
