Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDqWj25nMzDqy3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 11:18:09 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id k72so2526372pfj.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 18:18:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 05/11] powerpc/64s/radix: Do not allocate SLB shadow
 structures
Date: Sat, 22 Jul 2017 11:17:35 +1000
Message-Id: <20170722011741.13942-6-npiggin@gmail.com>
In-Reply-To: <20170722011741.13942-1-npiggin@gmail.com>
References: <20170722011741.13942-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/paca.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index fd7deb79110a..032b073c2c30 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -104,13 +104,22 @@ static struct slb_shadow *slb_shadow;
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
2.11.0
