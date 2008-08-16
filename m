Return-Path: <paul@burly.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id E6BB0DDDDF
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 18:55:56 +1000 (EST)
From: Paul Collins <paul@burly.ondioline.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: fix up KEXEC_CONTROL_CODE_SIZE missed during conversion
Date: Sat, 16 Aug 2008 20:55:54 +1200
Message-ID: <877iah8hk5.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, ying.huang@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 163f6876f5c3ff8215e900b93779e960a56b3694 missed one, resulting in
the following compile error:

  AS      arch/powerpc/kernel/misc_32.o
arch/powerpc/kernel/misc_32.S: Assembler messages:
arch/powerpc/kernel/misc_32.S:902: Error: unsupported relocation against KEXEC_CONTROL_CODE_SIZE
make[2]: *** [arch/powerpc/kernel/misc_32.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2
make: *** [vmlinux] Error 2

I grepped arch/ and found no further instances.

Signed-off-by: Paul Collins <paul@ondioline.org>
---
 arch/powerpc/kernel/misc_32.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 6321ae3..7a6dfbc 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -899,7 +899,7 @@ relocate_new_kernel:
 
 	/* set a new stack at the bottom of our page... */
 	/* (not really needed now) */
-	addi	r1, r4, KEXEC_CONTROL_CODE_SIZE - 8 /* for LR Save+Back Chain */
+	addi	r1, r4, KEXEC_CONTROL_PAGE_SIZE - 8 /* for LR Save+Back Chain */
 	stw	r0, 0(r1)
 
 	/* Do the copies */

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
