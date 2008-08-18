Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id C30D2DDFFE
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 02:34:17 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so216525uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Aug 2008 09:34:16 -0700 (PDT)
Message-ID: <48A9F8E9.8030303@gmail.com>
Date: Mon, 18 Aug 2008 18:34:17 -0400
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: paulus@samba.org, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] POWERPC: duplicate test of MACIO_FLAG_SCCB_ON
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

untested, is it correct?

arch/powerpc/include/asm/pmac_feature.h:359:
#define MACIO_FLAG_SCCA_ON  0x00000001
#define MACIO_FLAG_SCCB_ON  0x00000002
---
duplicate test of MACIO_FLAG_SCCB_ON

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 5169ecc..e6c0040 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2677,7 +2677,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
 	macio_chips[i].of_node	= node;
 	macio_chips[i].type	= type;
 	macio_chips[i].base	= base;
-	macio_chips[i].flags	= MACIO_FLAG_SCCB_ON | MACIO_FLAG_SCCB_ON;
+	macio_chips[i].flags	= MACIO_FLAG_SCCA_ON | MACIO_FLAG_SCCB_ON;
 	macio_chips[i].name	= macio_names[type];
 	revp = of_get_property(node, "revision-id", NULL);
 	if (revp)
