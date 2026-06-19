Return-Path: <linuxppc-dev+bounces-22777-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC4FCD98E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 04:11:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghPKl4dV2z3bpP;
	Fri, 19 Jun 2026 14:11:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781842283;
	cv=none; b=QZjxg/gdvwJEldkkQ8uBE3IeY46uwsaADCmS9EChd0dyEhd/VV97RNLq5AgdbmzvpehsTgwQwIY5N2p3JYOcRh/iG1xExsG2WwHadKf80S2IHL79SwDj0pBBDHqmX5y3D9nDu6HhoybPi9ib5UUG7051j2NVebiTD3xF/JkpCT0euFWvYy9glQGyPqVyzU80bc4phvKV19oCmUMeH6/c3ZAknFBY9VDZC95c6ntVBj3hMuVFxM/aRlG0MUElRP7UmdUlCELtL2H/JbRl+RqxqHN1hB0FJgKTC29DD8hN9Qs6Ck9BiujtNQ3P+monLFmVJxRrvenLsqwXyZO8UdY2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781842283; c=relaxed/relaxed;
	bh=ns7uFMdN8XmD+BmGhPlCgcUtZIHgSZf+bEO3nXaURYw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=IUycehSwI2ED7snKDQdZtvP2eiYxIGJ9VfQ66yV7fy0w8ltaE+LbyDYVF+QdVLkVn5BBEQevaPQ2K2Ifx5XHahnOCIycUDJdST2+mL4KVdvkJ/Hytt1imJ8stsPPXxO5OltZwQFNf42txGJB0GTgbElSUIM9XkSTPGgH3mVVxoFO2PmeULyEpLeGzTnAsaJJfA7WTmBpDQZU4Kq9FeATJTbIMJUObiGbR2rLY15pvT5wRyRDG5Kdq9WDDMNuyDptckILYyg4BBZWP68vDV0wXc9h0ymQcW8clLX7a0wKsHieQx0LfkTnTD0oRDd7k3iwpUEyoen/9T4Jk4D6JOjemw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hTn0qCeL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hTn0qCeL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghPKk157pz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 14:11:21 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-842848fd613so1550021b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781842279; x=1782447079; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ns7uFMdN8XmD+BmGhPlCgcUtZIHgSZf+bEO3nXaURYw=;
        b=hTn0qCeLXJMEMnoZxpw0M/tdC8Nb/qSqQ1XMBDFCoozvrkgKhuuQwAgAXq9FM9M1wV
         HlT/SV88sKjqnsbNjcq12egt+MbB9s43wlzvqnHbtAt575qTZ9GODq1LR1LpepP74e5K
         MnQjd+XSg/zj3ipdU84GPBKnM3F+4w56uoBKUUcBQpB1Aq5yNQ1glU8E6UEPNLoz7F7Q
         HBqUJEr/E+b9vQEuQbjNgqcqQ3gHj4Vi5V1vZfCfeAH0Hrm3gjwm6qYCCzzsihXePj/b
         r9DNNhL3DYcVqyRp6q3+8H5tqeXw8AVtXJoreoTxWrRghChf5geJu4fDeVePnqTI9ciA
         XBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781842279; x=1782447079;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ns7uFMdN8XmD+BmGhPlCgcUtZIHgSZf+bEO3nXaURYw=;
        b=fGgyUNdzyWNgsNZX52xVCvJNGXIm6MY1bzQlUn5t74dRp53O/fCC3Llbulj8uyJBj8
         vDY3NNPf6CFIFwQ6AyI7Xmtlqj6EffNZle0FY7OMyQC4xJ1nd5J4p96r1VcKh1jkbyy1
         jTg7MLC0k/C5SRdNNNcOY+yJ4si6DsZGqK+I2dKJokP/Vv0t4zWwQdWFuDX26P2GFvF4
         FTkf0Hhg4XHouiIjZSqPJX4vEr1V14OkeUsd/iZdWpc99eWarF3mxLYXkXy1iMPUsfbT
         Xga2MTnzLRwj3RrtuYxCIoPItpTTu4ZCCoi9XJRLQyDOpYTUiqq1yXENq8H3ZtBNgFi2
         WOPQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1r5sCkN7hEsC5eLVXljNEh3SW+fYP4WL2rFYPbVVF9tIOt4taHec1yB69Nv0JLlM6TlhLzMvcpdZ2xjM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxb/E7ODPsFOF1FXLVnIxvjdUNi2kz8/qNmVj7phLXZYujoTbZH
	ygymMKZgqlIQb+fnOIYcVGRPCpEDB/ABFP6DPuyB6hom9WuH9GdIZgig
X-Gm-Gg: AfdE7clNvoksjcrI1azfN8kl22ClXFmjZUG1ibGHZOL3Qbv3glc6J1bQIO880gJV8Vs
	vtemys/icYi/0aJI1QiM6REE2G5WyjPQdO5+fJOtZ7viv6xzboZz9dnjfHjqPXx9dVp6/AsVhJY
	OkQxV//3PB1UIY5bxysAfmh7wGUaXQaakHOOJjlNSdwigY6DI5onGSvrPo8d65HK4aCOnwouPO2
	HQf4lqITOPTOuY1pTySrCFg6GvsJLAE8zSxBMuZg19QvlcA9sBxLOpoWJDsSnuqg9XXHwORn2Er
	y2RSseKqrJrwmz5UpZWXOZh45x3VQAOouJIg8X2cXNTbyhXl0myi7BQzLpgmMTXEE6UBU15lNAp
	qp1TXufc5ZpHqskqib+XzZnwG92wz8+KGE6fC+QDVc1y8Zqnpypt4pz8Xl0HmZxrZ1xIyh+kQa9
	jwQDdg+hGzgEq036w=
X-Received: by 2002:a05:6a00:14d3:b0:835:4291:6975 with SMTP id d2e1a72fcca58-845508cce6amr2119845b3a.39.1781842279197;
        Thu, 18 Jun 2026 21:11:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8455382b766sm793864b3a.47.2026.06.18.21.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 21:11:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
In-Reply-To: <ajIUVSWaQbFoez5Y@KASONG-MC4>
Date: Fri, 19 Jun 2026 09:36:17 +0530
Message-ID: <5x3fdvie.ritesh.list@gmail.com>
References: <cover.1781287297.git.ritesh.list@gmail.com> <1e8d7e4d0bb1377277ae8b6561d89fa0e048e7de.1781287297.git.ritesh.list@gmail.com> <ajIUVSWaQbFoez5Y@KASONG-MC4>
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

Kairui Song <ryncsn@gmail.com> writes:

> On Fri, Jun 12, 2026 at 11:39:15PM +0800, Ritesh Harjani (IBM) wrote:
>> On PowerPC Book3S64, MMU is selected at runtime, so macros like
>> PMD_SHIFT are effectively runtime variables in the Book3S64 code. THP
>> swap code uses these macros to size some of its array data structures
>> based on PMD_ORDER e.g. SWAPFILE_CLUSTER macro is used for this very
>> purpose.
>> Hence this patch initializes SWAPFILE_CLUSTER at runtime and also
>> modifies swap_table and swap_memcg_table which were earlier using this
>> macro for defining the number of table entries.
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  mm/swap.h       |  5 +++--
>>  mm/swap_table.h |  6 ++----
>>  mm/swapfile.c   | 27 ++++++++++++++++++++++-----
>>  3 files changed, 27 insertions(+), 11 deletions(-)
>
> Hi Ritesh,
>
> Thanks for the patch.
>

Thanks Kairui for taking a look at this. Sorry about the delayed
response, (was on travel to #OSSMumbai).

>> 
>> diff --git a/mm/swap.h b/mm/swap.h
>> index 77d2d14eda42..956879a69ddd 100644
>> --- a/mm/swap.h
>> +++ b/mm/swap.h
>> @@ -26,11 +26,12 @@ extern int page_cluster;
>>  #define SWAP_TABLE_HAS_ZEROFLAG		((BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - \
>>  					  SWAP_CACHE_PFN_BITS) > SWAP_COUNT_MIN_BITS)
>> 
>> +extern unsigned int swap_slots_in_cluster __read_mostly;
>
> Maybe __ro_after_init is better for this kind of use case?
>

yup. I can change that.

>> +#define SWAPFILE_CLUSTER	swap_slots_in_cluster
>> +
>>  #ifdef CONFIG_THP_SWAP
>> -#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
>
> So on Book3S64, HPAGE_PMD_NR is also a variable right? Then we don't really
> need to change the SWAPFILE_CLUSTER defination here? We just need to adjust
> the users of this macro so the build will pass?
>

Right. Earlier I was playing with different values of this via an
arch_xxx variant. But for book3s64 usecase, the default values are fine.

So, I agree, we need not change SWAPFILE_CLUSTER here. I can update the
patch with the suggested changes in v4. 


-ritesh

