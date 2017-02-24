Return-Path: <hamishm@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsyG21BLzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:52:22 +1100 (AEDT)
From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: chris.packham@alliedtelesis.co.nz, linuxppc-dev@lists.ozlabs.org,
 Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] powerpc64: Allow for THREAD_SIZE > 16k
Date: Fri, 24 Feb 2017 13:52:10 +1300
Message-Id: <20170224005210.1318-3-hamish.martin@alliedtelesis.co.nz>
In-Reply-To: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
References: <20170224005210.1318-1-hamish.martin@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix an assembler error when the THREAD_SIZE is greater than 16k.

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/powerpc/kernel/head_64.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1dc5eae2ced3..0ddc602b33a4 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -949,7 +949,8 @@ start_here_multiplatform:
 	LOAD_REG_ADDR(r3,init_thread_union)
 
 	/* set up a stack pointer */
-	addi	r1,r3,THREAD_SIZE
+	LOAD_REG_IMMEDIATE(r1,THREAD_SIZE)
+	add	r1,r3,r1
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-- 
2.11.0
