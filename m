Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbcjm5blgzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:17:00 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id p62so5690049oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 08:17:00 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Subject: [PATCH v2 2/5] powerpc: pseries: vio: match parent nodes with
 of_find_node_by_path
Date: Mon, 21 Aug 2017 10:16:48 -0500
Message-Id: <20170821151651.25096-3-robh@kernel.org>
In-Reply-To: <20170821151651.25096-1-robh@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
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
v2:
- rebased to linux-next and removed spurious change fro patch 1.

 arch/powerpc/platforms/pseries/vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index aa5ca74316fa..5754572deb23 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1357,9 +1357,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	 */
 	parent_node = of_get_parent(of_node);
 	if (parent_node) {
-		if (!strcmp(parent_node->full_name, "/ibm,platform-facilities"))
+		if (parent_node == of_find_node_by_path("/ibm,platform-facilities"))
 			family = PFO;
-		else if (!strcmp(parent_node->full_name, "/vdevice"))
+		else if (parent_node == of_find_node_by_path("/vdevice"))
 			family = VDEVICE;
 		else {
 			pr_warn("%s: parent(%pOF) of %s not recognized.\n",
-- 
2.11.0
