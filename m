Return-Path: <Deepak_Saxena@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "relay1.mentorg.com",
	Issuer "Entrust Certification Authority - L1B" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2A01FB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 06:43:21 +1100 (EST)
Date: Wed, 8 Dec 2010 11:29:33 -0800
From: Deepak Saxena <deepak_saxena@mentor.com>
To: devicetree-discuss@ozlabs.org
Subject: [PATCH 5/5] of/device: Show even unavailable nodes in procfs
Message-ID: <20101208192933.GD32473@mentor.com>
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

Use the new "raw" of_get_next_child() variant so all device tree nodes
will appear in procfs.

Signed-off-by: Hollis Blanchard <hollis_blanchard@mentor.com>
Signed-off-by: Deepak Saxena <deepak_saxena@mentor.com>
---
 fs/proc/proc_devtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index d9396a4..aa914eb 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -188,7 +188,7 @@ void proc_device_tree_add_node(struct device_node *np,
 	const char *p;
 
 	set_node_proc_entry(np, de);
-	for (child = NULL; (child = of_get_next_child(np, child));) {
+	for (child = NULL; (child = _of_get_next_child(np, child));) {
 		/* Use everything after the last slash, or the full name */
 		p = strrchr(child->full_name, '/');
 		if (!p)
-- 
1.6.3.3
