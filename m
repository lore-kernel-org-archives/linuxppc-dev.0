Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 76C932C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jan 2014 22:31:10 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Thu, 2 Jan 2014 17:00:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 48768394005E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jan 2014 17:00:52 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s02BUjWj37027952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jan 2014 17:00:45 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s02BUk0j031235
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jan 2014 17:00:48 +0530
Subject: [PATCH] powerpc/powernv: Increase candidate fw image size
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Thu, 02 Jan 2014 17:00:42 +0530
Message-ID: <20140102113030.1292.5247.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present we assume candidate image is <= 256MB. But in P8,
candidate image size can go up to 750MB. Hence increasing
candidate image max size to 1GB.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-flash.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 4aeae4f..16e571b 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -76,8 +76,8 @@
 /* Validate buffer size */
 #define VALIDATE_BUF_SIZE	4096
 
-/* XXX: Assume candidate image size is <= 256MB */
-#define MAX_IMAGE_SIZE	0x10000000
+/* XXX: Assume candidate image size is <= 1GB */
+#define MAX_IMAGE_SIZE	0x40000000
 
 /* Flash sg list version */
 #define SG_LIST_VERSION (1UL)
