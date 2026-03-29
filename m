Return-Path: <linuxppc-dev+bounces-18969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FFBF3D5FE
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 09:14:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fk7wq65F9z2yYs;
	Sun, 29 Mar 2026 20:14:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774775643;
	cv=none; b=IqRmT/vQIvyLoCsQoATyakFj2teoT5k1W5F7JiqC4fgMpB646koyuIyNNqYEkdCj31HjT9OZ8a9upMg6hr4rc7aIDV8UPnMlXd2HbENt6oirO/F/AuGvF6aBZmBkzsOcBuU4nzjWytNvcF7vCNNoYvMm23CvDa9XoGlJ8WyRDfQuij5h5YTpCHSYRiAvH/lrWJehw6kMdu8eySDifHLqhDXSq1lGCfuQrg4sq7cdz+48SQ+MdURTep/aPP5RjGhf7yjecsZwJZcMe0t3hWGS4heI78p63MDIMtMKxyw1gvXRdaRC17ulpng6+uoqG102eNt2RtwM+wvelcw03d/ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774775643; c=relaxed/relaxed;
	bh=MQ3mnRT6diMlazrYkiPLEGvm0cEwRJiRjnz53r8uixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xd1t4zaTd00rKQk6ao5QkdHr2qFku4R5hQae6rChcasBQVTsT3sLbkYGyynKTjddyecE4QEJmTXdPGc4Gruily4aXjBP9m29qWOc7lfiksZ/FFdc0z+Mbo5YQH9LAeyPC5bH/Yl3VMiL+fKJXGZjjLvHnb+4mAz/lN3nZPXaFUtINTD8cYQ/iMGyqTyy0JdOJLwb8Gy8VuzvBlFTn+wehyiTOpZE2t5mHAd4UH4YEHrzHwjIAKUMSrXDTdG1iHVaTihzWj2qR2q8vsEs1hOadAZ1/xixWVxTzr04GP8LPiG+huhTaBVmyKDNGpfkwcmYYIkChyQQzgaIzSIBquIB7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QAvRcjtm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QAvRcjtm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fk7wn2MgQz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 20:14:00 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62T8U3fu2819414;
	Sun, 29 Mar 2026 09:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MQ3mnR
	T6diMlazrYkiPLEGvm0cEwRJiRjnz53r8uixc=; b=QAvRcjtmkH8+87cOqfgpS8
	0J21zMu23Ih7dIo8IzT8aw9C67eHT81skHbipE/wlFGpT3JD5IpR9TIBK2hVIYNC
	DJJbnOMRJ9Kja6FFDWn67iFBNW1qe5NJIdM+WZnGIIVG42gHW7ZMotTSniFVo1DO
	H2jxmYB/pMpW5TeYyLPSWOVq1zrn4BFct/rgPHf+CXjO382eblWWCcrX2e4CW6lH
	He6sy0oXvf15uDUr4FaHIJyS3bUcwKtZTmzMiC7NS+4cf6Z1n0XAXb4JnE7JwLRv
	C0r06rwOk5YpFfjr47dRKawp/gQQvzUXTYFCI2Q/XwfHZFjCtGsNrp4oi9g0sSVA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mrtwk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 09:13:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62T1rZB5014339;
	Sun, 29 Mar 2026 09:13:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttk8uhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 09:13:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62T9DU9U46072068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 29 Mar 2026 09:13:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2578320040;
	Sun, 29 Mar 2026 09:13:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0573A20043;
	Sun, 29 Mar 2026 09:13:28 +0000 (GMT)
Received: from [9.124.221.218] (unknown [9.124.221.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 29 Mar 2026 09:13:27 +0000 (GMT)
Message-ID: <275be5b0-9680-4d85-84f7-cf57142f20df@linux.ibm.com>
Date: Sun, 29 Mar 2026 14:43:27 +0530
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
Subject: Re: [PATCH 2/2] powerpc/xive: rework xive_find_target_in_mask()
To: Yury Norov <ynorov@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Nam Cao <namcao@linutronix.de>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260319033647.881246-1-ynorov@nvidia.com>
 <20260319033647.881246-3-ynorov@nvidia.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260319033647.881246-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69c8ed3d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=45r83EBxin15_2QMwJMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDA2NiBTYWx0ZWRfX+TJ49kkWIpxh
 uMO/X97NzGsTmqs3PrdpF1SbDkrJYyBgJ0ngRSyMKYyT3rDUYtdybf1Qil44ocr1Gh0Q3p158qd
 Nh0eDqYD1oXHqbs8f2PHzkrpoyzsLY/bwT/c06dVLXrl1gR0bQpORaj7ikXZ15CPiq8p7KWn+t3
 gDlkOAT1rAj9aZNVjmaUKpfY/RL5MdgWpIhVusg799By8r6W3MqueoS3SV/pxCjjo2na6tlgSik
 2e5pj6duJqa5acu7UoFVFTmpaZaNclP95rAzeK4FyYjLxdWkK1hCjaYA7S1H9DMet1gnxY12x5U
 mhvx92mzi3530jZnd4ojdH9qof/F/tIpxpQMF4vgsyDm58LavKSrjT7CtT+Y6c9112F1oVFywxf
 zrZ54bEUs1ws0JPGDljdWle5bIop+02TZ7fm/QfaPQRsGdV6/ITb85Rg5KSbu6daxKTGWieZO7a
 G7KNYwxQpgbOfrTX+Ug==
X-Proofpoint-GUID: eQjv0JxJLtGWfLCbPaq9ErLAMV99vw3G
X-Proofpoint-ORIG-GUID: KDmDmn973_yxrNt5g1R-msPTWpbZpz9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603290066

Hi Yury.

On 3/19/26 9:06 AM, Yury Norov wrote:
> Switch the function to using modern cpumask API and drop most of the
> housekeeping code.
> 
> Notice, if first >= nr_cpu_ids, for_each_cpu_wrap() iterator behaves just
> like for_each_cpu(), i.e. begins from 0. So even if WARN_ON() is triggered,
> no special handling is needed.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   arch/powerpc/sysdev/xive/common.c | 31 ++++++-------------------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index e91ec9036ad8..4e05f678e171 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -548,40 +548,21 @@ static void xive_dec_target_count(int cpu)
>   static int xive_find_target_in_mask(const struct cpumask *mask,
>   				    unsigned int fuzz)
>   {
> -	int cpu, first, num, i;
> +	int cpu, first;
>   
>   	/* Pick up a starting point CPU in the mask based on  fuzz */
> -	num = cpumask_weight(mask);
> -	first = fuzz % num;
> -
> -	/* Locate it */
> -	cpu = cpumask_first(mask);
> -	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
> -		cpu = cpumask_next(cpu, mask);
> -
> -	/* Sanity check */
> -	if (WARN_ON(cpu >= nr_cpu_ids))
> -		cpu = cpumask_first(cpu_online_mask);
> -
> -	/* Remember first one to handle wrap-around */
> -	first = cpu;
> +	fuzz %= cpumask_weight(mask);
> +	first = cpumask_nth(fuzz, mask);
> +	WARN_ON(first >= nr_cpu_ids);
>   
>   	/*
>   	 * Now go through the entire mask until we find a valid
>   	 * target.
>   	 */
> -	do {
> -		/*
> -		 * We re-check online as the fallback case passes us
> -		 * an untested affinity mask
> -		 */
> +	for_each_cpu_wrap(cpu, mask, first) {
>   		if (cpu_online(cpu) && xive_try_pick_target(cpu))
>   			return cpu;
> -		cpu = cpumask_next(cpu, mask);
> -		/* Wrap around */
> -		if (cpu >= nr_cpu_ids)
> -			cpu = cpumask_first(mask);
> -	} while (cpu != first);
> +	}
>   
>   	return -1;
>   }

Only concern i have, (which could potentially leads to while(1) loop
today if it), is if mask is empty. atleast for_each_cpu_wrap will not
be a while(1) loop.

So, IMO this is better than what we have today.

nit: maybe a good to add a WARN_ON(cpu >= nr_cpu_ids) in the end.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


