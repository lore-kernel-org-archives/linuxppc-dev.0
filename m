Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 067B12C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 20:46:45 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 23 Oct 2012 15:16:40 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9N9kbPw38993922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 15:16:37 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9NFGSEq023822
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2012 02:16:28 +1100
Message-ID: <1350985587.2904.59.camel@ThinkPad-T420>
Subject: [RFC PATCH powerpc] Fix MAX_STACK_TRACE_ENTRIES too low!
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 23 Oct 2012 17:46:27 +0800
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

This patch tries to fix the following BUG report:

[    0.012313] BUG: MAX_STACK_TRACE_ENTRIES too low!
[    0.012318] turning off the locking correctness validator.
[    0.012321] Call Trace:
[    0.012330] [c00000017666f6d0] [c000000000012128] .show_stack+0x78/0x184 (unreliable)
[    0.012339] [c00000017666f780] [c0000000000b6348] .save_trace+0x12c/0x14c
[    0.012345] [c00000017666f800] [c0000000000b7448] .mark_lock+0x2bc/0x710
[    0.012351] [c00000017666f8b0] [c0000000000bb198] .__lock_acquire+0x748/0xaec
[    0.012357] [c00000017666f9b0] [c0000000000bb684] .lock_acquire+0x148/0x194
[    0.012365] [c00000017666fa80] [c00000000069371c] .mutex_lock_nested+0x84/0x4ec
[    0.012372] [c00000017666fb90] [c000000000096998] .smpboot_register_percpu_thread+0x3c/0x10c
[    0.012380] [c00000017666fc30] [c0000000009ba910] .spawn_ksoftirqd+0x28/0x48
[    0.012386] [c00000017666fcb0] [c00000000000a98c] .do_one_initcall+0xd8/0x1d0
[    0.012392] [c00000017666fd60] [c00000000000b1f8] .kernel_init+0x120/0x398

[    0.012398] [c00000017666fe30] [c000000000009ad4] .ret_from_kernel_thread+0x5c/0x64
[    0.012404] [c00000017666fa00] [c00000017666fb20] 0xc00000017666fb20
[    0.012410] [c00000017666fa80] [c00000000069371c] .mutex_lock_nested+0x84/0x4ec
[    0.012416] [c00000017666fb90] [c000000000096998] .smpboot_register_percpu_thread+0x3c/0x10c
[    0.012422] [c00000017666fc30] [c0000000009ba910] .spawn_ksoftirqd+0x28/0x48
[    0.012427] [c00000017666fcb0] [c00000000000a98c] .do_one_initcall+0xd8/0x1d0
[    0.012433] [c00000017666fd60] [c00000000000b1f8] .kernel_init+0x120/0x398

[    0.012439] [c00000017666fe30] [c000000000009ad4] .ret_from_kernel_thread+0x5c/0x64
.......

The reason is that the back chain of c00000017666fe30
(ret_from_kernel_thread) contains some invalid value, which might form a
loop.

Not very sure whether it is good to clear the back chain to 0 here.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S
b/arch/powerpc/kernel/entry_64.S
index 56e0ff0..ad76666 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -374,6 +374,8 @@ _GLOBAL(ret_from_kernel_thread)
 	bl	.schedule_tail
 	REST_NVGPRS(r1)
 	REST_GPR(2,r1)
+	li	r3,0
+	std	r3,0(r1)
 	mtlr	r14
 	mr	r3,r15
 	blrl
-- 
1.7.1
