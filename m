Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569941A2C62
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 15:50:02 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0E6841401B5
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:50:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 15 Sep 2015 15:50:01 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A8619357804F
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:49:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F5nnaH22806774
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:49:57 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F5nO7l017973
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2015 15:49:25 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Fix build failure due to -Wunused-variable behaviour
 change
Date: Tue, 15 Sep 2015 15:48:34 +1000
Message-Id: <1442296114-16796-1-git-send-email-imunsie@au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

A recent change in gcc caused this build failure:

/var/lib/jenkins/workspace/gcc_kernel_build/linux/drivers/misc/cxl/cxl.h:72:27:
error: ‘CXL_PSL_DLCNTL’ defined but not used [-Werror=unused-const-variable]
 static const cxl_p1_reg_t CXL_PSL_DLCNTL  = {0x0060};

Because of this gcc commit:

Commit 1bca8cbd0c68366f07277f98ce6963e10c2aa617 by mark
PR28901 -Wunused-variable ignores unused const initialised variables in C
12 years ago it was decided that -Wunused-variable shouldn't warn about
static const variables because some code used const static char rcsid[]
strings which were never used but wanted in the code anyway. But as the
bug points out this hides some real bugs. These days the usage of
rcsids is not very popular anymore. So this patch changes the default
to warn about unused static const variables in C with
-Wunused-variable. And it adds a new option -Wno-unused-const-variable
to turn this warning off. For C++ this new warning is off by default,
since const variables can be used as #defines in C++. New testcases for
the new defaults in C and C++ are included testing the new warning and
suppressing it with an unused attribute or using
-Wno-unused-const-variable. gcc/ChangeLog

The cxl driver uses static consts in place of #defines in some cases
for type safety, so this change causes the driver to fail to build on
new copilers as these constants are not all used in every file that
imports the header. Suppress the warning for this driver to return to
the old behaviour of -Wunused-variable.

Reported-by: Anton Blanchard <anton@au1.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index 6f484df..6982f60 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1,4 +1,4 @@
-ccflags-y := -Werror
+ccflags-y := -Werror -Wno-unused-const-variable
 
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
-- 
2.1.4
