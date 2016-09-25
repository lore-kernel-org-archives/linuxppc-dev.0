Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shmm71V8qzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 22:35:51 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Only disable HAVE_EFFICIENT_UNALIGNED_ACCESS on
 POWER7 little endian
Date: Sun, 25 Sep 2016 22:35:40 +1000
Message-Id: <1474806941-5006-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

POWER8 handles unaligned accesses in little endian mode, but commit
0b5e6661ac69 ("powerpc: Don't set HAVE_EFFICIENT_UNALIGNED_ACCESS on
little endian builds") disabled it for all.

The issue with unaligned little endian accesses is specific to POWER7,
so update the Kconfig check to match. Using the stat() testcase from
commit a75c380c7129 ("powerpc: Enable DCACHE_WORD_ACCESS on ppc64le"),
performance improves 15% on POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0a70c86..04c447d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -96,7 +96,7 @@ config PPC
 	select VIRT_TO_BUS if !PPC64
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
-	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !CPU_LITTLE_ENDIAN
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !(CPU_LITTLE_ENDIAN && POWER7_CPU)
 	select HAVE_KPROBES
 	select HAVE_ARCH_KGDB
 	select HAVE_KRETPROBES
-- 
2.7.4
