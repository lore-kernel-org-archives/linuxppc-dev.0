Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 630A42C015A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 18:44:49 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 7 May 2013 18:38:37 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8421B2BB0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 18:44:47 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r478iexr23134350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 18:44:40 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r478ikwF029002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 May 2013 18:44:47 +1000
Message-ID: <1367916281.3083.24.camel@ThinkPad-T5421>
Subject: [PATCH v2] powerpc: Fix  MAX_STACK_TRACE_ENTRIES too low warning again
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 07 May 2013 16:44:41 +0800
In-Reply-To: <1367893978.3083.13.camel@ThinkPad-T5421>
References: <1367893978.3083.13.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Saw this warning again, and this time from the ret_from_fork path. 

It seems we could clear the back chain earlier in copy_thread(), which
could cover both path, and also fix potential lockdep usage in
schedule_tail(), or exception occurred before we clear the back chain.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
--- 
 arch/powerpc/kernel/entry_32.S |    2 --
 arch/powerpc/kernel/entry_64.S |    2 --
 arch/powerpc/kernel/process.c  |    1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index e514de5..d22e73e 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -439,8 +439,6 @@ ret_from_fork:
 ret_from_kernel_thread:
 	REST_NVGPRS(r1)
 	bl	schedule_tail
-	li	r3,0
-	stw	r3,0(r1)
 	mtlr	r14
 	mr	r3,r15
 	PPC440EP_ERR42
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 3fe5259..48e8a86 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -376,8 +376,6 @@ _GLOBAL(ret_from_fork)
 _GLOBAL(ret_from_kernel_thread)
 	bl	.schedule_tail
 	REST_NVGPRS(r1)
-	li	r3,0
-	std	r3,0(r1)
 	ld	r14, 0(r14)
 	mtlr	r14
 	mr	r3,r15
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ceb4e7b..80af366 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -971,6 +971,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	 * do some house keeping and then return from the fork or clone
 	 * system call, using the stack frame created above.
 	 */
+	((unsigned long *)sp)[0] = 0;
 	sp -= sizeof(struct pt_regs);
 	kregs = (struct pt_regs *) sp;
 	sp -= STACK_FRAME_OVERHEAD;
