Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ddbfea5b1932c224845e3441b115cf7c3e495deb.1180961962.git.michael@ellerman.id.au>
In-Reply-To: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] Add for_each_compatible_node()
Date: Mon,  4 Jun 2007 23:00:02 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 include/asm-powerpc/prom.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6845af9..1122a92 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -124,6 +124,9 @@ extern struct device_node *of_find_node_by_type(struct device_node *from,
 	     dn = of_find_node_by_type(dn, type))
 extern struct device_node *of_find_compatible_node(struct device_node *from,
 	const char *type, const char *compat);
+#define for_each_compatible_node(dn, type, compatible) \
+	for (dn = of_find_compatible_node(NULL, type, compatible); dn; \
+	     dn = of_find_compatible_node(dn, type, compatible))
 extern struct device_node *of_find_node_by_path(const char *path);
 extern struct device_node *of_find_node_by_phandle(phandle handle);
 extern struct device_node *of_find_all_nodes(struct device_node *prev);
-- 
1.5.1.3.g7a33b-dirty
