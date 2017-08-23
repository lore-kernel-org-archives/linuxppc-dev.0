Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbzS4DQ6zDrWc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:47:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/vio: Use device_type to detect family
Date: Wed, 23 Aug 2017 15:47:13 +1000
Message-Id: <1503467233-12708-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently in the vio.c code we use a comparision against the parent
device node's full path to decide if the device is a PFO or VIO family
device.

Both the ibm,platform-facilities and vdevice nodes are defined by PAPR,
and must have a matching device_type. So instead of using the path we
can instead compare the device_type.

I've checked Qemu and kvmtool both do this correctly, and all the
PowerVM systems I have access to do also. So it seems to be safe.

This removes the dependency on full_name, which is being removed
upstream.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 8a47f168476b..f26f906e6021 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	 */
 	parent_node = of_get_parent(of_node);
 	if (parent_node) {
-		if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
+		if (!strcmp(parent_node->type, "ibm,platform-facilities"))
 			family = PFO;
-		else if (!strcmp(parent_node->full_name, "/vdevice"))
+		else if (!strcmp(parent_node->type, "vdevice"))
 			family = VDEVICE;
 		else {
 			pr_warn("%s: parent(%s) of %s not recognized.\n",
-- 
2.7.4
