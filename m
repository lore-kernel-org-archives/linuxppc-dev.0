Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E6C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 05:34:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00386206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 05:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00386206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TcBp1NtqzDqLZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 16:34:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tc8C5NSyzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 16:32:26 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2R5Tq42101206
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:32:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rg05m5nnd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 01:32:24 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 27 Mar 2019 05:32:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Mar 2019 05:32:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2R5WI1j54067332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2019 05:32:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCB7142049;
 Wed, 27 Mar 2019 05:32:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A8C142045;
 Wed, 27 Mar 2019 05:32:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 27 Mar 2019 05:32:18 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 51072A00BD;
 Wed, 27 Mar 2019 16:32:16 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v4 0/7] Refactor OCXL driver to allow external drivers to use
 it
Date: Wed, 27 Mar 2019 16:31:29 +1100
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032705-0028-0000-0000-00000358B771
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032705-0029-0000-0000-0000241771B1
Message-Id: <20190327053137.15173-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-27_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=706 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270038
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

This series reworks the OpenCAPI driver to split frontend
(driver interactions) from backend (hardware interactions).

This allows external drivers to utilise the core of the
generic OpenCAPI driver to communicate with specific
OpenCAPI hardware.

This series is bisectable.

Changelog:
V4: 
  - For: 'ocxl: Create a clear delineation between ocxl backend & frontend'
      - Reword non-RCU comment to reflect info struct
      - Inline returns from err label in afu_open()
      - ocxl_file_make_(in)visibile & ocxl_sysfs_(un)register use info
        directly, rather than fetching in from the AFU. This, together with
        a delayed ocxl_afu_set_private(), make it clearer that
        ocxl_file_register() must succeed for cleanup code to be called
      - Remove stray ocxl_free_afu() prototype from header
  - For: 'ocxl: Allow external drivers to use OpenCAPI contexts'
      - Merge ocxl_context_init & ocxl_context_alloc
      - Add missing opaque struct ocxl_context 
  - For: 'ocxl: move event_fd handling to frontend'
      - Set missed free_private value in irq struct
      - Change goto unlock to fall-through comment
      - Clean stray whitespace
      - Mention that free_private can be NULL in ocxl_irq_set_handler docs
V3:
  - For: 'ocxl: Create a clear delineation between ocxl backend & frontend'
      - Integrate Frederick Barrat's suggestions
      - Further cleanup on error paths
      - Remove release handler for AFU private data
      - Make ocxl_file_make_(in)visibile static & call from ocxl_file_(un)register
V2:
  - Reorder patches as some required structs that were only available later
  - Add dev.release implementation for ocxl_file_info to address warning on
    driver unload (ocxl: Create a clear delineation...)
  - Set output var irq_id in ocxl_afu_irq_alloc (ocxl: afu_irq only deals...)
  - Bump copyright year (ocxl: Provide global MMIO accessors...,
        ocxl: Split pci.c)

Alastair D'Silva (7):
  ocxl: Split pci.c
  ocxl: Don't pass pci_dev around
  ocxl: Create a clear delineation between ocxl backend & frontend
  ocxl: Allow external drivers to use OpenCAPI contexts
  ocxl: afu_irq only deals with IRQ IDs, not offsets
  ocxl: move event_fd handling to frontend
  ocxl: Provide global MMIO accessors for external drivers

 drivers/misc/ocxl/Makefile        |   3 +-
 drivers/misc/ocxl/afu_irq.c       | 102 +++---
 drivers/misc/ocxl/context.c       |  31 +-
 drivers/misc/ocxl/core.c          | 574 ++++++++++++++++++++++++++++++
 drivers/misc/ocxl/file.c          | 177 ++++++---
 drivers/misc/ocxl/mmio.c          | 234 ++++++++++++
 drivers/misc/ocxl/ocxl_internal.h |  39 +-
 drivers/misc/ocxl/pci.c           | 565 ++---------------------------
 drivers/misc/ocxl/sysfs.c         |  54 +--
 drivers/misc/ocxl/trace.h         |  12 +-
 include/misc/ocxl.h               | 314 +++++++++++++++-
 11 files changed, 1390 insertions(+), 715 deletions(-)
 create mode 100644 drivers/misc/ocxl/core.c
 create mode 100644 drivers/misc/ocxl/mmio.c

-- 
2.20.1

