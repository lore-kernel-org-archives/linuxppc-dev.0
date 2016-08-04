Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4s0v73M0zDqd2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 23:56:15 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74DsN6d009323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 09:56:13 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kxmhe8eg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Aug 2016 09:56:13 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 14:56:11 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 512CB1B08069
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 14:57:40 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74Du95r8454504
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 13:56:09 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74Du8Xu021054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Aug 2016 09:56:09 -0400
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com, mpe@ellerman.id.au, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Use fixed width predefined types in data structure.
Date: Thu,  4 Aug 2016 15:56:04 +0200
Message-Id: <1470318964-19995-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a regression introduced by commit b810253.
It substitutes the type __u8 to u8 in the uapi header cxl.h,
because the latter is not always defined in userland build
environments, in particular when cross-compiling libcxl on
x86_64 linux machines (RHEL6.7 and Ubuntu 16.04).

It also makes the definition of cxl_event_afu_driver_reserved
more consistent with the other definitions in the header file.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
 include/uapi/misc/cxl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index cbae529..180d526 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -136,8 +136,8 @@ struct cxl_event_afu_driver_reserved {
 	 *
 	 * Of course the contents will be ABI, but that's up the AFU driver.
 	 */
-	size_t data_size;
-	u8 data[];
+	__u32 data_size;
+	__u8 data[];
 };
 
 struct cxl_event {
-- 
2.8.0
