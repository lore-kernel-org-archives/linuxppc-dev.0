Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
 [209.85.161.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHBbT4JnPzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:44:37 +1000 (AEST)
Received: by mail-yw0-f194.google.com with SMTP id p68so3603521ywg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 14:44:37 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/4] powerpc: pseries: vio: match parent nodes with
 of_find_node_by_path
Date: Tue, 25 Jul 2017 16:44:24 -0500
Message-Id: <20170725214427.25768-2-robh@kernel.org>
In-Reply-To: <20170725214427.25768-1-robh@kernel.org>
References: <20170725214427.25768-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to remove the full path from device_node.full_name, use
of_find_node_by_path instead of open coding with strcmp.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 3201feb6d32b..28a9505e4919 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	 */
 	parent_node = of_get_parent(of_node);
 	if (parent_node) {
-		if (!strcmp(parent_node->full_name, "ibm,platform-facilities"))
+		if (parent_node == of_find_node_by_path("/ibm,platform-facilities"))
 			family = PFO;
-		else if (!strcmp(parent_node->full_name, "vdevice"))
+		else if (parent_node == of_find_node_by_path("/vdevice"))
 			family = VDEVICE;
 		else {
 			pr_warn("%s: parent(%pOF) of %s not recognized.\n",
-- 
2.11.0
