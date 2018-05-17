Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mbmX2KRtzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 13:06:19 +1000 (AEST)
Message-ID: <48284701fe497bb4f5bede5c55bbce9d70309562.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Ensure gcc doesn't move around cache flushing in
 __patch_instruction
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Thu, 17 May 2018 13:06:10 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current asm statement in __patch_instruction() for the cache flushes
doesn't have a "volatile" statement and no memory clobber. That means
gcc can potentially move it around (or move the store done by put_user
past the flush).

Add both to ensure gcc doesn't play games.

Found by code inspection, no actual bug reported.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -32,8 +32,9 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
        if (err)
                return err;
 
-       asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
-                                                           "r" (exec_addr));
+       asm volatile("dcbst 0, %0; sync; icbi 0,%1; sync; isync"
+                    :: "r" (patch_addr), "r" (exec_addr)
+                    : "memory");
 
        return 0;
 }
