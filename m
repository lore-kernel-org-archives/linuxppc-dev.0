Return-Path: <dbaryshkov@gmail.com>
Date: Tue, 31 May 2011 17:17:37 +0400
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
Subject: PCI EDAC on MPC85xx
Message-ID: <20110531131737.GA29164@doriath.ww600.siemens.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Long time ago (around July of 2010), I've reported a problem of binding
pci error reporting driver to the hardware (See
http://thread.gmane.org/gmane.linux.kernel.edac/181). Grant Likely has
come with a patch to create platform devices (of_platform at that time),
for device_nodes which have "compatible" properties
(http://article.gmane.org/gmane.linux.ports.ppc.embedded/36981).

The patch was not applied at that time and the problem still arises at
3.0-rc1. Should the patch in question be applied, or is there any new
solution?
Current version of that patch which I have in my tree is attached
to this mail (no original signoff by Grant).

-- 
With best wishes
Dmitry


--LQksG6bCIzRHxTLp
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-of-device-Register-children-with-a-compatible-value-.patch"

>From 511ce78e6aeeb9562cff0f0bbc186419b53bc209 Mon Sep 17 00:00:00 2001
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Jul 2010 13:01:11 -0600
Subject: [PATCH] of/device: Register children with a compatible value in
 of_platform_bus_probe()

Currently, of_platform_bus_probe() completely skips nodes which do not
explicitly match the 'matches' table passed in.  Or, if the root node
matches, then it registers all the children unconditionally.  However,
there are situations, such as registering devices from the root node,
when it is desirable to register child nodes, but only if they actually
represent devices.  For example, the root node may contain both a local
bus and a PCI device, but it also contains the chosen, aliases and cpus
nodes which don't represent real devices.

This patch changes of_platform_bus_probe() to register all nodes at the
top level if they either match the matches table (the current behaviour),
or if they have a 'compatible' value (indicating it represents a device).

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/of/platform.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 63d3cb7..80f0682 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -269,7 +269,18 @@ int of_platform_bus_probe(struct device_node *root,
 	if (of_match_node(matches, root)) {
 		rc = of_platform_bus_create(root, matches, parent);
 	} else for_each_child_of_node(root, child) {
-		if (!of_match_node(matches, child))
+
+		/* Register each child node if either:
+		 *  a) it has a 'compatible' value indicating they are a device, or
+		 *  b) it is specified by the 'matches' table (by name or device_type)
+		 * If a node is specified in the matches table, then all its children
+		 * also get registered.
+		 */
+		const void *compat = of_get_property(child, "compatible", NULL);
+		const struct of_device_id *match = of_match_node(matches, child);
+
+		/* Skip if node neither matches nor has a compatible property */
+		if (!compat && !match)
 			continue;
 		rc = of_platform_bus_create(child, matches, parent);
 		if (rc)
-- 
1.7.4.4


--LQksG6bCIzRHxTLp--
