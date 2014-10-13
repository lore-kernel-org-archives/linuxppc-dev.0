Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE50D1A06DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:39 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/20] powerpc/corenet: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:14 +0200
Message-Id: <1413208888-49211-7-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 2 +-
 arch/powerpc/sysdev/fsl_soc.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index e56b89a..1f309cc 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -170,7 +170,7 @@ static int __init corenet_generic_probe(void)
 
 			ppc_md.get_irq = ehv_pic_get_irq;
 			ppc_md.restart = fsl_hv_restart;
-			ppc_md.power_off = fsl_hv_halt;
+			pm_power_off = fsl_hv_halt;
 			ppc_md.halt = fsl_hv_halt;
 #ifdef CONFIG_SMP
 			/*
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ffd1169..1e04568 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -238,7 +238,7 @@ void fsl_hv_restart(char *cmd)
 /*
  * Halt the current partition
  *
- * This function should be assigned to the ppc_md.power_off and ppc_md.halt
+ * This function should be assigned to the pm_power_off and ppc_md.halt
  * function pointers, to shut down the partition when we're running under
  * the Freescale hypervisor.
  */
-- 
1.8.1.4
