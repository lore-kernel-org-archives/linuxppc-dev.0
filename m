Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVg996tsCzDrFJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Aug 2017 23:50:02 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: store the intended structure
Date: Sun, 13 Aug 2017 15:24:23 +0200
Message-Id: <1502630663-18599-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally the values in the resource field and the argument to ARRAY_SIZE
in the num_resources are the same.  In this case, the value in the reousrce
field is the same as the one in the previous platform_device structure, and
appears to be a copy-paste error.  Replace the value in the resource field
with the argument to the local call to ARRAY_SIZE.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
index 2b4dc6a..1976071 100644
--- a/arch/powerpc/platforms/chrp/pegasos_eth.c
+++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
@@ -63,7 +63,7 @@
 	.name		= "orion-mdio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mv643xx_eth_mvmdio_resources),
-	.resource	= mv643xx_eth_shared_resources,
+	.resource	= mv643xx_eth_mvmdio_resources,
 };
 
 static struct resource mv643xx_eth_port1_resources[] = {
