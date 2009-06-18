Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2CE20B759F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 09:22:53 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id B0CF2DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 09:22:51 +1000 (EST)
Date: Fri, 19 Jun 2009 03:22:08 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Fix FSL RapidIO probing on MDS boards
Message-ID: <20090618232208.GA11063@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Vinson <rvinson@mvista.com>

FSL RapidIO won't probe without a proper compatible entry. This
patch fixes the issue by adding fsl,rapidio-delta compatible to
mpc85xx_ids.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index b2c0a43..daf6711 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -268,6 +268,7 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
 	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,rapidio-delta", },
 	{},
 };
 
-- 
1.6.3.1
