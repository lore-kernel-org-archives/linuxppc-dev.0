Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 15478DDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:10:06 +1000 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 75] drivers/macintosh/therm_adt746x.c: kmalloc + memset
	conversion to kzalloc
Date: Wed, 1 Aug 2007 00:10:03 +0200
References: <200707311845.48807.m.kozlowski@tuxland.pl>
In-Reply-To: <200707311845.48807.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200708010010.03964.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	kernel-janitors@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 drivers/macintosh/therm_adt746x.c | 17298 -> 17244 (-54 bytes)

 drivers/macintosh/therm_adt746x.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.23-rc1-mm1-a/drivers/macintosh/therm_adt746x.c	2007-07-26 13:07:42.000000000 +0200
+++ linux-2.6.23-rc1-mm1-b/drivers/macintosh/therm_adt746x.c	2007-07-31 11:18:55.000000000 +0200
@@ -379,13 +379,10 @@ static int attach_one_thermostat(struct
 	if (thermostat)
 		return 0;

-	th = (struct thermostat *)
-		kmalloc(sizeof(struct thermostat), GFP_KERNEL);
-
+	th = kzalloc(sizeof(struct thermostat), GFP_KERNEL);
 	if (!th)
 		return -ENOMEM;

-	memset(th, 0, sizeof(*th));
 	th->clt.addr = addr;
 	th->clt.adapter = adapter;
 	th->clt.driver = &thermostat_driver;
