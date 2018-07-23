Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4cc2vCPzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:08:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/powernv: Query firmware for count cache flush
 settings
Date: Tue, 24 Jul 2018 01:07:56 +1000
Message-Id: <20180723150756.11108-5-mpe@ellerman.id.au>
In-Reply-To: <20180723150756.11108-1-mpe@ellerman.id.au>
References: <20180723150756.11108-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Look for fw-features properties to determine the appropriate settings
for the count cache flush, and then call the generic powerpc code to
set it up based on the security feature flags.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/setup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index f96df0a25d05..0988d050becd 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -78,6 +78,12 @@ static void init_fw_feat_flags(struct device_node *np)
 	if (fw_feature_is("enabled", "fw-count-cache-disabled", np))
 		security_ftr_set(SEC_FTR_COUNT_CACHE_DISABLED);
 
+	if (fw_feature_is("enabled", "fw-count-cache-flush-bcctr2,0,0", np))
+		security_ftr_set(SEC_FTR_BCCTR_FLUSH_ASSIST);
+
+	if (fw_feature_is("enabled", "needs-count-cache-flush-on-context-switch", np))
+		security_ftr_set(SEC_FTR_FLUSH_COUNT_CACHE);
+
 	/*
 	 * The features below are enabled by default, so we instead look to see
 	 * if firmware has *disabled* them, and clear them if so.
@@ -125,6 +131,7 @@ static void pnv_setup_rfi_flush(void)
 
 	setup_rfi_flush(type, enable);
 	setup_barrier_nospec();
+	setup_count_cache_flush();
 }
 
 static void __init pnv_setup_arch(void)
-- 
2.14.1
