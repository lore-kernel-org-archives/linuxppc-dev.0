Return-Path: <linuxppc-dev+bounces-21501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C3ECD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 07:01:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPkDZ2xbsz2y8t;
	Tue, 26 May 2026 17:01:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779778862;
	cv=none; b=Aky022366V6ddyV76wb8bapRCllhN6H6Ps4MT9ct6JNDZMlWNovMDFSz0jAENxPslMCype9mQQHw2dWX6zR9l1YejOzUkIZ3j3cvIZkB6wKhZjx57kq2v/DtU5x2ri3UIYu7UlyYInv8y0x+otrsqU8cdVSjNTzbV3zx3G9Cbcfo//NmBvyrXKoBOvSPYhGprMMRYH9Q4gZQlIfw5mKRpkCtVuC6nRfWtpoR5p1eqtQslUh9TfjsCoDwtsn9M2q+kUcYzgTpa3Ga58x9FNK6wAuZ2nigsrrThDtOe5P1EVuqBiuE/FerOZkAKpLM1lmhVU9oZhKqYC2pNUAlSjPBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779778862; c=relaxed/relaxed;
	bh=VX8+1S+jkayJgLaGXATX8h/OXyDc7O/lTdANJFoVST4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCOwN05fBWvwrlK1UOhVxsgVAeA2cV9brgW6/vbt7HftP3kM/HDnKhhS4vYwE91vjUVwP7DIYVswta8OTje4Z7F74QDQvpHcO1Ha9u4LJSkZsT04lFuEIzUSFxWgYGsKHnsvjhMvYb/0OB+eG5Bhgxr5+YR+2v3KMr7tomms242FTHFivuOKqlNWF31GfNkglskAX61qqng2LsL0ku5/ps7FzIR/v6zXZTFQ9IkZC7/bK+zN1LvqyCBcl9N7rXOug+qvdIMm1wbmTIfaKouZK91KPLqCnWqf3Dkxm+TNLYFTG9XC5ASaIRiY6EaUPL36b0I9Nd5oE48ua2Ve9rzMEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T4KD+iQQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T4KD+iQQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPkDY4PpVz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 17:01:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PLIBLH4185202;
	Tue, 26 May 2026 07:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VX8+1S
	+jkayJgLaGXATX8h/OXyDc7O/lTdANJFoVST4=; b=T4KD+iQQboiVBtFZGNTDlv
	6HQA1fviE+ITIN4jI7Q6KD4g5IlfSepPGRiQj9w2ZGyDIbyHoLyRCYraXbKLb+ig
	p2+6pF17f01gJbfR+ByVTS6SwphcLzeYj0L8vQy4hfyzWt6hJ0Oksa6F84t1LzOq
	HROIkyXGVKBnsR0mytCVl2L1VHoiG5hqOYEdL7gt7Gznnu//1a7mXfUbNWUALidO
	nI1/MCisBVQu/qSJfTxpHB0qbe5ff5f6PtmS5zM1BJpEhrM3LQjVZwi3xoGV/Cfo
	RLc494LM3BXmx9WPYJ1lx3yw/H8ptpx0iJf6AmzDTsGh+xekYFxSx7wa3sTBf1dw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq1wma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 07:00:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q6s4Aa005766;
	Tue, 26 May 2026 07:00:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebpjq8bnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 07:00:49 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q70lqX16122604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 07:00:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7BCA58059;
	Tue, 26 May 2026 07:00:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73A285805D;
	Tue, 26 May 2026 07:00:44 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 07:00:44 +0000 (GMT)
Message-ID: <40b7656b-52ef-4140-b6e3-e034fd44a4fd@linux.ibm.com>
Date: Tue, 26 May 2026 12:30:43 +0530
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
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
Content-Language: en-GB
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        atrajeev@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260518044150.34632-1-gautam@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260518044150.34632-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7qkukWVPBjDP_LO3AnDPm149bcRTJKrk
X-Proofpoint-ORIG-GUID: NvEfuJU5a97V-5xkwsqXfnF1So_ulFhD
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a154522 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mE7zvaIDyRbJdjUQ4pMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA1NiBTYWx0ZWRfX1z7hS0EfpvnJ
 sAbzsT4d5VZP3aY/4JjjtCMq4OHBCdmWJCbaSHRTaI6TsLLmI9xXEfeQugl8Cvxlk3QjRkmGYQo
 LC/GbOwQkFJW3uVhCLG4B8CHmlS6Vpi20Tsb7gNfdkQD5LYZYHhw3QUeMvrV5QygEmxQkXSwCDz
 CsK/p8bPmfjjxzhy7c8PrZZdXbBZbIx9Pv87yCOGxSjM5ES/4DYwAnkjxnOGHOmAyJBC0g9vhef
 pJJjyUbxe4wrYImY7mzXrBrgwDDkbHbifkqjZHqs0pN1G5JZQI+tr1Yww9wmlcfBZk+yz3mK6kT
 KbF2ompqmrEy5dQztaK6vZvoUyvT67skM7pOG3qCzigFRAPl4UZsteEiCnOrp1+R8gsECZx/84s
 M74ib5oI5RxCGYYjZhvu9acMgFevCn16wYoBbnqwJL8yewcJzmFe/LRR25GNeEnHMc3xl6Cw5Ll
 Qv/ZJm5QmBkq55YMOLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260056



On 18/05/26 10:11 am, Gautam Menghani wrote:
> Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> vpa-pmu driver cannot be used since it is not enabled in distro configs.
> 

I think the commit log needs a rephrase as irrespective of current state 
of distro configs, it makes sense to enable CONFIG_VPA_PMU for KVM 
guests on Power by default since this is the only use-case for VPA 
counters (i.e. in a KVM guest).

> On fedora kernel 6.13.7, the config option is disabled:
> $ cat /boot/config-6.19.12-200.fc43.ppc64le  | grep VPA_PMU
>   # CONFIG_VPA_PMU is not set
> 
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v1 -> v2:
> 1. Rebased on latest master
> 
>   arch/powerpc/kvm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> index 9a0d1c1aca6c..56e86b46ff13 100644
> --- a/arch/powerpc/kvm/Kconfig
> +++ b/arch/powerpc/kvm/Kconfig
> @@ -82,6 +82,7 @@ config KVM_BOOK3S_64_HV
>   	select KVM_BOOK3S_HV_POSSIBLE
>   	select KVM_BOOK3S_HV_PMU
>   	select CMA
> +	select VPA_PMU if HV_PERF_CTRS


Also, since we already select KVM_BOOK3S_HV_PMU, VPA_PMU is a natural 
extension, provided we enable only if the required dependecy is enabled.

With an update to the changelog with suggested rationale:

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   	help
>   	  Support running unmodified book3s_64 guest kernels in
>   	  virtual machines on POWER7 and newer processors that have


