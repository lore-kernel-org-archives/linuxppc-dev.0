Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 570B167B52
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 05:29:52 +1000 (EST)
Date: Tue, 12 Sep 2006 21:29:47 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060912192947.GA5084@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060911115354.GA23884@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Follow up to the previous patch:

Update the return values in i8402 and parport to -ENODEV.

---
 drivers/input/serio/i8042-io.h |    2 +-
 drivers/parport/parport_pc.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
===================================================================
--- linux-2.6.18-rc6.orig/drivers/input/serio/i8042-io.h
+++ linux-2.6.18-rc6/drivers/input/serio/i8042-io.h
@@ -69,7 +69,7 @@ static inline int i8042_platform_init(vo
  */
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(I8042_DATA_REG))
-		return -EBUSY;
+		return -ENODEV;
 #endif
 #if !defined(__sh__) && !defined(__alpha__) && !defined(__mips__)
 	if (!request_region(I8042_DATA_REG, 16, "i8042"))
Index: linux-2.6.18-rc6/drivers/parport/parport_pc.c
===================================================================
--- linux-2.6.18-rc6.orig/drivers/parport/parport_pc.c
+++ linux-2.6.18-rc6/drivers/parport/parport_pc.c
@@ -3376,7 +3376,7 @@ static int __init parport_pc_init(void)
 {
 #if defined(CONFIG_PPC_MERGE)
 	if (check_legacy_ioport(PARALLEL_BASE))
-		return -EBUSY;
+		return -ENODEV;
 #endif
 	if (parse_parport_params())
 		return -EINVAL;
