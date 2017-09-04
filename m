Return-Path: <clg@kaod.org>
Received: from 4.mo68.mail-out.ovh.net (4.mo68.mail-out.ovh.net [46.105.59.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xm0Xh3qGtzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 16:38:12 +1000 (AEST)
Received: from player789.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 29DC77B6C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Sep 2017 08:38:07 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] powerpc/xive: Fix section __init warning
Date: Mon,  4 Sep 2017 08:37:55 +0200
Message-Id: <20170904063755.6836-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xive_spapr_init() is called from a __init routine and calls __init
routines.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 43e9eeb0d39f..f24a70bc6855 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -593,7 +593,7 @@ static bool xive_get_max_prio(u8 *max_prio)
 	return true;
 }
 
-bool xive_spapr_init(void)
+bool __init xive_spapr_init(void)
 {
 	struct device_node *np;
 	struct resource r;
-- 
2.13.5
