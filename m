Return-Path: <linuxppc-dev+bounces-20333-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD35ECD1297
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 05:50:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5jv927BFz2xnQ;
	Thu, 30 Apr 2026 15:50:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777528229;
	cv=none; b=KbHEzjnhfGxqe4GZwVq7OH0v81cjGbNG5HEoCC2rUNVaNjtQAULrdrLTpTVc/+uBiB8Qa46x1ETFPL5kHKsVIhE4oUe1X53wv9Ih/pslSq7lHiFzQL4s8VHV9ql1o7RTTgAJVWR2rujeQk8/hjdb7je4YsKNDCthaTe66hPqbU/qwr7ahx+HEVEjWjoND5KhXW0G0BCz6IobpCVOowHEZRqR62GNRzQnoZA6y04HHdyjgAfXjt89jMcABzpHSzcpY26mvu/0kcPmT5q3FYhMeIHDrsgxtIQquBAURfmZiIBjJvFW+65nkGc8m+EHvknWabO9z2j3+Z6etW9cm+gRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777528229; c=relaxed/relaxed;
	bh=Ubv6yMYn9d//u05u34jzNdKgQTaW5W4pj0AddL7IWss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHVD5yj9lnBgbbYE1A+hX02gPL86CGYE2CgcY1QQGvM18MuQdDPO6mPrH9kZ5KnxxKeOEsWbZ+k0fYgosM7IJox9ikgLnCB/x5XnuYd50PFAYslWkosFbJlDc0/bj6cvsU3Mq5yyjRseHZfDReIKX+v8SirU0D+7f61ftrV1xbwf+IGz4cvW0Vo8vu9wkPNAd2QOq4B5dnlYvc2Bl9OcNq+KPj6j3c3U94NftQit3MJ4ASksazw70r8Z3HqeB+QfANY1+VOcHHPzbKDDZuWmqwLCfI2o2n9X0m0O1OBWxACO7bob4iG3z9YI/31FuggCB3uCKQsmNnszTycZZHBScw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svjj4TBr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svjj4TBr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5jv83BnMz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 15:50:28 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TGvvQD1895497;
	Thu, 30 Apr 2026 05:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ubv6yMYn9d//u05u3
	4jzNdKgQTaW5W4pj0AddL7IWss=; b=svjj4TBrn4aZkvDbzolMj8YF6qj+ob52Q
	rsn8OX1ObecoIX8ZIuRbgDBR8X9HZFcU2uYs10qthTT6TqHV5aZwLIISlqIf95QF
	l4/LfKU4WArc4cYBOK5GeH8KreujIBBWDbf6qQziafCRsuj2l+fQEDN6fv4vc83V
	pMRT7oqT9GoAV/MZHDGo+kKJnBE5O1k8hMfAhfg/lkhVTffEJhnaztl4eKofKuwA
	8PyR07wbY2KGy4UGUG+nN9gZLIj9UsWwvMKm9yf7r5BXEq/Fu1K/t/X63QN3fRTZ
	us5Yj3qHfe/zq2wt8gRf/E3UfSuzCCVrU17MTiSRl39ihKIGVX6gQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e4f9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5cnE8018013;
	Thu, 30 Apr 2026 05:50:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8xk9k32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5oCU040829312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E93B320043;
	Thu, 30 Apr 2026 05:50:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EF220040;
	Thu, 30 Apr 2026 05:50:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:08 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Thu, 30 Apr 2026 11:19:00 +0530
Message-ID: <20260430054906.94431-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zt7r0mqoNlX3WLlD1khd0zPKSRuFFnQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX6OVWkafEfjB8
 mGOxl+gtNffqwNC0wEugg5aIzIDy5P9Eo/9wtpRfGvyESiLF2M5y3Axw/+ZW7aScOwaXXoxAX0C
 67UhbAH/fqnIStVlf04g4Et9Cr2090B+++Q9UvCU1ErcWuU6SfUhaKk/X91DBO3P+XNyfkYt3ZS
 L0b+ovgMHuZrp5mndhha+k38YvNUds1s4yhs1mPBQVGLiFf3GwdSsHQn57Uf24FGYbeg4yfEn/F
 kq3nRTEV4MNX3LtwXSaZI74+ZPJ+RA4jNhU1vr5xsdbEselicHS0LUwbuyQGzsWmWeJxyLMct8u
 Czx8wB6UGGPGJKPhEBVlAGFTKw80SXvceCALTM79Yc/TqTGHscAaQs8UhiDewJ0fCklHv3mROV7
 vu6ApxZdtiQzoeYFRQ4Mf7djOO38oEdTq8Mbtj71M0tF/sEuCe6N1NLZX4aDxQocQP8xirnGtq7
 WtOyJeHgbivWYO6N1YQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f2ed99 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=9nGdcix9NZkGgJ1vRr8A:9
X-Proofpoint-GUID: CQNBagWsl1eIXAex8tZNSm3NPZAAFrRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

On IBM POWER systems, newer processor generations can operate in
compatibility modes corresponding to earlier generations. This becomes
relevant for nested virtualization, where nested KVM guests may need to
run with a specific processor compatibility level.

Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
logical partition (L1) booted in Power10 compatibility mode, the guest
fails to boot while setting 'arch_compat'. This happens because the CPU
class is derived from the hardware PVR (via mfspr()), which reflects the
physical processor generation (Power11), rather than the effective
compatibility mode (Power10).

As a result, userspace may request a Power11 arch_compat for the L2
guest. However, the L1 partition, running in Power10 compatibility, has
only negotiated support up to Power10 with the Power Hypervisor (L0).
When H_SET_STATE is invoked with a Power11 Logical PVR, the hypervisor
rejects the request, leading to a late guest boot failure:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This situation should be detected earlier. Rejecting unsupported
'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
invalid H_SET_STATE hcall and provides a clearer failure mode.

Add a check to reject Power11 'arch_compat' requests when the host is
running in Power10 compatibility mode, returning -EINVAL early instead
of deferring the failure to the hypervisor.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..948c6b099a29 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -446,7 +446,13 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			guest_pcr_bit = PCR_ARCH_300;
 			break;
 		case PVR_ARCH_31:
+			guest_pcr_bit = PCR_ARCH_31;
+			break;
 		case PVR_ARCH_31_P11:
+			if ((PVR_ARCH_31 & cur_cpu_spec->pvr_mask) ==
+				cur_cpu_spec->pvr_value) {
+				return -EINVAL;
+			}
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
 		default:
-- 
2.50.1


