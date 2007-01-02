Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 5A54EDDE49
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 23:49:35 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] sound: aoa of_node_put and kfree cleanup
Date: Tue, 2 Jan 2007 13:50:57 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701021350.57816.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

	This patch removes redundant argument checks for of_node_put() and kfree().

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 sound/aoa/fabrics/snd-aoa-fabric-layout.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
--- linux-2.6.20-rc2-mm1-a/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2006-12-28 12:57:54.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007-01-02 01:50:26.000000000 +0100
@@ -1034,9 +1034,9 @@ static int aoa_fabric_layout_probe(struc
 	list_del(&ldev->list);
 	layouts_list_items--;
  outnodev:
- 	if (sound) of_node_put(sound);
+ 	of_node_put(sound);
  	layout_device = NULL;
- 	if (ldev) kfree(ldev);
+ 	kfree(ldev);
 	return -ENODEV;
 }
 


-- 
Regards,

	Mariusz Kozlowski
