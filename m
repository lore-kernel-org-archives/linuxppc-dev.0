Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 868CB2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 16:57:33 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r466ga4f017104
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 01:42:37 -0500
Message-ID: <1367822556.15842.13.camel@pasglop>
Subject: [PATCH] powerpc/cell/spufs: Fix status attribute permission
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 06 May 2013 16:42:36 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are registering the attribute with permission 0644 but it
doesn't have a store callback, which causes WARN_ON's during
boot. Fix the permission.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/cell/spu_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 8b12139..f85db3a 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -715,7 +715,7 @@ static ssize_t spu_stat_show(struct device *dev,
 		spu->stats.libassist);
 }
 
-static DEVICE_ATTR(stat, 0644, spu_stat_show, NULL);
+static DEVICE_ATTR(stat, 0444, spu_stat_show, NULL);
 
 #ifdef CONFIG_KEXEC
 
