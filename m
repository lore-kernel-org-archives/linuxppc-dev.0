Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8048967B59
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:42 +1000 (EST)
Date: Tue, 26 Sep 2006 13:34:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/7] [POWERPC] iSeries: set FW_FEATURE_ISERIES earlier
Message-Id: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
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

This will help in the combined kernel as some really early things depend
on being able to check this.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 7f19530..7cb6b5f 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -655,9 +655,6 @@ static int __init iseries_probe(void)
 	if (!of_flat_dt_is_compatible(root, "IBM,iSeries"))
 		return 0;
 
-	powerpc_firmware_features |= FW_FEATURE_ISERIES;
-	powerpc_firmware_features |= FW_FEATURE_LPAR;
-
 	hpte_init_iSeries();
 
 	return 1;
@@ -687,6 +684,9 @@ void * __init iSeries_early_setup(void)
 {
 	unsigned long phys_mem_size;
 
+	powerpc_firmware_features |= FW_FEATURE_ISERIES;
+	powerpc_firmware_features |= FW_FEATURE_LPAR;
+
 	iSeries_fixup_klimit();
 
 	/*
-- 
1.4.2.1
