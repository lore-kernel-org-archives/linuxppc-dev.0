Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjfxk3cQzzDwJS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 01:17:30 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBKEETTd102016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 09:17:28 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27f2adp8j2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 09:17:28 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 20 Dec 2016 19:47:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CBB51E005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 19:48:02 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBKEHE9F22282362
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 19:47:14 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBKEHDd0030902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 19:47:14 +0530
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL fails
Date: Tue, 20 Dec 2016 19:46:59 +0530
Message-Id: <1482243419-23041-1-git-send-email-vipin@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added check for OPAL_WRONG_STATE error code returned from OPAL.
Currently Linux flashes "unexpected error" over console for this
error. This will avoid throwing such message and return I/O error
for such OPAL failures.

Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2822935..ab91d53 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -866,9 +866,10 @@ int opal_error_code(int rc)
 	case OPAL_NO_MEM:		return -ENOMEM;
 	case OPAL_PERMISSION:		return -EPERM;
 
-	case OPAL_UNSUPPORTED:		return -EIO;
-	case OPAL_HARDWARE:		return -EIO;
-	case OPAL_INTERNAL_ERROR:	return -EIO;
+	case OPAL_UNSUPPORTED:
+	case OPAL_HARDWARE:
+	case OPAL_INTERNAL_ERROR:
+	case OPAL_WRONG_STATE:		return -EIO;
 	default:
 		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
 		return -EIO;
-- 
2.7.4
