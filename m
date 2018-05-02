Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT6r03S4zF2S1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:35:31 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426ZD9r048920
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:35:29 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hq37j1fj2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:35:29 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:35:27 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426ZOGp8454578
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:35:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3D234C044
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:34 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FBB54C050
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:34 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:34 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D9B4DA01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:35:22 +1000 (AEST)
Date: Wed, 2 May 2018 16:35:21 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/13] powerpc/eeh: Fix use-after-release of EEH driver
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <e50359f9211fcdc342401806ab65aa092c63e7b9.1525242772.git.sbobroff@linux.ibm.com>
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
