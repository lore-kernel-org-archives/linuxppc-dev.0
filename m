Return-Path: <srs0=usgk=dq=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1cCQ1mGLzF07j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:10:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3z1cCP3b6yz8vm8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 12:10:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3z1cCN4QJmz9t2f
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2017 12:10:40 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK18jxl106047
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 20:10:38 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eyc76c5vj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2017 20:10:38 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 19 Dec 2017 20:10:37 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] vas: vas_window_init_dbgdir: fix order of cleanup.
Date: Tue, 19 Dec 2017 17:10:29 -0800
In-Reply-To: <1513732229-10066-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1513732229-10066-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1513732229-10066-2-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the order of cleanup to ensure we free the name buffer in case
of an error creating 'hvwc' or 'info' files.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/vas-debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-debug.c b/arch/powerpc/platforms/powernv/vas-debug.c
index ca22f1e..b4de4c6 100644
--- a/arch/powerpc/platforms/powernv/vas-debug.c
+++ b/arch/powerpc/platforms/powernv/vas-debug.c
@@ -166,13 +166,13 @@ void vas_window_init_dbgdir(struct vas_window *window)
 
 	return;
 
-free_name:
-	kfree(window->dbgname);
-	window->dbgname = NULL;
-
 remove_dir:
 	debugfs_remove_recursive(window->dbgdir);
 	window->dbgdir = NULL;
+
+free_name:
+	kfree(window->dbgname);
+	window->dbgname = NULL;
 }
 
 void vas_instance_init_dbgdir(struct vas_instance *vinst)
-- 
2.7.4
