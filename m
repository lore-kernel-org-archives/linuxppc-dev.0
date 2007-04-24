Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 833A0DDF09
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:52:59 +1000 (EST)
Date: Tue, 24 Apr 2007 13:49:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/5] [POWERPC] remove find_all_nodes
Message-Id: <20070424134947.cd2a9f3d.sfr@canb.auug.org.au>
In-Reply-To: <20070424134841.cee3ff4e.sfr@canb.auug.org.au>
References: <20070413171422.c19353e2.sfr@canb.auug.org.au>
	<20070424134841.cee3ff4e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This old interface has no more users.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   17 -----------------
 include/asm-powerpc/prom.h |    1 -
 2 files changed, 0 insertions(+), 18 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 2f7e6ec..911ec77 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1110,23 +1110,6 @@ struct device_node *find_type_devices(const char *type)
 }
 EXPORT_SYMBOL(find_type_devices);
 
-/**
- * Returns all nodes linked together
- */
-struct device_node *find_all_nodes(void)
-{
-	struct device_node *head, **prevp, *np;
-
-	prevp = &head;
-	for (np = allnodes; np != 0; np = np->allnext) {
-		*prevp = np;
-		prevp = &np->next;
-	}
-	*prevp = NULL;
-	return head;
-}
-EXPORT_SYMBOL(find_all_nodes);
-
 /** Checks if the given "compat" string matches one of the strings in
  * the device's "compatible" property
  */
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index c2bb8b5..38f7c3e 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -115,7 +115,6 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 extern struct device_node *find_devices(const char *name);
 extern struct device_node *find_type_devices(const char *type);
 extern struct device_node *find_path_device(const char *path);
-extern struct device_node *find_all_nodes(void);
 
 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,
-- 
1.5.1.1
