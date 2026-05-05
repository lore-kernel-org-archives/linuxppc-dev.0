Return-Path: <linuxppc-dev+bounces-20471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE69FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:25:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8tRJ5793z2xmV;
	Tue, 05 May 2026 19:25:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777973148;
	cv=none; b=gcKFJ2tjULEoBg1kcK7wgOaL2TNFl08Y+/DxBgW9K8hlZ9XjfPDVlRMC9+u+2gE6KDI3R+v/z5/PNLkjmBPQgM34vazxoFJt0A10niyBWjM/k9THa6UgnTTDdfI2274XnnOJODewgUSlmo/l3UIN4cZ9nZceKt1rwYIlGdCFoOCFsL8aDWuEyeLmT9odLQ/10gklZfo735sxwQemZgdgSckEd1q93Ks2BDq3BSsC2/urWMP+WEqvk2gj18ZNvrU8lKHcLPaMPL2J9azgjNYIaJfkmInL4HI4HpAHKEqSrGhKCNgC2WmHWiYNbuW3HpDQ4rrWWFwDynIbx12EVLd24g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777973148; c=relaxed/relaxed;
	bh=flgNu318i+smlJGXobfYGEwk3IisKd22Asxn2ovnvPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auR4kI6QT1bQp31rPoYAfTphsetoO7OA+ENztJMlDxLkul/hhNIGUY/lsKutPZ4X/oFhRSssRKkdJluLCF9n1BCN6eA3qS+/yeYJg/wuTtQN+aRvHf7li6euC+BrIIAwMmotI5T5/bZc6skZuoflgRZp2VITltKXTaVKPDkhFYXWQa29bVnhpMWg4hxcVilQYGg+l2ln7mTfrGqiOWcEKfvX2VXp0dnEy8dJPBp7FgXHyZgbiR+H67lUZGKHRKPxyav37doykKVSU9dyCCRIomUEudU5A3cTyL49nUh/3D3MQo/mOFtWmbHZuTC/l5bJpxth8dGOP14+kdoLIdxATw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JvBYmCnI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JvBYmCnI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8tRH49T2z2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:25:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457Kvrj3486157;
	Tue, 5 May 2026 09:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=flgNu3
	18i+smlJGXobfYGEwk3IisKd22Asxn2ovnvPA=; b=JvBYmCnI4EwH4sfnFeO475
	bqWqWAe/b5+wCRkD1lZSTzIPaTNw3cprpLWR3gAcoji/zR97PnhXl5Bz7zIy6ysU
	QM+hj3j4kA+FqWIfGItIvfmIzJF5VHj+s+0Zj4rBosBUKn2kBLV2kVP0FBJPrffY
	lXlRb90RPEVcXlKbJ8jLuPc+lOzShM1W5fak3052cDtiYe52I7cue6S8XmT3BQJW
	80dIjocMRmYwwgRUQ5zViwdBj+Ewm0mgnl4SMcQZ7XIGWThn/TgyixwCEZ1LNNym
	O8Q94c+N3UydjtXo1xpwvsVE0k/3ei56mQd0t9F3+WwEXooQ0RQIiDk3ZRx4vXeQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxjj2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:25:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6459OgSg013227;
	Tue, 5 May 2026 09:25:35 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h0v5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:25:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6459PXic55050582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 09:25:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99A525805D;
	Tue,  5 May 2026 09:25:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A7005805A;
	Tue,  5 May 2026 09:25:30 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 09:25:29 +0000 (GMT)
Message-ID: <52c78fd5-e987-4140-bb37-f358fc25c7e6@linux.ibm.com>
Date: Tue, 5 May 2026 14:55:28 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] KVM: PPC: Book3S HV: Implement compat CPU capability
 retrieval for KVM on PowerVM
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-5-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-5-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4NCBTYWx0ZWRfX1EgMEx936yC2
 8ClkjSJFYxI8kMNPF9bnVv03Mp7hnAs9Ax5g2UeV6frsbhXCKAPmwz9XNMCCZRKYlKBHgFLAj44
 3fOam9CmnSMg6JRkmgm2g5448ds6oIiB7K4MqbKJwNZBQEKzyPzHS7jJc/v4F5jhlsP6sTmaCQg
 8iFbvTCDvpH1VouZqhTk6KeT1Szow75eqnbXYzSmqwfygcEAd73t62G8Gk6kSceUcQpNiURog0z
 +nIQSa4+hkDuwXcRankKZ6mb06i8qbGyD7fReZLjJJPuL8hpSfHK5R1Bl0P81Tz+a8tf+GlXa/t
 UTb5WjV0QcIMfSYLpLojF185Sa/LKGJ+TSj/YJM5F8qxAeMmgvOggpFOSB1KNkhBbbdLootMNTp
 sdgAFNedZWfh6F63aWVISYfB7XLxrPWNqVHBogyAl27vw1O/2ykeNoycP7hq5DabT2MvqOHl9dn
 A07IBcZ0cTZdX8UdBBw==
X-Proofpoint-ORIG-GUID: zU4OfGpg1IfdjQyCTpgy8kuTLyuWzZUh
X-Proofpoint-GUID: PGezDrCDj7nHos-a_DldcT35XT0ncSjm
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f9b790 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=3xnOzpcvsEFGoBSC2dMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050084



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> On POWER systems, the host CPU may run in a compatibility mode (e.g., a
> Power11 processor operating in Power10 compatibility mode). In such
> cases, the effective CPU level exposed to guests differs from the
> physical processor generation.
> 
> When running nested KVM guests, QEMU derives the host CPU type using
> mfpvr(), which reflects the physical processor version. This can result
> in a mismatch between the CPU model selected by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures.
> 
> For example, booting a nested guest on a Power11 LPAR configured in
> Power10 compatibility mode fails with:
> 
>    KVM-NESTEDv2: couldn't set guest wide elements
>    [..KVM reg dump..]
> 
> This occurs because QEMU selects a CPU model corresponding to the
> physical processor (via mfpvr()), while the host operates in a lower
> compatibility mode. As a result, KVM rejects the requested compatibility
> level during guest initialization.
> 
> Add support for retrieving host CPU compatibility capabilities for
> nested guests on PowerVM (PAPR nested API v2). The hypervisor provides
> the effective compatibility levels via the H_GUEST_GET_CAPABILITIES
> hcall, which reflects the processor modes negotiated between the Power
> hypervisor (L0) and the host partition (L1).
> 
> On pseries systems, obtain the capability bitmap using
> plpar_guest_get_capabilities() and return it via struct
> kvm_ppc_compat_caps. This information is then exposed to userspace
> through the KVM_PPC_GET_COMPAT_CAPS ioctl.
> 
> Hook the implementation into the Book3S HV kvmppc_ops so that it can be
> invoked by the generic KVM ioctl handling code.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 948c6b099a29..d602d90111d1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6516,6 +6516,22 @@ static bool kvmppc_hash_v3_possible(void)
>   	return true;
>   }
>   
> +
> +static int kvmppc_get_compat_cpu_caps(struct kvm_ppc_compat_caps *host_caps)
> +{
> +
> +	unsigned long capabilities = 0;
> +	long rc = -EINVAL;
> +
> +	if (kvmhv_on_pseries()) {
> +		if (kvmhv_is_nestedv2())

If this is only intended for nested APIv2, it should reflect in commit 
log/title, otherwise, we need to return success with capabilities set to 
0 for non-nestedv2 case.

Also, better to have combined check for pseries and nestedv2 if we are 
not handling other cases.

> +			rc = plpar_guest_get_capabilities(0, &capabilities);
> +		host_caps->compat_capabilities = capabilities;

Do we need to take care of PowerNV case ?

> +	}
> +
> +	return rc;
> +}
> +
>   static struct kvmppc_ops kvm_ops_hv = {
>   	.get_sregs = kvm_arch_vcpu_ioctl_get_sregs_hv,
>   	.set_sregs = kvm_arch_vcpu_ioctl_set_sregs_hv,
> @@ -6558,6 +6574,7 @@ static struct kvmppc_ops kvm_ops_hv = {
>   	.hash_v3_possible = kvmppc_hash_v3_possible,
>   	.create_vcpu_debugfs = kvmppc_arch_create_vcpu_debugfs_hv,
>   	.create_vm_debugfs = kvmppc_arch_create_vm_debugfs_hv,
> +	.get_compat_cpu_ver = kvmppc_get_compat_cpu_caps,
>   };
>   
>   static int kvm_init_subcore_bitmap(void)


