Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B4606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gTyrKRnm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGBTZ18WDz30RN;
	Fri, 30 Oct 2026 17:46:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793342802;
	cv=none; b=PKM2rbGFzaGr6ON4QWBB1Q8vEusoQF7+zj4CRvFaTVhVnYeQA/MWcufo69ETjWOh0+PoEP2AABuRdrd5TLDlHdI6jAbJSGen/3I+djglcwrxsg3J0Wczl5vP/6s+o3JLPY+NnmYdRtOSjU7bD28ZarINI1mGP+gcWbQL8XTHD9Fkfj9ownq8k/w77DNpgOW5xxSIN+Fs0T5SV+Iinb8MR4nx8sRuYgYJrRKutRkeju8sw3vnjVDg45sVsT/J9Az5twLlPJIuEBV+FJqpWj8eNUpn6Ru+VvhUfoW1cLMsSA4kFwgTHuFt8YUkGxeaeu9cTTnygazSdFmKUPuFpm7Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793342802; c=relaxed/relaxed;
	bh=Id8QGQONeVdgPpx5xV+Lr+vBDN9+KhzWpQXCGhMj0Vs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EQd8vqueauCfD+I7NDnluvBNz9wpZRIy/1xy5ckEs+NCbuO4Te7tRZAKQohiyEXRFEA3MDjc7dI/KrSQeXumEjXY8KypONGUGyL3LAU+MolidJamYGd+55ZB0LrZkUNHagl5uEfmkjpcUzKyZY372nxPcA+3+DwqTBTG5YRxZkJ/ZLgvCebWO93fyY0LzkYd4+ExRU17hZULT2Ue7lSN17q9GI5Ft1MWuSPTovtrIA5uRrErv1X/zuxWETNEHgTkWRdJ39/4CwLRJNDX5KsBZpM5oUtrQe2A5Liqm2AoXB7rLqGQo33pDgUSu6nCTbceWzwozL+DkcIxuZ/WjcGV4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gTyrKRnm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gTyrKRnm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=pavrampu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGBTY1fqrz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 17:46:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U5EOhF865528;
	Fri, 30 Oct 2026 06:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Id8QGQ
	ONeVdgPpx5xV+Lr+vBDN9+KhzWpQXCGhMj0Vs=; b=gTyrKRnmpTiLND7XEfHqOo
	TyTRYgZkDeKdKW7lXz7o/p0qDHu5pM67VvggXUAAJrj2abE/yxHM2++l5jqR5Zjo
	jYI9wt4g6YUBQDKPUJXbFSiJD/bYnIhjoSS42d5t2tPiKsFYgfhqQLgTmimUgQ/M
	admhuQY6/I1iH1ak1paNmhbrMyuVl2PPS49K257r+3dMnHs3ques1xCS+x/3SAxV
	NYMcdVhjRjqQ+WQBnkTG5TWXATqyUoHizXTnvct4Kl5JiAVhCSMXnZKJAbt+w3qa
	R0ZEsjrCvP7MUTD6vd/GRU8BoYu74nr1TJVmzJPCfMhiR+dcUFi4eA8oU6+HhDyA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeaysea6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 06:46:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69U5YuEt070120;
	Fri, 30 Oct 2026 06:46:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pja9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 06:46:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69U6kPfY64881096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Oct 2026 06:46:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB2058059;
	Fri, 30 Oct 2026 06:46:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A48658066;
	Fri, 30 Oct 2026 06:46:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Oct 2026 06:46:24 +0000 (GMT)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 12:16:23 +0530
From: pavrampu <pavrampu@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote
 <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@kernel.org>,
        Muchun
 Song <muchun.song@linux.dev>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCHv2] mm/huge_memory: set the mmu_gather page size in
 zap_huge_pud()
In-Reply-To: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
References: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com>
Message-ID: <7628b0e9814084298ae09abad0b5ac6f@linux.ibm.com>
X-Sender: pavrampu@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: gGY-rwakIoXDooIUogKTtF0LgTnN6YSW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyNiBTYWx0ZWRfX+v3beX+bO7UL
 mShVCHmwjlOQIjARv+1JbU3Q8Y1xvq0pMQT05BUwMWkXdzdlJKXsCY/AOhpKmPFObyv0M6c1ses
 0oVfTAzc2+iz0u++74zLyDwkr2SKLb7D7MaTQtbXsgbGeDCJ5/7CfbacZu3gn+JUNfWddwTP4fg
 PMw5VXqfuBg8NZJB/7xq5CTSz+oTUY4jP3o5UCiCoZVSX6NIc/efmWWApyMV0zRSK9dN/553MXE
 9vsHKG9ukEeV37Byi6GpmQgzxy3Ta7PZCYokQlkbUomoPKeVwc4pLl+48Ya5usoqvVdj4g40s0w
 mhuxmBo1fnwqD5Sz3oXUT9F90sFd5xGMmznYwWrX0X1dRNSKFhq5A6JZouiBqUSGFiiutFb2oLH
 ljWjOZjti+EkPQqITh2hmqnTBWK7hXcPLD4aJEdUsKayn5IHYg85CCxpq7PvHiJZ6effWCo0xmz
 tGz2bimsFA+/vBpsv7w==
X-Authority-Analysis: v=2.4 cv=Ms3HeGae c=1 sm=1 tr=0 ts=6ae43d43 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=968KyxNXAAAA:8 a=VnNF1IyMAAAA:8 a=T-xRWpmrxNWT4oxTfLkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyNiBTYWx0ZWRfXxTRjLDtP7dbK
 BzDxsU5s4ReIcrhMajyytxMyJd4MMBJUQfrS2urnaeXd4zDxCZ6BDzFTcjsaLlwUpP16WtN05iw
 HG5FsK3w2dhcX4LOwYLqoDC5endnV/Q=
X-Proofpoint-ORIG-GUID: nuh1h1ZEP6xnxA7x_sHTi-kj9tjJC_4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300026
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-30 05:37, Ritesh Harjani (IBM) wrote:
> Unmapping a device-dax mapping with 1G alignment on powerpc radix 
> kernel
> built with CONFIG_DEBUG_VM triggers this warning on every munmap:
> 
>     WARNING: mm/mmu_gather.c:176 at 
> __tlb_remove_folio_pages_size+0x38/0x230
>     NIP [c00000000063d508] __tlb_remove_folio_pages_size+0x38/0x230
>     LR [c0000000006fb688] zap_huge_pud+0x1b8/0x2d0
>     Call Trace:
>      zap_huge_pud+0x170/0x2d0 (unreliable)
>      __zap_vma_range+0x1604/0x1e20
>      unmap_vmas+0xa0/0x1f0
>      unmap_region+0xb0/0x130
>      vms_complete_munmap_vmas+0x120/0x310
>      do_vmi_align_munmap+0x1ec/0x240
>      __vm_munmap+0x148/0x220
>      sys_munmap+0x28/0x40
> 
> To trigger this - it is enough to mmap() /dev/dax0.0, touch the first
> byte so that the whole 1G is mapped by a single PUD and then munmap()
> it.
> 
> PowerPC needs MMU_GATHER_PAGE_SIZE in which mmu_gather needs to record
> the page size for which tlb flush is needed. zap_huge_pmd(),
> zap_pte_range(), change_huge_pud() etc all do this already. However,
> since commit:
>   dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> 
> a device-dax PUD maps a real folio and zap_huge_pud() now hands it to
> tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE). At that point
> tlb->page_size is still whatever the previous user left behind, which 
> is
> 0 for the fresh gather set up by munmap() and so the check fires.
> 
> Fix this in the same way like how other similar paths do.
> 
> Fixes: dbe54153296d0 ("mm/huge_memory: add vmf_insert_folio_pud()")
> Reported-by: Pavithra <pavrampu@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> [v1]->v2:
> =========
> - Split the 2 part patch series. Patch-1 is now superseded by a 
> different patch
>   from Muchun which he already posted [2].
> - No difference in this patch from v1.
> 
> [v1]:
> https://lore.kernel.org/all/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com/
> [2]:
> https://lore.kernel.org/all/20261029063601.1961415-1-songmuchun@bytedance.com/
> 
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bd44d58e8684..7e589a2fb02d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3040,6 +3040,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct
> vm_area_struct *vma,
>  	spinlock_t *ptl;
>  	pud_t orig_pud;
> 
> +	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
> +
>  	ptl = __pud_trans_huge_lock(pud, vma);
>  	if (!ptl)
>  		return 0;
> --
> 2.39.5

Tested on Power10 (ppc64le), kernel v7.3

Tested-by: Pavithra Prakash <pavrampu@linux.ibm.com>

