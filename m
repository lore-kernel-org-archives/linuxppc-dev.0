Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0CD62C0750
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:24:05 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 14 Aug 2013 23:24:04 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3F78E1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:18:35 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
 id r7F5O1eo183640
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:01 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7F5O0QM015195
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 23:24:01 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/pseries: child nodes are not detached by
 dlpar_detach_node
Date: Wed, 14 Aug 2013 22:23:52 -0700
Message-Id: <1376544232-24936-9-git-send-email-tyreld@linux.vnet.ibm.com>
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

Calls to dlpar_detach_node do not iterate over child nodes detaching them as
well. By iterating and detaching the child nodes we ensure that they have the
OF_DETACHED flag set and that their reference counts are decremented such that
the node will be freed from memory by of_node_release.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4ea667d..7cfdaae 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -286,8 +286,15 @@ int dlpar_attach_node(struct device_node *dn)
 
 int dlpar_detach_node(struct device_node *dn)
 {
+	struct device_node *child;
 	int rc;
 
+	child = of_get_next_child(dn, NULL);
+	while (child) {
+		dlpar_detach_node(child);
+		child = of_get_next_child(dn, child);
+	}
+
 	rc = of_detach_node(dn);
 	if (rc)
 		return rc;
-- 
1.7.12.4
