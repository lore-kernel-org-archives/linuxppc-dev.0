Return-Path: <linuxppc-dev+bounces-20498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5DFCD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 04:35:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9MxK6L76z2xdh;
	Wed, 06 May 2026 14:35:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778042101;
	cv=none; b=K4R8Ei7CtxUqpD54O5h5RPTz8auYSnMb/gNEs//ICfZ2LYsQhvsktGYWT/NLyT3+WcS6JwL6Mzoq0z8JHqns4nz9ZvgO5YKWUXuQa2gnqdXUjvE3Do+gTxpGe6aVYgDt0egINxhfwS7HmZ12044nZLpyKeafkmm6VUNR38BWTm+OPbGIGvYyC3K0DrRRmtLajap0C9WGudOBfnvQxgM3zkkeVgoVTVXjfg4vlbqPH0AjglDH6X8djjahR+WldPj/lxlG0k4AMwxFV1VKT9urnGgfIAOks6QF2HtAs3clv0ryxHMKfFx5DEYs03jjw+ahhmUlOHbn9yp82/D+wAsVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778042101; c=relaxed/relaxed;
	bh=tYeGJnUiR+pJlwKQlOjTGBVTkpn+nHsGOg6LYM+Gjy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dscTXI/Sw7oYMzWIiTYAI65dI3PlkA3Pio3TUGzKAue7ZjABAXOM/TvKPMRKKK2ZmdHHXK3KbEb7K4I2A0ZsxLqC5fzLCaasNAqkFgoDpWG1yd0SImDO86XmNhSxn5bN993cOukXCE/D+7wtQRKJqgo+nDx5SjeO96/Joj2wso+xI2cXTgyJiQa0BX9JcEFhy4I2zEFrKO9bbfX3JAeYLzlXv57MKKnQ7yzHgDwd21teP1tgEjGReDf/Bcp5cfUMhxInuXM/SYAwny4HefscErIx2QVMR6IJNmJ/0huHGnpEuuoHI7Zp0khzzXGAfb4ajpq18GjXKe35eQojGKWwDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rdnZ42K1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rdnZ42K1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9MxK0PrBz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 14:35:00 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645K6qdE2808530;
	Wed, 6 May 2026 04:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tYeGJn
	UiR+pJlwKQlOjTGBVTkpn+nHsGOg6LYM+Gjy0=; b=rdnZ42K13x26sE1dyRZze9
	yxjyRcsz9C1ccvndjqImRPEyOx3gstpXX+/YmJA280/ZTxw2SjTFvlNB8UzIp4V8
	yXZw/+UdWtndRiF1UwG1xUG7tgu4tQN1mt6PZwAyMTYj1IRLFT5r4wF/0eCf/8tE
	6GShg0l9jYYhH782fnhGGGcNb3SkQhpZ/cnmb1ryeOxck9865EwjpjL6zMC335U2
	j/4qltk94MRj4BzbuVMkVWYYwFCwVm/okZSLKKezkVeeLA5QJWQ/vVrsUK9E3JJD
	LIjHywKu20ps4GjC0Ilsmwi176jhlrZExbyVXunKoPBA14PfdN6NnX5kYNxPzYSA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1exba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:34:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6464OpXg015802;
	Wed, 6 May 2026 04:34:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgcghc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:34:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6464Ygek28574324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 04:34:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB41C5805A;
	Wed,  6 May 2026 04:34:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5523A58051;
	Wed,  6 May 2026 04:34:39 +0000 (GMT)
Received: from [9.124.209.5] (unknown [9.124.209.5])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 04:34:38 +0000 (GMT)
Message-ID: <c59f0ef2-efa0-49c1-ac79-0a6e69aeb7af@linux.ibm.com>
Date: Wed, 6 May 2026 10:04:37 +0530
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
Subject: Re: [PATCH] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Content-Language: en-GB
To: Julian Braha <julianbraha@gmail.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        jniethe5@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260405161545.161006-1-julianbraha@gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260405161545.161006-1-julianbraha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ggCt4CKrVVX0AWEJauPCYx9o4_NofMXm
X-Proofpoint-GUID: k8o3kzIb6igVr8HKgZABaI17iwiuwViq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzNyBTYWx0ZWRfX+Ku9GwQtdbCU
 D3V4+SD2YwkW8B/L16DxHXNIBXc+nMPkY1s+7Qp/GKJRVkcMU67ApHxCzR1HeYcc/KOPMj+EKrO
 j8eU53UWpf0iAp54CLbxxJlbHLfKM3qbWm43mpDvk2iJEWAv+4Li0VbP+bVNLadgcCw57sZSaLg
 tLWQtV8kQwMBi6+F8E4PVnI+hnbv0nEQa8nnx/5tyA/udje1VNNz+lGkBbrfDRJyM7Dv4atbM5p
 RXbdP48vHu6K1ouGNB+KNCel6y0lGKXeQwRj331zGZGhv5LWmSLpQdlHpTi+0nTI1hkaD9/LAKI
 lDDYln1/NCLC/qhBL8dDWcwL6d531S0Y0xDNCTIzCnLJTaZLMDQKfuJEoxZVLdkfUvCf/Kip4qR
 uiLpluuPwIjPTVw1zCa389pP18BICRVu1S64kffxKhOHStz6m7NPaUKBsL2bRy+W8Ds78rCGxrJ
 x+TX2mB0ALhfwZp4DCQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fac4e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=asDfj_d41YawczLiECMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060037



On 05/04/26 9:45 pm, Julian Braha wrote:
> The GUEST_STATE_BUFFER_TEST config option should default
> to KUNIT_ALL_TESTS so that if all tests are enabled then
> it is included, but currently the 'default KUNIT_ALL_TESTS'
> statement is shadowed by 'def_tristate n',
> meaning that this second default statement is currently dead code.
> 
> It looks to me like the commit
> 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> intended to set the default to KUNIT_ALL_TESTS, but mistakenly
> missed the def_tristate.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Keeping the commit title as "powerpc: correctly enable KUNIT_ALL_TESTS
as default for GUEST_STATE_BUFFER_TEST" might look better. Anyways,

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> ---
>   arch/powerpc/Kconfig.debug | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index f15e5920080b..e8718bc13eeb 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -83,11 +83,10 @@ config MSI_BITMAP_SELFTEST
>   	depends on DEBUG_KERNEL
>   
>   config GUEST_STATE_BUFFER_TEST
> -	def_tristate n
> +	def_tristate KUNIT_ALL_TESTS
>   	prompt "Enable Guest State Buffer unit tests"
>   	depends on KUNIT
>   	depends on KVM_BOOK3S_HV_POSSIBLE
> -	default KUNIT_ALL_TESTS
>   	help
>   	  The Guest State Buffer is a data format specified in the PAPR.
>   	  It is by hcalls to communicate the state of L2 guests between


