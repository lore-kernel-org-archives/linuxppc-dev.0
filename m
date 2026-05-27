Return-Path: <linuxppc-dev+bounces-21605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B955CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 18:08:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQd0P337Zz2ySJ;
	Thu, 28 May 2026 04:08:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779905317;
	cv=none; b=HoerTj4Q5+lVNL4r5vf4urcInlHFzoW1k8F5QkAkEgTTcApbxTatLnTqNTOTTYV5/vFO9z/dC0LXbf64NiroDK2MuQAv1HHtm1L1GMgLBaMqEEyHZ68YVKw9aEVfqP2EF4wb+Gqxc32c/+p7yfBD2cPYAJ4bqvXPGzqpmLx/F8QdofmKkh7i+68hbexgcuNC5+4DG8tY84GGf8qNUdcDcg4YbCgmEqC+rsMHvcErlR644CKePRzNNLUnnSNfQAtQS5uZuqphNie+tSCPt1KvJhcqImq2VQeBEnck4tgCDeCwV6NkHUoOJ/uFnPD9ypvzPwz6g+iNdv0/RmczQfHxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779905317; c=relaxed/relaxed;
	bh=KBhArppnVBBM6M4CD8pwBApItJWNjiw5adP314oYdw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Na2LEJvavac5kATY3QMWnfLtoTsvSP+OkSHfb2q84cPt6u6ZAAcTWUwMYUdcdFZv4FWpD3nbozLfRl1CYUAeNXC2zZvJOUZYbcD7o7jre7jgznfdyCmvRfuJJHv+75bhCmMkKtfhZtFxqZqz705jJKp9egEc1U/Rzemfy01oshXeHvkAeNjM+gGOuFsAae2HYhv2CnJmRzi9Nu02iIpGHNg9J5dJ3mJ28T/WZxWS3CoCE+/ga/9Xn4eYAF5jXq9ihFPrZO5n6iv3inVFSyML+EMNc+2rzuSpdBsrylUX8t2+PRPfoZAWFkHtaLZNdCONnuLfnQhIXwbz+AmJuWlZ0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z3uT0DTu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z3uT0DTu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQd0N4jD9z2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 04:08:36 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCB3Nn3594524;
	Wed, 27 May 2026 18:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KBhArppnVBBM6M4CD8pwBApItJWNjiw5adP314oYd
	w4=; b=Z3uT0DTu+ki3LEq5EMotRXZ01goq9hXOiO6xz5nlxRctx1bsqvfSsCjog
	C7xb5A9uUyU/iCHbFZUrSWJVaharwjmmTBBtE64Qb3QGxq662VCIPJ3KPPZBy7Lc
	ymKJexdhv0NB7Bj14JrVdlk/ixW01M0eDqUIGz9kkNzci4cEKuyZmeRRRUdojCwX
	wZji8zRw0cQFjdVwncphdFz3F+53zKdU8KmbmHBSw01KLwnxyv+Pq6fCeCZrQQSf
	ZTzxiOtqk6JQY09oICj76FXIDQGoVSB1vOglDR9+5Qioil/juISZL58lsBEEIbWZ
	zujG9QgrAGn0AcbdjA3x1WM/sjJIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2jsp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RHs53Z010671;
	Wed, 27 May 2026 18:08:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb4avw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 18:08:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RI8MQl45285874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 18:08:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C14BA20040;
	Wed, 27 May 2026 18:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D13482004B;
	Wed, 27 May 2026 18:08:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.220.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 18:08:18 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2 0/3] ppc/pnv: Fix panics and refactor pnv_php.c
Date: Wed, 27 May 2026 23:38:13 +0530
Message-ID: <20260527180816.2749186-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZahQOOm8zkH4eWS-r5JH1W7QD0QFF9rc
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a17331b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=19T7HI5kWQHWw3tJfkgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE4MiBTYWx0ZWRfX1pCvED0rGHRZ
 M4oSgjofiwDOuTw4tWitjmN9aLcKYJOmLF7abWijjHrM7iwu8FQMqdvFvzny25FxxLCJ2v/SffD
 XPktyDlBcpX4ckyUpuYjSfmR78h7iaax9iDyb/kK2F78e2F2j6ng6lyZX1TXe5cUzqKLdBqCvzS
 ZqpePIJaKqPuV8k7oIQ1/ROBhZgPl3VRD3I0ZPSFvOvsjWgHShoY7ZBzSYcPq/qvTKCDf8UPNDn
 BG5TQzIHHJQwATNZ+DoFzWcwBXsNogSG4YHNSXt5tkZ5bz2cgL6ya8eQiMHovuChb0JpCuJz2SA
 SBEVTiDlihCBdmfTA62Vz4yPtXKsg/22J34DsTC9xwFTijuO+VTaRsGvGeApxdcMbzj7ySd9DvS
 uTzNCQ2lpYGjaxXzF5H0b0a6xLNENPzNz/h7nAu5haNwUHWDzGtuFF84dRmj6e9uCwNuqF2FwKM
 59j64KEZAcmgTApyDDg==
X-Proofpoint-ORIG-GUID: Fo607T0LaHRznho-UTTfhKIGl523Cfnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270182

Overview
========

Since below upstream commit, powernv systems get a panic during boot when an
OpenCAPI hotplug slot is detected:

  commit 80f9fc2362797538ebd4fd70a1dfa838cc2c2cdb
  Date:   Tue Jul 15 16:36:55 2025 -0500
  
      PCI: pnv_php: Work around switches with broken presence detection

The panic log is present in patch #1

Patch #1: Adds null checks around null pointer dereferences
Patch #2: Rework the driver code to separate PCIe-specific and common code
Patch #3 (optional): Group PCIe functionality together, only code movements

Note: Patch 1 is important and independent of the other patches

Note2: Patch 2 & 3 can be squashed into 1 commit. Intentionally kept patch #2 as
small as possible for ease of review.

Changelog
=========
v1 -> v2:
* Sashiko pointed out various null pointer dereferences including a kernel panic triggered by userspace, fixed them
* Add rework patches, so that PCIe-specific and common code can be separated
  cleanly

Aditya Gupta (3):
  ppc/pnv: Add null checks for OpenCapi PHBs
  ppc/pnv: Refactor PNV PCI hotplug driver
  ppc/pnv: Refactor PNV PCI Hotplug to group PCIe functions

 arch/powerpc/include/asm/pnv-pci.h |  16 +
 drivers/pci/hotplug/pnv_php.c      | 554 ++++++++++++++++-------------
 2 files changed, 328 insertions(+), 242 deletions(-)

-- 
2.54.0


