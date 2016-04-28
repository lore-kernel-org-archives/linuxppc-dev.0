Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwQxw4JJpzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 15:54:12 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id p185so8792893pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 22:54:12 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH] powerpc/pseries: Add null property check to
 pseries_discover_pic()
Date: Thu, 28 Apr 2016 15:53:45 +1000
Message-Id: <1461822825-21542-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The return value of of_get_property() isn't checked before it is passed
to the strstr() function, if it happens that the return value is null
then this will result in a null pointer being dereferenced.

Add a check to see if the return value of of_get_property() is null and
if it is continue straight on to the next node.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/platforms/pseries/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 6e944fc..fa73494 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -235,6 +235,8 @@ static void __init pseries_discover_pic(void)
 
 	for_each_node_by_name(np, "interrupt-controller") {
 		typep = of_get_property(np, "compatible", NULL);
+		if (!typep)
+			continue;
 		if (strstr(typep, "open-pic")) {
 			pSeries_mpic_node = of_node_get(np);
 			ppc_md.init_IRQ       = pseries_mpic_init_IRQ;
-- 
2.5.0
