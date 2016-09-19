Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scxBP2sDbzDsd8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:49 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8J6XLYV082376
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 02:41:47 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25h059wg3f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 02:41:47 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 19 Sep 2016 16:41:45 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 761582CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8J6fgbc64094442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8J6fgZs001255
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:42 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u8J6fgQi001247
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:42 +1000
Received: from ajd.ozlabs.ibm.com. (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id ED0C4A01F3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Sep 2016 16:41:41 +1000 (AEST)
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: fix memory leak in queue_hotplug_event()
 error path
Date: Mon, 19 Sep 2016 16:41:32 +1000
Message-Id: <20160919064132.28760-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we fail to allocate work, we don't end up using hp_errlog_copy. Free it
in the error path.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Found by Coverity Scan. Compile tested only.
---
 arch/powerpc/platforms/pseries/dlpar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 4748124..6a99e72 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -413,6 +413,7 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
 		queue_work(pseries_hp_wq, (struct work_struct *)work);
 	} else {
 		*rc = -ENOMEM;
+		kfree(hp_errlog_copy);
 		complete(hotplug_done);
 	}
 }
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
