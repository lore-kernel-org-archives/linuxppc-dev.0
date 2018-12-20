Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B75C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:06:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6D6218FF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6D6218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LLpl1VGtzDr42
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:06:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLgS4KJFzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:00:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLgS3VhMz8vRt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:00:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLgS29s8z9sCV; Fri, 21 Dec 2018 06:00:36 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43LLgR5vTMz9sCQ
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:00:35 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIx1g2043932
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:00:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pgffuk8q7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:00:33 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:00:31 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:00:29 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ0SJK10224124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:00:28 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C555AE04D;
 Thu, 20 Dec 2018 19:00:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6EBDAE057;
 Thu, 20 Dec 2018 19:00:26 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:00:26 +0000 (GMT)
Subject: [PATCH 2/9] powerpc/fadump: Improve fadump documentation
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:30:25 +0530
In-Reply-To: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
References: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0008-0000-0000-000002A4344B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0009-0000-0000-0000220ED32F
Message-Id: <154533242556.28973.13958422857496711413.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=857 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The figures depicting FADump's (Firmware-Assisted Dump) memory layout
are missing some finer details like different memory regions and what
they represent. Improve the documentation by updating those details.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |   56 ++++++++++++----------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 18c5fee..4897665 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -125,42 +125,46 @@ space memory except the user pages that were present in CMA region.
 
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
+  |           |                |   Permanent Reservation  |      |
+  V           V                |   (Preserve area)        |      V
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
+  |           |<------------- Reserved dump area --------------->|
+  V           V                |<---- Preserve area ----->|      V
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

