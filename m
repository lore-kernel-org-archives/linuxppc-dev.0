Return-Path: <linuxppc-dev+bounces-16912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772FCE9A031
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 19:16:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFqB4473Sz2xm3;
	Wed, 18 Feb 2026 06:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771355772;
	cv=none; b=gQPvV8b6t7+TEh+D++V4So0IhavUGr/qWX5Yn+2NHjF4/u4aBTkLDSyDKmvmDGtddOOx+XAGXt6G3vA9DmRI47WPQrYFBIhBqDFZacafUd235Fv/tPKOejqU9x7JWml6IL845cuxENweyZjMBu5yimwIK016RsjH89qkGd1+sgNp34s6WXH5DorvK2J3OUowxqxiMiCYaBn7ZYcv5PDpTbJQwSq4hQSchOLiKR/HuynZ67375GMdscjrdSP71wLW6gqEhhVF0wpHrgzmlmNZRZtl/rYv/61/C15Gu4df8Zo1dn+RJImdDdaUldiLFQABC2RWW2PpVIEOCuN+yi7MSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771355772; c=relaxed/relaxed;
	bh=VNMpq4qyh3WYGxKXlPxpMOOQOK3XVP3jl0fTJEZhqqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiVgrNdx18EfAswKG9WRTxce1WOIK0kZfdHV01Igt/grllZRBRYSSJUydBmadkDpvfqBusJOGNAUUABWc3JbPXWoIcy4AbFq/YdG9dwk6azk4iMh6SloZ7HQnTzKhCiifiAGcLej/X62j/ZRpRSJDZAVxofLU8i9OIunnYDBjhvr6VUgb638ZwmFqhp67/TXtvu4qyi28eV/uJdKD5bhTIZI4fBRmRzTuHpJY53EAKBJbv38vRp84TwV0A9wFHZGAsBs3NsnKDOjhRdTncvk0ggWEui3Itw+bS0I9kDWK1oGaga4FOoAwsa3oY8+jLgH2hKkEHc2g2w3A6W1sfqtwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o/v2cGmD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o/v2cGmD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFqB34z6xz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 06:16:10 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HFF78t3013565;
	Tue, 17 Feb 2026 19:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VNMpq4qyh3WYGxKXlPxpMOOQOK3XVP
	3jl0fTJEZhqqQ=; b=o/v2cGmDJBZclaH3Apz9H2Lc0UbZc9P/Nh3skMRUCeKyMA
	BOUm60hRT4KlqWFKAcCtme6tHHCy5GbTN3WIhfteH4xhMleebCTcvHwlWNfL7ot7
	815XqgrtpFscGVM+YpJR2984AxAF/7eWHJzMOvLmNoG0oKDr4/QszrE8VummC2VV
	Ag9DWnF7rEQRVSK5TbdVWXCxPmIY3nKLpFwC56+lGkMjZOEezyJbecxbh28WjQJr
	cMiaTXtSTxzyH4EKCqR0IxaDucrWebONz/4gSybT2a/s3Jq1Q/4PeKdB5BKv0Kjw
	8MIriOmt9N6Jo9Nc7oOIJ347c9p12d7hvBFlkxcQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcqx0b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 19:15:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HJ3ll3030213;
	Tue, 17 Feb 2026 19:15:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb454hpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 19:15:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HJFYib50921818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 19:15:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2514B2004B;
	Tue, 17 Feb 2026 19:15:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61F6B20043;
	Tue, 17 Feb 2026 19:15:32 +0000 (GMT)
Received: from osiris (unknown [9.111.13.3])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 17 Feb 2026 19:15:32 +0000 (GMT)
Date: Tue, 17 Feb 2026 20:15:30 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org,
        ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
        rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
        ying.huang@linux.alibaba.com, apopple@nvidia.com,
        lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
        vbabka@suse.cz, jannh@google.com, rppt@kernel.org, mhocko@suse.com,
        pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: use vma_start_write_killable() in
 process_vma_walk_lock()
Message-ID: <20260217191530.13857Aae-hca@linux.ibm.com>
References: <20260217163250.2326001-1-surenb@google.com>
 <20260217163250.2326001-4-surenb@google.com>
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
In-Reply-To: <20260217163250.2326001-4-surenb@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wcqAAen5QtOIh3Yd7KPIhfP50s2xWLqT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NiBTYWx0ZWRfX7oqGr8VrV/Xk
 p0gIknVZDxQC2GBczDROOnBcM7o7b3pKMWShsmSu1vqb+BvlzcCZcclbforXI3g03Tg2w3NQXE0
 iXFAV4kar5rcK/dTEoKjXtQ1YydA7DBAYYTXJQ6GINk1YIMDoUkt+7mkJ3MI51bmInQTTszK824
 8nC+0GeJPvCKNnOgiTfjClOWWPT+8Lpcfx5vc85/5OZTHkYR01ktJG/0YRg76aGx/X0wf04+agQ
 4kI4XL8Z0IXYl+rLKXIZzDCweR6PPYquimZJ7zKZHJhugW/R0Zxnub8iJh9jLTWzQmDmDx2stnO
 COtshVSmyDhLJ6fSxUHaIBEZ1BEuSi+RgRGyBNoRxTvLU6HRcpoi/biPBkmqE8MvUghRu4fJIvr
 xZJMzLYZujcCXK+JpPkNmjgX9+7+EQ1UvF4aYXnwqc/76xKkXQpx4u4s86e/o2ezBaAxgc9G67x
 t92lhnQ8I8WJpFBDkPA==
X-Authority-Analysis: v=2.4 cv=UPXQ3Sfy c=1 sm=1 tr=0 ts=6994be5b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=1XWaLZrsAAAA:8
 a=28GIsqCL1x42zXYMcZMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Atfp6M6HOZik-aY60bN0PvQ41cv5zLBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170156

On Tue, Feb 17, 2026 at 08:32:50AM -0800, Suren Baghdasaryan wrote:
> Replace vma_start_write() with vma_start_write_killable() when
> process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> Adjust its direct and indirect users to check for a possible error
> and handle it.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  arch/s390/kvm/kvm-s390.c |  5 +++--
>  arch/s390/mm/gmap.c      | 13 ++++++++++---
>  fs/proc/task_mmu.c       |  7 ++++++-
>  mm/pagewalk.c            | 20 ++++++++++++++------
>  4 files changed, 33 insertions(+), 12 deletions(-)

The s390 code modified with this patch does not exist upstream
anymore. It has been replaced with Claudio's huge gmap rewrite.

