Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4783AC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:02:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79130218FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79130218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LLjj5TPLzDr7C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 06:02:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LLgB0JPrzDr3B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:00:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43LLg96KvZz8vqJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 06:00:21 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43LLg95lC7z9sCh; Fri, 21 Dec 2018 06:00:21 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43LLg91lDYz9sCQ
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2018 06:00:20 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBKIwk8h173536
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:00:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2pgg7uhcyj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2018 14:00:17 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Thu, 20 Dec 2018 19:00:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 20 Dec 2018 19:00:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBKJ0Cad51445984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Dec 2018 19:00:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B31311C06C;
 Thu, 20 Dec 2018 19:00:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4C6311C050;
 Thu, 20 Dec 2018 19:00:10 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.199.47.3])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 20 Dec 2018 19:00:10 +0000 (GMT)
Subject: [PATCH 0/9] Add FADump support on PowerNV platform
From: Hari Bathini <hbathini@linux.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Stewart Smith <stewart@linux.ibm.com>
Date: Fri, 21 Dec 2018 00:30:09 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122019-0020-0000-0000-000002FA7146
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122019-0021-0000-0000-0000214A84D1
Message-Id: <154533238217.28973.10173741387253773210.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-20_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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

Firmware-Assisted Dump (FADump) is currently supported only on pseries
platform. This patch series adds support for powernv platform too.

The first and third patches refactor the FADump code to make use of common
code across multiple platforms. The fourth patch adds basic FADump support
to powernv platform. The next patch processes CPU state data provided by
F/W and adds core notes to core file. The sixth patch adds support to export
opalcore. This is to make debugging of failures in opal code easier. The
remaining patches update firmware-assisted dump documentation appropriately.

The patch series is tested with the latest firmware plus the below skiboot
changes for MPIPL support:

    https://patchwork.ozlabs.org/project/skiboot/list/?series=78497
    ("MPIPL support")

The patches are based on top of the below fadump changes:

    https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=61500
    ("powerpc/fadump: Improvements for firmware-assisted dump")

---

Hari Bathini (9):
      powerpc/fadump: move internal fadump code to a new file
      powerpc/fadump: Improve fadump documentation
      pseries/fadump: move out platform specific support from generic code
      powerpc/fadump: enable fadump support on OPAL based POWER platform
      powerpc/fadump: process architected register state data provided by firmware
      powerpc/powernv: export /proc/opalcore for analysing opal crashes
      powerpc/fadump: add support to preserve crash data on FADUMP disabled kernel
      powerpc/fadump: use FADump instead of fadump for how it is pronounced
      powerpc/fadump: Update documentation about OPAL platform support


 Documentation/powerpc/firmware-assisted-dump.txt |  168 ++--
 arch/powerpc/Kconfig                             |   14 
 arch/powerpc/include/asm/fadump.h                |  191 ----
 arch/powerpc/include/asm/opal-api.h              |   35 +
 arch/powerpc/include/asm/opal.h                  |    1 
 arch/powerpc/kernel/Makefile                     |    6 
 arch/powerpc/kernel/fadump.c                     |  994 ++++++----------------
 arch/powerpc/kernel/fadump_internal.c            |  334 +++++++
 arch/powerpc/kernel/fadump_internal.h            |  228 +++++
 arch/powerpc/kernel/prom.c                       |    4 
 arch/powerpc/platforms/powernv/Makefile          |    5 
 arch/powerpc/platforms/powernv/opal-core.c       |  385 +++++++++
 arch/powerpc/platforms/powernv/opal-core.h       |   35 +
 arch/powerpc/platforms/powernv/opal-fadump.c     |  655 ++++++++++++++
 arch/powerpc/platforms/powernv/opal-fadump.h     |   49 +
 arch/powerpc/platforms/powernv/opal-wrappers.S   |    1 
 arch/powerpc/platforms/pseries/Makefile          |    1 
 arch/powerpc/platforms/pseries/pseries_fadump.c  |  534 ++++++++++++
 arch/powerpc/platforms/pseries/pseries_fadump.h  |   96 ++
 19 files changed, 2749 insertions(+), 987 deletions(-)
 create mode 100644 arch/powerpc/kernel/fadump_internal.c
 create mode 100644 arch/powerpc/kernel/fadump_internal.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.h
 create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.c
 create mode 100644 arch/powerpc/platforms/pseries/pseries_fadump.h

