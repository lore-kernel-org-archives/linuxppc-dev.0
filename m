Return-Path: <linuxppc-dev+bounces-24203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBDCC44501
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 10:31:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzwZL6L8Kz2y7W;
	Tue, 14 Jul 2026 20:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784025066;
	cv=none; b=SaJJmMJQ2w+aONRCAYPUsDG0MoxKZSZv9rkafrLVpAPK7HCgV3UMW+PhjlyINaPxMT4EGKeZbwPSQy84zIG1ltYGLiDN/QldnlnW6UPzZqOsZ55fcJO9R130Bdmc9XcQjcHDIak0470x/OJTFC2s2TO0qi4iLprtLRPEcOSnz55PvH2N5qXojcXmdzq1/x9xaxF3LG/xt0EDr2gg8Bvh7Iq71pxH4o49Oc/DVD574oQW8D4zBINDrVoM8WpF7QMGIreiSXpObepaZEcbQ1ZdDiDT62UIctsJ0+QtAGWTVNhN3u/dPR7gXe5NHVDGKhulqtcrtbhvwU6/rqEMC9K19A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784025066; c=relaxed/relaxed;
	bh=gy1aB4pTvay9Q185FG7c2Tinmh3y05RKR0UNFFzQZAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pb5JpnnulwEdqX00B7OySK2/MaBeEM70KBickzTZZA1XMdCu3q91p8eKeWBRm0ffqixn3syr8jiPZr9S2Azgyt+aoglH3melX8PdLO5aOxpLA0Ai+oUrQ6Md1LYo9z3tq5eCV2lj166A8z1LudQowgLXNXDyeoaGx1BZEaZrcnjqOB7aBUwMHljssJgM/lj/KFPFJPnmykMyS2JDppMXPeBWpRD+fQlyp8Ugk+25YvYv4Wo/0k3lFa5rJIyPwdRJvZ58CyB0OuMf63kPFVjcCLqRPWSrId8MbnPj7ojWhMzCz/lghXjwc8iNx4vQ7/VArvjFXvDy7ffplHjUNgetKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bLIPRjQv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bLIPRjQv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzwZK70ndz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 20:31:05 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fshM547279;
	Tue, 14 Jul 2026 10:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=gy1aB4pTvay9Q185FG7c2
	Tinmh3y05RKR0UNFFzQZAI=; b=bLIPRjQviX/sFrTb2p9rdV2txHQBGRLLc/rJS
	zdGdbD2rfz3mH982C+ysBHgiZffC5vKICZ8O6+fXJD/U//bcV+3y57km26QBOLqH
	xRywwgEP4qrM6d0AnieEpOWEtndb00ofU4g8Pc8kEQ/drYop6PzavBcQ+fWONG46
	W4+VOIJKDmowmm8/VkxtbCigzkzN0YHuW/VtGDXXK9oBlUToetCAPz+KduG320Dv
	mDwxwkQE4JRmEnQmXwrmqq1QmtcttT+6J1o1MNPiLSoG13BoXpRPrHZsYOChy8ru
	BSPShht0SAHaU0xg/h/gZCZBZIa1avj6na3x3PZoGAnshmZ5A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbn6q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 10:30:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EAJeiE013361;
	Tue, 14 Jul 2026 10:30:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cga3wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 10:30:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66EAUm0F36372778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 10:30:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF1520043;
	Tue, 14 Jul 2026 10:30:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 528FA20040;
	Tue, 14 Jul 2026 10:30:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.31.36])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jul 2026 10:30:46 +0000 (GMT)
Date: Tue, 14 Jul 2026 16:00:43 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adityag@linux.ibm.com
Subject: Re: [PATCH] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <alYLBqcvPxZ47N1M@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701182756.273019-1-nikhilks@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a560fdd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=k39Bn-rZO4FkpeY6yEkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX5OB/axAlwJf3
 3BOgQL7JEDgvctd5pigwWRDJGb2MJLSEK+/6oNvK9MdW545IlPBzHg71hOWlABhemsTQKD37Crr
 IeZd4577kKnhjoj66pzVkZOx0jkFQeg1hCuiTKLRnY+B7L2jRwDT/3Dn0wNf43kSTEwYyrK2cB/
 rKykMGieE7BkhLzMbfzZP7r+hqcVnJ4mi58TjqR5HWhuaEnncwV6VFCWM7ZCIXeO3D1mJdKtzTP
 RypD5nP6OLuHWpOLWy5tdvb87CmaL1CZYgCUsnTsXFlT7L4K66F2ozEdpsPuNkKckSuaQF6lxn2
 fnnG//+MXE64P+vxFDNU4YKgR25D+QcvRA5rQo/Sx3dYXBLTC+UnUG5dbhRYT8jwRaWFyUky/X5
 jZDRsQy4J8S6WqoSegQG5trCz1CPLBmyfoGhmwZOBlyGnHJHuBWApitt37q7ePTE+5BjSrgBGsV
 8wk0ANOeTSJdQWw/KkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX093ah9Aw3b7e
 d70gx1es6atUDGVjBH0KiR8+7ecQmwXMOcGWPBGRmM60EltVt1LngYb2Bf3iyNZNAAR8W012A2e
 gWA03NAnGEJ+oO4fUCPcJeX3wzO6UmI=
X-Proofpoint-GUID: if6q_xhqXc59JZ9jnbDfbe38AgJ2l5Z7
X-Proofpoint-ORIG-GUID: _0qBIYgcTkHkQPWMiZb_zJclb4l1-3Zk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140106

On 2026-07-01 23:57:56 Wed, Nikhil Kumar Singh wrote:
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
>  arch/powerpc/kernel/head_64.S | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..e21c2bce8f7e 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,14 @@ p_end: .8byte _end - copy_to_here
>  _GLOBAL(copy_and_flush)
>  	addi	r5,r5,-8
>  	addi	r6,r6,-8
> -4:	li	r0,8			/* Use the smallest common	*/
> -					/* denominator cache line	*/
> -					/* size.  This results in	*/
> -					/* extra cache line flushes	*/
> -					/* but operation is correct.	*/
> -					/* Can't get cache line size	*/
> -					/* from NACA as it is being	*/
> -					/* moved too.			*/
> +4:	li	r0,8			/* r0 is the number of 8-byte words       */
> +					/* to copy per cache sync iteration.      */
> +					/* 8 words * 8 bytes = 64 bytes. 64B is   */
> +					/* the current default cache line size.   */
> +					/* This is a loop count, not a byte       */
> +					/* count. Increasing it will skip         */
> +					/* dcbst/icbi for lines in between and    */
> +					/* leave stale instructions in icache.    */

Looks good to me. The previous comment was misleading which makes one to
think r0 as cache line size which is not the case.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

