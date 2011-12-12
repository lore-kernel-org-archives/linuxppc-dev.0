Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 072FFB70BB
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 19:51:41 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] ppc32/kprobe: complete kprobe and migrate exception frame
Date: Mon, 12 Dec 2011 16:50:52 +0800
Message-ID: <1323679853-31751-4-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
References: <1323679853-31751-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't emulate stwu since that may corrupt current exception stack.
So we will have to do real store operation in the exception return code.

Firstly we'll allocate a trampoline exception frame below the kprobed
function stack and copy the current exception frame to the trampoline.
Then we can do this real store operation to implement 'stwu', and reroute
the trampoline frame to r1 to complete this exception migration.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/entry_32.S |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 56212bc..d56e311 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -1185,6 +1185,8 @@ recheck:
 	bne-	do_resched
 	andi.	r0,r9,_TIF_USER_WORK_MASK
 	beq	restore_user
+	andis.	r0,r9,_TIF_DELAYED_KPROBE@h
+	bne-	restore_kprobe
 do_user_signal:			/* r10 contains MSR_KERNEL here */
 	ori	r10,r10,MSR_EE
 	SYNC
@@ -1202,6 +1204,30 @@ do_user_signal:			/* r10 contains MSR_KERNEL here */
 	REST_NVGPRS(r1)
 	b	recheck
 
+restore_kprobe:
+	lwz	r3,GPR1(r1)
+	subi    r3,r3,INT_FRAME_SIZE; /* Allocate a trampoline exception frame */
+	mr	r4,r1
+	bl	copy_exc_stack	/* Copy from the original to the trampoline */
+
+	/* Do real stw operation to complete stwu */
+	mr	r4,r1
+	addi	r4,r4,INT_FRAME_SIZE	/* Get kprobed entry */
+	lwz	r5,GPR1(r1)		/* Backup r1 */
+	stw	r4,GPR1(r1)		/* Now store that safely */
+
+	/* Reroute the trampoline frame to r1 */
+	subi    r5,r5,INT_FRAME_SIZE
+	mr	r1,r5
+
+	/* Clear _TIF_DELAYED_KPROBE flag */
+	rlwinm	r9,r1,0,0,(31-THREAD_SHIFT)
+	lwz	r0,TI_FLAGS(r9)
+	rlwinm	r0,r0,0,_TIF_DELAYED_KPROBE
+	stw	r0,TI_FLAGS(r9)
+
+	b	restore
+
 /*
  * We come here when we are at the end of handling an exception
  * that occurred at a place where taking an exception will lose
-- 
1.5.6
