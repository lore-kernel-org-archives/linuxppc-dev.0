Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40FrwM5TqMzF27s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 00:25:23 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id g20-v6so9001938plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 07:25:23 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-nvdimm@lists.01.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [RESEND v2 4/4] powerpc/powernv: Create platform devs for nvdimm buses
Date: Wed,  4 Apr 2018 00:24:15 +1000
Message-Id: <20180403142415.30083-4-oohall@gmail.com>
In-Reply-To: <20180403142415.30083-1-oohall@gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scan the devicetree for an nvdimm-bus compatible and create
a platform device for them.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index c15182765ff5..c37485a3c5c9 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -821,6 +821,9 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_pdev_init("ibm,opal-i2c");
 
+	/* Handle non-volatile memory devices */
+	opal_pdev_init("pmem-region");
+
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
-- 
2.9.5
