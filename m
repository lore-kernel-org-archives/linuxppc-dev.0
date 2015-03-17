Return-Path: <peter@hurleysoftware.com>
Received: from mail-qg0-f48.google.com (mail-qg0-f48.google.com
 [209.85.192.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 592AF1A0ED3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 07:46:57 +1100 (AEDT)
Received: by qgfa8 with SMTP id a8so20146417qgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 13:46:55 -0700 (PDT)
From: Peter Hurley <peter@hurleysoftware.com>
To: Rob Herring <robh@kernel.org>,
	Grant Likely <grant.likely@linaro.org>
Subject: [PATCH] Revert "of: Fix premature bootconsole disable with
 'stdout-path'"
Date: Tue, 17 Mar 2015 16:46:33 -0400
Message-Id: <1426625193-5055-1-git-send-email-peter@hurleysoftware.com>
Cc: devicetree@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Pranith Kumar <bobby.prani@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 2fa645cb2703d9b3786d850db815414dfeefa51d.

The assumption that at least 1 preferred console will be registered
when the stdout-path property is set is invalid, which can result
in _no_ consoles.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index adb8764..8b904e5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1893,10 +1893,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			name = of_get_property(of_chosen, "linux,stdout-path", NULL);
 		if (IS_ENABLED(CONFIG_PPC) && !name)
 			name = of_get_property(of_aliases, "stdout", NULL);
-		if (name) {
+		if (name)
 			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
-			add_preferred_console("stdout-path", 0, NULL);
-		}
 	}
 
 	if (!of_aliases)
-- 
2.3.3
