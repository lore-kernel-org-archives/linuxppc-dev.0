Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
 [209.85.161.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHBbX25xkzDqmw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:44:40 +1000 (AEST)
Received: by mail-yw0-f196.google.com with SMTP id u207so3655624ywc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 14:44:40 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/4] powerpc: pseries: remove dlpar_attach_node dependency on
 full path
Date: Tue, 25 Jul 2017 16:44:25 -0500
Message-Id: <20170725214427.25768-3-robh@kernel.org>
In-Reply-To: <20170725214427.25768-1-robh@kernel.org>
References: <20170725214427.25768-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation to stop storing the full node path in full_name, remove the
dependency on full_name from dlpar_attach_node(). Callers of
dlpar_attach_node() already have the parent device_node, so just pass the
parent node into dlpar_attach_node instead of the path. This avoids doing
a lookup of the parent node by the path.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/pseries/dlpar.c       | 6 ++----
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
 arch/powerpc/platforms/pseries/mobility.c    | 2 +-
 arch/powerpc/platforms/pseries/pseries.h     | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 80b84c9c8509..783f36364690 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -254,13 +254,11 @@ struct device_node *dlpar_configure_connector(__be32 drc_index,
 	return first_dn;
 }
 
-int dlpar_attach_node(struct device_node *dn)
+int dlpar_attach_node(struct device_node *dn, struct device_node *parent)
 {
 	int rc;
 
-	dn->parent = pseries_of_derive_parent(dn->full_name);
-	if (IS_ERR(dn->parent))
-		return PTR_ERR(dn->parent);
+	dn->parent = parent;
 
 	rc = of_attach_node(dn);
 	if (rc) {
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 0a93093fbcef..b357f1ae0b0a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -463,7 +463,7 @@ static ssize_t dlpar_cpu_add(u32 drc_index)
 		return -EINVAL;
 	}
 
-	rc = dlpar_attach_node(dn);
+	rc = dlpar_attach_node(dn, parent);
 	if (rc) {
 		saved_rc = rc;
 		pr_warn("Failed to attach node %s, rc: %d, drc index: %x\n",
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 2da4851eff99..210ce632d63e 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -229,7 +229,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 	if (!dn)
 		return -ENOENT;
 
-	rc = dlpar_attach_node(dn);
+	rc = dlpar_attach_node(dn, parent_dn);
 	if (rc)
 		dlpar_free_cc_nodes(dn);
 
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 1361a9db534b..4470a3194311 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -46,7 +46,7 @@ extern void dlpar_free_cc_nodes(struct device_node *);
 extern void dlpar_free_cc_property(struct property *);
 extern struct device_node *dlpar_configure_connector(__be32,
 						struct device_node *);
-extern int dlpar_attach_node(struct device_node *);
+extern int dlpar_attach_node(struct device_node *, struct device_node *);
 extern int dlpar_detach_node(struct device_node *);
 extern int dlpar_acquire_drc(u32 drc_index);
 extern int dlpar_release_drc(u32 drc_index);
-- 
2.11.0
