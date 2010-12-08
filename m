Return-Path: <Deepak_Saxena@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8644CB7624
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 07:04:34 +1100 (EST)
Date: Wed, 8 Dec 2010 11:29:44 -0800
From: Deepak Saxena <deepak_saxena@mentor.com>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH 3/5] of/device: Make of_get_next_child() check status
	properties
Message-ID: <20101208192944.GE32473@mentor.com>
References: <cover.1291799069.git.deepak_saxena@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1291799069.git.deepak_saxena@mentor.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We only return the next child if the device is available.

Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
---
 drivers/of/base.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 5d269a4..81b2601 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -321,6 +321,8 @@ struct device_node *of_get_next_parent(struct device_node *node)
  *
  *	Returns a node pointer with refcount incremented, use
  *	of_node_put() on it when done.
+ *
+ *	Does not return nodes marked unavailable by a status property.
  */
 struct device_node *of_get_next_child(const struct device_node *node,
 	struct device_node *prev)
@@ -330,7 +332,7 @@ struct device_node *of_get_next_child(const struct device_node *node,
 	read_lock(&devtree_lock);
 	next = prev ? prev->sibling : node->child;
 	for (; next; next = next->sibling)
-		if (of_node_get(next))
+		if (of_device_is_available(next) && of_node_get(next))
 			break;
 	of_node_put(prev);
 	read_unlock(&devtree_lock);
-- 
1.6.3.3
