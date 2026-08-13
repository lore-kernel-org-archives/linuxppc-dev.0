Return-Path: <linuxppc-dev+bounces-25816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E96EC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 09:46:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLL8Y0lPpz2ynH;
	Thu, 13 Aug 2026 19:46:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786614365;
	cv=none; b=THeFVXm0VyKjg4qLZ60WaEEa1Nx5h022ax6wjtbMbJe4T5BOZa/Z5IO+72IXRO9tWRP0DcKtw7925YXRstx4UHEn6J/rV+1JNAIY9GYf+Zu6qeFGsi/8WXvRO3ntxPmEqyyO+1omYHTCpiUovpbtAlEf4sroaoUDMeFpzLMIdye0yorRKJx8aX5t72wshLGyiv6vaWmqP4DOwVOPA1npRoIIqCMXrXIIp43gXfsFHfoq3tg51PiRu0u7ivBPq2G76chtxNfYI/5HN/p9phMC1WMmWrz91n4t5qSuKqI9kSbOM/HXfmkbYCn5gQD6Pu7mxTPAD5okoqFQP35i7ez/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786614365; c=relaxed/relaxed;
	bh=Me4pOBVWGAwV+SjWnURhczqoZAZkgyY5rVmFqXV8CZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOXaqbj88Ix/cNdY+z8REjhE9mldNB1Ey1dbRyH3lHQR0L2QMyqBfaynoJ8BGO4EWdMgSbVh9q2BoCXCQf9kKXq9Jwz1+hZJRlp/kI9mgJRkllfXTYfjUdF+WNEiX4qLbRC35EUc85jlU1WbnHbfIXoay2ZzSIoRnG8RLJ94qrCbio1rHlMoyor6YKo4UzR7b4/9yKD7XmM92WtrdI5omozVZCxSk6hug6S64x9BCJpTPHJAnR9MmH2Hh4OzYo2GpN1/E09lItbdrYeBLUW+K/AwvQL461q0+zmkGpkrP9oF0Z/j7AG5Lx4h0GBI/76XO4wRBAEHqZJ2UmOMLSupjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZfJF9sb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZfJF9sb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLL8X2jf8z2y32
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 19:46:03 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D98viO1949806;
	Thu, 13 Aug 2026 09:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Me4pOBVWGAwV+SjWn
	URhczqoZAZkgyY5rVmFqXV8CZE=; b=bZfJF9sbQsIlrEvmUD0P6DS0FFLaLOnOn
	HXGrdcIWxckcQ0Jb1m8FrGv+G/sVGu4tMbQ6l1bg8ao6HR1CFoMM4DhbTBQc7TKo
	olqp1po5sGE27a8zh7AvxEoLCvgmTl+xIMYbM7eFBAQy9nh1zePyu1cvh1QDYwGv
	DxvQbBucukSac4nA0EdqZ8s+kpOp+6S8dp2RwtcouG380IbwcRYllGpXHbW/IJd0
	026jCXkAl4f+7oFTF87tw2HA9huats+KBnnGT48rTsb9L+7yNa/4w6ABz/hxGkZP
	f5EOrrxtDG+WdpUDi5xNxMJLKk685LBzzVBAlDwaZsows/tC6uvjA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwe9dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:45:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67D9fLON007509;
	Thu, 13 Aug 2026 09:45:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9had5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:45:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67D9jm9835324338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 09:45:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1EF420043;
	Thu, 13 Aug 2026 09:45:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4776D20040;
	Thu, 13 Aug 2026 09:45:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.189])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 09:45:46 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs
Date: Thu, 13 Aug 2026 15:15:30 +0530
Message-ID: <20260813094535.10083-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813094535.10083-1-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7d9251 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8xd0QCqRopuxImrV20AA:9
X-Proofpoint-GUID: FJw04xx-zq-jRSzXgaWVKHzJ8V_3V8OC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfXzbqV3NAfqiUA
 4Zve2XUWRTP950oaUmfCq34ufdbDadXHR68oiBUx1wBqIBbAmKkWh8FCRZUaLfArl5dPWDm6tG5
 IUiJ93qvtA/QeGtzRgQoCif45F7XeGRKeuiQoouNFX5fdoXFz5FyzvFEI6BG2VKEEPwu62pVG4N
 oopScX6g4uyGBadk8XwYOEfFzlrwmf3sw/tBd+rz+fxKoDtLkfixrfa1fUEe0Ip8d8Nnd+oZZQ3
 s6lISq6pfYtbL4PpRzitmwXEabFCVI59A+tEEsUU3CXjCDb1v7FPc98ToyGxtWmI5FdBvKkOs69
 nDXbNedTy3GLJCl/JNSbPAkVw9naW3uzeS8O5td1MgVD9iExWK6q8kOse90u8u2rzbSjQGWBKwB
 ikSAXWn1fI9LPzcJr1+fuKiZAmltl/JlLDk0UdBRfgQP64o9g5aNXVtkWh/atT/gPjIcrcZ3N34
 wo7KKSVmPjukOalBELQ==
X-Proofpoint-ORIG-GUID: tmBil1HnmRbOVSnISHa86FAV-Ok2_DWh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA2NiBTYWx0ZWRfXyE901yEXWmtc
 /dLzIwqe0vAr9tsXGqbHMq5yb/+0ctlcRXDYEVw1hUII2G05+o+bx6v94MaAGmEl8R42WkjzOC7
 KwKtHVLvxGBhfcJsU9T0yip1EUVk9fI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130066

The variables in vcpu->arch currently store the latest values read from
PACA when the vCPU exits. Change this to instead store aggregate values
so that every vCPU has its own record of total context switch latencies
it has accumulated. This is essential for the vpa-pmu driver to report
correct numbers.

Fixes: 176cda0619b6 ("powerpc/perf: Add perf interface to expose vpa counters")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v1 -> v2:
1. Add stable/fixes tags

 arch/powerpc/kvm/book3s_hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..342168b8bfc8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4163,12 +4163,12 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
 	trace_kvmppc_vcpu_stats(vcpu, l1_to_l2_ns - *l1_to_l2_cs_ptr,
 					l2_to_l1_ns - *l2_to_l1_cs_ptr,
 					l2_runtime_ns - *l2_runtime_agg_ptr);
+	vcpu->arch.l1_to_l2_cs += (l1_to_l2_ns - *l1_to_l2_cs_ptr);
+	vcpu->arch.l2_to_l1_cs += (l2_to_l1_ns - *l2_to_l1_cs_ptr);
+	vcpu->arch.l2_runtime_agg += (l2_runtime_ns - *l2_runtime_agg_ptr);
 	*l1_to_l2_cs_ptr = l1_to_l2_ns;
 	*l2_to_l1_cs_ptr = l2_to_l1_ns;
 	*l2_runtime_agg_ptr = l2_runtime_ns;
-	vcpu->arch.l1_to_l2_cs = l1_to_l2_ns;
-	vcpu->arch.l2_to_l1_cs = l2_to_l1_ns;
-	vcpu->arch.l2_runtime_agg = l2_runtime_ns;
 }
 
 u64 kvmhv_get_l1_to_l2_cs_time(void)
-- 
2.54.0


