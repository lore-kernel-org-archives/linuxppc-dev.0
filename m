Return-Path: <linuxppc-dev+bounces-20474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB0CD342F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:56:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8v6H6xvnz2xfB;
	Tue, 05 May 2026 19:56:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777974967;
	cv=none; b=diACBmr+gyNYjySj+fcg3gZfUDm+zRMMIWKeoPPSk0tdTHejGAehqsfXHCPSAQVPSuq0SPLnefhsMT2TJ9wvyQiR6aRGyJ2AUmftgzreCFJ3VI/Mu41Tw04YW0YE0Kgw3z4RUVaG7NkMlOOFs1LzmyK4UMfjd5G+IZ5LEOlMD/UJsrk1u7avV6MUvMCs0HPWLA/FgEhfJxg34s18mRA2uovYSMQaXzeEMM2DuD50PS4YVudr8hsc2s6oXbHrd3gHsu4HRaoO1MsmKu6mQkRt8NVRy10r7icNas5TVhHC6E2vlWlAwArYUA3UVwQHX0lSKcdmuJKFBr6+Hg19wdFwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777974967; c=relaxed/relaxed;
	bh=fZg9BMP/RrkZZqiY4BkngS0ZULmxW98T0pWoSxe+/es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1Zw2Mh/nitOtq9HzbMJQmU/zGGfie3L9dgMorBQja05mqYsPVeEmWLaVFCdSbfNH7t4YYft2sjAfzFTxMpsBq9EF2JS2vNhwc1xQ2s3r2V0y/xfYYKfgHazWMI93XDYTg2m6KrXlTwzCSeJrSfcH/qbWPfVpfkBi/XhJF+A6zYtiP2tB8bAbREEjBjwtky5mq7A2mlfnvRgvpONwILc73HNyQoPc1TMyZrBAjz0utz9Q9iT0WL//lqYE85qgsg/OcogcowTzdOH2qoKlXuVcMRNyeo/psCZEHGzN79k0bGEnV1sGKQ0bmqGyrJsoA095GM7xGVjBoR0W7MCrtpgxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fw4U0QrK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Fw4U0QrK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8v6G2KWGz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:56:05 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644Kf6251494000;
	Tue, 5 May 2026 09:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fZg9BM
	P/RrkZZqiY4BkngS0ZULmxW98T0pWoSxe+/es=; b=Fw4U0QrKuYkB8wb7wezg/z
	oAN/p7X0qX+ZQ16yfc9O646xlBmjiuWQh5iJTQ71kv0hEjEb2GWU3NobBqdz4V6f
	NqUeMp2tyLrTM8Qce6bTzMT0VOsA1e/QLBXFptm4JjBXbEQufYwp7HZy1vuqrPTN
	GUMLd6904Wub3TptouAIGu4uRR0Kf5Lsw9tblZMigaHEae9vZY5umzQ1esg0b0BK
	CVJSo2MH1YDSxEOfybrxHA+7/llud9/KWArNpVE2eEL36rZlnhnxI49y6qulpAAH
	I4ds8wYMuha9JmKz5Ovz1Reh9L5z0t+GcQLzMKL8T47nhJ9rrkqz4L/LAmDjwThQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6aq4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:56:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6459sabA020043;
	Tue, 5 May 2026 09:56:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkjs0ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 09:56:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6459u0t923397018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 09:56:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EF758067;
	Tue,  5 May 2026 09:56:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A19D58052;
	Tue,  5 May 2026 09:55:57 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 09:55:56 +0000 (GMT)
Message-ID: <81b9d00f-7568-4bcd-9b77-2f6de3162d65@linux.ibm.com>
Date: Tue, 5 May 2026 15:25:55 +0530
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
Subject: Re: [PATCH 6/6] KVM: PPC: Document KVM_PPC_GET_COMPAT_CAPS ioctl
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-7-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-7-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9beb2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=im9YsioV1Km6TWkjvh8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: j3A9_HHPdO1RHNoHCRpb_PK_rvzdIqyZ
X-Proofpoint-GUID: j3A9_HHPdO1RHNoHCRpb_PK_rvzdIqyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA4OSBTYWx0ZWRfXwQxVQFGSk6RM
 KzX41sm6wp0PRaRd4yriVFc98N5Bw0cfDAkOuyKjAKGj5M7l6X5zrSM1poPVLKC+yGQM+Tm7/Zz
 0n4Sf95KHkvAUsIuMV3T9rPyhEme6rdBCkIp8iTe421yJcFLkJn9fAlYP7EEQQE6C9i1tZWOR17
 whuGvIJdG1YlHZPye3hpe5r0US6vmBjDTY5zeChxJ0PB5enBluvgNDRDZ5uYCYOT4f02kUK4QJx
 Rvfn+2k/gyo165XR725AeYfze0HOj3LQft+chqgXDRmoe32NOCNSwAtAfaxC1csGjRZT6tVwbzY
 HAW1DtO5uHsThtGZVsevd9E1oROng2IXxjTbXyLOmTvPzBtdcY28iFDiUar/ZPNyXo4rSY8cSE7
 31QxokltC2HOSk5eujABOGbJ/4TmsBW+pkjgLi0GCkFhmW2EodYuDiIrOkxVzml8tANgJPhK7OK
 CB6k/G5O2L9BVUMOASg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050089



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> Add documentation for the KVM_PPC_GET_COMPAT_CAPS ioctl to the KVM API
> documentation.
> 
> The ioctl exposes host processor compatibility modes supported for
> nested KVM guests on PowerPC systems.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   Documentation/virt/kvm/api.rst | 35 ++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 52bbbb553ce1..7a10c3c6cbf1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6555,6 +6555,41 @@ KVM_S390_KEYOP_SSKE
>   
>   .. _kvm_run:
>   
> +4.145 KVM_PPC_GET_COMPAT_CAPS
> +-----------------------------
> +:Capability: KVM_CAP_PPC_COMPAT_CAPS
> +:Architectures: powerpc
> +:Type: vm ioctl
> +:Parameters: struct kvm_ppc_compat_caps (out)
> +:Returns:
> +	0 on successful completion,
> +	-EFAULT if ``struct kvm_ppc_compat_caps`` cannot be written

-EINVAL also needs to be documented?

> +
> +IBM POWER system server-based processors provide a compatibility mode feature
> +where an Nth generation processor can operate in modes consistent with earlier
> +generations such as (N-1) and (N-2).
> +
> +This ioctl provides userspace with information about the CPU compatibility modes
> +supported by the current host processor for booting the nested KVM guests on
> +PowerNV (KVM nested APIv1) and PowerVM (KVM nested APIv2) platforms.
> +
> +::
> +
> +  struct kvm_ppc_compat_caps {
> +         __u32   flags;
> +         __u64   compat_capabilities;    /* Capabilities supported by the host */
> +  };
> +
> +The ``compat_capabilities`` bit field describes the processor compatibility
> +modes supported by the host. For example, the following bits indicate support
> +for specific processor modes.
> +
> +::
> +
> + bit 1: KVM guests can run in Power9 processor mode
> + bit 2: KVM guests can run in Power10 processor mode
> + bit 3: KVM guests can run in Power11 processor mode

May be use H_GUEST_CAP_POWER9 and friends ?

> +
>   5. The kvm_run structure
>   ========================
>   


