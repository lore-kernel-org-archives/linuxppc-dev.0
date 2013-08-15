Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6198F2C049F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:06 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:04 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B03063E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:23:36 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5O0CW151752
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:00 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5Nx9G015163
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:00 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] powerpc/pseries: do all node initialization in
 dlpar_parse_cc_node
Date: Wed, 14 Aug 2013 22:23:49 -0700
Message-Id: <1376544232-24936-6-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1376544232-24936-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the OF_DYNAMIC and kref initialization for a node happens in
dlpar_attach_node. However, a node passed to dlpar_attach_node may be a tree
containing child nodes, and no initialization traversal is done on the
tree. Since the children never get their kref initialized or the OF_DYNAMIC
flag set these nodes are prevented from ever being released from memory
should they become detached. This initialization step is better done at the
time each node is allocated in dlpar_parse_cc_node.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index a1a7b9a..c855233 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -83,6 +83,9 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa)
 		return NULL;
 	}
 
+	of_node_set_flag(dn, OF_DYNAMIC);
+	kref_init(&dn->kref);
+
 	return dn;
 }
 
@@ -256,8 +259,6 @@ int dlpar_attach_node(struct device_node *dn)
 {
 	int rc;
 
-	of_node_set_flag(dn, OF_DYNAMIC);
-	kref_init(&dn->kref);
 	dn->parent = derive_parent(dn->full_name);
 	if (!dn->parent)
 		return -ENOMEM;
-- 
1.7.12.4
