Return-Path: <michael.neuling@au1.ibm.com>
From: Michael Neuling <michael.neuling@au1.ibm.com>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Add isync to copy_and_flush
Date: Wed, 24 Apr 2013 20:30:09 +1000
Message-ID: <29244.1366799409@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, miltonm@realtime.net,
 Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In __after_prom_start we copy the kernel down to zero in two calls to 
copy_and_flush.  After the first call (copy from 0 to copy_to_here:)
we jump to the newly copied code soon after.

Unfortunately there's no isync between the copy of this code and the
jump to it.  Hence it's possible that stale instructions could still be
in the icache or pipeline before we branch to it.

We've seen this on real machines and it's results in no console output
after:
  calling quiesce...
  returning from prom_init

The below adds an isync to ensure that the copy and flushing has
completed before any branching to the new instructions occurs.

Signed-off-by: Michael Neuling <mikey@neuling.org>
cc: stable@kernel.org
---
benh: we should get this in 3.9 ASAP.

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 0886ae6..b61363d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -509,6 +509,7 @@ _GLOBAL(copy_and_flush)
 	sync
 	addi	r5,r5,8
 	addi	r6,r6,8
+	isync
 	blr
 
 .align 8
