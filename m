Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rCrx2LhczDr6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 10:22:41 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4N0KHuR046828
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j4vpva3th-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 20:22:39 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 18:22:38 -0600
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v5 7/7] migration/memory: Support 'ibm,dynamic-memory-v2'
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b9c98429-f3d7-1e6d-603f-6ac01225e400@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 19:22:33 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <5acb5dee-e514-3ab9-0f82-8272ddc7ac04@linux.vnet.ibm.com>
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
reflect those changes.  Support builds upon previous patches to
check for associativity changes in 'ibm,dynamic-memory'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index cdceb3e..ac329aa 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1139,7 +1139,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 		err = pseries_remove_mem_node(rd->dn);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory") ||
+		    !strcmp(rd->prop->name, "ibm,dynamic-memory-v2")) {
 			struct drmem_lmb_info *dinfo =
 				drmem_lmbs_init(rd->prop);
 			if (!dinfo)
