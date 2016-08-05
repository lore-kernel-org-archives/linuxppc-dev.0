Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5QQq4VHhzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:02:10 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u75BxVd6064309
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 08:02:08 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkakuu0b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 08:02:08 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 13:02:06 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: David.Laight@ACULAB.COM, mrochs@linux.vnet.ibm.com,
 manoj@linux.vnet.ibm.com, ukrishn@linux.vnet.ibm.com,
 mpe@ellerman.id.au, imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 mikey@neuling.org, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v2] cxl: Use fixed width predefined types in data structure.
Date: Fri,  5 Aug 2016 14:02:00 +0200
Message-Id: <1470398520-20463-1-git-send-email-felix@linux.vnet.ibm.com>
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

This patch also changes the size of the field data_size, and
makes it constant, to support 32-bit userland applications
running on big-endian ppc64 kernels transparently.

This breaks the (young) API that has been merged in v4.8.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
Changes since v1:
  Added an explanation for the proposed API change in the log.

Note:
As far as I know, cxlflash is the only known user of the API.

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
