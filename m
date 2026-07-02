Return-Path: <linuxppc-dev+bounces-23409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446FC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:37:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grfcd0Fxtz2ygm;
	Fri, 03 Jul 2026 00:37:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783003072;
	cv=none; b=leU2TmEpJmz9AD8tGJfmY/eGtufxnDj7JjkZuliXMWzw5ovthieGxEVxEuYGg18EOyMGNxM9bjztnp6ftUD5Qv9OT6w6Cr8MqY+DwNgiOPkxKvYBy2wqpM30z9FS/rMACFTmrV+cXeoAoxSC4ao9qKunP9Yoq8iD8Z0vI60JXnUpn3Ike+WJnlrnQiGCydKa3kMq/0EUbdxBLeGVvCVpSN323GZ7TohJA3kjtI0BDAsj5H5snRT/D6cpZdXvuugsMzrgvz0KDJBbsX/8pEq0AiYthSitJztUTdSocqzZn0U0r8ppzjO9iuMXvCKldh6wXqVNVn+nNdtS8SCWFWWzGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783003072; c=relaxed/relaxed;
	bh=lXnswjIaiRYG8U7BeW3Gzzri+uQJOKwM0h35YoRqO54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfwgIoQdr/pBupz5fkrdMWq5dqfY+aBOgn1wD61x9T6RIV/9+HSzEqIaVt7tNkW4yRcxR3ANj6bKQ1XmzwegIH971hByM+xi2xMXTtVnvU/QY3XftnzB9Mqut73niVOlBhHnNmDBO/K4gmN6ZmhKMEu79efzbM1bYqHZM38dukuWRHNKB0KfkCtBdpP2445Bcm8q0dYL0TnHVH6Eyjiy1NSgUy75IQGfyKpDPgsbcb1j2oBhpG3tfl3vjFr1aXgKZ2xCTSxV5yYYoqW2OCI4lOYgx2V68Li39YQCMTljoDlrFjxm/LcXR8SUz+cPuueUL60nYq3YQ56eAtwjfd3sTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BFbnC2nj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSh9WbE/; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ashok.raj@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BFbnC2nj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dSh9WbE/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ashok.raj@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grfcb6GFlz2yf5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:37:50 +1000 (AEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3Lur623004
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2026 14:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lXnswjIaiRYG8U7BeW3Gzzri
	+uQJOKwM0h35YoRqO54=; b=BFbnC2njgqijwErQAd6LOWtD7DJdESvTqDco7q7L
	NVtO0qt4eADNZ88+GI4ahZ7xjh33sr0Yy++xiIxnOAEosGQ6XazwuZYtKt1pRaMe
	Ha+V9mEDi5g18rnwovrPTZaE/CixaA60QulvSqvUqThhlfU0n37PvQ/D9kONd7qo
	WXXvryy1jDdSZ5di0cpe51/Q2bM2e0GMkfPQZpTwfZitgK0CciKJB9Wc71W9txuR
	sFiTX83w11RWWvNBa4Qll9h434UwphbRAH58Zq/IIS9y2Sq0kx3aziSA3abSM8so
	RN6e5BjYfN4Kt29iGXFa+OazycIHO/iyBKWktYjztd5N+g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s25081v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 14:37:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c892143db7fso1420997a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783003066; x=1783607866; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXnswjIaiRYG8U7BeW3Gzzri+uQJOKwM0h35YoRqO54=;
        b=dSh9WbE/G+aRovoBgt7wr3JHARrV4NuX7js2o4yz9/kgdiizp1eb7DuuFECsMCMMtb
         ltqBSCLk+mT9WktcPO4Q+01VnPoZ/XCSBAamZxOpeRC3jDKYEu7+/UGE7y933/MoxVmi
         fnSQwB0OgMd6vOG4Lh8CAxj0CI+IK9s2OBQakPTwvoXYs8F/3GXdNXIyCO1+o19FIapn
         2fKC6R1jS50BUgot2unrTVkx3WNKrm50O/+ajH+7q4gyDV53PjR+FZlNURFylS023L4M
         LBf5h2dsnYwBzdKCZERLgWKy/pFB2TYBsBk1oNDF5BoNaGaL3Gy44UahL98SeBBXMd8C
         Oyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783003066; x=1783607866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXnswjIaiRYG8U7BeW3Gzzri+uQJOKwM0h35YoRqO54=;
        b=ZE0Z9/fxt/A0zHIhywmEhEZbaTaUR03IyXj9GU6aE2hvoWPFVNa9Q882SCmIXnbhJJ
         FaiLfY60Lnm+/1NC2rUoj/vc9ph9b3ZTlSgO0KDiJOYQ9vDKLcsfnxdRIwVjbWIoAkj1
         xvNfJJybhoNXCwpZUwT7iOFlrMnP5XJ+L460Mwkf0ptkcGAVf7yhVtf80NzZzKFNunC2
         +MvodD/rZiqz2/jHhciSZcaCpb+KRuWMeaZJVLp1Vur/66iCFUGmyIpM3yWCMUuq6BZw
         ZxslHTDVlquS9HwD3esYJNCr/m7ICMksmtIYNHQV3c7fjpGppIvLqWnLej7SxEDvRkV0
         58xA==
X-Forwarded-Encrypted: i=1; AFNElJ9mC03lPnNJ7n8vKJ8rIbXxb8j6CgvVNSQkioz23NtB2e/Afa/j/qf4NQgz9yQLPnoCvBkehnWjFYsaBQM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx/TBvdqmvP3D1cLuUydQD0hLaZ6lSRlesBxYzz5SGlacMd5wfg
	gX65CQo3xIOJZ0bCHj22RwO5LlOt2iG9jq2dTwCsbXIlNLSz7rME0IB5PI2pHW8t3P8RVrCHL4v
	wna8+qkVBJSJPXlfvYa4fpNnYpeJMNDab/QW/PzTd4vAZuK1tECAXqvUCW1N/u9AxxYUL
X-Gm-Gg: AfdE7cnFRLLC+8VSpIksIsjuyPFrs7TglDAGQ2d9TE9QlhjnNf3CyftcgNh9uxYRENs
	mkk/7zAL250OVNz/yUHs9MgJhBMbnxFF3+LvRv8MopWpWTuWKHSDzkmRxFXJ2NUzeQSm3B+o6JW
	ern42kKv3AP3s2WdvHxTe5yw7Nw0V3VKkJm54F/Ug7/wXpelAhbC/Xw2eqKJuEFKoErUuGcKi+d
	/COX9WO7B3elUq4Gn96nB7bnP2sGS/m9m4NNOlPGnJtUiyFI8dqiSZRQeyLuWC7EfOltIJ2imS6
	7/3IqlRd1bTqpFkOy6YmncT4Py9psDkB94pGp2u/q9Q2u/AjCTayK388puvOOxgFjoHaq+O2ysZ
	XhJrf/bl5mhRmw2+/dBGdr1T5IFOqBjNII9qyuPCfdl8Sp3kLJqPjoHkaJpxW
X-Received: by 2002:a05:6a21:7d06:b0:3bf:3306:acdb with SMTP id adf61e73a8af0-3bff40be1b7mr6903925637.13.1783003066342;
        Thu, 02 Jul 2026 07:37:46 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d06:b0:3bf:3306:acdb with SMTP id adf61e73a8af0-3bff40be1b7mr6903890637.13.1783003065851;
        Thu, 02 Jul 2026 07:37:45 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b446a766asm1312275c88.7.2026.07.02.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:37:45 -0700 (PDT)
Date: Thu, 2 Jul 2026 07:37:43 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, guohanjun@huawei.com, mchehab@kernel.org,
        xueshuai@linux.alibaba.com, tongtiangen@huawei.com,
        james.morse@arm.com, robin.murphy@arm.com, andreyknvl@gmail.com,
        dvyukov@google.com, vincenzo.frascino@arm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, ryabinin.a.a@gmail.com, glider@google.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
        naveen.n.rao@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ashok Raj <ashok.raj@oss.qualcomm.com>
Subject: Re: [PATCH v15 5/9] mm/hwpoison: return -EFAULT when copy fail in
 copy_mc_[user]_highpage()
Message-ID: <akZ3t68so_q68OHx@hu-ashoraj-lv.qualcomm.com>
References: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
 <20260618092124.3901230-6-tianruidong@linux.alibaba.com>
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
In-Reply-To: <20260618092124.3901230-6-tianruidong@linux.alibaba.com>
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a4677bb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=RAEmS9DAgrXSH_0abccA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: dwMZ_cPafOiFQ8ShZRqttsr9Z6lMPADs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1MyBTYWx0ZWRfX1Et4EdUTifVM
 py1lrBN+rAkxodIw74UUxBw6MGS0C6IvI0v7WhZAwSc4i3zfbSEmesAx0TvGed5gBgnw2h96kSm
 L1KVGzR+omMTXA8/beoRoEvFqAjhsW2oNbcj6IgSuI1npyicEg8Z3L5e/GL3eSjepqt4KfkvFl/
 HJvuGz8xuXVmEqzjp+HgAUeZI3gQKESmtxcMlCNMyQ9/Wlt20E7ajHO2JV135Fr9wXWE0NpcJBu
 U74b8QMGmn/sVfot/IA31TH7PXnetR1MAIFrTTXfVurawcAZ98K0IN+DkaGzNTZTWEkGrMm4ebS
 iWe/l6B+6w7KrytVGrqTYKb5Z0PUzxA55LYHwxHikrwg9qHCYY30ZtIfDdIeuk3zr9jVyEyRVmC
 eHBGyq6BNpGWkPz8KX0DPOkm4GN+okza0+C1OBkrHT+6R6x2Ud+/0wE8c6TC5hNL32O4VAo46oE
 omgKl0lQF1p+eX20EoQ==
X-Proofpoint-GUID: dwMZ_cPafOiFQ8ShZRqttsr9Z6lMPADs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1MyBTYWx0ZWRfX7KclGvhMhIua
 gThYhurhFwB5bDfFgGZQKe2iHpPzE9Ds7ZeNiseV9BkUMVb0E4tyKPFGt9+N5y56fY76hiH2Whw
 fOmvmTDi/Jln3KOXLZnZh5J3fEWyo3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020153

On Thu, Jun 18, 2026 at 05:21:19PM +0800, Ruidong Tian wrote:
> From: Tong Tiangen <tongtiangen@huawei.com>
> 
> Currently, copy_mc_[user]_highpage() returns zero on success, or in case
> of failures, the number of bytes that weren't copied.
> 
> While tracking the number of not copied works fine for x86 and PPC, There
> are some difficulties in doing the same thing on ARM64 because there is no
> available caller-saved register in copy_page()(lib/copy_page.S) to save
> "bytes not copied", and the following copy_mc_page() will also encounter
> the same problem.
> 
> Consider the caller of copy_mc_[user]_highpage() cannot do any processing
> on the remaining data(The page has hardware errors), they only check if
> copy was succeeded or not, make the interface more generic by using an
> error code when copy fails (-EFAULT) or return zero on success.

Agreed on the rationale -- none of the callers can act on partial byte
count, so a plain success/-EFAULT is better contract.

> 
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  include/linux/highmem.h | 8 ++++----
>  mm/khugepaged.c         | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index af03db851a1d..18dc4aca4aa1 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -427,8 +427,8 @@ static inline void copy_highpage(struct page *to, struct page *from)
>  /*
>   * If architecture supports machine check exception handling, define the
>   * #MC versions of copy_user_highpage and copy_highpage. They copy a memory
> - * page with #MC in source page (@from) handled, and return the number
> - * of bytes not copied if there was a #MC, otherwise 0 for success.
> + * page with #MC in source page (@from) handled, and return -EFAULT if there
> + * was a #MC, otherwise 0 for success.
>   */
>  static inline int copy_mc_user_highpage(struct page *to, struct page *from,
>  					unsigned long vaddr, struct vm_area_struct *vma)
> @@ -447,7 +447,7 @@ static inline int copy_mc_user_highpage(struct page *to, struct page *from,
>  	if (ret)
>  		memory_failure_queue(page_to_pfn(from), 0);
>  
> -	return ret;
> +	return ret ? -EFAULT : 0;
>  }
>  
>  static inline int copy_mc_highpage(struct page *to, struct page *from)
> @@ -466,7 +466,7 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
>  	if (ret)
>  		memory_failure_queue(page_to_pfn(from), 0);
>  
> -	return ret;
> +	return ret ? -EFAULT : 0;
>  }

the critical part of this change is the semantic flip: the return value
goes from a count >= 0 to one that is < 0 on error. 

You have correctly converted the two call sites in khugepaged.c, but
confirm if a tree wide audit has been done.


with the caller audit confirmed

Reviewed-by: Ashok Raj <ashok.raj@oss.qualcomm.com>

