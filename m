Return-Path: <rusty@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A15B2C014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:29 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rusty@au1.ibm.com>;
 Thu, 7 Nov 2013 11:21:29 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1C3FB3578050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 12:21:27 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA713uKC066006
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:03:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA71LQwx021352
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Nov 2013 12:21:26 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc: ELF2 binaries launched directly.
Date: Thu,  7 Nov 2013 11:46:51 +1030
Message-Id: <1383787012-16455-3-git-send-email-rusty@au1.ibm.com>
In-Reply-To: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
References: <1383787012-16455-1-git-send-email-rusty@au1.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No function descriptor, but we set r12 up and set TIF_RESTOREALL as it
normally isn't restored on return from syscall.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/powerpc/kernel/process.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 59967ea..6fa271a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1078,25 +1078,45 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
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
