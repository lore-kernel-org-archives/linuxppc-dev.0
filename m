Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA1CC10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:34:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB6D206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB6D206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k1vS31s6zDqKy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:34:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1sQ6TDFzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:32:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44k1sP58GFz8t5T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:32:41 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 44k1sP4YWrz9s4V; Tue, 16 Apr 2019 20:32:41 +1000 (AEST)
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
 by ozlabs.org (Postfix) with ESMTPS id 44k1sP1KMkz9s3q
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 20:32:40 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GAUpTX084678
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:32:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rwcb52kp9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2019 06:32:37 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.ibm.com>;
 Tue, 16 Apr 2019 11:32:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:32:31 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GAWUZe57933858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:32:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0971852057;
 Tue, 16 Apr 2019 10:32:30 +0000 (GMT)
Received: from hbathini.in.ibm.com (unknown [9.184.183.117])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BAC0A5204E;
 Tue, 16 Apr 2019 10:32:28 +0000 (GMT)
Subject: [PATCH v2 00/16] Add FADump support on PowerNV platform
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Date: Tue, 16 Apr 2019 16:02:27 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-4275-0000-0000-00000328641F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-4276-0000-0000-00003837946F
Message-Id: <155541065470.812.7120798773144842076.stgit@hbathini.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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

Firmware-Assisted Dump (FADump) is currently supported only on pseries
platform. This patch series adds support for powernv platform too.

The first and third patches refactor the FADump code to make use of common
code across multiple platforms. The fifth patch adds basic FADump support
for powernv platform. Patches seven & eight honour reserved-ranges DT node
while reserving/releasing memory used by FADump. The next patch processes
CPU state data provided by firmware to create and append core notes to the
ELF core file. The tenth patch adds support for preserving crash data for
subsequent boots (useful in cases like petitboot). Patch twelve provides
support to export opalcore. This is to make debugging of failures in OPAL
code easier. The subsequent patch ensures vmcore processing is skipped
when only OPAL core is exported by f/w. The next patch provides option to
release the kernel memory used to export opalcore. The remaining patches
update Firmware-Assisted Dump documentation appropriately.

The patch series is tested with the latest firmware plus the below skiboot
changes for MPIPL support:

    https://patchwork.ozlabs.org/project/skiboot/list/?series=102588
    ("MPIPL support")


Changes in v2:
  * Rebased to latest upstream kernel version.
  * Updated according to latest OPAL changes.
  * Dropped patch seventeen from previous version as the quantam of increase
    in robustness due it doesn't seem worth breaking backward compatibility
    for older kernel versions.
---

Hari Bathini (16):
      powerpc/fadump: move internal fadump code to a new file
      powerpc/fadump: Improve fadump documentation
      pseries/fadump: move out platform specific support from generic code
      powerpc/fadump: use FADump instead of fadump for how it is pronounced
      powerpc/fadump: enable fadump support on OPAL based POWER platform
      powerpc/fadump: Update documentation about OPAL platform support
      powerpc/fadump: consider reserved ranges while reserving memory
      powerpc/fadump: consider reserved ranges while releasing memory
      powernv/fadump: process architected register state data provided by firmware
      powernv/fadump: add support to preserve crash data on FADUMP disabled kernel
      powerpc/fadump: update documentation about CONFIG_PRESERVE_FA_DUMP
      powerpc/powernv: export /proc/opalcore for analysing opal crashes
      powernv/fadump: Skip processing /proc/vmcore when only OPAL core exists
      powernv/opalcore: provide an option to invalidate /proc/opalcore file
      powernv/fadump: consider f/w load area
      powernv/fadump: update documentation about option to release opalcore


 Documentation/powerpc/firmware-assisted-dump.txt |  193 ++--
 arch/powerpc/Kconfig                             |   23 
 arch/powerpc/include/asm/fadump.h                |  190 ----
 arch/powerpc/include/asm/opal-api.h              |   58 +
 arch/powerpc/include/asm/opal.h                  |    1 
 arch/powerpc/kernel/Makefile                     |    6 
 arch/powerpc/kernel/fadump-common.c              |  205 ++++
 arch/powerpc/kernel/fadump-common.h              |  222 ++++
 arch/powerpc/kernel/fadump.c                     | 1163 ++++++++--------------
 arch/powerpc/kernel/prom.c                       |    4 
 arch/powerpc/platforms/powernv/Makefile          |    3 
 arch/powerpc/platforms/powernv/opal-call.c       |    1 
 arch/powerpc/platforms/powernv/opal-core.c       |  602 +++++++++++
 arch/powerpc/platforms/powernv/opal-fadump.c     |  562 +++++++++++
 arch/powerpc/platforms/powernv/opal-fadump.h     |  116 ++
 arch/powerpc/platforms/pseries/Makefile          |    1 
 arch/powerpc/platforms/pseries/rtas-fadump.c     |  534 ++++++++++
 arch/powerpc/platforms/pseries/rtas-fadump.h     |   96 ++
 18 files changed, 2998 insertions(+), 982 deletions(-)
 create mode 100644 arch/powerpc/kernel/fadump-common.c
 create mode 100644 arch/powerpc/kernel/fadump-common.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-core.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-fadump.h
 create mode 100644 arch/powerpc/platforms/pseries/rtas-fadump.c
 create mode 100644 arch/powerpc/platforms/pseries/rtas-fadump.h

