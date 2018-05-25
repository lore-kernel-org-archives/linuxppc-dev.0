Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sWW86RB0zF1Sn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:48 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4P3AF3S083206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:46 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j6abcr0rp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 23:11:46 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Fri, 25 May 2018 04:11:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w4P3Bglp6750550
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:11:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 469624203F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:21 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E908B42042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:20 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 04:02:20 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 63BFAA0253
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 13:11:40 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 03/13] powerpc/eeh: Fix use-after-release of EEH driver
Date: Fri, 25 May 2018 13:11:30 +1000
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
In-Reply-To: <cover.1527217866.git.sbobroff@linux.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
Message-Id: <e50359f9211fcdc342401806ab65aa092c63e7b9.1527217866.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct two cases where eeh_pcid_get() is used to reference the driver's
module but the reference is dropped before the driver pointer is used.

In eeh_rmv_device() also refactor a little so that only two calls to
eeh_pcid_put() are needed, rather than three and the reference isn't
taken at all if it wasn't needed.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/kernel/eeh_driver.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 07e0a42035ce..54333f6c9d67 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -458,9 +458,11 @@ static void *eeh_add_virt_device(void *data, void *userdata)
 
 	driver = eeh_pcid_get(dev);
 	if (driver) {
-		eeh_pcid_put(dev);
-		if (driver->err_handler)
+		if (driver->err_handler) {
+			eeh_pcid_put(dev);
 			return NULL;
+		}
+		eeh_pcid_put(dev);
 	}
 
 #ifdef CONFIG_PCI_IOV
@@ -497,17 +499,19 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	if (eeh_dev_removed(edev))
 		return NULL;
 
-	driver = eeh_pcid_get(dev);
-	if (driver) {
-		eeh_pcid_put(dev);
-		if (removed &&
-		    eeh_pe_passed(edev->pe))
-			return NULL;
-		if (removed &&
-		    driver->err_handler &&
-		    driver->err_handler->error_detected &&
-		    driver->err_handler->slot_reset)
+	if (removed) {
+		if (eeh_pe_passed(edev->pe))
 			return NULL;
+		driver = eeh_pcid_get(dev);
+		if (driver) {
+			if (driver->err_handler &&
+			    driver->err_handler->error_detected &&
+			    driver->err_handler->slot_reset) {
+				eeh_pcid_put(dev);
+				return NULL;
+			}
+			eeh_pcid_put(dev);
+		}
 	}
 
 	/* Remove it from PCI subsystem */
-- 
2.16.1.74.g9b0b1f47b
