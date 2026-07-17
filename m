Return-Path: <linuxppc-dev+bounces-24337-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEADC4450F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 06:41:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1gKm40KFz3brV;
	Fri, 17 Jul 2026 16:41:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784270476;
	cv=none; b=N99SDgdWBoR7mLoBkDvRFASY//FIFif+ScJj84Kj9hQ21h9Z3QXLAI4FDoJjJp7qLXEychGaBVvKfHFsRsEE7fu2FMjjEqxA40zxyCeaZOIu0rEGwLZPjnxCr1Yy/36Bg3HZfh5VTttvzei24UKWOmCQGnp2xwLPKkmhU5+lXvntzkOfBuNE616XSGrf1RHu+mwnNEZMniqGq6WTdVx0n2u8RRuqdunKbjbB/lYS09KR3rEgZ6s7kNwDHvGsCBYU+FgpoyRNVUWUGW3Ya2ssknP4VXEEHRRo0zMAox/MwWFpkJaLrCDBRz3VLFJDN0Rbt7Qz33JDrRbh9pxCNp8ZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784270476; c=relaxed/relaxed;
	bh=LZiS6OqBDGjgcFUxsfvG+Q//lbkHAodJg99/Im0Xmug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ioducBBtTCpDfA4SzN0pd2kYDA9Mpgs2zLsykiGQrnxkG4KKJhi5DA1l2KMxc14lBYx36YapH2YN+fRzi34WP9bvfCqv07KKNnElRaRj5VyQOzyM7kR3oOEnqO4vtzTe1HIf2glQbHg8xHHEaBEfm9TlaWBg532Ed9u6/tURwmzuBqQPLH3/8YQLltFZqIa2t2BM6W0OhtDXhJF22aWNMYsn+7jiw3hN9o574TBoW7fKCDFj6V+wls/KlBlFORm9nEy/lt/jZ3mcI8+bcUhmbxCyUQCA1BRNXYEr9PATHMq4hRvFFjsweOMnxLY+pDalQlpchvXIL4LC02+yxKz8SA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lnlefo8V; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lnlefo8V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1gKk6ypGz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 16:41:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3C9fX779172;
	Fri, 17 Jul 2026 06:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LZiS6O
	qBDGjgcFUxsfvG+Q//lbkHAodJg99/Im0Xmug=; b=Lnlefo8Vx0rYEP0zKssOWM
	v4DNFQHO9GHF8nQNUh4UINI0RTsjsGWcIyrgDRR334E62A1wklpNzAGYEfI/sKNV
	3ilFkxTirnF8mmYqNn7PmeWw8V/DK9rlPeSaGinYjHdSSihQ+b3If66FLmtJkBgr
	di3OWrJpnMGO2DJsx8OPfANyiV4YXOxlvjthdOdawDJZPlFc2OHxuW9LUCCx0lRO
	PvrfFGfOUmWkD6dApXFQeJuZBpRBGs/DZcgusAQNMZOUHETLygi8YuEirE2ZWIpV
	N5i6d5is66oWlUTc0UL/++xkuV25q7eEXxjuEiSfZ5+SieOzRFIbb3OVQd1aujUg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexx421p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 06:41:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H6Z27m011253;
	Fri, 17 Jul 2026 06:41:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15k8fre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 06:41:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H6euMO28311810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 06:40:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF81520040;
	Fri, 17 Jul 2026 06:40:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE00820043;
	Fri, 17 Jul 2026 06:40:53 +0000 (GMT)
Received: from [9.39.17.79] (unknown [9.39.17.79])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 06:40:53 +0000 (GMT)
Message-ID: <1f7213ef-72ae-4ee7-8af6-e44f7859ed31@linux.ibm.com>
Date: Fri, 17 Jul 2026 12:10:52 +0530
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
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mkchauras@gmail.com
Cc: linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260706082708.43918-1-nikhilks@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VjiC2mMexStX6XT0d2FefVkTGP-W_cPl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA1OSBTYWx0ZWRfX/u1lxYAOm3yL
 2vF0Xg4V7MPyH3zB4DRevkBHiyuR9wGAM4O2tTGiLTvyqz9HUkd83rT2x5tJW6Vvldi7RCpIWXh
 s8442NZ69cgkbvcVrCwy2ZBCvQ1/NgVaf5mXhYnr2MfTrie5QsoBjnJC/3J+bf1tLAdRZyJakXi
 11XdU4eOHHmHeWR2W79c1yuEGgkH2dK6I5q66wVJFb1MPBduhDEGvh+gcNzPHOw1ivyuSIE6jP4
 tBk5Ii9Y2ZFv7XT8wiqBil3e498xC7+oWqlQDMd50gcYy6ixbn2nj/sHgVqGQVsBEQ/wxADn4LI
 0mTWDD6QGz5v+vGyf4UEfXnmumAkw1vd+QerjPekzu3gk/jIJQynPZNVSluu7PxhfU/Cpau56cT
 bIHUIgzNcDM4Qh9AZI6D/ZsJpnBQrFPgaZ5jD62RDST7vtd12wFElJSS7pvlqv5r6ZtoP67L+H6
 YjrllhhnHp6Bn+cuBAw==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a59ce7d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=k39Bn-rZO4FkpeY6yEkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5bKdtJOSvU5aPqbRwLVYZIAuvU7bHbKZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA1OSBTYWx0ZWRfX9h13gIW1hYzV
 DuK6UBv+yo+X8ouST8kNuJgUrbxbNeTpCxXuJG6K55i5aoGjT6tviKzoeyD8pQyDNJsuemMiA6d
 QCoQppufrbD8tIgrfkO/kez8nW4VvY8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170059

On 06/07/26 13:57, Nikhil Kumar Singh wrote:

> The value loaded into r0 in copy_and_flush() represents the number of
> 8-byte words processed between cache synchronization operations.
>
> The existing comment refers to cache line size, which can make it appear
> that the value is a cache line size in bytes rather than a loop count.
> Clarify the comment to explain that the loop processes 8 words (64 bytes)
> per cache synchronization iteration, and that increasing the value would
> skip cache maintenance for intermediate cache lines.
>
> This is a comment-only change with no functional impact.
>
> Signed-off-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> ---
>   arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..a54f6f979173 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
>   _GLOBAL(copy_and_flush)
>   	addi	r5,r5,-8
>   	addi	r6,r6,-8
> -4:	li	r0,8			/* Use the smallest common	*/
> -					/* denominator cache line	*/
> -					/* size.  This results in	*/
> -					/* extra cache line flushes	*/
> -					/* but operation is correct.	*/
> -					/* Can't get cache line size	*/
> -					/* from NACA as it is being	*/
> -					/* moved too.			*/
> +4:	li	r0,8			/* r0 is the number of 8-byte words	*/
> +					/* to copy per cache sync iteration.	*/
> +					/* 8 words * 8 bytes = 64 bytes. 64B is	*/
> +					/* the current default cache line size.	*/
> +					/* This is a loop count, not a byte	*/
> +					/* count. Increasing it may skip	*/
> +					/* dcbst/icbi for lines in between and	*/
> +					/* leave stale instructions in icache.	*/
> +					/* This results in extra cache line	*/
> +					/* flushes but operation is correct.	*/
> +					/* Can't get cache line size from NACA	*/
> +					/* as it is being moved too.		*/
>   
>   	mtctr	r0			/* put # words/line in ctr	*/
>   3:	addi	r6,r6,8			/* copy a cache line		*/

Makes sense. Feel free to keep the rb.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G


