Return-Path: <linuxppc-dev+bounces-27491-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F36AC982C4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2026 15:24:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlN3n3qZtz2yGT;
	Thu, 17 Sep 2026 01:24:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789572293;
	cv=none; b=i5ZsM1BF/L72M/GIgnS9ICujjRor3GzIN9+DvpwElB8qklNmg5bC1igXpJuC+fUEx3LYXW8BJSIiAlIyzt+jw0LsUguB5K75Arcbl40rqbX3Ue5cCGGfrgVhndHGeVhlsx3ZBLe2jfDv8161JCEMecP09+0jCy0qlfdppjAVyOfcs84ZjGwjPirAfavGt285KDgzYb9VDzin03b7jQcvfU9vSVbpsQp98BopoFZuNXB/HdxlMNSXXN5xbLUMvCjjMDNsnZuwFLNPpzq0IyGUfEFQW+fE9PMvvQtk81rYzwvmHBuYGr9Q3M8Ev3rH5jZrHLiVrJ4Clx5o0wQ4plsXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789572293; c=relaxed/relaxed;
	bh=bmSKfJ+DuEp78ohwrZ9bi3DjkEQISwc3a58ABb7nYFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngGfq3LN7Dnzt9niPT6b4Og7ZS8BO4DZev/VE8WUZ83HdRwEAKHKBAac1bMZGtyYngqqySdc02pcYmHIQSNcWIWpyBcoPyck96YIo8GU9NZNsvCdcP1rIYTgNVtJO6WPH6ZzRmGiaoLvboOvzeKPqh+VvEY0GDKTJIpDrjX1pBc1cWLGzXnuMBBtWRInagxHc+AEa8a5f19bIAav8xcGFKWjVPcNeBLffr8VCyZfiMzJ6FFOVtAen3KD5kf4GZHZSmFI1P5fDUmaiDY4sPsDTBEhLbAgkXELMToVNIjefJBV3LqYL6Fdp67nfJasjTS+p9Pw0wqD9KMb7ZRmu1KgTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pWVqs8mm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pWVqs8mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlN3m28vkz2xqp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 01:24:51 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEW0jK4047273;
	Wed, 16 Sep 2026 15:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bmSKfJ
	+DuEp78ohwrZ9bi3DjkEQISwc3a58ABb7nYFg=; b=pWVqs8mm1KLVHeVpN+DVF+
	D+4VpOYnaa7x6Ulv/NLU+GcY89Z36FvacSjdpOizWvz5x8KQbAR3TzBN34jILMvB
	eKSvAGJTGENtghBND1S0vzI/8oIzfsQUj8sIO/AnK3hQbf3FRdk6adNs1XVpQh94
	thDD9kqo1UhhUGB9ilAkdNuyiPTM7GMNx938ekwvZxgBoLs+Up5yXPhYCtfDtv+F
	HJ+E3YX4pVQvtTmSn7T9iUqL9qIhEen6KpjT2g5ifVA3cAINAz/gzxK5CmR3Lc2O
	EWCp2ojeSUHVHeTs5V4dXnY5AZTmxthay8CNTuLxTUe/zJQEf34qeNBJjxc4iRuA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv4yb4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:24:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFKEnC1601859;
	Wed, 16 Sep 2026 15:24:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsf0m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:24:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFOTsN52494718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:24:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E4A20043;
	Wed, 16 Sep 2026 15:24:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EBDF20040;
	Wed, 16 Sep 2026 15:24:27 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Sep 2026 15:24:27 +0000 (GMT)
Date: Wed, 16 Sep 2026 21:02:13 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/sysfs: Remove redundant wait time clamps
Message-ID: <20260916205928.ed6f9a7e-66-amachhiw@linux.ibm.com>
Mail-Followup-To: Thorsten Blum <blum@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260916151254.120629-2-blum@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916151254.120629-2-blum@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX1MKeEM5oGno+
 TD/yKnMp+E9lWMFOuVrOppA4MS4jKaGUM5Q+qTyICZrt/9QaUon7fuzNZP0+IdXD1QhtOMeFlxH
 0rru5dfRTkU+rGlMAgF7cdNjd7YvEZM=
X-Proofpoint-ORIG-GUID: h_8GQgs1B2ldWI7eBrB5MBw1c6gErRxb
X-Proofpoint-GUID: iP8mRjI1rMc7DlK3nD45BzSs0JD4b3kR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfXxw4IM6GsMJOM
 LqbLtNdR6IERi5mWtXssBuFWpt6iTLMLQvfCbthVTsI3UqdPHoNY+y51FFA4Zc8JliOxAVRuFZA
 SaqQmv9CM8lT0ufqj3PyVA9qcpAKWNAlxVNH9YhXCpkGPzTrUGWaFDPN8zH9247B9lhBi5BcMZB
 xG7aandOjo93i3nUsio5zUCDgoP3rk8zISZ1sD21BaZZ5J47EepUzgMCWzsuRy0khEYmPgXa0kY
 1TcyUOR7fVyQmzOwwjqra77Bf4WIgj/McB0XmGkeBjfd4V8aYXaGmV7irM02wT7bYxaAQ8EBpvl
 VCGHwc5SkVTDMEHXcPDhiq82CiEV6Rj9f05M/isazaE/+Y25iQZY6kwUTpn7RtSKrOyapMSSAtD
 PUUqfd8LfXtCuoDCdQ95KzQq1NeDJT+YzYdsuEaBb5q2mn3uI+1g45euSZTtA0QjjiwE1uFNvoM
 020YeEtBzeKxlesOEVA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaab4b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rBgiJsE2jx_ROkl76MsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204

On 2026/09/16 05:12 PM, Thorsten Blum wrote:
> The wait times are u64 and cannot be negative. Remove the redundant
> clamps.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/powerpc/kernel/sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 329c1690b5ed..2100c5e2c821 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -338,7 +338,7 @@ static ssize_t show_pw20_wait_time(struct device *dev,
>  		time = pw20_wt;
>  	}
>  
> -	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);

The time variables in both show_pw20_wait_time() and show_altivec_idle_wait_time()
are u64, so the expression time > 0 ? time : 0 is indeed a no-op for all
possible values — when time == 0 the ternary also yields 0, and negative values
are impossible by type.  The simplification is correct and removes a subtly
misleading pattern that implies a signed type.

Nit: the commit message could also mention that when time == 0, the ternary
still yields 0, making the conditional identity-preserving for all possible
inputs — not just the non-negative ones.  Strengthens the rationale a little,
but not a blocker.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

> +	return sysfs_emit(buf, "%llu\n", time);
>  }
>  
>  static void set_pw20_wait_entry_bit(void *val)
> @@ -460,7 +460,7 @@ static ssize_t show_altivec_idle_wait_time(struct device *dev,
>  		time = altivec_idle_wt;
>  	}
>  
> -	return sysfs_emit(buf, "%llu\n", time > 0 ? time : 0);
> +	return sysfs_emit(buf, "%llu\n", time);
>  }
>  
>  static void set_altivec_idle_wait_entry_bit(void *val)

