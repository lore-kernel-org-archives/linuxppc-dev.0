Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1087C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 16:57:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AC952087F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 16:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC952087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pt2v4kTCzDqKw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 03:57:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pt0y42vyzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 03:55:45 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TGtWhX107365
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:55:42 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qarv4q1de-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 11:55:42 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 29 Jan 2019 16:55:41 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 16:55:38 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TGtbeW22806696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 16:55:37 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 583FA112065;
 Tue, 29 Jan 2019 16:55:37 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45D5D112066;
 Tue, 29 Jan 2019 16:55:37 +0000 (GMT)
Received: from ltcalpine2-lp20.aus.stglabs.ibm.com (unknown [9.40.195.203])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 16:55:37 +0000 (GMT)
Received: from ltcalpine2-lp20.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp20.aus.stglabs.ibm.com (Postfix) with ESMTP id 9C93540B726F;
 Tue, 29 Jan 2019 10:55:36 -0600 (CST)
Subject: [REPOST PATCH v07 0/5] powerpc/migration: Affinity fix for memory
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Tue, 29 Jan 2019 10:55:36 -0600
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012916-0060-0000-0000-0000030267FC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153535; UDB=6.00601407; IPR=6.00933901; 
 MB=3.00025341; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 16:55:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012916-0061-0000-0000-0000481AA2CC
Message-Id: <20190129165514.14612.16201.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=958 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290126
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The migration of LPARs across Power systems affects many attributes
including that of the associativity of memory blocks.  The patches
in this set execute when a system is coming up fresh upon a migration
target.  They are intended to,

* Recognize changes to the associativity of memory recorded in
  internal data structures when compared to the latest copies in
  the device tree (e.g. ibm,dynamic-memory, ibm,dynamic-memory-v2).
* Recognize changes to the associativity mapping (e.g. ibm,
  associativity-lookup-arrays), locate all assigned memory blocks
  corresponding to each changed row, and readd all such blocks.
* Generate calls to other code layers to reset the data structures
  related to associativity of memory.
* Re-register the 'changed' entities into the target system.
  Re-registration of memory blocks mostly entails acting as if they
  have been newly hot-added into the target system.

This code builds upon features introduced in a previous patch set
that updates CPUs for affinity changes that may occur during LPM.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Michael Bringmann (5):
  powerpc/drmem: Export 'dynamic-memory' loader
  powerpc/drmem: Add internal_flags feature
  migration/memory: Add hotplug flags READD_MULTIPLE
  migration/memory: Evaluate LMB assoc changes
  migration/memory: Support 'ibm,dynamic-memory-v2'
---
Changes in v07:
  -- Provide more useful return value from dlpar_memory_readd_multiple
Changes in v06:
  -- Rebase to powerpc next branch to account for recent code changes.
  -- Fix prototype problem when CONFIG_MEMORY_HOTPLUG not defined.
Changes in v05:
  -- Add walk_drmem_lmbs_pairs to replace macro for_each_pair_lmb
  -- Use walk_drmem_lmbs_pairs and callback instead of local loop
  -- Provide dlpar_memory_readd_helper routine to compress some common code
  -- Move common structure from numa.c + hotplug-memory.c to header file.
  -- Clarify some comments.
Changes in v04:
  -- Move dlpar_memory_readd_multiple() to patch with new ACTION
     constant.
  -- Move init of 'lmb->internal_flags' in init_drmem_v2_lmbs to
     patch with other references to flag.
  -- Correct spacing in one of the patches
Changes in v03:
  -- Change operation to tag changed LMBs in DRMEM array instead of
     queuing a potentially huge number of structures.
  -- Added another hotplug queue event for CPU/memory operations
  -- Added internal_flags feature to DRMEM
  -- Improve the patch description language for the patch set.
  -- Revise patch set to queue worker for memory association
     updates directly to pseries worker queue.

