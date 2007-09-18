Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AC0CADDE16
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 17:25:24 +1000 (EST)
Date: Tue, 18 Sep 2007 17:25:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/2] [POWERPC] fwnmi is only used on pSeries
Message-Id: <20070918172512.6aa5af03.sfr@canb.auug.org.au>
In-Reply-To: <20070918172259.dc4172b0.sfr@canb.auug.org.au>
References: <20070918172259.dc4172b0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This saves 4k on non pSeries builds (except for iSeries where it saves
almost 4k).

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/crash_dump.c |    2 ++
 arch/powerpc/kernel/head_64.S    |    7 +++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

Boot tested on iSeries and POWER5+.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash_dump.c
index ffa91d6..29ff77c 100644
--- a/arch/powerpc/kernel/crash_dump.c
+++ b/arch/powerpc/kernel/crash_dump.c
@@ -54,8 +54,10 @@ void __init setup_kdump_trampoline(void)
 		create_trampoline(i);
 	}
 
+#ifdef CONFIG_PPC_PSERIES
 	create_trampoline(__pa(system_reset_fwnmi) - PHYSICAL_START);
 	create_trampoline(__pa(machine_check_fwnmi) - PHYSICAL_START);
+#endif /* CONFIG_PPC_PSERIES */
 
 	DBG(" <- setup_kdump_trampoline()\n");
 }
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 384cc75..22ac245 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -341,6 +341,7 @@ slb_miss_user_pseries:
 	b	.				/* prevent spec. execution */
 #endif /* __DISABLED__ */
 
+#ifdef CONFIG_PPC_PSERIES
 /*
  * Vectors for the FWNMI option.  Share common code.
  */
@@ -358,6 +359,8 @@ machine_check_fwnmi:
 	mtspr	SPRN_SPRG1,r13		/* save r13 */
 	EXCEPTION_PROLOG_PSERIES_FORCE_64BIT(PACA_EXMC, machine_check_common)
 
+#endif /* CONFIG_PPC_PSERIES */
+
 /*** Common interrupt handlers ***/
 
 	STD_EXCEPTION_COMMON(0x100, system_reset, .system_reset_exception)
@@ -1012,6 +1015,7 @@ _GLOBAL(do_stab_bolted)
 initial_stab:
 	.space	4096
 
+#ifdef CONFIG_PPC_PSERIES
 /*
  * Data area reserved for FWNMI option.
  * This address (0x7000) is fixed by the RPA.
@@ -1019,6 +1023,7 @@ initial_stab:
 	.= 0x7000
 	.globl fwnmi_data_area
 fwnmi_data_area:
+#endif /* CONFIG_PPC_PSERIES */
 
 	/* iSeries does not use the FWNMI stuff, so it is safe to put
 	 * this here, even if we later allow kernels that will boot on
@@ -1043,7 +1048,9 @@ xLparMap:
 
 #endif /* CONFIG_PPC_ISERIES */
 
+#ifdef CONFIG_PPC_PSERIES
         . = 0x8000
+#endif /* CONFIG_PPC_PSERIES */
 
 /*
  * On pSeries and most other platforms, secondary processors spin
-- 
1.5.3.1
