Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn0kw1lKDzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 16:50:16 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5D6n9jB107763
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 02:50:14 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b2a44tryx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 02:50:13 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 16:50:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5D6oAQq62718198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 16:50:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5D6o8aa027686
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 16:50:09 +1000
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] recordmcount.pl: Add ppc64le to list of supported
 architectures
Date: Tue, 13 Jun 2017 12:19:59 +0530
Message-Id: <1497336599-17894-1-git-send-email-kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Module make on ppc64le, fails with:

make -C /root/kernel/linux M=/root/.kpatch/tmp/patch kpatch-data-read-mostly.ko
make[1]: Entering directory '/root/kernel/linux'
  CC [M]  /root/.kpatch/tmp/patch/patch-hook.o
Arch ppc64le is not supported with CONFIG_FTRACE_MCOUNT_RECORD at ./scripts/recordmcount.pl line 379.

Fix it by adding 'ppc64le' to list of supported architectures
in recordmcount.pl script.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Balbir Singh <bsingharora@gmail.com>
---
 scripts/recordmcount.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 1633c3e..683b8b5 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -264,7 +264,7 @@ if ($arch eq "x86_64") {
     $ld .= " -m shlelf_linux";
     $objcopy .= " -O elf32-sh-linux";
 
-} elsif ($arch eq "powerpc") {
+} elsif ($arch eq "powerpc" || $arch eq "ppc64le") {
     $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
     # See comment in the sparc64 section for why we use '\w'.
     $function_regex = "^([0-9a-fA-F]+)\\s+<(\\.?\\w*?)>:";
-- 
2.7.4
