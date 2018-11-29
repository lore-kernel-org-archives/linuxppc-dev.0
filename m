Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE9C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:22:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5000E206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 03:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5000E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4352s31gtNzDqvN
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4352kC5gKYzDqxb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAT3DZEL058873
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p26q8u0t1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:16:48 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Thu, 29 Nov 2018 03:16:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 29 Nov 2018 03:16:45 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAT3GiaX10027454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0E904C05A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AFCF4C04E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 03:16:44 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id EDD2FA0209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 14:16:42 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] powerpc/eeh: Improve recovery of passed-through devices
Date: Thu, 29 Nov 2018 14:16:36 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112903-0008-0000-0000-0000029A1F02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112903-0009-0000-0000-0000220468BA
Message-Id: <cover.1543460917.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-29_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=35
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=99 spamscore=35
 clxscore=1015 lowpriorityscore=99 mlxscore=35 impostorscore=0
 mlxlogscore=26 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811290024
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

Hello,

Here are changes that allow EEH to successfully recover after a failure that
affects of both host and guest devices. This happens, for example, when a PHB
containing passed-through devices is fenced. (Failures that include only
passed-through devices are ignored by the host.)

Currently, when an error affects both passed-through and un-passed-through
devices, the passed-through devices are treated as if their driver was not EEH
aware. This causes them to be hot-unplugged as part of recovery.

The hot unplug request is forwarded to the guest which checks the device status
before releasing the device. Because the host is recovering the device, it
reports the device status as EEH_STATE_UNAVAILABLE which causes the guest to
wait for the device to become available. This deadlocks the recovery process.

This change causes the host to recover it's own devices but leave
passed-through devices frozen until the guest performs it's own recovery. (They
are not removed.) If the guest detects the error and begins recovery itself,
waiting for the device state to change away from EEH_STATE_UNAVAILABLE causes
it to wait until the host has finished it's recovery and the guest's subsequent
recovery can then succeed.

Note that resetting a PE may implicitly thaw both it and child PEs, and to
prevent the device from being accidentally used by the guest (which may be
unaware of the failure and reset) when in this state, we re-freeze those
devices. This does leave a small window of opportunity but that will need to be
addressed with a firmware change.

I've also included a fix to the reset function (the last patch), because
without it some scenarios still fail. An example is injecting an error into
a PHB and then exiting a guest that contains passed-through devices from that
PHB so that an EEH event is raised during the process of passing the device
back to the host.

Cheers,
Sam.

Sam Bobroff (6):
  powerpc/eeh: Cleanup eeh_pe_clear_frozen_state()
  powerpc/eeh: remove sw_state from eeh_unfreeze_pe()
  powerpc/eeh: Add include_passed to eeh_pe_state_clear()
  powerpc/eeh: Add include_passed to eeh_clear_pe_frozen_state()
  powerpc/eeh: Improve recovery of passed-through devices
  powerpc/eeh: Correct retries in eeh_pe_reset_full()

 arch/powerpc/include/asm/eeh.h     |   4 +-
 arch/powerpc/include/asm/ppc-pci.h |   4 +-
 arch/powerpc/kernel/eeh.c          | 103 +++++++++++++++++++----------
 arch/powerpc/kernel/eeh_driver.c   |  86 ++++++++++--------------
 arch/powerpc/kernel/eeh_pe.c       |  68 ++++++++-----------
 arch/powerpc/kernel/eeh_sysfs.c    |   3 +-
 drivers/vfio/vfio_spapr_eeh.c      |   6 +-
 7 files changed, 140 insertions(+), 134 deletions(-)

-- 
2.19.0.2.gcad72f5712

