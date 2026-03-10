Return-Path: <linuxppc-dev+bounces-17944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7441AFCC9DD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 08:22:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVRgV3m5kz3bjb;
	Tue, 10 Mar 2026 19:21:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773130918;
	cv=none; b=Y4OjI1Ut322GCYjDx9qOFdAc6wfElZMbkCCaqNGtWvTAN+vMQ1g7S7O6V3vlZLXNsCZvMSf8MQfUFKyPOWk1zgRTlqHAPNI4hrA/+JnNtPpsN7BhmEJRcjUIkEI+UAdA4TNLLzKxC4fPHO9T2ho2ce3TgOP7KkpOSKoWaNiYvyHU1Nf3w1ZXBLZERW+BPiZclaIqbK4pbwr4Dq5fYQJeGPvUaIE9a+Agon31KeOD2EU8dYnF3tXF+quCMzAX2S721BLdAytzWJU8+ij8iOegOWBWVJwafuihqNBSEFwCaAxCGKv6LYoMfPXG9BNL3uznpWmkGHtDz4kOJQ33kouR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773130918; c=relaxed/relaxed;
	bh=hOTYgg6mAnrJZtsmRXaTdKZxYr1YPaOyUamHM4muKFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JI1J9MBzii0t5HS/7sgbEwOnY7pf1MTgLp9D/t0YeIOMBu4Zq82KJ6QFOv0Ct+fiGC7OT2FQCT1VJ4NlxABQtQs5H5id8kFXayUAprsK9P/Qh5ru5gF0PTUrst1FPdAIAA847iLKPhmTcfa1R1NjawiSI0iwHL1vR6lT4yGkKleCVdIW4v0dtSZuPdJSKUqlrJVsnsG8TnhJDhhT5/N4qmr3CULwO8gbhs2bv9HOrgFVx5dXzqSFa4CtIjKB985Jnhk2JcNdEsM6VqN7Gq3QBYXghB+H/3B8nynZNyPQarrNsjIeSBE2jtA3r+PliaouEmB+lbsqSSclrs4ziB2LKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kDDzB6sj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kDDzB6sj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nilay@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVRgT2jFvz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 19:21:56 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629H1oka1991199;
	Tue, 10 Mar 2026 08:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hOTYgg6mAnrJZtsmRXaTdKZxYr1YPaOyUamHM4muK
	Fo=; b=kDDzB6sjONzwzpZVsE0J+NAIwKKcr8shBV6iUYZIkmGNVrS3DRsVF9Esy
	E5JqkBbVI24OHniSOcv8V1j0BGSuoG7hcI7cisn3cWyzn74Z5A4p8iTKM+lX29Vq
	XcbXYnNfrAOL2T/izVL8AvAcS0gfHrTe8ItOcYcHCWv2K/i6Jkl0VEPzNHmYFEg/
	je37fxEiYlNKAYcoviuMAFz8b5y8CJNdDFzK7qpoDrOQ67uNkOUdj9Qn7CtjhRSX
	plKZfQuGpq+wA77A5f76GObUdbC+pJ4W1jr0ycJgNXyh8HK00BX/GX3U8fo1JxlW
	c6mEth0hGNESxNmB/ti3FTC1FHV1g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywa09k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 08:21:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A5cFMd029850;
	Tue, 10 Mar 2026 08:21:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4csp6umw53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 08:21:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62A8LfaZ44433780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 08:21:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6FC62004D;
	Tue, 10 Mar 2026 08:21:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4906520043;
	Tue, 10 Mar 2026 08:21:38 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.124.213.198])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 08:21:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: iommu@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
Cc: nicolinc@nvidia.com, joerg.roedel@amd.com, jgg@nvidia.com,
        baolu.lu@linux.intel.com, kevin.tian@intel.com, maddy@linux.ibm.com,
        sbhat@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>,
        stable@vger.kernel.org
Subject: [PATCH] powerpc/iommu: fix lockdep warning during PCI enumeration
Date: Tue, 10 Mar 2026 13:51:24 +0530
Message-ID: <20260310082129.3630996-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NyBTYWx0ZWRfX9zIN52HLKd+M
 FDuF9gD3N8l9EulZyXFz7g59ci4YfCL5D06JSIKpCG9Sdm6aQzNnh2GoPjD3fQL2IH0g3BtFd3q
 Y0iwYUAqwVQns+ZUWaVY7DvPCPgQYrhZkB+s5ChGIaiIgTqdzwGxnM8Ig1vQN2zjB8FglMXhYXB
 iWt8QS6XmpnvGOpL/rlZgiGX9PLmzlrnoyXsFQyP6ln8jiHOtcL/oBiRwl+4u2jb0+enplbZ+VN
 s0iqL6W28cqy3MH4Tle4VWfdxGKG9yaQImbFM3FQgXGrW1umHzLiA/AdSNoVJL7JZK19kACJ2q5
 Mgays45JNmPYNepC8qYMeyLB/4/vCkSylVzE6uqlgbw1K/SUW9n92WshPEFD1Q5MJFpEfdRj9qf
 U0718joUHo7gmgBXHCQzIuxzDtPpSIXFbS8wMuLfeSSyxH1VY/Kfuu0S+3QaN6kcxPJoMT/jCRs
 fSI63QfOu62WLpRZxSw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69afd49b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ekpCZll6AK0GQq_nEskA:9
X-Proofpoint-GUID: 2Elq3pM91g6BGRAPrlWp0DnOX4jzOR_A
X-Proofpoint-ORIG-GUID: 2Elq3pM91g6BGRAPrlWp0DnOX4jzOR_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100067

Commit a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev()
helper") introduced iommu_driver_get_domain_for_dev() for driver
code paths that hold iommu_group->mutex while attaching a device
to an IOMMU domain.

The same commit also added a lockdep assertion in
iommu_get_domain_for_dev() to ensure that callers do not hold
iommu_group->mutex when invoking it.

On powerpc platforms, when PCI device ownership is switched from
BLOCKED to the PLATFORM domain, the attach callback
spapr_tce_platform_iommu_attach_dev() still calls
iommu_get_domain_for_dev(). This happens while iommu_group->mutex
is held during domain switching, which triggers the lockdep warning
below during PCI enumeration:

WARNING: drivers/iommu/iommu.c:2252 at iommu_get_domain_for_dev+0x38/0x80, CPU#2: swapper/0/1
Modules linked in:
CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc2+ #35 PREEMPT
Hardware name: IBM,9105-22A Power11 (architected) 0x820200 0xf000007 of:IBM,FW1120.00 (RB1120_115) hv:phyp pSeries
NIP:  c000000000c244c4 LR: c00000000005b5a4 CTR: c00000000005b578
REGS: c00000000a7bf280 TRAP: 0700   Not tainted  (7.0.0-rc2+)
MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 22004422  XER: 0000000a
CFAR: c000000000c24508 IRQMASK: 0
GPR00: c00000000005b5a4 c00000000a7bf520 c000000001dc8100 0000000000000001
GPR04: c00000000f972f10 0000000000000000 0000000000000000 0000000000000001
GPR08: 0000001ffbc60000 0000000000000001 0000000000000000 0000000000000000
GPR12: c00000000005b578 c000001fffffe480 c000000000011618 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: ffffffffffffefff 0000000000000000 c000000002d30eb0 0000000000000001
GPR24: c0000000017881f8 0000000000000000 0000000000000001 c00000000f972e00
GPR28: c00000000bbba0d0 0000000000000000 c00000000bbba0d0 c00000000f972e00
NIP [c000000000c244c4] iommu_get_domain_for_dev+0x38/0x80
LR [c00000000005b5a4] spapr_tce_platform_iommu_attach_dev+0x2c/0x98
Call Trace:
 iommu_get_domain_for_dev+0x68/0x80 (unreliable)
 spapr_tce_platform_iommu_attach_dev+0x2c/0x98
 __iommu_attach_device+0x44/0x220
 __iommu_device_set_domain+0xf4/0x194
 __iommu_group_set_domain_internal+0xec/0x228
 iommu_setup_default_domain+0x5f4/0x6a4
 __iommu_probe_device+0x674/0x724
 iommu_probe_device+0x50/0xb4
 iommu_add_device+0x48/0x198
 pci_dma_dev_setup_pSeriesLP+0x198/0x4f0
 pcibios_bus_add_device+0x80/0x464
 pci_bus_add_device+0x40/0x100
 pci_bus_add_devices+0x54/0xb0
 pcibios_init+0xd8/0x140
 do_one_initcall+0x8c/0x598
 kernel_init_freeable+0x3ec/0x850
 kernel_init+0x34/0x270
 ret_from_kernel_user_thread+0x14/0x1c

Fix this by using iommu_driver_get_domain_for_dev() instead of
iommu_get_domain_for_dev() in spapr_tce_platform_iommu_attach_dev(),
which is the appropriate helper for callers holding the group mutex.

Cc: stable@vger.kernel.org
Fixes: a75b2be249d6 ("iommu: Add iommu_driver_get_domain_for_dev() helper")
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 arch/powerpc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 0ce71310b7d9..d122e8447831 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -1159,7 +1159,7 @@ spapr_tce_platform_iommu_attach_dev(struct iommu_domain *platform_domain,
 				    struct device *dev,
 				    struct iommu_domain *old)
 {
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_driver_get_domain_for_dev(dev);
 	struct iommu_table_group *table_group;
 	struct iommu_group *grp;
 
-- 
2.53.0


