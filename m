Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F8401A0271
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 21:28:25 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 10:28:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 257F92190043
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 10:27:49 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBCASHUP42795162
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 10:28:18 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBCASHIe003494
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 03:28:17 -0700
Message-ID: <548AC365.3040801@linux.vnet.ibm.com>
Date: Fri, 12 Dec 2014 11:28:53 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] Update CXL ABI documentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Philippe Bergheaud <felix@linux.vnet.ibm.com>

This fixes two typos and explains where shared attributes are stored.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Acked-by: Michael Neuling <mikey@neuling.org>
---
  Documentation/ABI/testing/sysfs-class-cxl |   11 ++++++++---
  1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index faf9479..3393ee6 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -1,3 +1,9 @@
+Note: Attributes that are shared between devices are stored in the directory
+pointed to by the symlink device/.
+Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
+/sys/class/cxl/afu0.0s/device/irqs_max, i.e. /sys/class/cxl/afu0.0/irqs_max.
+
+
  Slave contexts (eg. /sys/class/cxl/afu0.0s):

  What:           /sys/class/cxl/<afu>/irqs_max
@@ -67,7 +73,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
  Description:    read only
                  Decimal value of the current version of the kernel/user API.

-What:           /sys/class/cxl/<afu>/api_version_com
+What:           /sys/class/cxl/<afu>/api_version_compatible
  Date:           September 2014
  Contact:        linuxppc-dev@lists.ozlabs.org
  Description:    read only
@@ -75,7 +81,6 @@ Description:    read only
                  this this kernel supports.


-
  Master contexts (eg. /sys/class/cxl/afu0.0m)

  What:           /sys/class/cxl/<afu>m/mmio_size
@@ -106,7 +111,7 @@ Contact:        linuxppc-dev@lists.ozlabs.org
  Description:    read only
                  Identifies the CAIA Version the card implements.

-What:           /sys/class/cxl/<card>/psl_version
+What:           /sys/class/cxl/<card>/psl_revision
  Date:           September 2014
  Contact:        linuxppc-dev@lists.ozlabs.org
  Description:    read only
-- 
1.7.2.5
