Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <9ac0032bf8356ff6e41b0860b6f67dddf9bda2f5.1182233192.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/3] Check for the root node in of_detach_node()
Date: Tue, 19 Jun 2007 16:07:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's not sensible to call of_detach_node() on the root node,
but we should check for it just to be safe.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index af42dda..6ea94cf 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1432,6 +1432,8 @@ void of_detach_node(const struct device_node *np)
 	write_lock(&devtree_lock);
 
 	parent = np->parent;
+	if (!parent)
+		goto out_unlock;
 
 	if (allnodes == np)
 		allnodes = np->allnext;
@@ -1455,6 +1457,7 @@ void of_detach_node(const struct device_node *np)
 		prevsib->sibling = np->sibling;
 	}
 
+out_unlock:
 	write_unlock(&devtree_lock);
 }
 
-- 
1.5.1.3.g7a33b
