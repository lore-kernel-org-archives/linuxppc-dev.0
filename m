Return-Path: <linuxppc-dev+bounces-25815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30747C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLL8W0C3gz2yfN;
	Thu, 13 Aug 2026 19:46:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614362;
	cv=none; b=kU7OkdEcSLQUbgkWPELkFhTwo0ssU5gkzyDZre8miVj34HPTmS2n5MmOs1l8Nu56eK6S76+CmA0FXGyRCBa2/kFLTD/jVprTNYW81YDCGPBWgkhEmTH/L+5Wzr/LOruHLYPXcMoV2azpxQj8cqcGTweZJW9mt+Cu5lf3Pcih+CO9EedEUj4WwfrbyumlIJ2eCG1N4IC1GDCyTgDDFeaoTDOBFfwg5lTcPC9dESsXhO1w9cTUgeRHE2bSX9vQZAi9aC7XeV3DWTMsQB5w2bXEkRA2NvMWlQ7O0EbjIbZ1wIJmvCT8PlT/LGdLXYE/kulWzM3ZXQBkO4V2ihKPGTGsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614362; c=relaxed/relaxed;
	bh=U/U4gNffHLdPUWX384p/FMq5oq6FLru5o4PpaR4Smxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUEhTOPLTDVAW5Sc5C+YT5yKoHiKCHogZaK0DEYngbjfpyHI92XeBvtH6meBlVmRxluceQGGZn1FBkTkJBao6urrad3CjL97TEyR6Ln4hFiZWpgwGBWd/jMI8Q4X0oEa9S1YowTp3Rgg9Iw9YkVyQYUSm4s7A7F9V04sz1NUsoPHGPBPEzpBzBnh1BNrlbGK2H4Q8sYt9p3SrzFIvZ20PKkZErel5zWKksBc2WfxMIQCNQ+PYwgWr4iBoYIqvA8C42YmDJI8tTyJluZkTqC1+ChWGAgsrJ1HRafb9bTS92reP2XYKcwwiEpKeDIl/FAHudO0+SSPajeDq60r71F9Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R4pZneih; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R4pZneih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLL8T25hxz2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:46:00 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98x0c811213;
	Thu, 13 Aug 2026 09:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=U/U4gNffHLdPUWX384p/FMq5oq6FLru5o4PpaR4Sm
	xw=; b=R4pZneihKmTt+x757r3d69MSrwXl5+1FM8yOOStjNOaofAh+g5z7rWqJ5
	YXfZSU1ZHIGamTwPW3I2GzytX/3IRL2vEQjKQ9LuMX9kzpzbWBJkYuaNql2ha8Im
	bAY06DTW5qg2FR56XW2Jlj1D9ZxIUBsmA8M1UBK9yHnSQJ1YOg1bM1X0yO73ke2Z
	BvpgtTIT03gVn94/8dyLkVll4Bd5VJTRxCXVtGWJtMJo7Pn4WA4naEvBNgu37b3A
	EkW1l7zmkJmgNw3asY2JRqDODzZNdgZlpQ2qh8sSlNIgkjQaVPweZ9hmKG/TyMQJ
	ac4PFouJ5u/isIacUdTF2sd1Yt7Tw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23ymx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:45:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D9fGpv018318;
	Thu, 13 Aug 2026 09:45:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gjawb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:45:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D9jhLX31785364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:45:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59E772004B;
	Thu, 13 Aug 2026 09:45:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 020E520040;
	Thu, 13 Aug 2026 09:45:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.189])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:45:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] powerpc/perf: Fix vpa-pmu driver to report correct numbers
Date: Thu, 13 Aug 2026 15:15:29 +0530
Message-ID: <20260813094535.10083-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7d924c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=2wL9yz101uEFEcatHFYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfX6gmCqVpDCrrv
 IWi1CGa16WotAhKVgfGQThtJ0RomSkkxGwl1G255d6hhx6xr/20fwBFDOmRZFCVpc2FibEp7L1Z
 dvRVIwFKEl0R7EP8PFiTSj2+QAwjivm51G8D8+JPa7Ea86H0+BOTRtLRreifDgHWv7ybvESbr7u
 5Omacbth/3ZQX6sD5+R8CsjjeV/B8g/9VstRG7ljd4+2ASTANlc/u4ur26bViQAmE3XWNlPB39Y
 ph2tRPJfZXC3xvX2LHv7AyJXxjzm5iNkCrQRKO6ICNk3y4ntgZbCmAvu8ElypCI6SkCv0f8mvUu
 5yRXNOB4EgTiIPuTV6xTrd9823EvuBMjwM3h+OJG389LcdqKl5jJBi6wciOJScL+Cx4ZicjD2+h
 7y7aBwf9D4SKgh0e8jMArC4PzfPwa8i5GfezYlPDuCNPj6DpwZGNPmQuXQPg+/o0ddgOH5+XdbM
 UKkUYIdr5HAkyD1Cl1w==
X-Proofpoint-ORIG-GUID: ID7kYmrJxcWXZHrqcgLaWReLcQmOSBY7
X-Proofpoint-GUID: AbZaUBK5c7U3HdG4ZewI4kU9M2eop95W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfXxMhu3+nsu6Uj
 pvCIWMSGmwE7RDDu/r7mx0/V0dX8dVCm6PzM0J/TUOuHQmTeBk1wowBXVZRXZfla+p8iY0eP5eL
 mgo24AGxnJOdipNJnbL+l3b86KCAzBM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130066

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


changes in v2:
1. Fix the output for "perf stat --cpu ..."
2. Add stable and fixes tags

Gautam Menghani (3):
  KVM: PPC: Book3S HV: Maintain aggregate context switch values for
    vCPUs
  powerpc/perf: Use the aggregate context switch values from vcpu struct
  powerpc/perf: Update prev_count of event to get accurate values

 arch/powerpc/include/asm/kvm_book3s_64.h |  3 --
 arch/powerpc/kvm/book3s_hv.c             | 51 ++----------------------
 arch/powerpc/perf/vpa-pmu.c              | 25 +++++++++---
 3 files changed, 22 insertions(+), 57 deletions(-)

-- 
2.54.0


