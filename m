Return-Path: <linuxppc-dev+bounces-21816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666A5CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 13:40:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTZq20SCQz2yrt;
	Mon, 01 Jun 2026 23:40:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780321246;
	cv=none; b=K/BvEedWIMdbw9Uap5hWmUg6344bEMYApVouO0H0xHl0eQPXro8lK/L9gbuUfMqXqVYEUUnPAwz7xqwPFD8v5cw+5o9Ag35Ml8OPhfKSkwykrGAeciIQmFRXkUi+wCz+e8Ptn7Xn1OERZedHpx2sX9X7vvS8BYAUtY+eP0Lq7MuUnZ7it0pR22shRRGRoK+WD/q5/vNnKkEZcHHpVMqzQNQOQEMM8gbjgrLCiTD60AilhVOxxJhfh03XFhfZLYjV18JTMtCkDpASynqHXx22C7Bm+I5EYvCXZg2H2hNl16ctwI0smAXV+oC3svMElt416ikzL6PIOslQs2HCNBRHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780321246; c=relaxed/relaxed;
	bh=Raw98YOpdyebzETA6JS8rNgY5x5+eRVucU1jg8ia5go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wo7wywj9iKrlqorcbrLr5hwn1aZx72+UUL6oZjnCtFUTsewXpLJDMjmUnBmrvc28JXlPOgbpmIZa44xiYj4psg8H++3wFs5r1KFrJIF6je5OkasrDkQT6gwOODauF7X6eLkG7j2+22sY3UWkAZKMIUTQqF9ZCeqvlC88f77tk7rTt3CWLeh0VQ2VLjNyZ+xrn8NySdcI0xSo0G/gwcmwWoj+69DWgrKGREkalbTxvmrE8kPRNzemB2GpDb2+q5DICK+AtlvnQ9dOYCgqfurk4HDFn0rEw0XRKJ/rvhJv0/rwUDGQH+en1SiTeOilYzKM9M/qLUzHkQPfYGcyifP96g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TUwsuSjI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TUwsuSjI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTZq10qRqz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 23:40:44 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6513Rpei2915495;
	Mon, 1 Jun 2026 13:40:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Raw98YOpdyebzETA6JS8rNgY5x5+eR
	VucU1jg8ia5go=; b=TUwsuSjIgK8FGgh5rBb/X9/ObHaqTe+iISxlffGXO2D0aO
	Do6fCO98+Xdo/ovP/g7cSxnRmeG01RhAFN29d0QSmP3MhPkypt6fqxjRkzjM+fqr
	zrROalB5l/6IETkNsT5nCDHzdB5zILiEBc2S5nJqUV+uCMTiqHBpZwnepDZ3Tu0j
	quUKu6ZaDG/fqrs32r64rtiE+cFuAGp/BmKemISj4Ut+C9rcyYJLzWefN7+ywjQD
	DSZAdsF68fWb6bw27pmSbdL1ldkgWnf6OOnl/HuLuq1bAgAd3adlE0B6zRVNlz3U
	JKhO1Rf9MHCC3D9ZAEw0D+tlAy8KygFqGlSSbCKQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4102m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:40:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Dd5Bn028374;
	Mon, 1 Jun 2026 13:40:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcege414-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 13:40:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651DeVK451511608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 13:40:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC7A2004E;
	Mon,  1 Jun 2026 13:40:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 128A42004D;
	Mon,  1 Jun 2026 13:40:27 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.23.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Jun 2026 13:40:26 +0000 (GMT)
Date: Mon, 1 Jun 2026 19:10:23 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Aditya Gupta <adityag@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom: Remove redundant early_init_dt_scan_root()
 call
Message-ID: <ah2KsuPcOu8tVOXo@shivang.upadyay>
References: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
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
In-Reply-To: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzNiBTYWx0ZWRfXxSIJKI7UoOt0
 QyB2NU3pcziW0+eTAPzLyHUlvs7G4vl1ZBSj3DNiuAnyVMgpKPvzhM8SoGJsSzKmD1UnhnqFBc1
 M7976C63la4HRYVKXC9uMLgpT+NVh0o8VxqHr6YPo3g0NHlei2r40+CKWVB2KkjjXHd7i0YGdMX
 XZu5xaktZCCK/7IZW7jw0mZ8kG2bi/Jvqe0yzTsWkKT+FBV01bF6iDOMguQv6vrI8yprPPpBo45
 FSb3vEDbrkXC2VTpefIkQFQDTLMVP37IOs2qiJFmbvvDjJo2CDWmCWVhhUyEdiCLYOUPlU3XaGE
 +puuM9k1o9SZBSW96zoEtNqvpx9lcEiMw4RjONyp9GHQte/zhquq6EqehS+0q7S/0NEtsY9Wt6h
 JS+CKN63Am3vMV8FJVdEbuj5gKPTFVoxrliaEGpnXWYJmgiPUF1yy9BTO0AhfhvBaMbihj+LhST
 HHEYXo1PXa7m6oVqKUA==
X-Proofpoint-GUID: vlHsqXbAbAaRY0mYF20z14Oyo34MOQ0_
X-Proofpoint-ORIG-GUID: lFxV2fBQafaSu_vO3F4oWlbpol5rkQRF
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1d8bd4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=6XZm-ef3JerJ913lw0wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010136

On Sat, Apr 18, 2026 at 02:42:50PM +0530, Sourabh Jain wrote:
> Commit 554b66233623 ("of/fdt: Scan the root node properties earlier")
> moved the invocation of early_init_dt_scan_root() into
> early_init_dt_verify().
> 
> early_init_devtree() already calls early_init_dt_verify(), so the root
> node properties are parsed before reaching the explicit call in this
> function.
> 
> Keeping the call here results in scanning the root node twice. Remove
> the redundant call and rely on the invocation from
> early_init_dt_verify().
> 
> This change keeps the behavior the same and removes an unnecessary
> duplicate call.
> 
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 9ed9dde7d231..d218c8cc1f73 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -824,7 +824,6 @@ void __init early_init_devtree(void *params)
>  	fadump_append_bootargs();
>  
>  	/* Scan memory nodes and rebuild MEMBLOCKs */
> -	early_init_dt_scan_root();
>  	early_init_dt_scan_memory_ppc();
>  
>  	/*
> -- 
> 2.52.0
> 

Hi Sourabh,

Patch Looks good to me. Ran a quick boot test also.
Feel free to add.

Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.

