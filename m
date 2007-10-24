Return-Path: <michael@ozlabs.org>
To: <adaplas@gmail.com>
Message-Id: <b05af1671aecaccf02242108b71046b1f1547e64.1193199944.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Use of_get_next_child() in riva_get_EDID_OF()
Date: Wed, 24 Oct 2007 14:26:22 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

riva_get_EDID_OF() uses its own hand-rolled loop to check a nodes
children for a property, this is not safe WRT refcounting, so fix it
to use of_get_next_child().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/video/riva/fbdev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index 5c47968..07b6b2d 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1759,7 +1759,10 @@ static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 
 	NVTRACE_ENTER();
 	dp = pci_device_to_OF_node(pd);
-	for (; dp != NULL; dp = dp->child) {
+
+	for (dp = of_get_next_child(dp, NULL);
+	     dp != NULL;
+	     dp = of_get_next_child(dp, dp)) {
 		disptype = of_get_property(dp, "display-type", NULL);
 		if (disptype == NULL)
 			continue;
-- 
1.5.1.3.g7a33b
