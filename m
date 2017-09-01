Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkYD913t8zDqZf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 08:03:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org
Subject: [PATCH] powerpc/sstep: Avoid used uninitialized error
Date: Sat,  2 Sep 2017 08:03:44 +1000
Message-Id: <1504303424-28452-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older compilers think val may be used uninitialized:

  arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
  arch/powerpc/lib/sstep.c:2758:23: error: 'val' may be used uninitialized in this function

We know better, but initialise val to 0 to avoid breaking the build.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/sstep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index 06dd61d8d48b..fb9f58b868e7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -2727,6 +2727,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		if (!address_ok(regs, ea, size))
 			return -EFAULT;
 		err = 0;
+		val = 0;
 		switch (size) {
 #ifdef __powerpc64__
 		case 1:
-- 
2.7.4
