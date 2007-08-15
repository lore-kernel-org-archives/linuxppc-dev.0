Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 708A5DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 16:45:17 +1000 (EST)
Date: Wed, 15 Aug 2007 16:45:15 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Remove get_property and device_is_compatible
Message-Id: <20070815164515.44233b66.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

They were only needed for backwards compatibility and all in tree uses
have now been changed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/prom.h |    1 -
 include/asm-ppc/prom.h     |    1 -
 include/linux/of.h         |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6720837..920b756 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -145,7 +145,6 @@ extern void of_detach_node(struct device_node *);
 extern void finish_device_tree(void);
 extern void unflatten_device_tree(void);
 extern void early_init_devtree(void *);
-#define device_is_compatible(d, c)	of_device_is_compatible((d), (c))
 extern int machine_is_compatible(const char *compat);
 extern void print_properties(struct device_node *node);
 extern int prom_n_intr_cells(struct device_node* np);
diff --git a/include/asm-ppc/prom.h b/include/asm-ppc/prom.h
index 901f7fa..71f4c99 100644
--- a/include/asm-ppc/prom.h
+++ b/include/asm-ppc/prom.h
@@ -35,7 +35,6 @@ extern unsigned long sub_reloc_offset(unsigned long);
 #define machine_is_compatible(x)		0
 #define of_find_compatible_node(f, t, c)	NULL
 #define of_get_property(p, n, l)		NULL
-#define get_property(a, b, c)			of_get_property((a), (b), (c))
 
 #endif /* _PPC_PROM_H */
 #endif /* __KERNEL__ */
diff --git a/include/linux/of.h b/include/linux/of.h
index 47734ff..6df80e9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -54,7 +54,6 @@ extern int of_device_is_compatible(const struct device_node *device,
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
-#define get_property(a, b, c)	of_get_property((a), (b), (c))
 extern int of_n_addr_cells(struct device_node *np);
 extern int of_n_size_cells(struct device_node *np);
 
-- 
1.5.2.4
