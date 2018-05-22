Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rBr85mlfzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 09:36:56 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MNYK4t111100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:36:55 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4qqvckvr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:36:54 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 17:36:54 -0600
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [RFC v5 5/6] powerpc/mobility: Add lock/unlock device hotplug
In-Reply-To: <4b1138ff-4ca0-bdce-26cc-b42191258017@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 18:36:50 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b50abd93-5ced-d6b5-8f5f-a3eac0a507b2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/mobility: Add device lock/unlock to PowerPC 'mobility' operation
to delay the operation of CPU DLPAR work queue operations by the 'readd'
activity until after any changes to the corresponding device-tree
properties have been written.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a..6d98f84 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -283,6 +283,8 @@ int pseries_devicetree_update(s32 scope)
 	if (!rtas_buf)
 		return -ENOMEM;
 
+	lock_device_hotplug();
+
 	do {
 		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
 		if (rc && rc != 1)
@@ -321,6 +323,7 @@ int pseries_devicetree_update(s32 scope)
 	} while (rc == 1);
 
 	kfree(rtas_buf);
+	unlock_device_hotplug();
 	return rc;
 }
 
