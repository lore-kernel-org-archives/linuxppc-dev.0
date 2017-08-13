Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVLrR1fWXzDr6q
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 11:34:31 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h75so6783007pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 18:34:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 6/9] powerpc/64s/radix: Do not allocate SLB shadow
 structures
Date: Sun, 13 Aug 2017 11:33:43 +1000
Message-Id: <20170813013346.14002-6-npiggin@gmail.com>
In-Reply-To: <20170812113416.15978-1-npiggin@gmail.com>
References: <20170812113416.15978-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are unused in radix mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/paca.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 64401f551765..354a955ca377 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -101,18 +101,27 @@ static inline void free_lppacas(void) { }
  * If you make the number of persistent SLB entries dynamic, please also
  * update PR KVM to flush and restore them accordingly.
  */
-static struct slb_shadow *slb_shadow;
+static struct slb_shadow * __initdata slb_shadow;
 
 static void __init allocate_slb_shadows(int nr_cpus, int limit)
 {
 	int size = PAGE_ALIGN(sizeof(struct slb_shadow) * nr_cpus);
+
+	if (early_radix_enabled())
+		return;
+
 	slb_shadow = __va(memblock_alloc_base(size, PAGE_SIZE, limit));
 	memset(slb_shadow, 0, size);
 }
 
 static struct slb_shadow * __init init_slb_shadow(int cpu)
 {
-	struct slb_shadow *s = &slb_shadow[cpu];
+	struct slb_shadow *s;
+
+	if (early_radix_enabled())
+		return NULL;
+
+	s = &slb_shadow[cpu];
 
 	/*
 	 * When we come through here to initialise boot_paca, the slb_shadow
-- 
2.13.3
