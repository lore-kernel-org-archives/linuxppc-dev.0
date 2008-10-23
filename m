Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A3A5FDDF03
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 16:02:06 +1100 (EST)
Date: Thu, 23 Oct 2008 15:52:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: linux-next: rr tree build failure
Message-Id: <20081023155228.c8fa9da8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org, Mike Travis <travis@sgi.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Rusty,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

arch/powerpc/platforms/cell/spu_base.c: In function 'mm_needs_global_tlbie':
arch/powerpc/platforms/cell/spu_base.c:117: error: implicit declaration of function '__cpus_setall'

Caused by commit 20ec1a8465bd6d2e7e68fa5a7b09309c920b4792
("cpumask:add-struct-cpumask") which removed __cpus_setall from
include/linux/cpumask.h.

I applied the hack patch below (which is probably not what we want).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Oct 2008 15:36:21 +1100
Subject: [PATCH] powerpc/spu: cpumask updates fallout.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/spu_base.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index a5bdb89..a876904 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -111,10 +111,13 @@ void spu_flush_all_slbs(struct mm_struct *mm)
  */
 static inline void mm_needs_global_tlbie(struct mm_struct *mm)
 {
-	int nr = (NR_CPUS > 1) ? NR_CPUS : NR_CPUS + 1;
-
 	/* Global TLBIE broadcast required with SPEs. */
-	__cpus_setall(&mm->cpu_vm_mask, nr);
+	if (NR_CPUS > 1)
+		cpumask_setall(&mm->cpu_vm_mask);
+	else {
+		cpumask_set_cpu(0, &mm->cpu_vm_mask);
+		cpumask_set_cpu(1, &mm->cpu_vm_mask);
+	}
 }
 
 void spu_associate_mm(struct spu *spu, struct mm_struct *mm)
-- 
1.5.6.5
