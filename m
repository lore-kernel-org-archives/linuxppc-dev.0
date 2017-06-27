Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxhx30qCmzDr2g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 20:29:11 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id d5so4200751pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:29:11 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-nvdimm@lists.01.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [RFC 4/4] powerpc/powernv: Create platform devs for nvdimm buses
Date: Tue, 27 Jun 2017 20:28:51 +1000
Message-Id: <20170627102851.15484-4-oohall@gmail.com>
In-Reply-To: <20170627102851.15484-1-oohall@gmail.com>
References: <20170627102851.15484-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scan the devicetree for nonvolatile-memory buses and instantiate a
platform device for them.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 59684b4af4d1..bd3ed78f6f04 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -775,6 +775,9 @@ static int __init opal_init(void)
 	/* Create i2c platform devices */
 	opal_pdev_init("ibm,opal-i2c");
 
+	/* Handle non-volatile memory devices */
+	opal_pdev_init("nonvolatile-memory");
+
 	/* Setup a heatbeat thread if requested by OPAL */
 	opal_init_heartbeat();
 
-- 
2.9.4
