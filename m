Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BD2E1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 04:30:20 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D8D7140BAC
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2016 04:30:20 +1100 (AEDT)
Date: Wed, 9 Mar 2016 18:30:17 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: jeyu@redhat.com, jkosina@suse.cz, jikos@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: [PATCH 2/2] ppc64le live patch: get rid of mini stack frame
Message-ID: <20160309173017.GD27913@lst.de>
References: <20160309172821.GC27913@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160309172821.GC27913@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After the mini stack frame is no longer required for TOC storage, it can
be eliminated iff the functionality of klp_return_helper, which required
a stack frame for the extra return address previously, is carried out
by the replacement function now. This requires _every_ live patch replacement
function to execute the following (or similar) sequence of machine instructions
just before every return to the original caller:

	ld	r0, 0(r1)	/* use back link to find caller's frame */
        lwa     r2, 12(r0)      /* Load from CR+4, offset of TOC w.r.t LR */
        ld      r0, LRSAVE(r0)  /* get the real return address */
        add     r2, r2, r0      /* Add the current LR to offset */

Signed-off-by: Torsten Duwe <duwe@suse.de>

---

This is solution 1 now.
Do we really want that? I don't think so; this is merely to illustrate
what the alternative to klp_return_helper and its extra stack frame would
look like. Hence, I didn't test yet whether all the details are correct.

--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1277,21 +1277,11 @@ ftrace_call:
 	 * For a local call, restore this TOC after calling the patch function.
 	 * For a global call, it does not matter what we restore here,
 	 * since the global caller does its own restore right afterwards,
-	 * anyway. Just insert a klp_return_helper frame in any case,
-	 * so a patch function can always count on the changed stack offsets.
-	 * The patch introduces a frame such that from the patched function
-	 * we return back to klp_return helper. For ABI compliance r12,
-	 * lr and LRSAVE(r1) contain the address of klp_return_helper.
-	 * We loaded ctr with the address of the patched function earlier
+	 * anyway. Just prepare here the TOC restore in patch functions.
+	 * We loaded ctr with the address of the patched function earlier.
 	 */
 	subf    r0, r0, r2      /* Calculate offset from current TOC to LR */
 	stw     r0, 12(r1)      /* and save it in CR+4 */      
-	stdu	r1, -32(r1)	/* open new mini stack frame */
-	bl	5f
-5:	mflr	r12
-	addi	r12, r12, (klp_return_helper + 4 - .)@l
-	std	r12, LRSAVE(r1)
-	mtlr	r12
 	mfctr	r12		/* allow for TOC calculation in newfunc */
 	bctr
 4:
@@ -1313,25 +1303,6 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
-#ifdef CONFIG_LIVEPATCH
-/* Helper function for local calls that are becoming global
- * due to live patching.
- * We can't simply patch the NOP after the original call,
- * because, depending on the consistency model, some kernel
- * threads may still have called the original, local function
- * *without* saving their TOC in the respective stack frame slot,
- * so the decision is made per-thread during function return by
- * maybe inserting a klp_return_helper frame or not.
-*/
-klp_return_helper:
-	addi r1, r1, 32		/* destroy mini stack frame */
-	lwa     r2, 12(r1)      /* Load from CR+4, offset of TOC w.r.t LR */
-	ld	r0, LRSAVE(r1)	/* get the real return address */
-	add     r2, r2, r0      /* Add the current LR to offset */
-	mtlr	r0
-	blr
-#endif
-
 
 #else
 _GLOBAL_TOC(_mcount)
