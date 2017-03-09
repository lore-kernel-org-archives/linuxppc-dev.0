Return-Path: <srs0=epap=2s=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfCts3ZgvzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:48:21 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vfCts1y08z8tJ9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:48:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vfCtr5wSPz9s7n
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2017 01:48:20 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29Ehmn9135744
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 09:48:12 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292y9c970h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Mar 2017 09:48:12 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 20:18:09 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29Em6tu37486696
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 20:18:06 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29Em6UA005837
 for <linuxppc-dev@ozlabs.org>; Thu, 9 Mar 2017 20:18:06 +0530
Subject: [PATCH 2/2] powerpc/fadump: update fadump documentation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 09 Mar 2017 20:18:04 +0530
In-Reply-To: <148907087368.3574.8071537539290192784.stgit@hbathini.in.ibm.com>
References: <148907087368.3574.8071537539290192784.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148907088422.3574.8594937665167145469.stgit@hbathini.in.ibm.com>
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
 
