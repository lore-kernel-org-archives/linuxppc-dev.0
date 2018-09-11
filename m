Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428nzc1VRHzF38C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 00:56:11 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id v198-v6so30004685oif.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 07:56:11 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: Finn Thain <fthain@telegraphics.com.au>, Stan Johnson <userm57@yahoo.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: [PATCH] of: fix phandle cache creation for DTs with no phandles
Date: Tue, 11 Sep 2018 09:56:07 -0500
Message-Id: <20180911145607.6009-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of
of_find_node_by_phandle()"), a G3 PowerMac fails to boot. The root cause
is the DT for this system has no phandle properties when booted with
BootX. of_populate_phandle_cache() does not handle the case of no
phandles correctly. The problem is roundup_pow_of_two() for 0 is
undefined. The implementation subtracts 1 underflowing and then things
are in the weeds.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Cc: stable@vger.kernel.org # 4.17+
Reported-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
Here's a formal patch of what Stan tested. Will send to Linus this week.

Rob

 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a055cd1ef96d..17ae594b7014 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -140,6 +140,9 @@ void of_populate_phandle_cache(void)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
 			phandles++;
 
+	if (!phandles)
+		goto out;
+
 	cache_entries = roundup_pow_of_two(phandles);
 	phandle_cache_mask = cache_entries - 1;
 
-- 
2.17.1
