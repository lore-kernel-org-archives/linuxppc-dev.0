Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4A4D1DDF46
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 17:16:55 +1100 (EST)
Date: Wed, 17 Dec 2008 17:16:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH] powerpc/iseries: viodasd needs to depend on CONFIG_BLOCK
Message-Id: <20081217171649.f3cd7c96.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Otherwise you get lot of errors like these:

drivers/block/viodasd.c:72: error: dereferencing pointer to incomplete type
drivers/block/viodasd.c: In function 'viodasd_open':
drivers/block/viodasd.c:135: error: dereferencing pointer to incomplete type
drivers/block/viodasd.c: In function 'viodasd_release':
drivers/block/viodasd.c:184: error: dereferencing pointer to incomplete type
drivers/block/viodasd.c: In function 'viodasd_getgeo':
drivers/block/viodasd.c:209: error: dereferencing pointer to incomplete type
drivers/block/viodasd.c:214: error: implicit declaration of function 'get_capacity'
drivers/block/viodasd.c: At top level:
drivers/block/viodasd.c:222: error: variable 'viodasd_fops' has initializer but incomplete type
drivers/block/viodasd.c:223: error: unknown field 'owner' specified in initializer

Discovered by a randconfig build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 45ffd8e..ed3753d 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -9,6 +9,7 @@ menu "iSeries device drivers"
 
 config VIODASD
 	tristate "iSeries Virtual I/O disk support"
+	depends on BLOCK
 	help
 	  If you are running on an iSeries system and you want to use
 	  virtual disks created and managed by OS/400, say Y.
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
