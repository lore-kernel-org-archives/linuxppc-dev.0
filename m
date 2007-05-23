Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <b2142e4e32fc4da14a4044751ea38744afb6f3f9.1179907686.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/1] Update documentation for of_find_node_by_type()
Date: Wed, 23 May 2007 18:08:13 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The documentation for of_find_node_by_type() incorrectly refers to the
"name" parameter - it should be "type".

Also the behaviour when from == NULL is not really documented, fix that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/prom.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c065b55..a589b42 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1171,11 +1171,12 @@ EXPORT_SYMBOL(of_find_node_by_name);
 
 /**
  *	of_find_node_by_type - Find a node by its "device_type" property
- *	@from:	The node to start searching from or NULL, the node
- *		you pass will not be searched, only the next one
- *		will; typically, you pass what the previous call
- *		returned. of_node_put() will be called on it
- *	@name:	The type string to match against
+ *	@from:	The node to start searching from, or NULL to start searching
+ *		the entire device tree. The node you pass will not be
+ *		searched, only the next one will; typically, you pass
+ *		what the previous call returned. of_node_put() will be
+ *		called on from for you.
+ *	@type:	The type string to match against
  *
  *	Returns a node pointer with refcount incremented, use
  *	of_node_put() on it when done.
-- 
1.5.1.3.g7a33b
