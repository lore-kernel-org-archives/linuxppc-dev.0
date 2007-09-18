Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D69A7DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 22:05:21 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 33DCF8810
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 17:05:20 +0500 (SAMST)
Date: Tue, 18 Sep 2007 16:07:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC][RFC] mpc8xx: fix build with CONFIG_MODULES=y
Message-ID: <20070918120752.GA4859@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

It seems there is no __res in the arch/powerpc. How it was used in
the new tree, can we now safely remove it? At least kernel builds
with that patch.

Thanks,

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/ppc_ksyms.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 430c502..b4163c3 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -180,9 +180,6 @@ EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
 #endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx)
-EXPORT_SYMBOL(__res);
-#endif
 
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(next_mmu_context);
-- 
1.5.0.6
