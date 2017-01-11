Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzFl10v1kzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 04:10:19 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0BH9Tnu136247
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:10:14 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27wkk7fdy6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:10:14 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 11 Jan 2017 10:10:13 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0A3C11FF0028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 10:09:49 -0700 (MST)
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0BHA9YI37355546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 17:10:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4DAF28048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:10:10 -0500 (EST)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP id A18072803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 12:10:10 -0500 (EST)
Subject: [PATCH] powerpc/pseries: Report DLPAR capabilities
To: linuxppc-dev@lists.ozlabs.org
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2017 12:00:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20170111170058.10550.91156.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we add the ability to do DLPAR of additional devices through
the sysfs interface we need to know which devices are supported.
This adds the reporting of supported devices with a comma separated
list reported in the existing /sys/kernel/dlpar.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dlpar.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 76caa4a..1152590 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -551,7 +551,13 @@ static ssize_t dlpar_store(struct class *class, struct class_attribute *attr,
 	return rc ? rc : count;
 }
 
-static CLASS_ATTR(dlpar, S_IWUSR, NULL, dlpar_store);
+static ssize_t dlpar_show(struct class *class, struct class_attribute *attr,
+			  char *buf)
+{
+	return sprintf(buf, "%s\n", "memory,cpu");
+}
+
+static CLASS_ATTR(dlpar, S_IWUSR | S_IRUSR, dlpar_show, dlpar_store);
 
 static int __init pseries_dlpar_init(void)
 {
