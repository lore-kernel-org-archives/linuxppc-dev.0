Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D3C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 18:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B00C20836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 18:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B00C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4452Xf4Wx8zDqRy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 05:08:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4451rk1cryzDqMs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:37:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 4451rj6x2gz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 04:37:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 4451rj5kMRz9sBr; Fri, 22 Feb 2019 04:37:41 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 4451rj1WxMz9s4Y
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2019 04:37:40 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1LHbBqF104058
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:37:39 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qt0j080n7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 12:37:38 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 21 Feb 2019 17:37:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 21 Feb 2019 17:37:35 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1LHbYYf27918584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 17:37:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 164C311C052;
 Thu, 21 Feb 2019 17:37:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 861E511C04C;
 Thu, 21 Feb 2019 17:37:32 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.32.125])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 21 Feb 2019 17:37:32 +0000 (GMT)
Subject: [PATCH 18/18] powerpc/fadump: Update documentation about backup
 area support
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Thu, 21 Feb 2019 23:07:31 +0530
In-Reply-To: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
References: <155077048463.21014.13936958730316555495.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022117-0028-0000-0000-0000034B65D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022117-0029-0000-0000-00002409ABD7
Message-Id: <155077065158.21014.4619439728235653815.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-21_11:, , signatures=0
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

With backup area support available for FADump on PowerNV platform,
update FADump documentation with these details.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   71 +++++++++++++---------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 6411449..42a0065 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -117,6 +117,17 @@ to ensure that crash data is preserved to process later.
    e.g.
      # echo 1 > /sys/kernel/fadump_release_opalcore
 
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
+
 Implementation details:
 ----------------------
 
@@ -131,12 +142,12 @@ that are run. If there is dump data, then the
 memory is held.
 
 If there is no waiting dump data, then only the memory required to
-hold CPU state, HPTE region, boot memory dump, FADump header and
-elfcore header, is usually reserved at an offset greater than boot
-memory size (see Fig. 1). This area is *not* released: this region
+hold CPU state, HPTE region, boot memory dump, FADump header, elfcore
+header and backup area, is usually reserved at an offset greater than
+boot memory size (see Fig. 1). This area is *not* released: this region
 will be kept permanently reserved, so that it can act as a receptacle
-for a copy of the boot memory content in addition to CPU state and
-HPTE region, in the case a crash does occur.
+for a copy of the boot memory content in addition to CPU state and HPTE
+region, in the case a crash does occur.
 
 Since this reserved memory area is used only after the system crash,
 there is no point in blocking this significant chunk of memory from
@@ -150,19 +161,19 @@ that were present in CMA region.
 
   o Memory Reservation during first kernel
 
-  Low memory                                                 Top of memory
-  0      boot memory size    |<--- Reserved dump area --->|       |
-  |           |              |    Permanent Reservatio    |       |
-  V           V              |       (Preserve area)      |       V
-  +-----------+--------/ /---+---+----+-------+-----+-----+-------+
-  |           |              |///|////|  DUMP | HDR | ELF |       |
-  +-----------+--------/ /---+---+----+-------+-----+-----+-------+
-        |                      ^    ^     ^      ^
-        |                      |    |     |      |
-        \                     CPU  HPTE   /      |
-         ---------------------------------       |
-      Boot memory content gets transferred       |
-      to reserved area by firmware at the        |
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
       time of crash.                             |
                                              FADump Header
                                               (meta area)
@@ -171,13 +182,13 @@ that were present in CMA region.
 
   o Memory Reservation during second kernel after crash
 
-  Low memory                                                 Top of memory
-  0      boot memory size                                         |
-  |           |<--------------- Reserved dump area -------------->|
-  V           V              |<---- Preserve area ------->|       |
-  +-----------+--------/ /---+---+----+-------+-----+-----+-------+
-  |           |              |///|////|  DUMP | HDR | ELF |       |
-  +-----------+--------/ /---+---+----+-------+-----+-----+-------+
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
@@ -185,9 +196,10 @@ that were present in CMA region.
                    Fig. 2
 
         +---+
-        |///| -> Regions (CPU & HPTE) marked like this in the above figures
-        +---+    are not always present. For example, OPAL platform does not
-                 have CPU & HPTE regions.
+        |///| -> Regions (CPU, HPTE, HDR extension & Backup area) marked
+        +---+    like this in the above figures are not always present.
+                 For example, OPAL platform does not have CPU & HPTE regions
+                 while PSeries platform doesn't use Backup area currently.
 
 
 Currently the dump will be copied from /proc/vmcore to a new file upon
@@ -330,7 +342,10 @@ TODO:
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

