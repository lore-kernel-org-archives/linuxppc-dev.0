Return-Path: <linuxppc-dev+bounces-25743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479F2C5B572
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 14:03:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKCyg21Wtz2yyJ;
	Wed, 12 Aug 2026 00:03:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786457019;
	cv=none; b=mwfkZN00QR9PC29g5Tj0K1Mwi+P8dKOQSLuEchKG9fxCQ+tmPTMEii4EmFFdcz0prifufaRGDFQAy2+t9kdrFBvBMPhto2WqbXdiZ0XNr+UjwqZDatBTHouBbFARpJqlngzaylqNQfOVGcGpF1MSo/abXeio8DE/k6Tv9cVoABvDD/4A+g3QFq59qiwmjPdW3eVqT8+MP0f2l7tEnzpgZQEXM6IdYtKAzUzTkzTaFuvnfkHMt0wdzTk6M5rBl4KfFyDC+CwmSI37M/1c6HXZsd8+xgurtu9jEL15cXkgFdwFaKOAsV1loGUL2nVJ5dnKQUf+gG0B+CsMxdp3WZ6BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786457019; c=relaxed/relaxed;
	bh=mbLuhsJZxdPDx91G7WysTYsE8JT4DjJauP9xQHB9Lcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBn7CTKAAhYf3GbSUWTbjjnG1REWTumVITh5K92W2iabPCriD5XsV6HwI77Q2DSHa3vop/AGKhO+DcrFjnk7M65SvhFrXpmzclA+Eyjik/tcbgbCJO918qJEG717QpFt60Es8vjnv450UuhwQjomnUqeU9IR433TrCgOoMdlao6GoLM+/ddRAIm8N9y4IF4VWCWh+OHDmBWaLfuD+lHoEQIGiDmpPlceCLl30/9dquhS6D1aM6hpZyrx2rLCdnWqGa9L7l8OBU1xUT6bZ4A6HLmdcNtARjFp3HkCWesGLhHK3JBz54S+19AGiZprZHbhz7Ak913IBYOLLYIZIglvNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T1ScCOQA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T1ScCOQA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKCyf2jKgz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 00:03:38 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXCOR570015;
	Tue, 11 Aug 2026 14:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mbLuhsJZxdPDx91G7WysTYsE8JT4DjJauP9xQHB9L
	cw=; b=T1ScCOQAorW3SgXIx/Y9BNdFJQjQ7m+Ob74neDp0qPMWjARxZTSPfrUEu
	Ijkml33hJenN0n3Vw7MCSKarjMxC/tnuDP3AZu0Ydk/RfpkdW+MgZkp6+d7YsRRi
	AmoHQwUteoZDihPuWZHLYtWDY2/CWKoL2QR/lvV8qKxA4HMTXHJLu2YnOzjVUec9
	tzYh57VmrpX2F9ZxMOiMUk+OQ9ijdbLNFKvcfPCzqRIGEu7C6CBuKoDa3paY/Sax
	C8dnGi2dOhWxH7nZ1jNbV7vESDCHBHI7WDCKNGev9Ggeuy0QLUHwf+yh3TpRuGeR
	PEMhx0ZXH3J7r0/B+ziDfJ6BxTbFA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4ksb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuF07012350;
	Tue, 11 Aug 2026 14:03:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq1bnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3MFj34931192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BBAB2004B;
	Tue, 11 Aug 2026 14:03:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C79320040;
	Tue, 11 Aug 2026 14:03:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:19 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] powerpc/perf: Fix vpa-pmu driver to report correct
Date: Tue, 11 Aug 2026 19:33:06 +0530
Message-ID: <20260811140313.15397-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2baf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=2wL9yz101uEFEcatHFYA:9
X-Proofpoint-GUID: jE-68-cucBNX4sFAfjca3-3i-bUQtCL0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX8Sg/UTiNgZBD
 9N/Z+dkdACQbqtaiX/fPi6U8umhmZovD6FrcWTQifKPgx9N5vpvoY25jyc2Zp1AdeVcpEJBcQPT
 l+KyREaJFa+xRUqaLqONiQqOsORops7wfTmYmCdGj7pRulLPviXf/8WIX1V1JD+gLoHu9/ZpqyV
 fsILfDdHjlWB1VAOjOvBwkXuGTGWnWrROJp9tfwSMAtSacMQmD2LwOVuKVEl1bfnEIxAWUtFKC3
 xNMvRap4CsYQczFWt6+pW4n1eEkbCoEumsKuSHyXkCi4pleJaLEGiOdeTOvW2nBmfyZSIuU12Q1
 JupLgnwiabC/q9Nnp92FfctCeOxyKgfKlGewSXaHlQVOVEoelqrDg+0ISsxEQK1EHja/x9FDcr+
 olz3YApCbsy3sGMLNvjypW3OXwWMB7080GzToU41GK+kpWUI5pS+ivP2aXKNPdbyV7T7txkewgz
 EQUCBzSU1Wd2VRCObFg==
X-Proofpoint-ORIG-GUID: l_kpnYccm93pd4ZtELwQOdSjR1-qjyP8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX2d0f2FDynAnh
 HHbK/3C36NflOjEoLDvtJhVQ+YtjIghdF1O7cZ2Rma6CCDFsWNk/BW97MIb+C+Uw3UB0asYEfag
 sFM3UPi5rsrNugpXJHfYg3hEgNKlq+I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110117

The vpa-pmu driver can sometimes report incorrect context switch latency
numbers:

$ perf stat -e vpa_pmu/l1_to_l2_lat/  --tid=2061  -I 1000
           time             counts unit events
     1.001022517 18,446,744,073,708,177,408      vpa_pmu/l1_to_l2_lat/
     2.002120674            345,092      vpa_pmu/l1_to_l2_lat/
     3.003171582            406,342      vpa_pmu/l1_to_l2_lat/
     4.004234838            340,836      vpa_pmu/l1_to_l2_lat/

These invalid numbers are observed because the vpa-pmu driver does not
handle the following scenarios:

1. The vCPU process gets rescheduled to a different host cpu.

2. The vCPU process is not running, and vpa_pmu_read() is called to read
counter values.

Fix the above cases by maintaining aggregate counter values inside the
vcpu->arch struct and using them to report data.

Gautam Menghani (3):
  KVM: PPC: Book3S HV: Maintain aggregate context switch values for
    vcpus
  powerpc/perf: Use the aggregate context switch values from vcpu struct
  powerpc/perf: Update prev_count of event to get accurate values

 arch/powerpc/include/asm/kvm_book3s_64.h |  6 --
 arch/powerpc/kvm/book3s_hv.c             | 69 +----------------------
 arch/powerpc/perf/vpa-pmu.c              | 70 ++++++++++++------------
 3 files changed, 39 insertions(+), 106 deletions(-)

-- 
2.54.0


