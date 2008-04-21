Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E09DBDE41F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:03:05 +1000 (EST)
Subject: [PATCH] sysdev,mv64x60: early console fix
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>, Dale Farnsworth <dale@farnsworth.org>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 14:02:56 -0700
Message-Id: <1208811777.5789.86.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MPSC driver and prpmc2800.dts have been modified to
use property 'cell-index' as the serial port number but 
the early serial console driver for the mv64x60 has not 
been modified to use this new property.

Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)
---

 arch/powerpc/sysdev/mv64x60_udbg.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mv64x60_udbg.c b/arch/powerpc/sysdev/mv64x60_udbg.c
index ccdb3b0..2792dc8 100644
--- a/arch/powerpc/sysdev/mv64x60_udbg.c
+++ b/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -94,7 +94,7 @@ static void mv64x60_udbg_init(void)
 	if (!np)
 		return;
 
-	block_index = of_get_property(np, "block-index", NULL);
+	block_index = of_get_property(np, "cell-index", NULL);
 	if (!block_index)
 		goto error;
 
