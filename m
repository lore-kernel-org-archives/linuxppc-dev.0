Return-Path: <chrisp@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc8nj4x6NzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 07:22:01 +1000 (AEST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
 mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 1/3] EDAC: mv64x60: check driver registration success
Date: Tue, 30 May 2017 09:21:40 +1200
Message-Id: <20170529212142.25572-2-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
References: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check the return status of platform_driver_register() in
mv64x60_edac_init(). Only output messages and initialise the
edac_op_state if the registration is successful.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v3:
- catch the retval of platform_register_drivers and return early on failure
  (thanks Borislav).

 drivers/edac/mv64x60_edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
index 14b7e7b71eaa..172081551a70 100644
--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -853,7 +853,11 @@ static struct platform_driver * const drivers[] = {
 
 static int __init mv64x60_edac_init(void)
 {
-	int ret = 0;
+	int ret;
+
+	ret = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+	if (ret)
+		return ret;
 
 	printk(KERN_INFO "Marvell MV64x60 EDAC driver " MV64x60_REVISION "\n");
 	printk(KERN_INFO "\t(C) 2006-2007 MontaVista Software\n");
@@ -867,7 +871,7 @@ static int __init mv64x60_edac_init(void)
 		break;
 	}
 
-	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+	return 0;
 }
 module_init(mv64x60_edac_init);
 
-- 
2.13.0
