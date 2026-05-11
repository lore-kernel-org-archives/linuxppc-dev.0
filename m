Return-Path: <linuxppc-dev+bounces-20715-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81464CD37BE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 14:22:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDhl010z4z2xlh;
	Tue, 12 May 2026 00:22:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778509356;
	cv=none; b=Anqmwcb53pmnGDgA4XnrfOx+zXBZuvz/F1UYeJs0eV9AucWrDqb9jsM1fy4jTQB6MdeAaXDUOMt+CngHGknH3YBkzryVxqadFY9RkGPp1mNDUa6Kx+Wanaup4OScI9SoLtJXMwwi36rCNEqAIaccWFzeTvIN76f4VmzmeKaPFVCTbmn5MRkc9onwXFkw7d277X3Frh/7vK/DIl4LQ72qVICFRod6fbFPyIBm5th+/dtq46BjuH7QbN3sFZo+zPvY3GB8LT9LXSzFN9fp7ZD1b7WywERN+e4r4OY5jXFje1xKTGLraU6BydXx3ULmcrjifK7zpAGs9jS2BHXuSXorfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778509356; c=relaxed/relaxed;
	bh=EBr6Fvx4EhFl+fiKVDbOrGkrFPYrVTn8Rw8J0IyiXD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxbczWeSaA6WYa5CAq4yBM7umh7Q+R7sN01h6bY46LMxcYwdR20nL3sJPEV/ucVRNF2dAnV7mop2p+jVuWr71dYpvHiq6YDAvnfCneeQRiyKfYOSspDQrTM0OLZ9eFqV9R/bjY+rq9dhwItjIqNznKevPzNlDnnvCXDash8mvEULAu+1y7xVFK7FIWgbMY4GjbyyVBPR+LXSwuYM6lXmDq0HiCwIsZWqPfRWXbiNTpQnBVJda9I9h0ZfoOKLNa9MWxcTDLUK7OyIF23HvjTflcb3JaupWQAfHowdYvnfaXWnyV26j4HVxkO7QImu9Wltmz/MM58+aDadUQi5gNppyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PZ7AFLYQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PZ7AFLYQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDhky6RC8z2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 00:22:34 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BA7tVh2635669;
	Mon, 11 May 2026 14:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EBr6Fvx4EhFl+fiKVDbOrGkrFPYrVT
	n8Rw8J0IyiXD4=; b=PZ7AFLYQWQh0DARv50iTmhHp5zS/Ejizy+ypwzeFIZouS+
	B35jEKPkz+I44ugqqDSrk8uynJ7EHmDfCwwk1qyUL168wMn90+7Jy5+au6gRMXUO
	sohcL6fxqf+EZVCwwBOvb+sWp7MXoR+Tmhu6yI7HRbKbUXd0OiJl+h6cVw0fcv5g
	kwq9vh8vJEUQE30DRbwn4toirDsVN+vRKyC0JGmbMgcWv6pJuPYzeNVul71s8p3I
	LVZxytsy51FnmX0GF48ZqK1TplFzATu/pDeLDl+oy4MskbU6Ndernf421G9yVjeO
	GEqUMuWEB/2Cg9oKDU0VrIyx80tksyXLv8iyOVhQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4rnt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:22:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BE9MBW024960;
	Mon, 11 May 2026 14:22:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2f8q5rb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 14:22:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BEM0RU56885546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 14:22:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21C8320043;
	Mon, 11 May 2026 14:22:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF7420040;
	Mon, 11 May 2026 14:21:58 +0000 (GMT)
Received: from osiris (unknown [9.111.59.149])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 14:21:58 +0000 (GMT)
Date: Mon, 11 May 2026 16:21:57 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in
 vmem_free_pages()
Message-ID: <20260511142157.9589E90-hca@linux.ibm.com>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01e60d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=boL7ADR7qhV1eUdEaRQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NiBTYWx0ZWRfX9eMnKqaesw6+
 dWs2XKM2Coq1K2t6vtXUjCW/Ls+NZ6Ocg3gIMXDYbWqvM6Y0/kNGHNfKyKSDy/e3V4I52+nyQQi
 T3hsKpBs0j02l46KbBJkcPht0W/0kHwHvm4nqdzNNiCiM5wHjaB84yj9A2qQZyKXC2oxOvSlswb
 wSoxhLpnddu+8ySgcU2uuvafRjZowWq84v9GgZQdQ0Es9DC4wReHZ/1ONwt0vlnq3MHc1YWEKrm
 5ao/IHMrjvsa9qqgcduF5p7V0yZqz3m6sLsOm4Avt688GEJB+mepfPl6WURzMeIkxi0WMs+IRa+
 PoqPydwHWthihJUCXymL3VfYwixUhRzXJrrFraRWYVTmgFokNaqu3am6bSfwEB/qC3GP/Jjdnz7
 JPN7qTOE+na8g2XkmlyZr6FYNBN9/lA3gSZ/YrLsrDG2hmEeOI0xukvAfJ+SlzbPzcNbqa0PIua
 kpfzIVDuYDfFYEnQKVA==
X-Proofpoint-GUID: yUQzDOeY4Z3eWv4ViXPYc2-41M_eHNnR
X-Proofpoint-ORIG-GUID: HMCowyjGDOqPNKrRS-Lt9uxif4ohm-SX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110156

On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
> We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
> free_bootmem_page() nowadays always translates to free_reserved_page().
> 
> Let's use free_reserved_page() to replace the free_bootmem_page() loop.
> We can stop including bootmem_info.h.
> 
> Likely, vmemmap freeing code could be factored out into the core in the
> future.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/s390/mm/vmem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index eeadff45e0e1..d8b2a60e0c33 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <linux/memory_hotplug.h>
> -#include <linux/bootmem_info.h>
>  #include <linux/cpufeature.h>
>  #include <linux/memblock.h>
>  #include <linux/pfn.h>
> @@ -51,7 +50,7 @@ static void vmem_free_pages(unsigned long addr, int order, struct vmem_altmap *a
>  	if (PageReserved(page)) {
>  		/* allocated from memblock */
>  		while (nr_pages--)
> -			free_bootmem_page(page++);
> +			free_reserved_page(page++);

What about the implicit call of kmemleak_free_part_phys() which gets
removed with this?

