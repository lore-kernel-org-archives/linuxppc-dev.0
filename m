Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,SUBJ_ALL_CAPS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D83FC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:07:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B3A20857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PFFt2tp6zDqCX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PF3x053szDqFp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:36 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K2s9n1103169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbcas9yrd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 20 Mar 2019 02:58:27 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 02:58:24 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K2wSeK55312580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F13F11C04C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E4D411C04A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 26146A013F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:27 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/8] 
Date: Wed, 20 Mar 2019 13:58:19 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-4275-0000-0000-0000031D0E4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-4276-0000-0000-0000382B9072
Message-Id: <cover.1553050609.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=895 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200018
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

Hi all,

This patch set adds support for EEH recovery of hot plugged devices on pSeries
machines. Specifically, devices discovered by PCI rescanning using
/sys/bus/pci/rescan, which includes devices hotplugged by QEMU's device_add
command. (pSeries doesn't currently use slot power control for hotplugging.)

As a side effect this also provides EEH support for devices removed by
/sys/bus/pci/devices/*/remove and re-discovered by writing to /sys/bus/pci/rescan,
on all platforms.

The approach I've taken is to use the fact that the existing
pcibios_bus_add_device() platform hooks (which are used to set up EEH on
Virtual Function devices (VFs)) are actually called for all devices, so I've
widened their scope and made other adjustments necessary to allow them to work
for hotplugged and boot-time devices as well.

Because some of the changes are in generic PowerPC code, it's
possible that I've disturbed something for another PowerPC platform. I've tried
to minimize this by leaving that code alone as much as possible and so there
are a few cases where eeh_add_device_{early,late}() or eeh_add_sysfs_files() is
called more than once. I think these can be looked at later, as duplicate calls
are not harmful.

The patch "Convert PNV_PHB_FLAG_EEH" isn't strictly necessary and I'm not sure
if it's better to keep it, because it simplifies the code or drop it, because
we may need a separate flag per PHB later on. Thoughts anyone?

The first patch is a rework of the pcibios_init reordering patch I posted
earlier, which I've included here because it's necessary for this set.

I have done some testing for PowerNV on Power9 using a modified pnv_php module
and some testing on pSeries with slot power control using a modified rpaphp
module, and the EEH-related parts seem to work.

Cheers,
Sam.

Sam Bobroff (8):
  powerpc/64: Adjust order in pcibios_init()
  powerpc/eeh: Clear stale EEH_DEV_NO_HANDLER flag
  powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
  powerpc/eeh: Improve debug messages around device addition
  powerpc/eeh: Add eeh_show_enabled()
  powerpc/eeh: Initialize EEH address cache earlier
  powerpc/eeh: EEH for pSeries hot plug
  powerpc/eeh: Remove eeh_probe_devices() and eeh_addr_cache_build()

 arch/powerpc/include/asm/eeh.h               | 19 +++--
 arch/powerpc/kernel/eeh.c                    | 33 ++++-----
 arch/powerpc/kernel/eeh_cache.c              | 29 +-------
 arch/powerpc/kernel/eeh_driver.c             |  4 ++
 arch/powerpc/kernel/of_platform.c            |  3 +-
 arch/powerpc/kernel/pci-common.c             |  4 --
 arch/powerpc/kernel/pci_32.c                 |  4 ++
 arch/powerpc/kernel/pci_64.c                 | 12 +++-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++------
 arch/powerpc/platforms/powernv/pci.c         |  7 +-
 arch/powerpc/platforms/powernv/pci.h         |  2 -
 arch/powerpc/platforms/pseries/eeh_pseries.c | 75 +++++++++++---------
 arch/powerpc/platforms/pseries/pci.c         |  7 +-
 13 files changed, 122 insertions(+), 118 deletions(-)

-- 
2.19.0.2.gcad72f5712

