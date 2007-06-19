Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9a9e13609d106a224005981d3469af14cb6fd738.1182233192.git.michael@ellerman.id.au>
In-Reply-To: <9ac0032bf8356ff6e41b0860b6f67dddf9bda2f5.1182233192.git.michael@ellerman.id.au>
References: <9ac0032bf8356ff6e41b0860b6f67dddf9bda2f5.1182233192.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/3] Add a warning to help trackdown device_node refcounting
	bugs
Date: Tue, 19 Jun 2007 16:08:00 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When the refcount for a device node goes to 0, we call the
destructor - of_node_release(). This should only happen if we've
already detached the node from the device tree.

So add a flag OF_DETACHED which tracks detached-ness, and if we
find ourselves in of_node_release() without it set, issue a
warning and don't free the device_node. To avoid warning
continuously reinitialise the kref to a sane value.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
The warning looks something like the following. In this case it shows that
I erroneously did an of_node_put() inside the of_find_node_by_type() loop
in setup_arch().

WARNING: Bad of_node_put() on /memory@b8000000
Call Trace:
[c0000000007e3ba0] [c00000000000f74c] .show_stack+0x6c/0x1a0 (unreliable)
[c0000000007e3c40] [c00000000002397c] .of_node_release+0x44/0xe8
[c0000000007e3cd0] [c00000000021f4e0] .kref_put+0x74/0x94
[c0000000007e3d50] [c000000000022b34] .of_node_put+0x20/0x34
[c0000000007e3dc0] [c000000000022fcc] .of_find_node_by_type+0x90/0xc8
[c0000000007e3e50] [c00000000063ff78] .setup_arch+0x1b8/0x234
[c0000000007e3ee0] [c0000000006376ac] .start_kernel+0xd8/0x3e4
[c0000000007e3f90] [c0000000000084c8] .start_here_common+0x54/0x8c


 arch/powerpc/kernel/prom.c |   11 +++++++++++
 include/asm-powerpc/prom.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 4f70764..e0f61bb 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1375,8 +1375,17 @@ static void of_node_release(struct kref *kref)
 	struct device_node *node = kref_to_device_node(kref);
 	struct property *prop = node->properties;
 
+	/* We should never be releasing nodes that haven't been detached. */
+	if (!of_node_check_flag(node, OF_DETACHED)) {
+		printk("WARNING: Bad of_node_put() on %s\n", node->full_name);
+		dump_stack();
+		kref_init(&node->kref);
+		return;
+	}
+
 	if (!of_node_check_flag(node, OF_DYNAMIC))
 		return;
+
 	while (prop) {
 		struct property *next = prop->next;
 		kfree(prop->name);
@@ -1457,6 +1466,8 @@ void of_detach_node(const struct device_node *np)
 		prevsib->sibling = np->sibling;
 	}
 
+	of_node_set_flag(np, OF_DETACHED);
+
 out_unlock:
 	write_unlock(&devtree_lock);
 }
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6eb98aa..01b27f2 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -99,6 +99,7 @@ extern struct device_node *of_chosen;
 
 /* flag descriptions */
 #define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
+#define OF_DETACHED	2 /* node has been detached from the device tree */
 
 static inline int of_node_check_flag(struct device_node *n, unsigned long flag)
 {
-- 
1.5.1.3.g7a33b
