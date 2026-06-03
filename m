Return-Path: <linuxppc-dev+bounces-21949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F013BCD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:28:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVd6q4llqz2yNn;
	Wed, 03 Jun 2026 16:28:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780468083;
	cv=none; b=bxeEvB1gzGeyGjVO/u2lkyGafudSk5mIjsvXvlwAAkvNEd9gbR82h5BLeCc4aUE5+OGzCHeGLrJEdzaL3RbG34XZn1/ccaH6UtcscxO4M6OZ/PHSLgYJ3FWFDoPibNSWda5TJT3GXWwKbvfQJvBFkblNnMZpTsEXXUuqy8ds+yIa17G5cq5cp+XrbgLgcPfPor3Mh6X6d932F7htUQCPo1OjGMKyZG/w3QLRZKug87LgDWVOyKvsrZJYWG8SNX6E8k6eKQwIYKTrq/rIvboqdEewkeYX+Ev4jn80nNNhSMveRC2Fr6MJ/FlajGOjZJqsEGJweP81KM2miLqDT7GHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780468083; c=relaxed/relaxed;
	bh=ubK824ZkBVyARGvt1b8MoeFNF2vITyoABnTOG6lEDuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QE27B9CJNaZPdSD3Iey1lkQ7Zx9v5vPmfDWx11IbLNskGPSMXrcHoz24TbojletS73MSGfByeoUVfH+Dwo9BArjrLpi3qDudRz29ngasf4YXtJQh42sm7ox7vowLJlbPzN+kOXYEHxYF6aL8nsdqGwkyITMxPaW5H7q/+ThbuhE/nCMuOBr+GO4z6WyM9uCI7pTazKolN/UlRcshw4SukMv2kENSz1avtpuodsoRpaw4ClhtBeunUqB7lwQHToh3v9GrTnSldXBjZQc47SZE8OfXJPMWpEfar79k2mLYsLbwlHf28ISxNoGMQ31Uz30LgqE5/nrUI4O5bb3eu98Qlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WkGQJFil; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WkGQJFil;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVd6p5fgqz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:28:02 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H8a3j2252299;
	Wed, 3 Jun 2026 06:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ubK824ZkBVyARGvt1b8MoeFNF2vITyoABnTOG6lED
	uc=; b=WkGQJFillfMpUwgMBM/ryaAxvPJVMlaIQ4Fh41gYI/b1xliPilTJm4QXB
	LTqkkhyfyBmL+SCxUHwNo2H5NP7fSkDr5fs8BkbPw7xZTJoSujrQIFj4SQZYcA3z
	CqTWtLpe1/AuXkm6LhMV+23XwUMNyJ3pe6sqsZR+EVbxquWaUrn+E2FVyvwrtWVi
	DxIDf/1HYQA1DBuFPZ598PaTgqzPSnOGvm7ftQd4+g5xxfJqytXvHl/yOTWmSdaT
	+BcwnJrmgCmMhcpwNj2ZaAU1/o0xuWNtRV6mxOvWXVIy9NfVFetLTNVNm1XP5EUI
	GkAGTBo7foqJD8085pjZlLEO+E8Vw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae91tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:27:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536O5H6021173;
	Wed, 3 Jun 2026 06:27:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhescf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:27:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536RrO745089106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:27:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2FDD20043;
	Wed,  3 Jun 2026 06:27:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65CCD20040;
	Wed,  3 Jun 2026 06:27:50 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.24.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:27:50 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v2 0/3] powerpc: fix preempt_count imbalances in perf and kexec paths
Date: Wed,  3 Jun 2026 11:57:40 +0530
Message-ID: <20260603062743.1152253-1-aboorvad@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1fc96e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EHRFYB8xNeBlr5IdY6MA:9
X-Proofpoint-GUID: Tkkwab5r0hhCwwOAkKCB6xIHKnMW8LEI
X-Proofpoint-ORIG-GUID: fYOsCkLXsSYfDrmSSXsLGwlgzP_21SqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX6C4Ap57hfJ42
 OykgRKSgyfIhhSrpFV/SZ4FwLg/LbNwVXuJbNE/A//Se9z01RpyKJuNF3qn0R1F+zy6b3EkdEko
 iq8itIudR7TRfm+VlNsL7wT+0QdtZiHCm55L1atbaJS8NKAmyi0SNiQn8/NukVRQNbFsLDCq8X4
 Zyp3cFAh8f23j7LxRodWFaz+uWkFnFIQGaI4UFBCIjuhlXdNkjSQodRYuyM92IP3jWbCcVjNRwa
 6yYpENP6/qwP6AhAb4OBkw+gN+mPOmoH+xFaa7d7itoc9pbUHGpH+/DRbj/l7eQYQmABr5/wrrB
 XSxtXtAhHOuAIKvyhzbsBMH2FTr4YJGHofAZW/SAE3BPoPKvQqpBCXSiDX2ybCVsAxqiqlUHS8g
 1WXxWewp2vfsrsYM5BByZfvvGsccwrw+u2iqDafFFBbNzCdLxlQ/xwsMAWqU3Pg22XwrNN2IESC
 RYnldTs2Uo0OrpFoC9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

Hi all,

This patch series fixes some minor preempt_count bookkeeping issues in
arch/powerpc/ found during a preemption leak audit prompted by the
lazy/full preemption model changes. These are get_cpu/put_cpu and
get_cpu_var/put_cpu_var pairing errors that leave preempt_count
incorrectly elevated or underflowed.

v1: https://lore.kernel.org/all/20260518050855.1147242-1-aboorvad@linux.ibm.com/

v1 -> v2:
 - Patch 1 (fsl_emb_pmu_del): no functional change; picked up
   Shrikanth's Reviewed-by.
 - Patch 2 (pnv_kexec_wait_secondaries_down): per Shrikanth's review,
   use smp_processor_id() instead of raw_smp_processor_id(). The kexec/
   crash teardown path runs with IRQs disabled so it is safe.
 - Patch 3 (kexec_prepare_cpus): per Shrikanth's review, dropped the
   approach of passing the cpu id through kexec_prepare_cpus_wait() as
   a parameter. kexec_prepare_cpus() already runs local_irq_disable()/
   hard_irq_disable() before the wait, so get_cpu()/put_cpu() is
   unnecessary: just read the cpu id in kexec_prepare_cpus_wait() and
   drop the trailing put_cpu(). This keeps the function signature
   unchanged. smp_processor_id() is used here too, consistent with patch 2.

Testing:
 - Patch 1: compile-tested only (ppc64e_defconfig + CONFIG_FSL_EMB_PERFMON);
   no e500/fsl_emb hardware to runtime-test so far.
 - Patches 2 and 3: kexec boot-tested on PowerNV (powernv_defconfig)
   and pseries (pseries_defconfig).

Please let me know your comments.

Thanks,
Aboorva

Aboorva Devarajan (3):
  powerpc/perf: fix preempt count underflow in fsl_emb_pmu_del
  powerpc/powernv: fix preempt count leak in
    pnv_kexec_wait_secondaries_down
  powerpc/kexec: fix double get_cpu() imbalance in kexec_prepare_cpus

 arch/powerpc/kexec/core_64.c           | 4 +---
 arch/powerpc/perf/core-fsl-emb.c       | 3 ++-
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.54.0


