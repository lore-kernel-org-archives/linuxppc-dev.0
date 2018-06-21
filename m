Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41B2m14XLTzF12B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 10:35:13 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5L0Xkj8113184
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:35:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jqx1xxq5b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 20:35:11 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 20 Jun 2018 18:35:10 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <c7b0c1e5-7adf-299b-646f-6988b1fa0f8b@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 3/3] migration/memory: Support 'ibm,dynamic-memory-v2'
Date: Wed, 20 Jun 2018 19:35:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a0da0ec4-c9f3-ad20-82d1-2a5a1762a323@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migration/memory: This patch adds recognition for changes to the
associativity of memory blocks described by 'ibm,dynamic-memory-v2'
in order to update local and general kernel data structures to
reflect those changes.  This patch builds upon previous enhancements
that scan the device-tree properties to build an LMB array in memory
to reuse and evaluate that structure for the new property.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 2573b87..d390dd4 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1144,7 +1144,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 		err = pseries_remove_mem_node(rd->dn);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory") ||
+		    !strcmp(rd->prop->name, "ibm,dynamic-memory-v2")) {
 			struct drmem_lmb_info *dinfo =
 				drmem_lmbs_init(rd->prop);
 			if (!dinfo)
