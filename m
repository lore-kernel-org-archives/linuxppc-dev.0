Return-Path: <linuxppc-dev+bounces-24088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C79C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8Xd5Ddfz2xjN;
	Mon, 13 Jul 2026 14:26:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783916817;
	cv=none; b=EIMWX7XCRXElHMtskNQapGOYDXDWQsLnznp/Z5I5wuXI167aKqb1xOmNWpYphXBsfGIdoAHjY4ycEEtn4mo/6aYNXd2X1bBqylRj76IdxITUwWW5fftN8B96VDh0ZpNogjGgHwG/TlmTkJ/Z0aJz6YjvZ/JX8IyaC61PAqoLyqZJ1BjZe+JMO3LWJHvrB05h++imlWrYQGW/CXn1btSsXdsNzUPDdd1gLIbO0IH6X8Lew6ZVnSkreriAJM1/wLLSil1W2N9A81S8FOXFOT+UgPc8S1zU4WXkeQ7qzS3uqz1BoOQS8OvlqcT0w8FNo3JneL1RS8o6Ovh2A3qEesdhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783916817; c=relaxed/relaxed;
	bh=mqLuyZFebgY4+9zKQ6zLMqqW1yWcOHqBGwwEaqwUVF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+YGNhFNwo2aARQ67k4Qjz87BbPv+hG5Cu8/yePJrhaPYS9Mytq+MUJlnSyLeozqsu61CDHtHRa+Iog28T8t7Gb3cEyXvmt++QrUdGmUjl1kmmv2qu+suLBb+zwRl8ApJNsg/ZjylqYkSYHcpkcSx/3aPP1Fk62kNxJeMiiboCh1m4J5NQT4LQ8ifmdKOT+hokk/j/JpcU7q6xOlFOIBzAZy0zzuwXs9AR+zyekKFB5ETT/C3xfLvr/7tJLEFUOPT3eVQesHBLcSxxUPKvEGaIM6hxsR6CUPAtMsL8rNvuYYaP6AxVW2VrAQxUsJrKauz6AN91BdrnsgUn7JLNO2SQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TBO1QauO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TBO1QauO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8Xc5B3Lz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:26:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3C4SH1284114;
	Mon, 13 Jul 2026 04:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mqLuyZFebgY4+9zKQ6zLMqqW1yWcOHqBGwwEaqwUV
	F4=; b=TBO1QauOifAt6AHKy67ZqqA3vfHy2P7yctzTicd1XO727fNvexdtHbhsC
	h65uUdWbKT07V8KBLRT5f9Wln9LXalSRsSbzki3L1tWZoJMSvrE6mzuS+1IpU6Hf
	BmFsabaPbQhS+Ib0GKbx/8MbbwNG/7E9vuPhUxbJOrPlThm5WEhe+VWQJrrbq3FD
	9BP9ajCVdbSc05PxKsdcj/6lsBpRld0dBPtkzOI1qXUEclmSM/EfPkae235Wr88d
	lNCM5qXtBMFZYK+n1a8vGLJB74ov0gRJzeFHsztPLz57rK+3w9B11xY9XWvfvhsH
	RGR5GPsNrBKAuDFV3rmzrsJ2FyqBQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86ks0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4JaSK031333;
	Mon, 13 Jul 2026 04:26:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxuqhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:26:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4QhCt36241892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:26:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98F9620040;
	Mon, 13 Jul 2026 04:26:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B907F2004B;
	Mon, 13 Jul 2026 04:26:40 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:26:40 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        ritesh.list@gmail.com
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2 0/2] powerpc/fadump: remove deprecated sysfs compatibility links
Date: Mon, 13 Jul 2026 09:56:33 +0530
Message-ID: <20260713042636.1599868-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfXylZwstqwi1/Y
 rkx+RqSnqKuCSijrXyve2kGmE6kTVQU1bwNCsInFGWDfF7VyvVO2hZGAPwDHdXdqm5PR4z8Hq8I
 UwYsTavfs42T+JGl9wKOS3ei4zSmBPtS92laU4Gtruu1XIG0HPN8WoZ73Mzu29MwbBNr5Ngau9N
 IqK/HpuhLS18CyFm5IWriyDVelZfLCyKRuuPUuFuvTuOCx8jEv7RJhkkrgGFDaNp4n/NnGpznLt
 S6MSh/dKklhGiNyhGhpOjIPDMvcMB+5BF4WGdSE5nSBaXzs42xZQLa/qk8e00+MRSLIaeUvKSXI
 qU6MRBI+Q1hsMnVjjLjVfy1OzDFYN1Oa1jSr5970RE43lsMqgoOjAlL5K1KgDMAAtkUwifb40se
 mVVBZ1+W1w8ogPsXOJVIAF8xM/GmXp/uI0u2N16eJxMyv9klFS594W+HGuUdr8g6gUFqtbOXDsE
 JHoCTCgYnwDCvWe6PHg==
X-Proofpoint-ORIG-GUID: 9y9rzqRiMQWuWeBAco-tqpYrohR6ibqA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX/JIdGt0LSFsx
 SVQrMMSJeYXQ7zWaeUUSMCnLlHlU4RZmmz1MuhQq2mnW2v7GATdCOeUrxP2X0Bjl2nz6U65/ADh
 IpDaCAMKJDKR7R60JJ/tFojd/tVhxA0=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a546908 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c-FhyHnyx8AdMRAp0osA:9
X-Proofpoint-GUID: 579pQ4H-SGNFlU_KaCXnALpwHKJttjCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130039

The FADump sysfs interface was reorganized in 2019 by moving the
/sys/kernel/fadump_* files under /sys/kernel/fadump/ and marking the
old paths as deprecated. Compatibility symlinks were retained to avoid
breaking existing userspace.

The following deprecated compatibility symlinks are removed by this
series:

/sys/kernel/fadump_enabled
/sys/kernel/fadump_registered
/sys/kernel/fadump_release_mem

The corresponding supported interfaces remain:

/sys/kernel/fadump/enabled
/sys/kernel/fadump/registered
/sys/kernel/fadump/release_mem

The major userspace consumers have since been updated to use the new
interface, and the deprecated paths have remained supported for several
years. This series completes the transition by removing the compatibility
symlinks and updating the documentation to reference only the current
sysfs interface.

Sourabh Jain (2):
  powerpc/fadump: remove old sysfs symlink
  Documentation/ABI: remove old fadump sysfs doc

 .../ABI/obsolete/sysfs-kernel-fadump_enabled  |  9 -----
 .../obsolete/sysfs-kernel-fadump_registered   | 10 ------
 .../obsolete/sysfs-kernel-fadump_release_mem  | 10 ------
 .../arch/powerpc/firmware-assisted-dump.rst   | 33 ++++++-----------
 arch/powerpc/kernel/fadump.c                  | 36 -------------------
 5 files changed, 11 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_enabled
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_registered
 delete mode 100644 Documentation/ABI/obsolete/sysfs-kernel-fadump_release_mem

-- 
2.52.0


