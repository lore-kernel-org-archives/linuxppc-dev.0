Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCYx90m2MzDq74
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 05:01:49 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id e4so28926666pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 10:01:49 -0800 (PST)
Date: Tue, 31 Jan 2017 10:01:44 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/powermac: drop useless call to of_find_node_by_name
Message-ID: <20170131180144.GA27740@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are not using result, so this simply results in a leaked refcount.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Found by visual inspection, not tested...

 arch/powerpc/platforms/powermac/feature.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 1e02328c3f2d..730e48111848 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2853,7 +2853,6 @@ set_initial_features(void)
 		}
 
 		/* Enable ATA-100 before PCI probe. */
-		np = of_find_node_by_name(NULL, "ata-6");
 		for_each_node_by_name(np, "ata-6") {
 			if (np->parent
 			    && of_device_is_compatible(np->parent, "uni-north")
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
