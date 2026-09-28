Return-Path: <linuxppc-dev+bounces-28379-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F18FC9832F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 08:33:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htZMM0Wgsz30Wg;
	Mon, 28 Sep 2026 18:33:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790584398;
	cv=none; b=Mn3dYdjraRNAIVhUjU+H+YRvgug5H8GkxeV0wDIlyFbJ5IuoKkwUKg1rDIIm6KJ5jovV3ZiW19qbT0uyw7/UrObGzsy5ynDLl0u6wErAAchnXC3Ei4VKkhVJFcwssODQYWxqloeQITWWUG9o1cqnUm6NQjMG7bY4f6M+bY5PtYyu3Nh0ZL0uP+FRqGG6kovgOAi8fKAnr8yk531YY8G4VHWdP6s6pA0VkdCOx0ETHsKbTUG73P7ft7MysItx9eXSLeuxKQf3i/k2ERNBWwvqtDdkUx/4L6jvgnSOUpt9T/kRGyBVu/M/4FyCHrTiwzYXcpuaVJV5ThCg9EBknWucMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790584398; c=relaxed/relaxed;
	bh=2V0T/QH1NxZzr7ALdjEKUfyiN/ir/ewgEkREcbHU8GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXx7m2Je6JLyHrL7k61gfAE0kZxHXytTL0Z/ReRCKWxC+HTnAA+bhbdFY/Xx385SxdHVeUo+Vubsjso7SvCKPKZXOm2ULx3CRqf91EHfQFZ7xkYIPnsMVX05iH7LhWcBwHiDOi2e9jse67hTPeoYTniPJLNlZO8WN5z5VZTPg6/OTTc0+JGe1eDz/tU50tWDyw8IDk9zAy9D1uT4+jngmQofTV3LX3Dg9so92oRri+eAtgnGX2nJzn4La8/avan1YsBR45KzLYBdGP6NIKoJ1u8l8S84uJgq7Kh/EkrIbhYia/QBDY1oDl+E4vOF1Z2DvhlNW+9POFXP+CNmMq4Qzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O9HiGk/4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O9HiGk/4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htZMK5r1qz30WF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 18:33:17 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S85Z8S3545312;
	Mon, 28 Sep 2026 08:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2V0T/QH1NxZzr7ALdjEKUfyiN/ir/ewgEkREcbHU8
	GI=; b=O9HiGk/4PBANUXJNkTMFqidb9JrLCW0ZjUoaPgOhlxGhW1YANKtXzKRvy
	fMcXIKcvnfVoz5//BNhxE8t8qAM+37zm/J/GiBqUxXLT+jZX8bT1e0b4yGLTX+8J
	GcYK1KVcZ8w561GiIsO+Q/v5OC3GI07QHmb3T92xqtNMKHPsxyTFpAThhiMHZ2OT
	N37bev3e6xvVVayUQSMLuJtyVPnMvSXFMfeSv6pnszOXeC8bl8wW1LIKv1K13DAm
	H3qzjTsyhd6lS6BlLOoAQY0TdYKKjORsoEeVjV6M/Nb+Ckr7VabZH8uM8QG4MWXP
	wKKBMaNMg7WM4NiEr1FWuDN/0UsAQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdyyuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S82UDg4036587;
	Mon, 28 Sep 2026 08:32:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y45j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 08:32:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S8Wct250987286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 08:32:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5167820043;
	Mon, 28 Sep 2026 08:32:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E25BB20040;
	Mon, 28 Sep 2026 08:32:33 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 08:32:33 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/2] powerpc: enable Kexec HandOver (KHO)
Date: Mon, 28 Sep 2026 14:02:24 +0530
Message-ID: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba262b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8
 a=Z4Rwk6OoAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=voM4FWlXAAAA:8
 a=itPyUPzOZQCiFHcQqVsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfX4f+kgIpPIGVj
 uwaG28rTrKEHIVdkZvig/T2b0K2y423NKMNJoO3nOja5TdnkcYkuLzg10lYlz8rkO1nLvx91snl
 pKr4tArX/ihyRX009CGAx64RQajKNZw=
X-Proofpoint-ORIG-GUID: dwrLQ9ljU_LN2RkMYCllj3KVN-DgVXNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzMiBTYWx0ZWRfXydZ5+LBSAB3g
 DWOGDyZye/X6SynjJforcAVntJNPIhcxmnwOyepSuiMXjWaylAmShseTZgO+PV/S2Lg+rftrb2d
 Bg97yNlihEL1vOJ5JPakg+DR5sWm2BNUmAUm6GqDmcGsZ9eS9L0X2/+me1T0gX+4U5GoeVYyFss
 58C19/UdJ/5G75GcUAwIS7hYy8FJAnO7bqC69ilR2EU3lYMzU+BjjVN8hj5AZRsSfqtChHW7WUO
 pZc6sIlFHid4RJ+g/HdhtO8gA5J38PnMUxxca1x2aBgIEZ8tGvqihF7uFZGp1PTEIuk5JI+eZwx
 pF73eFstl73Jz53utDrWs9V+sAD2n2O6XV3LtsiJ1uJaj+MHogaIWPjo7x+SpoIRlEQhfm4PZPk
 aLxBZNxLyINNIiCSy+KqgeYlGLethLX20vGMGNY4Hh/78PQP4HFNeZF/5s+dhvbUbt/O8n+Mn/r
 AygC3bFghR/bJOJCvbg==
X-Proofpoint-GUID: 4SGsXfmGwyZu8BRXa6Efo3WVi6WdezfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280032

The first patch fixes the KHO scratch alignment check by moving it from
a compile-time static assertion to a runtime check. On powerpc,
CMA_MIN_ALIGNMENT_BYTES can depend on pageblock_order and it may not be a
compile-time constant with some configurations. The runtime check
allows KHO to be enabled for these configurations and disables KHO if
the required scratch alignment is not met.

The second patch enables KHO support for powerpc and adds the call to
early_init_dt_check_kho() from the powerpc architecture setup path,
where KHO information needs to be checked early during boot.
early_init_dt_check_kho() is also made public so that the powerpc code
can make use of it.

There is a generic issue with KHO scratch sizing when other memory
reservations, such as crashkernel, are made before the KHO scratch
reservation. Such reservations can be included when calculating the
scratch size and may cause the KHO scratch reservation to fail. This
will be addressed separately in a follow-up patch. To know more on
this [1]

Testing:
========
This series was tested in the following two environments with
CONFIG_TEST_KEXEC_HANDOVER enabled and the kho_test kernel module:

- pSeries LPAR
- pSeries guest running on PowerNV
- pSeries guest running on Pseries LPAR

The KHO test module successfully verified KHO state restoration:
> dmesg | grep -i kho

Linux version 7.3.0-rc4kho-ppc-upstream+ (root@ltcrain85-lp7.ltc.tadn.ibm.com) (gcc (GCC) 15.3.1 20260722 (Red Hat 15.3.1-1), GNU ld version 2.45.1-5.fc43) #2 SMP PREEMPT_DYNAMIC
KHO: found kexec handover data.
Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v-scsi@3000006b/disk@8100000000000000,gpt2)/vmlinuz-7.3.0-rc4kho-ppc-upstream+ root=/dev/mapper/fedora_root ro rd.lvm.lv=fedora
KHO: exec from: 7.3.0-rc4kho-ppc-upstream+ (count 5)
test_kho: KHO restore succeeded

Changelog:
==========

RFC: https://lore.kernel.org/all/20260821105609.983622-1-sourabhjain@linux.ibm.com/ [1]

v1:
- Drop the first patch from the RFC series, which added KEXEC_FILE as a
  dependency of KEXEC_HANDOVER, and use select instead.
- Replace the SCRATCH_ALIGNMENT_BYTES static assertion with a runtime
  check to fix the build failure on powerpc configurations where
  CMA_MIN_ALIGNMENT_BYTES is not a compile-time constant.
- Remove the CRASH_DUMP dependency from ARCH_SUPPORTS_KEXEC_HANDOVER.
- Reuse the existing early_init_dt_check_kho() function to process the
  KHO FDT properties.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org

Sourabh Jain (2):
  kho: check scratch vs CMA alignment at runtime
  powerpc: add support for Kexec HandOver (KHO)

 arch/powerpc/Kconfig               |  3 +++
 arch/powerpc/kernel/setup-common.c |  2 ++
 drivers/of/fdt.c                   |  2 +-
 include/linux/of_fdt.h             |  1 +
 kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
 5 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.55.0


