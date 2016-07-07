Return-Path: <jallen@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlgsb3m2vzDqvS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 01:05:23 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67F4Mgq144620
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 11:05:21 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xn00q4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 11:05:21 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 09:05:20 -0600
Subject: [PATCH 3/3] powerpc/pseries: Use kernel hotplug queue for PowerVM
 hotplug events
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
From: John Allen <jallen@linux.vnet.ibm.com>
Date: Thu, 7 Jul 2016 10:05:52 -0500
MIME-Version: 1.0
In-Reply-To: <4cf3edf2-fc24-5989-ae5d-b451a2323cf2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4467d582-954a-23ca-af5e-75ddc1c99cee@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sysfs interface used to handle PowerVM hotplug events should use the
hotplug queue as well. PRRN events will soon be placing many hotplug
events on the queue at once and we will need ordinary hotplug events to
use the queue as well in order to ensure these events will still be handled
and that proper serialization is maintained during the PRRN event.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 66a77d7..4748124 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -489,7 +489,9 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 		goto dlpar_store_out;
 	}

-	rc = handle_dlpar_errorlog(hp_elog);
+	init_completion(&hotplug_done);
+	queue_hotplug_event(hp_elog, &hotplug_done, &rc);
+	wait_for_completion(&hotplug_done);

 dlpar_store_out:
 	kfree(hp_elog);
