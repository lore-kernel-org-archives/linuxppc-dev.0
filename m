Return-Path: <SRS0=UcJ4=Y5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE59FC5DF60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 15:26:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C402053B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 15:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C402053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 476tn82Pw9zF3qW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 02:26:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 476tkN70TgzF3gh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2019 02:24:28 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5FJRXY020021; Tue, 5 Nov 2019 10:24:19 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w3bmf07jq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 10:24:19 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5FOGwg018700;
 Tue, 5 Nov 2019 15:24:18 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2w11e7xcf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:24:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5FOHhi30147054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 15:24:17 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A2502805E;
 Tue,  5 Nov 2019 15:24:17 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A329328058;
 Tue,  5 Nov 2019 15:24:16 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 15:24:16 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 0/9] Fixes and Enablement of ibm,drc-info property 
Date: Tue,  5 Nov 2019 09:24:04 -0600
Message-Id: <1572967453-9586-1-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050126
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
Cc: nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There was a previous effort to add support for the PAPR
architected ibm,drc-info property. This property provides a more
memory compact representation of a paritions Dynamic Reconfig
Connectors (DRC). These can otherwise be thought of as currently
partitioned, or available but yet to be partitioned system resources
such as cpus, memory, and physical/logical IOA devices.

The initial implementation proved buggy and was fully turned of by
disabling the bit in the appropriate CAS support vector. We now have
PowerVM firmware in the field that supports this new property, and 
further to suppport partitions with 24TB+ of possible memory this
property is required to perform platform migration.

This serious fixs the short comings of the previous submission
in the areas of general implementation, cpu hotplug, and IOA hotplug.

Tyrel Datwyler (9):
  powerpc/pseries: Fix bad drc_index_start value parsing of drc-info
    entry
  powerpc/pseries: Fix drc-info mappings of logical cpus to drc-index
  powerpc/pseries: Add cpu DLPAR support for drc-info property
  PCI: rpaphp: Fix up pointer to first drc-info entry
  PCI: rpaphp: Don't rely on firmware feature to imply drc-info support
  PCI: rpaphp: Add drc-info support for hotplug slot registration
  PCI: rpaphp: annotate and correctly byte swap DRC properties
  PCI: rpaphp: Correctly match ibm,my-drc-index to drc-name when using
    drc-info
  powerpc/pseries: Enable support for ibm,drc-info property

 arch/powerpc/kernel/prom_init.c                 |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    | 101 ++++++++++++++++---
 arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
 arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
 drivers/pci/hotplug/rpaphp_core.c               | 124 +++++++++++++++++-------
 5 files changed, 187 insertions(+), 71 deletions(-)

-- 
2.7.4

