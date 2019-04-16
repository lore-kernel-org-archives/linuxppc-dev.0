Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0629C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:42:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263E020693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263E020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k2481k2DzDqDs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:42:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1tx3JqrzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:34:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1tx0z8gz8t5T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:34:01 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1tx0MCYz9s4V; Tue, 16 Apr 2019 20:34:01 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=hbathini@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44k1tw3zbXz9s3q
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:34:00 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAWp7M030644
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:33:58 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwbr44sht-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:33:58 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:33:56 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:33:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAXpZP60227598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:33:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE1E911C04C;
 Tue, 16 Apr 2019 10:33:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7558E11C05C;
 Tue, 16 Apr 2019 10:33:50 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:33:50 +0000 (GMT)
Subject: [PATCH v2 04/16] powerpc/fadump: use FADump instead of fadump for
 how it is pronounced
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:03:49 +0530
In-Reply-To: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
References: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0020-0000-0000-000003305E52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0021-0000-0000-00002182A1E8
Message-Id: <155541082215.812.11468225657030072940.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160072
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
Cc: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Stewart Smith <stewart@linux.ibm.com>, Daniel Axtens <dja@axtens.net>
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

