Return-Path: <linuxppc-dev+bounces-25744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F9BC5B572
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 14:03:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKCyn2rnyz30BC;
	Wed, 12 Aug 2026 00:03:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786457025;
	cv=none; b=TEwwj2PDwc46rgyOkSpk3nORJci2mNGTX7wim70A7oX8PqztWls6+rrapMPgEU+ih8VjqRcYQy/Ul4X4JpIsM9eh6InWiY6uv/4qwV+3WEMAnU/8ZfeNyWQXb2Z/gg3NBGondXleks5SK2WTPnqZlff+8h3/EGonw5gYUSYeEAgONPsvYqdlVUkNRqRtzd9gvi/UxS2AY4rOjSIHeQKiQXiXEWFj/HrcjhgVhONM7viV0dvU020LzukBoTgnsx1orh5Ko1V/8muBioCDa2rWjv3LJSYZEhEHKqaF64+Yj+bNADDCtsK+Jd7M28k1WjI2GGM1ge6xRpz+g7tejViF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786457025; c=relaxed/relaxed;
	bh=z6IXOIpdpQznsNPd+qftb3KOHokP0NhoXlYJAhh6GXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOCx5OcKKZ9oI70KJ0L8HTo4oWqQZ5DnN7QVaNfjDKx19L60F0BBwFJD/ryX+46KT4iO+Ij8yyYof5Ew3tpXUyfdEq0o+VyBZ85N1IQnwUbx5oJrYuWQDG6vPKk9i8O7+bwn4reN3858nh76AlQGPslTr02+N/s0t7MPgvGmB2tOwiWgGP7TDW12FUVo4M6sEuflmcZwVsSqT++Ct9nR6PJJ4FteHDHSczAVtiAEC+0+O+LGlXOCapAyZP/bKyaHqm36f5SEIMDSYDShzT+U6bhTqDLVwZFKg2aq2JyRc4hWvP9Qt0YkcCHTVjs+QyNyNDPYrHtRD07R9LGncDnccw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcCXUEwx; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcCXUEwx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKCym3Rdmz2yrW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2026 00:03:44 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXAIk569992;
	Tue, 11 Aug 2026 14:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z6IXOIpdpQznsNPd+
	qftb3KOHokP0NhoXlYJAhh6GXs=; b=FcCXUEwx2f6NvdDKLNEUIXWqHqAX0W2eM
	v4pbo/14FIEiIvoCr0RrgKF86bWEPhQULr5Hh0cPq5z4ZgE75eiccqofcGYErzRr
	61qwpsSuFtJ/ZtzbmKg1m04+PT7LU70xhT1T0sBrP0m+Uk0I0Jk+JUwid0PzAjWh
	Xbo5qE85CD5ufpZWmWyrJ6J32t3B6omYNQRm5VW4a7GTYLPXKvuiXM3yvP7LlzTG
	sJqwBSXq3NaLAZIE6ivcoUliTEMIfUeMCl8LuOowDZ8aL7I4YZtI87p1iC2Qzzfd
	d7S3qHA+rfKqQb5ZSn2pM0riOvjXt3NDR1NRdnKFvmxQ8t7g3ymkw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw4kt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDuHfn012719;
	Tue, 11 Aug 2026 14:03:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g92by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:03:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BE3TuX36831504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:03:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26162004D;
	Tue, 11 Aug 2026 14:03:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A599B2004B;
	Tue, 11 Aug 2026 14:03:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:03:27 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, atrajeev@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: PPC: Book3S HV: Maintain aggregate context switch values for vCPUs
Date: Tue, 11 Aug 2026 19:33:07 +0530
Message-ID: <20260811140313.15397-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260811140313.15397-1-gautam@linux.ibm.com>
References: <20260811140313.15397-1-gautam@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7b2bb6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=8UmGTkYCL32R6Bbc0TMA:9
X-Proofpoint-GUID: D-nJeyP14wjrQolOxb6Gm6rNb85ea8-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXwjtu/Jxl3SZe
 gfncvTXW13LD3/Yh7DlgBd1CB9k+BVPFmI/msxF3ZZSgdt4AroCDradbNWMvcdO+5Av7lJiy9an
 DS0QLYA9iOaFvaArYLh+8k/9wgTTKT23i5DTj9JdKvyZajslHEusQUakNGBeP70NwrGuX91uRUQ
 Hu5owhFRMd5rMteWJkyIMY6vHX32GXYBKaikeJvZK6yOR2BKcrj2f3+fIa2i2qWALy/3/hirvAk
 +Iid5D0pE8qQNYTaqLx6St44cU7boOTFXfz8w1mF/KNWhAdIMHVzHN3RMkF0qIKtMed2Z5qgP2t
 ygBoVTIo/54CbgFhoPW9jOdB70EMj+SezY2ARpUFUmcnuhtwcPV18IQ5Eg4tJXeahv4ELxrX+So
 Tb3Ghmdutv3issEb0XXgUMcqNYJJ1cGhZj48cNZhnmLfdcMcp7arombPoU4TdD4RcCqcHeyhTOD
 258QwRsQkBBfmpSQYWg==
X-Proofpoint-ORIG-GUID: vZ27zggUO2WVRtHJwx-Z47FiDl59PRE-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfXxPZtrC0ErRhc
 FuTj1s14RIW0KtwBkh1TrEKiXpuztzl+1Ui9MPDuyVfhIWSiKVaGnbMIYMqaQzQVdyxV5eJnm9o
 3uCSQVjzdeU0EAIy0AnwmVLBZH89Pm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110117

The variables in vcpu->arch currently store the latest values read from
PACA when the vCPU exits. Change this to instead store aggregate values
so that every vCPU has its own record of total context switch latencies
it has accumulated. This is essential for the vpa-pmu driver to report
correct numbers.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 3cfe9a7be9c6..0e8a959122a8 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4164,12 +4164,12 @@ static void do_trace_nested_cs_time(struct kvm_vcpu *vcpu)
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


