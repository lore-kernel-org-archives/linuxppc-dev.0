Return-Path: <michael@ozlabs.org>
To: <lists@nerdbynature.de>
Message-Id: <0958c243b32f5f77028a794a9ce0d55f9a12121e.1274272289.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] device-tree: Drop properties with "/" in their name
Date: Wed, 19 May 2010 22:32:29 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some bogus firmwares include properties with "/" in their name. This
causes problems when creating the /proc/device-tree file system,
because the slash is taken to indicate a directory.

We don't care about those properties, and we don't want to encourage
them, so just throw them away when creating /proc/device-tree.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

Hi Christian, if you could test this new patch that'd be great, thanks!


 fs/proc/proc_devtree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index ce94801..d9396a4 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -209,6 +209,9 @@ void proc_device_tree_add_node(struct device_node *np,
 	for (pp = np->properties; pp != NULL; pp = pp->next) {
 		p = pp->name;
 
+		if (strchr(p, '/'))
+			continue;
+
 		if (duplicate_name(de, p))
 			p = fixup_name(np, de, p);
 
-- 
1.7.0.4
