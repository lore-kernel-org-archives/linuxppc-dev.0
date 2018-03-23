Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406x9H1QpGzF21K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 19:12:35 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id v26so1796852pge.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 01:12:34 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linux-nvdimm@lists.01.org
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 5/6] powerpc/powernv: Create platform devs for nvdimm buses
Date: Fri, 23 Mar 2018 19:12:08 +1100
Message-Id: <20180323081209.31387-5-oohall@gmail.com>
In-Reply-To: <20180323081209.31387-1-oohall@gmail.com>
References: <20180323081209.31387-1-oohall@gmail.com>
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
index c15182765ff5..a16f4b63ccf2 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -821,6 +821,9 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_pdev_init("ibm,opal-i2c");
 
+	/* Handle non-volatile memory devices */
+	opal_pdev_init("nvdimm-region");
+
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
-- 
2.9.5
