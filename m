Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 43D39DDE40
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 00:32:59 +1000 (EST)
Date: Sun, 22 Jul 2007 00:33:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] init and exit markings for hvc_iseries
Message-Id: <20070722003311.665a837b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_iseries.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Built for PowerPC allmodconfig and ppc64_defconfig.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/char/hvc_iseries.c b/drivers/char/hvc_iseries.c
index b37f1d5..a08f8f9 100644
--- a/drivers/char/hvc_iseries.c
+++ b/drivers/char/hvc_iseries.c
@@ -472,7 +472,7 @@ static void hvc_handle_event(struct HvLpEvent *event)
 	}
 }
 
-static int send_open(HvLpIndex remoteLp, void *sem)
+static int __init send_open(HvLpIndex remoteLp, void *sem)
 {
 	return HvCallEvent_signalLpEventFast(remoteLp,
 			HvLpEvent_Type_VirtualIo,
@@ -484,7 +484,7 @@ static int send_open(HvLpIndex remoteLp, void *sem)
 			0, 0, 0, 0);
 }
 
-static int hvc_vio_init(void)
+static int __init hvc_vio_init(void)
 {
 	atomic_t wait_flag;
 	int rc;
@@ -552,14 +552,14 @@ static int hvc_vio_init(void)
 }
 module_init(hvc_vio_init); /* after drivers/char/hvc_console.c */
 
-static void hvc_vio_exit(void)
+static void __exit hvc_vio_exit(void)
 {
 	vio_unregister_driver(&hvc_vio_driver);
 }
 module_exit(hvc_vio_exit);
 
 /* the device tree order defines our numbering */
-static int hvc_find_vtys(void)
+static int __init hvc_find_vtys(void)
 {
 	struct device_node *vty;
 	int num_found = 0;
-- 
1.5.2.3
