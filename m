Return-Path: <srs0=ruhu=gx=linux.vnet.ibm.com=prvs=0630f71b8d=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40F2QZ46CMzF22J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 16:30:14 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40F2QZ1B03z8vSL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Apr 2018 16:30:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40F2QY1F5Dz9s15
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2018 16:30:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w326TW0x125366
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2018 02:30:11 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2h3em91br7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Apr 2018 02:30:11 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 2 Apr 2018 07:30:08 +0100
Subject: [PATCH v3 2/7] powerpc/fadump: Update documentation to reflect the
 metadata region movement.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 02 Apr 2018 12:00:03 +0530
In-Reply-To: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
References: <152265046485.23251.1392824827444770657.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <152265060147.23251.3669620531517333403.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Metadata region that holds fadump header and ELF header is now placed at
the start of reserved memory area. Update the documentation accordingly

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   31 +++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index bdd344aa18d9..c77f8dc9231f 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -115,17 +115,24 @@ be kept permanently reserved, so that it can act as a receptacle
 for a copy of the boot memory content in addition to CPU state
 and HPTE region, in the case a crash does occur.
 
+The first kernel, during fadump registration, prepares ELF core header
+that contains necessary information for the coredump of the 1st kernel
+which includes its physical memory layout. This ELF header and some more
+additional data is stored in the area called metadata region at the start
+of the reserved memory area.
+
   o Memory Reservation during first kernel
 
   Low memory                                         Top of memory
   0      boot memory size                                       |
   |           |                |<--Reserved dump area -->|      |
   V           V                |   Permanent Reservation |      V
-  +-----------+----------/ /---+---+----+-----------+----+------+
-  |           |                |CPU|HPTE|  DUMP     |ELF |      |
-  +-----------+----------/ /---+---+----+-----------+----+------+
-        |                                           ^
-        |                                           |
+  +-----------+----------/ /---+----+---+----+-----------+------+
+  |           |                |ELF |CPU|HPTE|  DUMP     |      |
+  +-----------+---------/ /----+----+---+----+-----------+------+
+        |                        ^                  ^
+        |                        |                  |
+        |                metadata region            |
         \                                           /
          -------------------------------------------
           Boot memory content gets transferred to
@@ -137,14 +144,14 @@ and HPTE region, in the case a crash does occur.
 
   Low memory                                        Top of memory
   0      boot memory size                                       |
-  |           |<------------- Reserved dump area ----------- -->|
+  |           |<------------- Reserved dump area -------------->|
   V           V                                                 V
-  +-----------+----------/ /---+---+----+-----------+----+------+
-  |           |                |CPU|HPTE|  DUMP     |ELF |      |
-  +-----------+----------/ /---+---+----+-----------+----+------+
-        |                                              |
-        V                                              V
-   Used by second                                /proc/vmcore
+  +-----------+----------/ /---+----+----+---------------+------+
+  |           |                |ELF |CPU|HPTE|  DUMP     |      |
+  +-----------+----------/ /---+----+----+---------------+------+
+        |                         |
+        V                         V
+   Used by second             /proc/vmcore
    kernel to boot
                    Fig. 2
 
