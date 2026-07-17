Return-Path: <linuxppc-dev+bounces-24345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8DBC4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 14:53:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1tG51qp9z2yRl;
	Sat, 18 Jul 2026 00:53:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784300029;
	cv=none; b=afv5R7iP5kfDJCn95uTlgpBrBRTedVi/eZN+2j5c5p++U7V1leNB/RKaf7xMNMq0IbrJ68oL/EruFo9vuA913r2ClbNqikW6nHuKF1d1G7iYkKvCrbIe/7YpBeGP9Pc4T8jTOfb1LTVJU1+9cDgItLVobBxYxbsBqhGMiZBcFv8Vyy1QLhoCBooJwaWc9UBZyJxNnnyl6p5l9L5yAvTTeT/QlzIoyVFiDK4Vsig9Z4EvoDsXruBWyNxWujKi3tROaQTliMxFgMc0TfvVxEOcBrDfHyXL3Mk5h0BMTW+kfvfsa4w4o64VIChVUkSEhpOZY+zoO4HSkSUtEXG+MVJQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784300029; c=relaxed/relaxed;
	bh=RoD28vbB7VQ2CpVZ/w+acAmXh860NLyZOZNU2jktAbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HflO0wFqSUfc08qb3FA7J2jsY1JzpScbHg5Cq6ivnXcqMH2kQ4h7gZrmAZnKIYNfWxKSov9f06SNm1fO8ZZG3h6zV7nhK4o7dOhc8aXsQ0D+VXUSueOwOARkgia+wv0qUJFCBpTUNba+hcjdBlB+u/Ex4Y531Z9qfib2jfNLS+cDuUUA/lL7sU2kQ8+tl0+rtB8vMfhQR1U+imymqnRXGLeTjrV0/PsNVVeiYPayzKRUJKhG+V6jsUG3axWoK71HtOivDTgtxnAgajV9uQrvaD49EWNQj5jnvIx2OXhRR4kfmjKKFdfdSGlgMqK5XmUDM+tzqFyGt3o1nbFPt95eRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WpMqs1EF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WpMqs1EF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1tG40rtGz2yRM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 00:53:47 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HEBmDG2164833;
	Fri, 17 Jul 2026 14:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=RoD28vbB7VQ2CpVZ/w+ac
	AmXh860NLyZOZNU2jktAbw=; b=WpMqs1EFF7k6tknE1CUdt3iZHyMSpiQx6aw/N
	ePMbJ1lXdSpmMjwXxy8e+q6YKtGK+qBeaYcQZOS0a+CG39AewfUMv8VotnxARipa
	Nhl70Vwgqggnz3R29899rou+TEpfKNc56/bMcbvEgIGY1DeiA78O8ClSpj4VsOJd
	fPc7LhY767cn4O+Wp5vhoig5brnpgqTxd01kBbBtJiol+90MEjL05vGMHI17QXZe
	IQJ+LykmRFAumnmbRkveW7TvNoN+ynYQR4qBlbTwyouMGiC3PqvGrLU2bxNbyc8Q
	6qM+lM5ndCtl8pLtqBysIDuz5UvrLGQDsAjRqiPfry4S7zJRg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2ap08x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 14:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HEngdA030832;
	Fri, 17 Jul 2026 14:53:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgsxd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 14:53:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HErPHG30212564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 14:53:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1339620043;
	Fri, 17 Jul 2026 14:53:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB3C20040;
	Fri, 17 Jul 2026 14:53:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.217.166])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 17 Jul 2026 14:53:22 +0000 (GMT)
Date: Fri, 17 Jul 2026 20:22:34 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mkchauras@gmail.com,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, adityag@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/64s: Clarify copy_and_flush() cache sync loop
 comment
Message-ID: <alpA874OQSZkDNH3@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260701182756.273019-1-nikhilks@linux.ibm.com>
 <20260706082708.43918-1-nikhilks@linux.ibm.com>
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
In-Reply-To: <20260706082708.43918-1-nikhilks@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX5wFg7+Qh99bc
 FuZIfPQy+vpHe7vn1dr7uRU6KlsSiDVep8vaEMQFl0jz7+3I6lf50gy3vvqFeo2iLUeWHbEA22X
 1/SdMCFRLj8935wF0BB1cNu4LpYGbmU=
X-Proofpoint-GUID: 12EyJPqtRTd4M50x8ob-QBgB84WS9xWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX2UM8qKlwimfB
 nIFazF7nd0U2/t6tqyPhibMbshUkDgmROQJCILW7MSE3n+Pg3jnciNEFZjr6sJVDBULpqhX5x+A
 rk5iF2aNnsLx2LkxYZv5iGxceogFrLBFtplo/pwAB6MIG89LxGGIdu92oAGpT+ixqIR7cMUwgte
 WWHXJYqN4nl6K/y16DkhnMvygegxFGxsThzbDFVF5LuTnoYFEvdVIUUBS5DO+EDCILY+fBT7Ce1
 TRH7jpauZ2zGzY7zSouzg2P+eIgiPV9P6c3Xfe+2g2+HM6iin+r1FKVz/LFosxgo18+h40z9DEx
 WZtVrrpNIMO96LGR2GJehDPoUwiX15e0L9M4/3AKpjtGxoT9eugATOd4u07voOTCxeLNDcN8Lv1
 4OL8wMJiQF6uz+0bRpOFVwivtGt1NXTkhfAEh2H/QZD9LBOzx2p2GKoBppYCLjBXpT31fTtkO8+
 Shkr/KmhaARTbDI3p8g==
X-Proofpoint-ORIG-GUID: kwPz7CUXUJN8XXAf5G7ihSXQhgS0uI9_
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5a41e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=k39Bn-rZO4FkpeY6yEkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

On 2026-07-06 13:57:08 Mon, Nikhil Kumar Singh wrote:
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
>  arch/powerpc/kernel/head_64.S | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 63432a33ec49..a54f6f979173 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -713,14 +713,18 @@ p_end: .8byte _end - copy_to_here
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

Looks good to me. The previous comment was misleading which makes one to
think r0 as cache line size which is not the case.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

