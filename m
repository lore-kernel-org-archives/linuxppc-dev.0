Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP2Yg3zXTzDw0t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:02:31 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so1085967pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:02:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/64e: convert cmpi to cmpwi in head_64.S
Date: Thu, 24 Nov 2016 00:02:07 +1100
Message-Id: <20161123130209.1667-2-npiggin@gmail.com>
In-Reply-To: <20161123130209.1667-1-npiggin@gmail.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 80f23935cadb ("powerpc: Convert cmp to cmpd in idle enter sequence"):

    PowerPC's "cmp" instruction has four operands. Normally people write
    "cmpw" or "cmpd" for the second cmp operand 0 or 1. But, frequently
    people forget, and write "cmp" with just three operands.

    With older binutils this is silently accepted as if this was "cmpw",
    while often "cmpd" is wanted. With newer binutils GAS will complain
    about this for 64-bit code. For 32-bit code it still silently assumes
    "cmpw" is what is meant.

    In this instance the code comes directly from ISA v2.07, including the
    cmp, but cmpd is correct. Backport to stable so that new toolchains can
    build old kernels.

In this case, cmpwi is called for, so this is just a build fix for
new toolchians.

Stable: v3.0
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/head_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 04c546e..1f7f908 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -214,9 +214,9 @@ booting_thread_hwid:
  */
 _GLOBAL(book3e_start_thread)
 	LOAD_REG_IMMEDIATE(r5, MSR_KERNEL)
-	cmpi	0, r3, 0
+	cmpwi	r3, 0
 	beq	10f
-	cmpi	0, r3, 1
+	cmpwi	r3, 1
 	beq	11f
 	/* If the thread id is invalid, just exit. */
 	b	13f
@@ -241,9 +241,9 @@ _GLOBAL(book3e_start_thread)
  * r3 = the thread physical id
  */
 _GLOBAL(book3e_stop_thread)
-	cmpi	0, r3, 0
+	cmpwi	r3, 0
 	beq	10f
-	cmpi	0, r3, 1
+	cmpwi	r3, 1
 	beq	10f
 	/* If the thread id is invalid, just exit. */
 	b	13f
-- 
2.10.2
