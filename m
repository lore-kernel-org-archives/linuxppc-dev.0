Return-Path: <linuxppc-dev+bounces-26966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2FEC79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:00:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg59t1bVZz3000;
	Thu, 10 Sep 2026 02:00:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969618;
	cv=none; b=Ucld/1mIHeotWKwp0doZqtjZNW2qz83BVHxmJuJE7jwLFlB7yTjy+DFumHYBsbs+STh1QFpB1RMyPL+hvTRTPBhaggNsrMG50IaRM2Ni0j+tPz9ygQ1heEpxO4MxSeesy3f306eCXLgGcNq9dU4RMGTdsE3WSpqjFPHJgvwg5jynv89gQ5OP6Dd0OZaV61u1Z9cOdzRq9VpYs2Vw1O3h/tQY89HxHk5PsChNKDLP2hpM4xchbuaruqe0hilZ0efAhY9WZRvtotF/FkeipLehBBoVCLYfRitfmbMrEzJpQtaSoZ69oaAcDwSTlX2axcwQztqRQIAH7jTTSAou+Qa3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969618; c=relaxed/relaxed;
	bh=l12FJLZSA4lmCvF85/DILU4UfSjIkRXJcWpsUPU1aSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCHiDh0jfGGc0jZ05qsHNx8kZZioQYibUzmzeqjdeSO3TmvZSVjvENzwjRVcT+WzhNcHVbD068cDpudJimuAphH7GoPhpizmz/Jj3uh7ierGmaWmylIPi6Q+nc1EnSJDlTStMrKL/NGex4SSEQC//YsXv3z1Hiq6TUl5im+lMV9hc1S/eYqu9pe5swZILk4BcGhzizZTXeBs5E2xC90p/GGDBk9dOQatYLurtfQ0WsCqaIgZSApeCSnzZgTFWjaA7dHa0atuBjyv6+nheFVo/G9d5skBKFi8sN7f6gwPIVArMVuObyhcwrRGYA5gIycp/aC54m9c5vus8kBJJToB3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hXTN4gQz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hXTN4gQz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg59r1BJ9z2yyq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:00:15 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1cEf3669831;
	Wed, 9 Sep 2026 16:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l12FJL
	ZSA4lmCvF85/DILU4UfSjIkRXJcWpsUPU1aSM=; b=hXTN4gQz3sdKnMApujNdIi
	VuxTt52V0rk3zNYpT+NI7bl+5VlbeJiKh/WLSs4pxd0+QUh0ZhuHHT4lSeGgN38X
	rLo7kss42obpriGrOi/ra1DVzam1TYDezzZ8iR9aDiO/EN6WrIir2CIV8BKuP6Rw
	365CrmkW4I053DDuKV4sBbR7G5BksUxR4EyuU3a08o4PAmjf2f8qwH7y3UxzWC0Z
	tQIRqyNfog5xC25BcslyzX4OMCxtkeMw4DVMFOXOLKDadFgXXGdZXq6y/gz9d5cp
	CWb/tYCRHz7pL964YxsWwA/bvbHdRPQkdryQA6XjaNHk6623nCUGHpahsNwbysNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8ehwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:59:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuJen005298;
	Wed, 9 Sep 2026 15:59:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwhb3f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:59:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FxuPa40894808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:59:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A370E2004D;
	Wed,  9 Sep 2026 15:59:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 015FC2004F;
	Wed,  9 Sep 2026 15:59:43 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:59:42 +0000 (GMT)
Message-ID: <3f441c3d-79fd-4d38-870a-717bb966524f@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:29:39 +0530
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
Subject: Re: [PATCH v2 10/22] coredump: make the dump helper return bool
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-10-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-10-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: As9ZvkhTmFbf5q03THjZ7-Osc9MPFSF9
X-Proofpoint-ORIG-GUID: 3bHKayFLGyoZ6KIkXeR-RS08J7sKCY_v
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa1827f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=I4qysWOTMUEmWVq9S28A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX9YpKFD1SA8Au
 obQLFoDYCOSUIM4a4Qep3/J3+OHzyRosT8TscuBAFe37etjpPIM4ieo+xQlOt+VvnzTxzyIqQx5
 K9eccaBwVO+j3TyZxK4AliW72lLOIYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX6C6q3/y29XcS
 cufZlgokQbw1jid1HVKkztls79FLjAhYQp/aXVO838yuM7nloQ27pPnG9oXmYvO3pdmZZu8gesH
 nrCqay1/NS3zHwC5CHizpI7qK4hrFENFmpuSAwOGC6V12O/gEvFwbv2H9fkvcVs0PBdaKzQ1+Eh
 eIoSv0hmLtlqIQ/aO3uO4AaWvpqIk7eQhk7ARv6WAQtRmfJQi0MF3v1Ks7WL3F3A5c57QXQyjeh
 5VYfmLmdavgn50vXOZrRg/JjSoXDkt2GF+nUYShznapGTX2GhWNzIOChINBIu7dBuegEhd1KOzB
 unxYt8khCt3qdl5ug4CAPYOLTyv7Yl3MUOJJetx0PK1fgqV9qVuulmhdUH4xEPJGgIziX3VZx23
 tqUf6DhVL6PS/yCewiWYwU05FAgPBe7ZS2hSaZtZwy14sSOYRgiehLcXsvkXPLwbCfx77WuWeWu
 xcFHWSDNB5Od+dC8y4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The various dump helpers return one and zero. Every caller just does a
> boolean test. Convert them to return an actual bool.
>
> While at it, drop the externs.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c            | 63 ++++++++++++++++++++++++------------------------
>   include/linux/coredump.h | 14 +++++------
>   2 files changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index cd36a72be445..d837819031ff 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1215,41 +1215,41 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>    * do on a core-file: use only these functions to write out all the
>    * necessary info.
>    */
> -static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
> +static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>   {
>   	struct file *file = cprm->file;
>   	loff_t pos = file->f_pos;
>   	ssize_t n;
>   
>   	if (cprm->written + nr > cprm->limit)
> -		return 0;
> +		return false;
>   	if (dump_interrupted())
> -		return 0;
> +		return false;
>   	n = __kernel_write(file, addr, nr, &pos);
>   	if (n != nr)
> -		return 0;
> +		return false;
>   	file->f_pos = pos;
>   	cprm->written += n;
>   	cprm->pos += n;
>   
> -	return 1;
> +	return true;
>   }
>   
> -static int __dump_skip(struct coredump_params *cprm, size_t nr)
> +static bool __dump_skip(struct coredump_params *cprm, size_t nr)
>   {
>   	static char zeroes[PAGE_SIZE];
>   	struct file *file = cprm->file;
>   
>   	if (file->f_mode & FMODE_LSEEK) {
>   		if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
> -			return 0;
> +			return false;
>   		cprm->pos += nr;
> -		return 1;
> +		return true;
>   	}
>   
>   	while (nr > PAGE_SIZE) {
>   		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> -			return 0;
> +			return false;
>   		nr -= PAGE_SIZE;
>   	}
>   
> @@ -1257,20 +1257,20 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>   }
>   
>   /* Flush the accumulated hole before writing data. */
> -static int dump_flush_skip(struct coredump_params *cprm)
> +static bool dump_flush_skip(struct coredump_params *cprm)
>   {
>   	if (cprm->to_skip) {
>   		if (!__dump_skip(cprm, cprm->to_skip))
> -			return 0;
> +			return false;
>   		cprm->to_skip = 0;
>   	}
> -	return 1;
> +	return true;
>   }
>   
> -int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
> +bool dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>   {
>   	if (!dump_flush_skip(cprm))
> -		return 0;
> +		return false;
>   	return __dump_emit(cprm, addr, nr);
>   }
>   EXPORT_SYMBOL(dump_emit);
> @@ -1290,7 +1290,7 @@ void dump_skip(struct coredump_params *cprm, size_t nr)
>   EXPORT_SYMBOL(dump_skip);
>   
>   #ifdef CONFIG_ELF_CORE
> -static int dump_emit_page(struct coredump_params *cprm, struct page *page)
> +static bool dump_emit_page(struct coredump_params *cprm, struct page *page)
>   {
>   	struct bio_vec bvec;
>   	struct iov_iter iter;
> @@ -1299,25 +1299,25 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
>   	ssize_t n;
>   
>   	if (!page)
> -		return 0;
> +		return false;
>   
>   	if (!dump_flush_skip(cprm))
> -		return 0;
> +		return false;
>   	if (cprm->written + PAGE_SIZE > cprm->limit)
> -		return 0;
> +		return false;
>   	if (dump_interrupted())
> -		return 0;
> +		return false;
>   	pos = file->f_pos;
>   	bvec_set_page(&bvec, page, PAGE_SIZE, 0);
>   	iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, PAGE_SIZE);
>   	n = __kernel_write_iter(cprm->file, &iter, &pos);
>   	if (n != PAGE_SIZE)
> -		return 0;
> +		return false;
>   	file->f_pos = pos;
>   	cprm->written += PAGE_SIZE;
>   	cprm->pos += PAGE_SIZE;
>   
> -	return 1;
> +	return true;
>   }
>   
>   /*
> @@ -1349,18 +1349,19 @@ static inline struct page *dump_page_copy(struct page *src, struct page *dst)
>   }
>   #endif
>   
> -int dump_user_range(struct coredump_params *cprm, unsigned long start,
> -		    unsigned long len)
> +bool dump_user_range(struct coredump_params *cprm, unsigned long start,
> +		     unsigned long len)
>   {
>   	unsigned long addr;
>   	struct page *dump_page;
> -	int locked, ret;
> +	int locked;
> +	bool ret;
>   
>   	dump_page = dump_page_alloc();
>   	if (!dump_page)
> -		return 0;
> +		return false;
>   
> -	ret = 0;
> +	ret = false;
>   	locked = 0;
>   	for (addr = start; addr < start + len; addr += PAGE_SIZE) {
>   		struct page *page;
> @@ -1384,7 +1385,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>   				mmap_read_unlock(current->mm);
>   				locked = 0;
>   			}
> -			int stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
> +			bool stop = !dump_emit_page(cprm, dump_page_copy(page, dump_page));
>   			put_page(page);
>   			if (stop)
>   				goto out;
> @@ -1403,7 +1404,7 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>   		}
>   		cond_resched();
>   	}
> -	ret = 1;
> +	ret = true;
>   out:
>   	if (locked)
>   		mmap_read_unlock(current->mm);
> @@ -1413,14 +1414,14 @@ int dump_user_range(struct coredump_params *cprm, unsigned long start,
>   }
>   #endif
>   
> -int dump_align(struct coredump_params *cprm, int align)
> +bool dump_align(struct coredump_params *cprm, int align)
>   {
>   	unsigned mod = (cprm->pos + cprm->to_skip) & (align - 1);
>   	if (align & (align - 1))
> -		return 0;
> +		return false;
>   	if (mod)
>   		cprm->to_skip += align - mod;
> -	return 1;
> +	return true;
>   }
>   EXPORT_SYMBOL(dump_align);
>   
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index dc7a05b1bb0a..943bddfb22bf 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -43,13 +43,13 @@ extern unsigned int core_file_note_size_limit;
>    * These are the only things you should do on a core-file: use only these
>    * functions to write out all the necessary info.
>    */
> -extern void dump_skip_to(struct coredump_params *cprm, unsigned long to);
> -extern void dump_skip(struct coredump_params *cprm, size_t nr);
> -extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
> -extern int dump_align(struct coredump_params *cprm, int align);
> -int dump_user_range(struct coredump_params *cprm, unsigned long start,
> -		    unsigned long len);
> -extern void vfs_coredump(const kernel_siginfo_t *siginfo);
> +void dump_skip_to(struct coredump_params *cprm, unsigned long to);
> +void dump_skip(struct coredump_params *cprm, size_t nr);
> +bool dump_emit(struct coredump_params *cprm, const void *addr, int nr);
> +bool dump_align(struct coredump_params *cprm, int align);
> +bool dump_user_range(struct coredump_params *cprm, unsigned long start,
> +		     unsigned long len);
> +void vfs_coredump(const kernel_siginfo_t *siginfo);
>   
>   /*
>    * Logging for the coredump code, ratelimited.
>
-- 
Thanks and Regards
R.Nageswara Sastry


