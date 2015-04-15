Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40E3F1A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 12:17:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Show utsname->machine in boot-up banner
Date: Wed, 15 Apr 2015 12:17:07 +1000
Message-Id: <1429064227-21689-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we print "Starting Linux PPC64" at boot. But we don't mention
anywhere whether the kernel is big or little endian.

If we print the utsname->machine value instead we get either "ppc64" or
"ppc64le" which is much more informative, eg:

  Starting Linux ppc64le #1 SMP Wed Apr 15 12:12:20 AEST 2015

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 49f553bbb360..dfbeabad523b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -522,7 +522,8 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
-	pr_info("Starting Linux PPC64 %s\n", init_utsname()->version);
+	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
+		 init_utsname()->version);
 
 	pr_info("-----------------------------------------------------\n");
 	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
-- 
2.1.0
