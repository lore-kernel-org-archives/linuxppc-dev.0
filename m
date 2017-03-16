Return-Path: <srs0=tmo9=2z=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkgyK5JCtzDqbk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 08:06:49 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vkgyK44b0z8t4P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 08:06:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vkgyK10Lnz9ryQ
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 08:06:48 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GL47wI039088
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 17:06:38 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2980w6bnvd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Mar 2017 17:06:37 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 17 Mar 2017 07:06:34 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2GL6Pbp54853652
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 08:06:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2GL5xID020001
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Mar 2017 08:05:59 +1100
Subject: [PATCH v2 2/2] powerpc/fadump: update fadump documentation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 17 Mar 2017 02:35:42 +0530
In-Reply-To: <148969794004.4130.14805754334064000704.stgit@hbathini.in.ibm.com>
References: <148969794004.4130.14805754334064000704.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148969833262.4130.15644962872616343895.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the unnecessary restriction to reserve memory for fadump at the
top of RAM forgone, update the documentation accordingly.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 3007bc9..19b1e3d 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -105,21 +105,21 @@ memory is held.
 
 If there is no waiting dump data, then only the memory required
 to hold CPU state, HPTE region, boot memory dump and elfcore
-header, is reserved at the top of memory (see Fig. 1). This area
-is *not* released: this region will be kept permanently reserved,
-so that it can act as a receptacle for a copy of the boot memory
-content in addition to CPU state and HPTE region, in the case a
-crash does occur.
+header, is usually reserved at an offset greater than boot memory
+size (see Fig. 1). This area is *not* released: this region will
+be kept permanently reserved, so that it can act as a receptacle
+for a copy of the boot memory content in addition to CPU state
+and HPTE region, in the case a crash does occur.
 
   o Memory Reservation during first kernel
 
-  Low memory                                        Top of memory
+  Low memory                                         Top of memory
   0      boot memory size                                       |
-  |           |                       |<--Reserved dump area -->|
-  V           V                       |   Permanent Reservation V
-  +-----------+----------/ /----------+---+----+-----------+----+
-  |           |                       |CPU|HPTE|  DUMP     |ELF |
-  +-----------+----------/ /----------+---+----+-----------+----+
+  |           |                |<--Reserved dump area -->|      |
+  V           V                |   Permanent Reservation |      V
+  +-----------+----------/ /---+---+----+-----------+----+------+
+  |           |                |CPU|HPTE|  DUMP     |ELF |      |
+  +-----------+----------/ /---+---+----+-----------+----+------+
         |                                           ^
         |                                           |
         \                                           /
@@ -135,12 +135,12 @@ crash does occur.
   0      boot memory size                                       |
   |           |<------------- Reserved dump area ----------- -->|
   V           V                                                 V
-  +-----------+----------/ /----------+---+----+-----------+----+
-  |           |                       |CPU|HPTE|  DUMP     |ELF |
-  +-----------+----------/ /----------+---+----+-----------+----+
-        |                                                    |
-        V                                                    V
-   Used by second                                    /proc/vmcore
+  +-----------+----------/ /---+---+----+-----------+----+------+
+  |           |                |CPU|HPTE|  DUMP     |ELF |      |
+  +-----------+----------/ /---+---+----+-----------+----+------+
+        |                                              |
+        V                                              V
+   Used by second                                /proc/vmcore
    kernel to boot
                    Fig. 2
 
