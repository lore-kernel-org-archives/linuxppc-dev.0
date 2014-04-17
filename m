Return-Path: <leif.lindholm@linaro.org>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
 [209.85.212.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1C9BE1400A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 03:43:26 +1000 (EST)
Received: by mail-wi0-f171.google.com with SMTP id q5so3268670wiv.16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Apr 2014 10:43:22 -0700 (PDT)
From: Leif Lindholm <leif.lindholm@linaro.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
Date: Thu, 17 Apr 2014 18:42:01 +0100
Message-Id: <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
In-Reply-To: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 patches@linaro.org, Leif Lindholm <leif.lindholm@linaro.org>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to deal with an firmware bug on a specific ppc32 platform
(longtrail), early_init_dt_scan_memory() looks for a node called
memory@0 on all platforms. Restrict this quirk to ppc32 kernels only.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/of/fdt.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index fa16a91..7368472 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -887,14 +887,19 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 
 	/* We are scanning "memory" nodes only */
 	if (type == NULL) {
+#ifdef CONFIG_PPC32
 		/*
 		 * The longtrail doesn't have a device_type on the
 		 * /memory node, so look for the node called /memory@0.
 		 */
 		if (depth != 1 || strcmp(uname, "memory@0") != 0)
 			return 0;
-	} else if (strcmp(type, "memory") != 0)
+#else
+		return 0;
+#endif
+	} else if (strcmp(type, "memory") != 0) {
 		return 0;
+	}
 
 	reg = of_get_flat_dt_prop(node, "linux,usable-memory", &l);
 	if (reg == NULL)
-- 
1.7.10.4
