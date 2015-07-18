Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A9631A0CEC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:23 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 02/17] powerpc/85xx: Don't use generic timebase sync on
 64-bit
Date: Sat, 18 Jul 2015 15:08:39 -0500
Message-ID: <1437250134-307-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

85xx currently uses the generic timebase sync mechanism when
CONFIG_KEXEC is enabled, because 32-bit 85xx kexec support does a hard
reset of each core.  64-bit 85xx kexec does not do this, so we neither
need nor want this (nor is the generic timebase sync code built on
ppc64).

FWIW, I don't like the fact that the hard reset is done on 32-bit
kexec, and I especially don't like the timebase sync being triggered
only on the presence of CONFIG_KEXEC rather than actually booting in
that environment, but that's beyond the scope of this patch...

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index c2ded03..a0763be 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -344,7 +344,7 @@ struct smp_ops_t smp_85xx_ops = {
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
 #endif
-#ifdef CONFIG_KEXEC
+#if defined(CONFIG_KEXEC) && !defined(CONFIG_PPC64)
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
 #endif
-- 
2.1.4
