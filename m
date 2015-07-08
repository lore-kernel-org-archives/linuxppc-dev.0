Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 196F31A1D14
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 01:14:43 +1000 (AEST)
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] cxl: Destroy cxl_adapter_idr on module_exit
Date: Wed,  8 Jul 2015 17:14:36 +0200
Message-Id: <1436368476-30592-1-git-send-email-jthumshirn@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Destroy cxl_adapter_idr on module exit, reclaiming the allocated memory.

This was detected by the following semantic patch (written by Luis Rodriguez
<mcgrof@suse.com>)
<SmPL>
@ defines_module_init @
declarer name module_init, module_exit;
declarer name DEFINE_IDR;
identifier init;
@@

module_init(init);

@ defines_module_exit @
identifier exit;
@@

module_exit(exit);

@ declares_idr depends on defines_module_init && defines_module_exit @
identifier idr;
@@

DEFINE_IDR(idr);

@ on_exit_calls_destroy depends on declares_idr && defines_module_exit @
identifier declares_idr.idr, defines_module_exit.exit;
@@

exit(void)
{
 ...
 idr_destroy(&idr);
 ...
}

@ missing_module_idr_destroy depends on declares_idr && defines_module_exit && !on_exit_calls_destroy @
identifier declares_idr.idr, defines_module_exit.exit;
@@

exit(void)
{
 ...
 +idr_destroy(&idr);
}
</SmPL>

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/misc/cxl/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index 833348e..4e58e0b 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -222,6 +222,7 @@ static void exit_cxl(void)
 	cxl_debugfs_exit();
 	cxl_file_exit();
 	unregister_cxl_calls(&cxl_calls);
+	idr_destroy(&cxl_adapter_idr);
 }
 
 module_init(init_cxl);
-- 
2.4.3
