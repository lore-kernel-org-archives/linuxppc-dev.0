Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4740D1A074F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 11:42:13 +1000 (AEST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 21:42:10 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F33AE6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 21:33:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3U1g77C44761152
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 01:42:08 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3U1g648016527
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 21:42:06 -0400
Message-ID: <5541886E.2090207@linux.vnet.ibm.com>
Date: Wed, 29 Apr 2015 20:42:06 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/pseries: Correct cpu affinity for dlpar added cpus
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The incorrect ordering of operations during cpu dlpar add results in invalid
affinity for the cpu being added. The ibm,associativity property in the
device tree is populated with all zeroes for the added cpu which results in
invalid affinity mappings and all cpus appear to belong to node 0.

This occurs because rtas configure-connector is called prior to making the
rtas set-indicator calls. Phyp does not assign affinity information
for a cpu until the rtas set-indicator calls are made to set the isolation
and allocation state.

Correct the order of operations to make the rtas set-indicator
calls (done in dlpar_acquire_drc) before calling rtas configure-connector.

Fixes: 1a8061c46c46 ("powerpc/pseries: Add kernel based CPU DLPAR handling")

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index b4b1109..019d34a 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -412,6 +412,10 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 	if (rc)
 		return -EINVAL;
 
+	rc = dlpar_acquire_drc(drc_index);
+	if (rc)
+		return -EINVAL;
+
 	parent = of_find_node_by_path("/cpus");
 	if (!parent)
 		return -ENODEV;
@@ -422,12 +426,6 @@ static ssize_t dlpar_cpu_probe(const char *buf, size_t count)
 
 	of_node_put(parent);
 
-	rc = dlpar_acquire_drc(drc_index);
-	if (rc) {
-		dlpar_free_cc_nodes(dn);
-		return -EINVAL;
-	}
-
 	rc = dlpar_attach_node(dn);
 	if (rc) {
 		dlpar_release_drc(drc_index);
