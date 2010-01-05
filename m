Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFD58B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jan 2010 22:07:53 +1100 (EST)
Date: Tue, 5 Jan 2010 19:49:02 +0900
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix pseries/dlpar compile warning without
	CONFIG_PROC_DEVICETREE
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100105194830S.fujita.tomonori@lab.ntt.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cc1: warnings being treated as errors
arch/powerpc/platforms/pseries/dlpar.c: In function 'dlpar_attach_node':
arch/powerpc/platforms/pseries/dlpar.c:239: error: unused variable 'ent'
arch/powerpc/platforms/pseries/dlpar.c: In function 'dlpar_detach_node':
arch/powerpc/platforms/pseries/dlpar.c:271: error: unused variable 'prop'
arch/powerpc/platforms/pseries/dlpar.c:270: error: unused variable 'parent'
make[3]: *** [arch/powerpc/platforms/pseries/dlpar.o] Error 1

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/platforms/pseries/dlpar.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 67b7a10..3bd8df8 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -236,7 +236,9 @@ static struct device_node *derive_parent(const char *path)
 
 int dlpar_attach_node(struct device_node *dn)
 {
+#ifdef CONFIG_PROC_DEVICETREE
 	struct proc_dir_entry *ent;
+#endif
 	int rc;
 
 	of_node_set_flag(dn, OF_DYNAMIC);
@@ -267,10 +269,10 @@ int dlpar_attach_node(struct device_node *dn)
 
 int dlpar_detach_node(struct device_node *dn)
 {
+#ifdef CONFIG_PROC_DEVICETREE
 	struct device_node *parent = dn->parent;
 	struct property *prop = dn->properties;
 
-#ifdef CONFIG_PROC_DEVICETREE
 	while (prop) {
 		remove_proc_entry(prop->name, dn->pde);
 		prop = prop->next;
-- 
1.5.6.5
