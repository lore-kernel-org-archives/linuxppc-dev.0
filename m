Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rknx94sT5zDqyf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 14:35:25 +1000 (AEST)
Message-ID: <1467779716.13965.104.camel@kernel.crashing.org>
Subject: [RFC/PATCH 4/4] powerpc/64/kexec: Remove BookE special
 default_machine_kexec_prepare()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard
 <anton@au1.ibm.com>
Date: Wed, 06 Jul 2016 14:35:16 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only difference is now the TCE table check which doesn't need
to be ifdef'ed out, it will basically do nothing on BookE (it is
only useful for ancient IBM machines).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Currently only compile tested

 arch/powerpc/kernel/machine_kexec_64.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 77fcc34..a44ffe5 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -31,21 +31,6 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/firmware.h>
 
-#ifdef CONFIG_PPC_BOOK3E
-int default_machine_kexec_prepare(struct kimage *image)
-{
-	int i;
-	/*
-	 * Since we use the kernel fault handlers and paging code to
-	 * handle the virtual mode, we must make sure no destination
-	 * overlaps kernel static data or bss.
-	 */
-	for (i = 0; i < image->nr_segments; i++)
-		if (image->segment[i].mem < __pa(_end))
-			return -ETXTBSY;
-	return 0;
-}
-#else
 int default_machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -85,7 +70,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 
 	return 0;
 }
-#endif /* !CONFIG_PPC_BOOK3E */
 
 static void copy_segments(unsigned long ind)
 {
