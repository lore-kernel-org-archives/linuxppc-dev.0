Return-Path: <arnd@arndb.de>
Message-Id: <20071218175106.115180000@arndb.de>
References: <20071218174852.112644000@arndb.de>
Date: Tue, 18 Dec 2007 18:49:05 +0100
From: arnd@arndb.de
To: paulus@samba.org
Subject: [POWERPC 13/18] cell: safer of_has_vicinity routine
Cc: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, Andre Detsch <adetsch@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the way we check for the existence of
vicinity property in spe device nodes.

The new implementation does not depend on having an initialized
cbe_spu_info[0].spus, and checks for presence of vicinity in all
nodes, not only in the first one.

Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spu_manage.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6-new/arch/powerpc/platforms/cell/spu_manage.c
===================================================================
--- linux-2.6-new.orig/arch/powerpc/platforms/cell/spu_manage.c
+++ linux-2.6-new/arch/powerpc/platforms/cell/spu_manage.c
@@ -422,10 +422,15 @@ static void init_affinity_qs20_harcoded(
 
 static int of_has_vicinity(void)
 {
-	struct spu* spu;
+	struct device_node *dn;
 
-	spu = list_first_entry(&cbe_spu_info[0].spus, struct spu, cbe_list);
-	return of_find_property(spu_devnode(spu), "vicinity", NULL) != NULL;
+	for_each_node_by_type(dn, "spe") {
+		if (of_find_property(dn, "vicinity", NULL))  {
+			of_node_put(dn);
+			return 1;
+		}
+	}
+	return 0;
 }
 
 static struct spu *devnode_spu(int cbe, struct device_node *dn)

-- 
