Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BEFCB1A0A91
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 20:22:21 +1000 (EST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/14] powerpc: gamecube/wii: delete unneeded test before
 of_node_put
Date: Fri,  8 Aug 2014 12:07:48 +0200
Message-Id: <1407492475-26283-7-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

Simplify the error path to avoid calling of_node_put when it is not needed.

The semantic patch that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

-if (e)
   of_node_put(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index 20a8ed9..7feb325 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -247,7 +247,7 @@ void __init ug_udbg_init(void)
 	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-exi");
 	if (!np) {
 		udbg_printf("%s: EXI node not found\n", __func__);
-		goto done;
+		goto out;
 	}
 
 	exi_io_base = ug_udbg_setup_exi_io_base(np);
@@ -267,8 +267,8 @@ void __init ug_udbg_init(void)
 	}
 
 done:
-	if (np)
-		of_node_put(np);
+	of_node_put(np);
+out:
 	return;
 }
 
