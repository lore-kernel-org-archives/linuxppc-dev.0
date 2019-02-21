Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C60C00319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D104F20818
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D104F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44521250glzDqJH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 04:44:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4451pf5BsdzDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:35:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4451pf3Dh9z8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:35:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4451pf295Qz9sD4; Fri, 22 Feb 2019 04:35:54 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4451pd57Ptz9sCH
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2019 04:35:53 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LHPExI117754
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:35:51 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qswk392uw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:35:50 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 21 Feb 2019 17:35:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 17:35:46 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LHZiax60489828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Feb 2019 17:35:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7233CA405F;
 Thu, 21 Feb 2019 17:35:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7FDBA4054;
 Thu, 21 Feb 2019 17:35:42 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.32.125])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Feb 2019 17:35:42 +0000 (GMT)
Subject: [PATCH 04/18] powerpc/fadump: use FADump instead of fadump for how
 it is pronounced
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Thu, 21 Feb 2019 23:05:41 +0530
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022117-0020-0000-0000-00000319A002
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0021-0000-0000-0000216AF38F
Message-Id: <155077054180.21014.2257479511420862161.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210125
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   56 +++++++++++-----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 059993b..62e75ef 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -8,18 +8,18 @@ a crashed system, and to do so from a fully-reset system, and
 to minimize the total elapsed time until the system is back
 in production use.
 
-- Firmware assisted dump (fadump) infrastructure is intended to replace
+- Firmware-Assisted Dump (FADump) infrastructure is intended to replace
   the existing phyp assisted dump.
 - Fadump uses the same firmware interfaces and memory reservation model
   as phyp assisted dump.
-- Unlike phyp dump, fadump exports the memory dump through /proc/vmcore
+- Unlike phyp dump, FADump exports the memory dump through /proc/vmcore
   in the ELF format in the same way as kdump. This helps us reuse the
   kdump infrastructure for dump capture and filtering.
 - Unlike phyp dump, userspace tool does not need to refer any sysfs
   interface while reading /proc/vmcore.
-- Unlike phyp dump, fadump allows user to release all the memory reserved
+- Unlike phyp dump, FADump allows user to release all the memory reserved
   for dump, with a single operation of echo 1 > /sys/kernel/fadump_release_mem.
-- Once enabled through kernel boot parameter, fadump can be
+- Once enabled through kernel boot parameter, FADump can be
   started/stopped through /sys/kernel/fadump_registered interface (see
   sysfs files section below) and can be easily integrated with kdump
   service start/stop init scripts.
@@ -33,7 +33,7 @@ dump offers several strong, practical advantages:
    in a clean, consistent state.
 -- Once the dump is copied out, the memory that held the dump
    is immediately available to the running kernel. And therefore,
-   unlike kdump, fadump doesn't need a 2nd reboot to get back
+   unlike kdump, FADump doesn't need a 2nd reboot to get back
    the system to the production configuration.
 
 The above can only be accomplished by coordination with,
@@ -61,7 +61,7 @@ as follows:
          boot successfully. For syntax of crashkernel= parameter,
          refer to Documentation/kdump/kdump.txt. If any offset is
          provided in crashkernel= parameter, it will be ignored
-         as fadump uses a predefined offset to reserve memory
+         as FADump uses a predefined offset to reserve memory
          for boot memory dump preservation in case of a crash.
 
 -- After the low memory (boot memory) area has been saved, the
@@ -120,7 +120,7 @@ blocking this significant chunk of memory from production kernel.
 Hence, the implementation uses the Linux kernel's Contiguous Memory
 Allocator (CMA) for memory reservation if CMA is configured for kernel.
 With CMA reservation this memory will be available for applications to
-use it, while kernel is prevented from using it. With this fadump will
+use it, while kernel is prevented from using it. With this FADump will
 still be able to capture all of the kernel memory and most of the user
 space memory except the user pages that were present in CMA region.
 
@@ -170,14 +170,14 @@ KDump, as dump mechanism.
 The tools to examine the dump will be same as the ones
 used for kdump.
 
-How to enable firmware-assisted dump (fadump):
+How to enable firmware-assisted dump (FADump):
 ---------------------------------------------
 
 1. Set config option CONFIG_FA_DUMP=y and build kernel.
-2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
-   By default, fadump reserved memory will be initialized as CMA area.
-   Alternatively, user can boot linux kernel with 'fadump=nocma' to
-   prevent fadump to use CMA.
+2. Boot into linux kernel with 'FADump=on' kernel cmdline option.
+   By default, FADump reserved memory will be initialized as CMA area.
+   Alternatively, user can boot linux kernel with 'FADump=nocma' to
+   prevent FADump to use CMA.
 3. Optionally, user can also set 'crashkernel=' kernel cmdline
    to specify size of the memory to reserve for boot memory dump
    preservation.
@@ -190,7 +190,7 @@ NOTE: 1. 'fadump_reserve_mem=' parameter has been deprecated. Instead
          option is set at kernel cmdline.
       3. if user wants to capture all of user space memory and ok with
          reserved memory not available to production system, then
-         'fadump=nocma' kernel parameter can be used to fallback to
+         'FADump=nocma' kernel parameter can be used to fallback to
          old behaviour.
 
 Sysfs/debugfs files:
@@ -203,29 +203,29 @@ Here is the list of files under kernel sysfs:
 
  /sys/kernel/fadump_enabled
 
-    This is used to display the fadump status.
-    0 = fadump is disabled
-    1 = fadump is enabled
+    This is used to display the FADump status.
+    0 = FADump is disabled
+    1 = FADump is enabled
 
     This interface can be used by kdump init scripts to identify if
-    fadump is enabled in the kernel and act accordingly.
+    FADump is enabled in the kernel and act accordingly.
 
  /sys/kernel/fadump_registered
 
-    This is used to display the fadump registration status as well
-    as to control (start/stop) the fadump registration.
-    0 = fadump is not registered.
-    1 = fadump is registered and ready to handle system crash.
+    This is used to display the FADump registration status as well
+    as to control (start/stop) the FADump registration.
+    0 = FADump is not registered.
+    1 = FADump is registered and ready to handle system crash.
 
-    To register fadump echo 1 > /sys/kernel/fadump_registered and
+    To register FADump echo 1 > /sys/kernel/fadump_registered and
     echo 0 > /sys/kernel/fadump_registered for un-register and stop the
-    fadump. Once the fadump is un-registered, the system crash will not
+    FADump. Once the FADump is un-registered, the system crash will not
     be handled and vmcore will not be captured. This interface can be
     easily integrated with kdump service start/stop.
 
  /sys/kernel/fadump_release_mem
 
-    This file is available only when fadump is active during
+    This file is available only when FADump is active during
     second kernel. This is used to release the reserved memory
     region that are held for saving crash dump. To release the
     reserved memory echo 1 to it:
@@ -244,20 +244,20 @@ Here is the list of files under powerpc debugfs:
 
  /sys/kernel/debug/powerpc/fadump_region
 
-    This file shows the reserved memory regions if fadump is
+    This file shows the reserved memory regions if FADump is
     enabled otherwise this file is empty. The output format
     is:
     <region>: [<start>-<end>] <reserved-size> bytes, Dumped: <dump-size>
 
     e.g.
-    Contents when fadump is registered during first kernel
+    Contents when FADump is registered during first kernel
 
     # cat /sys/kernel/debug/powerpc/fadump_region
     CPU : [0x0000006ffb0000-0x0000006fff001f] 0x40020 bytes, Dumped: 0x0
     HPTE: [0x0000006fff0020-0x0000006fff101f] 0x1000 bytes, Dumped: 0x0
     DUMP: [0x0000006fff1020-0x0000007fff101f] 0x10000000 bytes, Dumped: 0x0
 
-    Contents when fadump is active during second kernel
+    Contents when FADump is active during second kernel
 
     # cat /sys/kernel/debug/powerpc/fadump_region
     CPU : [0x0000006ffb0000-0x0000006fff001f] 0x40020 bytes, Dumped: 0x40020
@@ -274,7 +274,7 @@ TODO:
  o Need to come up with the better approach to find out more
    accurate boot memory size that is required for a kernel to
    boot successfully when booted with restricted memory.
- o The fadump implementation introduces a fadump crash info structure
+ o The FADump implementation introduces a FADump crash info structure
    in the scratch area before the ELF core header. The idea of introducing
    this structure is to pass some important crash info data to the second
    kernel which will help second kernel to populate ELF core header with

