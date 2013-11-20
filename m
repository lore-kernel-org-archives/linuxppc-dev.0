Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 5/9] powerpc: ELF2 binaries launched directly.
Date: Wed, 20 Nov 2013 22:15:02 +1100
Message-Id: <1384946106-18200-6-git-send-email-anton@samba.org>
In-Reply-To: <1384946106-18200-1-git-send-email-anton@samba.org>
References: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

No function descriptor, but we set r12 up and set TIF_RESTOREALL as it
normally isn't restored on return from syscall.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 75c2d10..0650e18 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1086,25 +1086,45 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	regs->msr = MSR_USER;
 #else
 	if (!is_32bit_task()) {
-		unsigned long entry, toc;
+		unsigned long entry;
 
-		/* start is a relocated pointer to the function descriptor for
-		 * the elf _start routine.  The first entry in the function
-		 * descriptor is the entry address of _start and the second
-		 * entry is the TOC value we need to use.
-		 */
-		__get_user(entry, (unsigned long __user *)start);
-		__get_user(toc, (unsigned long __user *)start+1);
+		if (is_elf2_task()) {
+			/* Look ma, no function descriptors! */
+			entry = start;
 
-		/* Check whether the e_entry function descriptor entries
-		 * need to be relocated before we can use them.
-		 */
-		if (load_addr != 0) {
-			entry += load_addr;
-			toc   += load_addr;
+			/*
+			 * Ulrich says:
+			 *   The latest iteration of the ABI requires that when
+			 *   calling a function (at its global entry point),
+			 *   the caller must ensure r12 holds the entry point
+			 *   address (so that the function can quickly
+			 *   establish addressability).
+			 */
+			regs->gpr[12] = start;
+			/* Make sure that's restored on entry to userspace. */
+			set_thread_flag(TIF_RESTOREALL);
+		} else {
+			unsigned long toc;
+
+			/* start is a relocated pointer to the function
+			 * descriptor for the elf _start routine.  The first
+			 * entry in the function descriptor is the entry
+			 * address of _start and the second entry is the TOC
+			 * value we need to use.
+			 */
+			__get_user(entry, (unsigned long __user *)start);
+			__get_user(toc, (unsigned long __user *)start+1);
+
+			/* Check whether the e_entry function descriptor entries
+			 * need to be relocated before we can use them.
+			 */
+			if (load_addr != 0) {
+				entry += load_addr;
+				toc   += load_addr;
+			}
+			regs->gpr[2] = toc;
 		}
 		regs->nip = entry;
-		regs->gpr[2] = toc;
 		regs->msr = MSR_USER64;
 	} else {
 		regs->nip = start;
-- 
1.8.3.2
