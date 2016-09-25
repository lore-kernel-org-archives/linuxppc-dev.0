Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shmm90cCmzDrPk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 22:35:53 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Set default CPU type to POWER8 for little endian
 builds
Date: Sun, 25 Sep 2016 22:35:41 +1000
Message-Id: <1474806941-5006-2-git-send-email-anton@ozlabs.org>
In-Reply-To: <1474806941-5006-1-git-send-email-anton@ozlabs.org>
References: <1474806941-5006-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

We supported POWER7 CPUs for bootstrapping little endian, but the
target was always POWER8. Now that POWER7 specific issues are
impacting performance, change the default target to POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec..fa06676 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -86,6 +86,7 @@ endchoice
 choice
 	prompt "CPU selection"
 	depends on PPC64
+	default POWER8_CPU if CPU_LITTLE_ENDIAN
 	default GENERIC_CPU
 	help
 	  This will create a kernel which is optimised for a particular CPU.
-- 
2.7.4
