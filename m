Return-Path: <linuxppc-dev+bounces-20554-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67EACD3427
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 05:24:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB0zv0vZzz2yrD;
	Thu, 07 May 2026 15:24:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778131467;
	cv=none; b=LDtBDTl0kTTQtJv8l7wndHzAb9VN+hUTG1ObW7YuGogLh6KodfwRIPcOzRCy/MGMQlhCzWlpDIWPHnUufmo/EuATNiX2CcLCLhEkYzYv27MMYjRTMDF47PIuO8o+/xmkPvshK60DyKAKWXg+GSfApe7NFjX1ijMdxkELYgKCvfbXXfyqGxhgOqoAP4fS9hm+P5iBXU9tjUOvMmJGgWF5kB+8TlTOEzsrBwrZ18o3OXvswbk8eKZz60Ppwd0GLobnI87SMg9t0qpPeeYUKnn5k4Dj71ScDfW4vkWN1pJ2hbszFOxK7z48kg7o62hCzHYr+skzK5HAeVI5wlNaDfPQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778131467; c=relaxed/relaxed;
	bh=TucOZ0sBTZFdshtdPDyBxWcOC6Ft10rot4sd8h+52sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSsXyhh3eSthBbFc0W4PjU7qjIb0OktfcqflVqBRGKiR/xP/eFTveMumFAV/qJR1Mx0ffR3ouIOVsl7yO7zlxN6xdoZif1vD1i9g9tPDuH2YAFz9zJgeoQbD7qNdN/kDiQ8Pqo2SAD7rUJvQINlA+UgA/cDT+xCTRfxX7bCw/iZjPV2Oce6sILD7/TwMQsvQJkH/3WirzGe8cwaoghniSQEga86p0Ouaf9OTIuEwWxitNmu4g/ncNhIteLlkD+TOfFiMMSZ7U+Bp96zy2stSNMbuPLc6tRjRw3m+oUFajgZIKV2FxZVgAob+5tVVeBPd3YlVhq8UjJQDxJk6EjZaVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YpxmtDkW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YpxmtDkW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB0zs3sskz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 15:24:25 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646Mo7Dv2210426;
	Thu, 7 May 2026 05:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TucOZ0
	sBTZFdshtdPDyBxWcOC6Ft10rot4sd8h+52sg=; b=YpxmtDkWv7KWlAHeuJIO8w
	NqpcEj4tyZZhTrGjZw2q/AfoESH/i2qCJtwg8+M4fOt795pvOBn7pkivmJU4UpG0
	LPTBXI6OPE7zyaKqnmlJpuwIyiTmz7vX3XU3D1vP0DNJ3mmIxm0jrqZMFuxSv5fS
	Tqbxr3vaLJP6w78sQE4Qw9dYiN7b6+BHEzfJvc9MTHnC9huExunjQZQElwWga5LL
	58vdaZH9R6m46YwDu0TXDZLQ4dyB6UAtgHMM2kzAjcMkFgSuWHSmMbD0CNS8R+3k
	R3QV63bvccBFapddA1nmJAuUNpm5QoqP7LPFNPXWHoNqSaYLRGaE2w6ScH+KqW7w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1m9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:24:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64759dwV013557;
	Thu, 7 May 2026 05:24:15 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk1jgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:24:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6475ODuj31326914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 05:24:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A646658053;
	Thu,  7 May 2026 05:24:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C02C58059;
	Thu,  7 May 2026 05:24:10 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 05:24:10 +0000 (GMT)
Message-ID: <7907d821-b2f0-4f55-9763-6d419f04d01b@linux.ibm.com>
Date: Thu, 7 May 2026 10:54:09 +0530
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
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Add H_FAC_UNAVAIL mapping for
 tracing exits
Content-Language: en-GB
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260428084534.49781-1-Gautam.Menghani@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: lxxOA8XLE-8Wzx3m7j-fLuNrZphalmWy
X-Proofpoint-GUID: 4zUHY9eC3UmHz477yT1_bcYfE0X_wwCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0NyBTYWx0ZWRfX22owosNOeKce
 ROtBVmIOK2zgv5tfJEZyCt03DW0B6P2jT/TSB6I+Bxwz8bLzuKA5uyUgOqqDF8KVrVj3baZyaju
 9K2J4Yg08sYcCmGylqst4CI1LHaK7cbVpdpZJQ1ndSQppepeQBhEHLTTzhFuhIkrYfJ6sHDYWf5
 tjzUIWmr+4Z51HQms+JfR4M7Sk1eK7TLlJf01E3qqjp8jKFP5R8wa97/IOO/zSVmNgqh3aV8QiO
 fiJmRyJz8Tz7ou0o9PZwAw5f73ABH1jaNZ3O27c6v30rlHr2qCOcunTtWTP6BJLivhPgSj97eDz
 pPM2c+Lu8ghZgZFWuuoM7lte0bW8hlUxYTKt35L6EQAtoq4Gv8Fb2aRGquMGHzQUv01865MOuNt
 hf5S4QN+iaJIF/iHuka0MO2h1CLLsSR0Mu7rkG8qyJBkp6xGfOfmxgQdtn6M+GCzF85BY8+BQY3
 mw2AtK1CMPG1vcFGCpQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc2200 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=sf-K9OUI_O-0kvPjvxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070047



On 28/04/26 2:15 pm, Gautam Menghani wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> The macro kvm_trace_symbol_exit is used for providing the mappings
> for the trap vectors and their names. Add mapping for H_FAC_UNAVAIL so that
> trap reason is displayed as string instead of a vector number when using
> the kvm_guest_exit tracepoint.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Remove the trailing comma after last element
> 
>   arch/powerpc/kvm/trace_book3s.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/trace_book3s.h b/arch/powerpc/kvm/trace_book3s.h
> index 9260ddbd557f..5d272c115331 100644
> --- a/arch/powerpc/kvm/trace_book3s.h
> +++ b/arch/powerpc/kvm/trace_book3s.h
> @@ -28,6 +28,7 @@
>   	{0xea0, "H_VIRT"}, \
>   	{0xf00, "PERFMON"}, \
>   	{0xf20, "ALTIVEC"}, \
> -	{0xf40, "VSX"}
> +	{0xf40, "VSX"}, \
> +	{0xf80, "H_FAC_UNAVAIL"}

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


>   
>   #endif


