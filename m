Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE77C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3DB218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3DB218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LM912SmmzDrNY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:22:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLhX086czDr6x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLhW6T3Zz8tRf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:01:31 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLhW65S7z9sCr; Fri, 21 Dec 2018 06:01:31 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43LLhW1xCfz9sCh
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:01:31 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwlGP115583
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:29 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pggdx9088-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:01:29 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:01:27 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:01:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ1OIH8192390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:01:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64F144C044;
 Thu, 20 Dec 2018 19:01:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0EC64C050;
 Thu, 20 Dec 2018 19:01:22 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:01:22 +0000 (GMT)
Subject: [PATCH 9/9] powerpc/fadump: Update documentation about OPAL
 platform support
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:31:21 +0530
In-Reply-To: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
References: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0028-0000-0000-0000032D5DE6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0029-0000-0000-000023E9C562
Message-Id: <154533248159.28973.754639553919897320.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812200154
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

With FADump support now available on both pseries and OPAL platforms,
update FADump documentation with these details. Also, update about
backup area and why it is used.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |  102 ++++++++++++++--------
 1 file changed, 64 insertions(+), 38 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 326f89c..eff9f38 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -70,7 +70,8 @@ as follows:
    normal.
 
 -- The freshly booted kernel will notice that there is a new
-   node (ibm,dump-kernel) in the device tree, indicating that
+   node (ibm,dump-kernel on PSeries or ibm,opal/dump/result-table
+   on OPAL platform) in the device tree, indicating that
    there is crash data available from a previous boot. During
    the early boot OS will reserve rest of the memory above
    boot memory size effectively booting with restricted memory
@@ -92,7 +93,20 @@ as follows:
 
 Please note that the firmware-assisted dump feature
 is only available on Power6 and above systems with recent
-firmware versions.
+firmware versions on PSeries (PowerVM) platform and Power9
+and above systems with recent firmware versions on PowerNV
+(OPAL) platform.
+
+To process dump on OPAL platform, additional meta data (PIR to
+Logical CPU map) from the crashing kernel is required. This info
+has to be backed up by the crashing kernel for capture kernel to
+use it in making sense of the register state data provided by the
+F/W. The start address of the area where this info is backed up
+is stored at the tail end of FADump crash info header. To indicate
+the presence of this additional meta data (backup info), the magic
+number field in FADump crash info header is overloaded as version
+identifier.
+
 
 Implementation details:
 ----------------------
@@ -108,56 +122,65 @@ that are run. If there is dump data, then the
 memory is held.
 
 If there is no waiting dump data, then only the memory required
-to hold CPU state, HPTE region, boot memory dump and elfcore
-header, is usually reserved at an offset greater than boot memory
-size (see Fig. 1). This area is *not* released: this region will
-be kept permanently reserved, so that it can act as a receptacle
-for a copy of the boot memory content in addition to CPU state
-and HPTE region, in the case a crash does occur. Since this reserved
-memory area is used only after the system crash, there is no point in
-blocking this significant chunk of memory from production kernel.
-Hence, the implementation uses the Linux kernel's Contiguous Memory
-Allocator (CMA) for memory reservation if CMA is configured for kernel.
-With CMA reservation this memory will be available for applications to
-use it, while kernel is prevented from using it. With this FADump will
-still be able to capture all of the kernel memory and most of the user
-space memory except the user pages that were present in CMA region.
+to hold CPU state, HPTE region, boot memory dump, FADump header,
+elfcore header and backup area, is usually reserved at an offset
+greater than boot memory size (see Fig. 1). This area is *not*
+released: this region will be kept permanently reserved, so that
+it can act as a receptacle for a copy of the boot memory content in
+addition to CPU state and HPTE region, in the case a crash does occur.
+Since this reserved memory area is used only after the system crash,
+there is no point in blocking this significant chunk of memory from
+production kernel. Hence, the implementation uses the Linux kernel's
+Contiguous Memory Allocator (CMA) for memory reservation if CMA is
+configured for kernel. With CMA reservation this memory will be
+available for applications to use it, while kernel is prevented from
+using it. With this FADump will still be able to capture all of the
+kernel memory and most of the user space memory except the user pages
+that were present in CMA region.
 
   o Memory Reservation during first kernel
 
-  Low memory                                                Top of memory
-  0      boot memory size      |<--Reserved dump area --->|      |
-  |           |                |   Permanent Reservation  |      |
-  V           V                |   (Preserve area)        |      V
-  +-----------+----------/ /---+---+----+--------+---+----+------+
-  |           |                |CPU|HPTE|  DUMP  |HDR|ELF |      |
-  +-----------+----------/ /---+---+----+--------+---+----+------+
-        |                                   ^      ^
-        |                                   |      |
-        \                                   /      |
-         -----------------------------------     FADump Header
-          Boot memory content gets transferred   (meta area)
-          to reserved area by firmware at the
-          time of crash
-
+  Low memory                                                  Top of memory
+  0      boot memory size    |<---- Reserved dump area ---->|       |
+  |           |              |     Permanent Reservation    |       |
+  V           V              |       (Preserve area)        |       V
+  +-----------+--------/ /---+---+----+-------+-----+----+--+-------+
+  |           |              |///|////|  DUMP |HDR|/|ELF |//|       |
+  +-----------+--------/ /---+---+----+-------+-----+----+--+-------+
+        |                      ^    ^     ^      ^ |      ^^
+        |                      |    |     |      | |      ||
+        \                     CPU  HPTE   /      |  \    / Backup Info
+         ---------------------------------       |   ----
+      Boot memory content gets transferred       | Start address of
+      to reserved area by firmware at the        | Backup Info.
+      time of crash.                             |
+                                             FADump Header
+                                              (meta area)
                    Fig. 1
 
 
   o Memory Reservation during second kernel after crash
 
-  Low memory                                                Top of memory
-  0      boot memory size                                        |
-  |           |<------------- Reserved dump area --------------->|
-  V           V                |<---- Preserve area ----->|      V
-  +-----------+----------/ /---+---+----+--------+---+----+------+
-  |           |                |CPU|HPTE|  DUMP  |HDR|ELF |      |
-  +-----------+----------/ /---+---+----+--------+---+----+------+
+  Low memory                                                  Top of memory
+  0      boot memory size                                           |
+  |           |<--------------- Reserved dump area ---------------->|
+  V           V              |<----- Preserve area -------->|       |
+  +-----------+--------/ /---+---+----+-------+-----+----+--+-------+
+  |           |              |///|////|  DUMP |HDR|/|ELF |//|       |
+  +-----------+--------/ /---+---+----+-------+-----+----+--+-------+
         |                                              |
         V                                              V
    Used by second                                /proc/vmcore
    kernel to boot
                    Fig. 2
 
+        +---+
+        |///| -> Regions (CPU, HPTE, HDR extension & Backup area) marked
+        +---+    like this in the above figures are not always present
+                 For example, OPAL platform does not have CPU & HPTE regions
+                 while PSeries platform doesn't use Backup area currently.
+
+
 Currently the dump will be copied from /proc/vmcore to a new file upon
 user intervention. The dump data available through /proc/vmcore will be
 in ELF format. Hence the existing kdump infrastructure (kdump scripts)
@@ -289,7 +312,10 @@ TODO:
 	2. Reserve the area of predefined size (say PAGE_SIZE) for this
 	structure and have unused area as reserved (initialized to zero)
 	for future field additions.
+
    The advantage of approach 1 over 2 is we don't need to reserve extra space.
+   Using approach 1 to provide additional meta data on OPAL platform while
+   overloading magic number field as version identifier for version tracking.
 ---
 Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
 This document is based on the original documentation written for phyp

