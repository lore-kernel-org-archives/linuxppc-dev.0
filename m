Return-Path: <glikely@secretlab.ca>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com
 [IPv6:2a00:1450:400c:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 420C72C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 21:58:46 +1100 (EST)
Received: by mail-wi0-f170.google.com with SMTP id hq7so285099wib.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2012 02:58:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: Fix export of of_find_matching_node_and_match()
Date: Wed, 19 Dec 2012 10:58:36 +0000
Message-Id: <1355914716-19469-1-git-send-email-grant.likely@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 50c8af4cf9, "of: introduce for_each_matching_node_and_match()"
renamed of_find_matching_node() to of_find_matching_node_and_match() and
created a new static inline of_find_matching_node() wrapper around the
new name. However, the change neglected to change the EXPORT_SYMBOL()
reference causing build errors for modules.

This patch fixes the EXPORT_SYMBOL() statement. Discovered on a PowerPC
Efika build with the mpc52xx_uart driver being built as a module.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Anatolij Gustschin <agust@denx.de>
---

I'll push this patch out to my tree ASAP.

 drivers/of/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index db8d211..2390ddb 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -629,7 +629,7 @@ struct device_node *of_find_matching_node_and_match(struct device_node *from,
 	read_unlock(&devtree_lock);
 	return np;
 }
-EXPORT_SYMBOL(of_find_matching_node);
+EXPORT_SYMBOL(of_find_matching_node_and_match);
 
 /**
  * of_modalias_node - Lookup appropriate modalias for a device node
-- 
1.7.10.4
