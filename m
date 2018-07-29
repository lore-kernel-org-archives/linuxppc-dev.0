Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41djlf1jJjzF132
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 23:11:57 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6TD8ltW015388
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:11:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kh5qk3t22-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jul 2018 09:11:54 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sun, 29 Jul 2018 07:11:54 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mobility: Fix node detach/rename problem
Date: Sun, 29 Jul 2018 08:11:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <c2fba52a-baac-25fb-c26b-c84b25c3178c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During LPAR migration, the content of the device tree/sysfs may
be updated including deletion and replacement of nodes in the
tree.  When nodes are added to the internal node structures, they
are appended in FIFO order to a list of nodes maintained by the
OF code APIs.  When nodes are removed from the device tree, they
are marked OF_DETACHED, but not actually deleted from the system
to allow for pointers cached elsewhere in the kernel.  The order
and content of the entries in the list of nodes is not altered,
though.

During LPAR migration some common nodes are deleted and re-added
e.g. "ibm,platform-facilities".  If a node is re-added to the OF
node lists, the of_attach_node function checks to make sure that
the name + ibm,phandle of the to-be-added data is unique.  As the
previous copy of a re-added node is not modified beyond the addition
of a bit flag, the code (1) finds the old copy, (2) prints a WARNING
notice to the console, (3) renames the to-be-added node to avoid
filename collisions within a directory, and (3) adds entries to
the sysfs/kernfs.

This patch fixes the 'migration add' problem by changing the
stored 'phandle' of the OF_DETACHed node to 0 (reserved value for
of_find_node_by_phandle), so that subsequent re-add operations,
such as those during migration, do not find the detached node,
do not observe duplicate names, do not rename them,  and the
extra WARNING notices are removed from the console output.

In addition, it erases the 'name' field of the OF_DETACHED node,
to prevent any future calls to of_find_node_by_name() or
of_find_node_by_path() from matching this node.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 2de0f0d..9d82c28 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -274,6 +274,9 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	dn->phandle = 0;
+	memset(dn->name, 0, strlen(dn->name));
+
 	return 0;
 }
 
