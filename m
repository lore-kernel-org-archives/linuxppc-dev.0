Return-Path: <dja@axtens.net>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FCDA1A072A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:36:18 +1100 (AEDT)
Received: by pacwe9 with SMTP id we9so17267458pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:36:16 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/27] powerpc/swiotlb: give init call a less misleading name
Date: Wed, 25 Mar 2015 16:35:37 +1100
Message-Id: <1427261761-22952-4-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

swiotlb_late_init sets up platform specific hooks. It's not actually
a late initcall, but a subsys initcall, called much earlier.

Ideally we'd call it swiotlb_init, but that's taken.
Call it swiotlb_subsys_init for now.
(It will be refactored and renamed later.)

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/kernel/dma-swiotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 7359797..d06491b 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -116,7 +116,7 @@ void __init swiotlb_detect_4g(void)
 	}
 }
 
-static int __init swiotlb_late_init(void)
+static int __init swiotlb_subsys_init(void)
 {
 	if (ppc_swiotlb_enable) {
 		swiotlb_print_info();
@@ -128,4 +128,4 @@ static int __init swiotlb_late_init(void)
 
 	return 0;
 }
-subsys_initcall(swiotlb_late_init);
+subsys_initcall(swiotlb_subsys_init);
-- 
2.1.4
