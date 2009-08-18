Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44F93B7BA1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 09:28:12 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BC2F4DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 09:28:11 +1000 (EST)
Date: Wed, 19 Aug 2009 03:28:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/82xx: Fix BCSR bits for MPC8272ADS boards
Message-ID: <20090818232810.GA27907@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8272_ads.c is using BCSR bits definitions from pq2ads.h, but
according to User's Guide the bits are wrong for MPC8272ADS boards
(I guess definitions from pq2ads should only be used for PQ2FADS
boards).

So, let's introduce our own definitions for MPC8272ADS, and don't
include pq2ads.h.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/82xx/mpc8272_ads.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 8054c68..67e2184 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -29,7 +29,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
-#include "pq2ads.h"
 #include "pq2.h"
 
 static void __init mpc8272_ads_pic_init(void)
@@ -144,6 +143,13 @@ static void __init mpc8272_ads_setup_arch(void)
 		return;
 	}
 
+#define BCSR1_FETHIEN		0x08000000
+#define BCSR1_FETH_RST		0x04000000
+#define BCSR1_RS232_EN1		0x02000000
+#define BCSR1_RS232_EN2		0x01000000
+#define BCSR3_FETHIEN2		0x10000000
+#define BCSR3_FETH2_RST		0x08000000
+
 	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
 	setbits32(&bcsr[1], BCSR1_FETH_RST);
 
-- 
1.6.3.3
