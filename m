Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BF6082BDC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J5wvC0kA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMKJ22sBvz2xwM;
	Sun, 08 Nov 2026 02:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794064274;
	cv=none; b=AltE7Uj/oHWvfhkOATOxEtL0ytoqnFU3EMgh4Yz6nlo4mhD1ILkQZ52IanwyWB4I4qT1CFH7M9bjFRYJ4oTIOmNljZXF5lfOwG1aEJeSSY0UbG/d1vUJhmKXuSaB3LSK2RzP+YEieR2z8PiclcTwyeXBq8Z5IrkDZT4UTbFm1VvTt6f28wUpzS1SJBfvJqW7JNW6pZAeCf438eyqS3YlAyB/oyACh/SyGjZfIC/niI8QtJhPXLbltWP/gg3wiy6v79coD/Unmtf8cbV6Iv5CrHID7V5Cpzmy05zGv72c46108nPoBjebqXq8GD2SPxv1hEjsdvCPE9NJqyVr7Vm9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794064274; c=relaxed/relaxed;
	bh=LrJ821n4aqzgpo5xnB92QQehLQuyuvpOQZcpPG/IMH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe5GknvcCGnyTE5usMv/8AQa4wKkURJxTsAWIe9u+Osc6uUczfOktTUiP0/RBmV9bfZWRE+LjwgJCkrZL2MZ7YtG1HxGp6q+chZNLENCIChQ8UNmLFYZMKqHDWEikPQKnuu+0T3gjewPjR0JyBYsz4l/B1wGsePEqEBE+a++YJonz2eH4bEoQKyuyqCtsZDREbhsb1ZqobagC0fUv9wlHJC8is+yXUsYay989yrOZCM8e5KwSU7uz6xJT9LN71ZB8UzTThee3HwJYZT9HykT/r/o3DeEY/V9v6x5AFEimNEhMpieIhLgiHMYt5LWTZ5ohjjeAK9Md3DM3PuGyxO4/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J5wvC0kA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J5wvC0kA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMKJ11Zgpz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 02:11:12 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7CECIN1710169;
	Sat, 7 Nov 2026 15:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LrJ821
	n4aqzgpo5xnB92QQehLQuyuvpOQZcpPG/IMH8=; b=J5wvC0kAcK0X9fE9PDnLeX
	UhQQSlYKzjitMMiYG+BXIlnp/PEQZjD00oWo23+wyCDKaabCAYLTzaBVAOjV5cRu
	HQAQmhQ2D68/ENGlQ/fptwSibtoicSnougFAgHSTL+2Bp+GFPQrxAXAQvM4nXX9Y
	3xpDCkTWDpgMapI5FTPmOtLZH7W7bjc7pu36AB6vUdAS2xQfZNNmwjXTKPVRlTRM
	SgRo2KB3xbrx1BO3l/YXlUGT3R7HGxI3jhCt5Kghdgknl4JBzJpnCAn440lTC/NW
	AHtbk0bTKlPmGGACNy8cG64hfKHqSPj/BOP5ZECSE/a1K6F3WNrderot6A65AIRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5jn17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 07 Nov 2026 15:11:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A7F56Si1086609;
	Sat, 7 Nov 2026 15:10:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hswppj305-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Nov 2026 15:10:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A7FAsax52232604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Nov 2026 15:10:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1412004E;
	Sat,  7 Nov 2026 15:10:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BC020040;
	Sat,  7 Nov 2026 15:10:51 +0000 (GMT)
Received: from [9.39.28.191] (unknown [9.39.28.191])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  7 Nov 2026 15:10:51 +0000 (GMT)
Message-ID: <3d6722a2-688b-4829-b015-c15c03838c47@linux.ibm.com>
Date: Sat, 7 Nov 2026 20:40:50 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] KVM: PPC: BookE: Fix boot hang on preemptible kernels
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260928110411.844582-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TiLWMMM_PkRDynKR8b8pz-lHL4BKbpqG
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6aef3f84 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=tAcHNJzwEHiiyL2kpDMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: f85d2Sjoe9ihTO0_OUSj3gE0sAtXjGR8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1OCBTYWx0ZWRfX6nuIgrWgcMy3
 O0Mgzx3jDcwQxDDRT7el7aNM8Z0uhDlIBLwYZuNzZchZSF5wiDgWEaegJa8C/On9uzvwJCi/GIM
 HrXXqE6ZWf0e3825Z4/fJb8ZoIxvPxRWqiNiSBmeqqxiLzxvRMmkln6jCBEnyApZwlzDCM7RnMu
 enIweON24DGVYX3T3BrC9pCYifyh+VeiBvbHWvsZk70fUy+taLtRtNwwKl/k4Q/70UaDU40QviX
 zZiQtycHjZ0nRUFH4yQCmxgNN5ShhLJJVQ34ha2aWhjmbccrcLW1P3LGktM0aD27HiBVyOzNoLE
 FDnSvgPas8g3IsHCC09ZKPUvf4hVkbZCGWX8Yd43uAT7o+g0gw4l0nF4aSPawQONKu8Ky/csgO+
 VPT/yBcDzO+85Q5HyUuH9El5P/ONy6ZHIeEYmZIEs0FG7byes6th/SnCHNvfe/U/k5YbObyqgMb
 9HBeW6WmbSsWqWR19FA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1OCBTYWx0ZWRfXw3+IL1wYDnyF
 haqiangTFkETZEsEwc664X0DIBTV4oFvoJg74K1TNUjwmJjRVSxi1YIJFXyg0cfNv1LKBh7MCAW
 xCUQAWM50d/OpqY5o34uJIxeNPqeKCY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070058
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi.

On 9/28/26 4:34 PM, Shrikanth Hegde wrote:
> Christian Zigotzky had reported that preemptible kernels don't boot on
> his FSL Cyrus+ board. The board freezes on running either full/lazy
> preemption and has been an issue for a while now.
> 
> https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t
> 
> After 7.0, there is only preempt=full/lazy which removed the
> preempt=none/voluntary workaround used to mask the issue. There was
> challenge is getting the console logs which made the fixes difficult since
> one couldn't know where the issue is.
> 
> Thanks to Michal for helping in getting the logs. That pointed at few
> places where the issue could be. This series is an attempt at fixing
> those.
> 
> Christian, KVM team,
> Please *test* the patches.
> 
> Shrikanth Hegde (2):
>    KVM: PPC: BookE: Disable preemption before loading guest FP and
>      Altivec
>    KVM: PPC: Replay pending interrupts before entering the guest
> 
>   arch/powerpc/kvm/booke.c   |  9 ++++++++-
>   arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 

All the suggested changes makes sense. I will plan to send out version soon.
Hopefully mid next week.

1. Re-order in below way.
	kvmppc_load_guest_fp(vcpu);
	kvmppc_load_guest_altivec(vcpu);
	kvmppc_fix_ee_before_entry();

2. Define a common helper. I am thinking to name it as ppc_hard_irq_disable().
    Since suggestion was also to be used in the entry code.
    Other names i could think of are local_hard_irq_disable,
    arch_hard_irq_disable, local_irq_disable_hard.

