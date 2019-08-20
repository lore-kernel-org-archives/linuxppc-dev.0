Return-Path: <SRS0=bLNb=WQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D95BC3A589
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 12:14:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E773A2082F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 12:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E773A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CV885J4GzDqfF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 22:14:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CTxQ1v93zDqwh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 22:04:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46CTxP07KNz8tSM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 22:04:41 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46CTxN5s9Dz9sDQ; Tue, 20 Aug 2019 22:04:40 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 46CTxM61Q0z9s3Z
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Aug 2019 22:04:39 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7KC28tX012256
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Aug 2019 08:04:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ugegq5gkj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Aug 2019 08:04:37 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 20 Aug 2019 13:04:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 20 Aug 2019 13:04:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7KC4Tmc46465038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Aug 2019 12:04:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FCC7AE05D;
 Tue, 20 Aug 2019 12:04:29 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3075EAE045;
 Tue, 20 Aug 2019 12:04:28 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 20 Aug 2019 12:04:28 +0000 (GMT)
Subject: [PATCH v5 03/31] powerpc/fadump: Improve fadump documentation
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 20 Aug 2019 17:34:27 +0530
In-Reply-To: <156630261682.8896.3418665808003586786.stgit@hbathini.in.ibm.com>
References: <156630261682.8896.3418665808003586786.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19082012-0028-0000-0000-00000391AD6E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082012-0029-0000-0000-00002453D134
Message-Id: <156630266743.8896.6830034015936541230.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-20_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=671 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200128
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
 Vasant Hegde <hegdevasant@linux.ibm.com>, Oliver <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The figures depicting FADump's (Firmware-Assisted Dump) memory layout
are missing some finer details like different memory regions and what
they represent. Improve the documentation by updating those details.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.rst |   61 ++++++++++++----------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index 9ca1283..563c021 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -76,8 +76,9 @@ as follows:
    there is crash data available from a previous boot. During
    the early boot OS will reserve rest of the memory above
    boot memory size effectively booting with restricted memory
-   size. This will make sure that the second kernel will not
-   touch any of the dump memory area.
+   size. This will make sure that this kernel (also, referred
+   to as second kernel or capture kernel) will not touch any
+   of the dump memory area.
 
 -  User-space tools will read /proc/vmcore to obtain the contents
    of memory, which holds the previous crashed kernel dump in ELF
@@ -128,42 +129,46 @@ space memory except the user pages that were present in CMA region::
 
   o Memory Reservation during first kernel
 
-  Low memory                                         Top of memory
-  0      boot memory size                                       |
-  |           |                |<--Reserved dump area -->|      |
-  V           V                |   Permanent Reservation |      V
-  +-----------+----------/ /---+---+----+-----------+----+------+
-  |           |                |CPU|HPTE|  DUMP     |ELF |      |
-  +-----------+----------/ /---+---+----+-----------+----+------+
-        |                                           ^
-        |                                           |
-        \                                           /
-         -------------------------------------------
-          Boot memory content gets transferred to
-          reserved area by firmware at the time of
-          crash
+  Low memory                                                Top of memory
+  0      boot memory size      |<--Reserved dump area --->|      |
+  |           |                | (Permanent Reservation)  |      |
+  V           V                |                          |      V
+  +-----------+----------/ /---+---+----+--------+---+----+------+
+  |           |                |CPU|HPTE|  DUMP  |HDR|ELF |      |
+  +-----------+----------/ /---+---+----+--------+---+----+------+
+        |                                   ^      ^
+        |                                   |      |
+        \                                   /      |
+         -----------------------------------     FADump Header
+          Boot memory content gets transferred   (meta area)
+          to reserved area by firmware at the
+          time of crash
+
                    Fig. 1
 
+
   o Memory Reservation during second kernel after crash
 
-  Low memory                                        Top of memory
-  0      boot memory size                                       |
-  |           |<------------- Reserved dump area ----------- -->|
-  V           V                                                 V
-  +-----------+----------/ /---+---+----+-----------+----+------+
-  |           |                |CPU|HPTE|  DUMP     |ELF |      |
-  +-----------+----------/ /---+---+----+-----------+----+------+
+  Low memory                                                Top of memory
+  0      boot memory size                                        |
+  |           |<----------- Crash preserved area --------------->|
+  V           V                |<-- Reserved dump area -->|      V
+  +-----------+----------/ /---+---+----+--------+---+----+------+
+  |           |                |CPU|HPTE|  DUMP  |HDR|ELF |      |
+  +-----------+----------/ /---+---+----+--------+---+----+------+
         |                                              |
         V                                              V
    Used by second                                /proc/vmcore
    kernel to boot
                    Fig. 2
 
-Currently the dump will be copied from /proc/vmcore to a
-a new file upon user intervention. The dump data available through
-/proc/vmcore will be in ELF format. Hence the existing kdump
-infrastructure (kdump scripts) to save the dump works fine with
-minor modifications.
+Currently the dump will be copied from /proc/vmcore to a new file upon
+user intervention. The dump data available through /proc/vmcore will be
+in ELF format. Hence the existing kdump infrastructure (kdump scripts)
+to save the dump works fine with minor modifications. KDump scripts on
+major Distro releases have already been modified to work seemlessly (no
+user intervention in saving the dump) when FADump is used, instead of
+KDump, as dump mechanism.
 
 The tools to examine the dump will be same as the ones
 used for kdump.

