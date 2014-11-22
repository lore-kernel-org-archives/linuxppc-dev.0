Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2BC1A1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Nov 2014 02:32:48 +1100 (AEDT)
Message-ID: <5470AB2D.705@users.sourceforge.net>
Date: Sat, 22 Nov 2014 16:26:37 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Kumar Gala <galak@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] PowerPC-83xx: Deletion of an unnecessary check before
 the function call "of_node_put"
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Content-Type: text/plain; charset=windows-1252
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 22 Nov 2014 16:18:20 +0100

The of_node_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/83xx/usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 1ad748b..5c31d82 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -162,8 +162,7 @@ int mpc831x_usb_cfg(void)
 
 	iounmap(immap);
 
-	if (immr_node)
-		of_node_put(immr_node);
+	of_node_put(immr_node);
 
 	/* Map USB SOC space */
 	ret = of_address_to_resource(np, 0, &res);
-- 
2.1.3
