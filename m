Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXZC873g6zDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:12:52 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1SA95kT000760
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 05:12:50 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28w3d4j78e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 05:12:49 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Tue, 28 Feb 2017 20:12:47 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3C61B2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:12:45 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1SACb9w35586140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:12:45 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1SACCkG000832
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 21:12:12 +1100
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: [PATCH v2] powernv/opal: Handle OPAL_WRONG_STATE error from OPAL fails
Date: Tue, 28 Feb 2017 15:41:42 +0530
Message-Id: <1488276702-14646-1-git-send-email-vipin@linux.vnet.ibm.com>
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
Changes in v2:
 - Added log message indicating sleeping/offline core
   for OPAL_WRONG_STATE

 arch/powerpc/platforms/powernv/opal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 86d9fde..8af230e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -869,8 +869,11 @@ int opal_error_code(int rc)
 	case OPAL_UNSUPPORTED:		return -EIO;
 	case OPAL_HARDWARE:		return -EIO;
 	case OPAL_INTERNAL_ERROR:	return -EIO;
+	case OPAL_WRONG_STATE:
+		pr_notice("%s: Core sleeping/offline\n", __func__);
+		return -EIO;
 	default:
-		pr_err("%s: unexpected OPAL error %d\n", __func__, rc);
+		pr_err("%s: Unexpected OPAL error %d\n", __func__, rc);
 		return -EIO;
 	}
 }
-- 
2.7.4
