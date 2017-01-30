Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBwHh0x9QzDq9K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 03:45:35 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vBwHf6YwKz9stc
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2017 03:45:34 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0UGiKUJ015055
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 11:45:32 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28a7d8nvy1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2017 11:45:31 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 31 Jan 2017 02:45:29 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6C03C2BB0045
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2017 03:45:26 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0UGjIqD23724122
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2017 03:45:26 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0UGirsV020691
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2017 03:44:54 +1100
Subject: [PATCH v1 2/2] fadump: update documentation about introduction of
 handover area
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 22:14:35 +0530
In-Reply-To: <148579466976.5257.13873211534670897645.stgit@hbathini.in.ibm.com>
References: <148579466976.5257.13873211534670897645.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148579467581.5257.11699888411183128587.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update documentation about introduction of handover area that includes
configuration details like extra parameters to append to capture
kernel.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   83 ++++++++++++++--------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 3007bc9..2da3a3f 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -67,11 +67,17 @@ as follows:
 
 -- The freshly booted kernel will notice that there is a new
    node (ibm,dump-kernel) in the device tree, indicating that
-   there is crash data available from a previous boot. During
-   the early boot OS will reserve rest of the memory above
-   boot memory size effectively booting with restricted memory
-   size. This will make sure that the second kernel will not
-   touch any of the dump memory area.
+   there is crash data available from a previous boot. This
+   second kernel, where crash data is available from previous
+   boot, is referred to as capture kernel. The capture kernel,
+   early during the boot process, looks for a handover area
+   (see fig. 2), saved by the first kernel to be handed over
+   to it. This handover area contains certain config info like
+   extra parameters to append to the capture kernel. The capture
+   kernel applies this configuration accordingly. Later, reserves
+   rest of the memory above boot memory size effectively booting
+   with restricted memory size. This will make sure that the
+   capture kernel will not touch any of the dump memory area.
 
 -- User-space tools will read /proc/vmcore to obtain the contents
    of memory, which holds the previous crashed kernel dump in ELF
@@ -113,15 +119,18 @@ crash does occur.
 
   o Memory Reservation during first kernel
 
-  Low memory                                        Top of memory
-  0      boot memory size                                       |
-  |           |                       |<--Reserved dump area -->|
-  V           V                       |   Permanent Reservation V
-  +-----------+----------/ /----------+---+----+-----------+----+
-  |           |                       |CPU|HPTE|  DUMP     |ELF |
-  +-----------+----------/ /----------+---+----+-----------+----+
-        |                                           ^
-        |                                           |
+  Low memory                                              Top of memory
+  0                                                               |
+  | Handover area                                                 |
+  |   |                                                           |
+  |   |      boot memory size           |<-- Reserved dump area-->|
+  |   |          |                      |  Permanent Reservation  |
+  V   V          V                                                V 
+  +--+-+--------+----------/ /----------+---+----+-----------+----+
+  |  | |        |                       |CPU|HPTE|  DUMP     |ELF |
+  +--+-+--------+----------/ /----------+---+----+-----------+----+
+  |____  _______|                                   ^
+       \/                                           |
         \                                           /
          -------------------------------------------
           Boot memory content gets transferred to
@@ -129,18 +138,21 @@ crash does occur.
           crash
                    Fig. 1
 
-  o Memory Reservation during second kernel after crash
-
-  Low memory                                        Top of memory
-  0      boot memory size                                       |
-  |           |<------------- Reserved dump area ----------- -->|
-  V           V                                                 V
-  +-----------+----------/ /----------+---+----+-----------+----+
-  |           |                       |CPU|HPTE|  DUMP     |ELF |
-  +-----------+----------/ /----------+---+----+-----------+----+
-        |                                                    |
-        V                                                    V
-   Used by second                                    /proc/vmcore
+  o Memory Reservation during capture (fadump) kernel after crash
+
+  Low memory                                          Top of memory
+  0                                                               |
+  |  Handover area                                                |
+  |   |                                                           |
+  |   |    boot memory size                                       |
+  |   |         |<------------- Reserved dump area ----------- -->|
+  V   V         V                                                 V
+  +--+-+--------+----------/ /----------+---+----+-----------+----+
+  |  | |        |                       |CPU|HPTE|  DUMP     |ELF |
+  +--+-+--------+----------/ /----------+---+----+-----------+----+
+  |____  _______|                                            |
+       \/                                                    V
+   Used by capture                                      /proc/vmcore
    kernel to boot
                    Fig. 2
 
@@ -196,10 +208,21 @@ Here is the list of files under kernel sysfs:
     be handled and vmcore will not be captured. This interface can be
     easily integrated with kdump service start/stop.
 
+ /sys/kernel/fadump_cmdline_append
+
+    This is used to specify the extra parameters to append to capture
+    kernel. Typically used to pass parameters that reduce memory/resource
+    consumption for dump capture kernel. To pass parameters to append to
+    dump capture kernel:
+
+    echo "nr_cpus=1 kvm_cma_resv_ratio=0" > /sys/kernel/fadump_cmdline_append
+
+    This interface can be easily integrated with kdump service start/stop.
+
  /sys/kernel/fadump_release_mem
 
     This file is available only when fadump is active during
-    second kernel. This is used to release the reserved memory
+    capture kernel. This is used to release the reserved memory
     region that are held for saving crash dump. To release the
     reserved memory echo 1 to it:
 
@@ -230,7 +253,7 @@ Here is the list of files under powerpc debugfs:
     HPTE: [0x0000006fff0020-0x0000006fff101f] 0x1000 bytes, Dumped: 0x0
     DUMP: [0x0000006fff1020-0x0000007fff101f] 0x10000000 bytes, Dumped: 0x0
 
-    Contents when fadump is active during second kernel
+    Contents when fadump is active during capture kernel
 
     # cat /sys/kernel/debug/powerpc/fadump_region
     CPU : [0x0000006ffb0000-0x0000006fff001f] 0x40020 bytes, Dumped: 0x40020
@@ -249,8 +272,8 @@ TODO:
    boot successfully when booted with restricted memory.
  o The fadump implementation introduces a fadump crash info structure
    in the scratch area before the ELF core header. The idea of introducing
-   this structure is to pass some important crash info data to the second
-   kernel which will help second kernel to populate ELF core header with
+   this structure is to pass some important crash info data to the capture
+   kernel which will help capture kernel to populate ELF core header with
    correct data before it gets exported through /proc/vmcore. The current
    design implementation does not address a possibility of introducing
    additional fields (in future) to this structure without affecting
