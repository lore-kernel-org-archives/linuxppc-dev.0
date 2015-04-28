Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 594851A0211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 01:37:59 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 11:37:56 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EAF6138C8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 11:37:50 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SFbo1v60162194
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 15:37:50 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SFboM2022004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 11:37:50 -0400
Received: from [9.76.45.100] (sig-9-76-45-100.ibm.com [9.76.45.100])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t3SFbnsx021938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 11:37:50 -0400
Message-ID: <553FA94D.2000608@linux.vnet.ibm.com>
Date: Tue, 28 Apr 2015 10:37:49 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Correct cpu affinity for dlpar added cpus
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The incorrect ordering of operations during cpu dlpar causes the affinity
of cpus being added to be invalid. Phyp does not assign affinity information
for a cpu until the rtas set-indicator calls are made to set the isolation
and allocation state. In the current code we call rtas configure-connector
before making the set-indicator calls which results in invalid data in the
ibm,associativity property for the cpu we're adding.

This patch corrects the order of operations to make the set-indicator
calls (done in acquire_drc) before calling configure-connector.

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
