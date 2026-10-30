Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF7606A31C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evM0GLG/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG24m4x3yz2yYK;
	Fri, 30 Oct 2026 11:28:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793320088;
	cv=none; b=jtCrRkBdb94zxkzDbyXytmPgq5/hhfFZxnuYI4O/KADTZpmmkQhCJR5phsYh3+FwJgSDxrdJFngviOVNe+Pvh4UPobRkEbKA9atAXmDbhMAX9mLP1zKbUGWIrsAKqTl7vw+5aghD9LI8Vz7wneqGk7/FlZmi/BnsYOUTYVXmS1w8zuKpqTH0m1A+u8rHW6Nmo1MWQGDjWq3qORXit5nXhZSqgTUHkiGzd3fAwi8urKOKe6GlsO/3tRMpDfQBudHQ5WpsKKSQ8vU/u9Z5wA4geJqYJCYLFs9qwnWlA9+qDZ7K7m+tekU1bPziTbexQbVBjJ9mWiPGVAQX+z1Zq0artg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793320088; c=relaxed/relaxed;
	bh=ux1Gd4wJ4i6CbO5kAuUr+fRClS71fFbOF44xw5i7O6M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OoX+4X0T8OS4HTeAb6TnxUo/YT//R0r+daQtJ6NALCzs813ep3UswFrXoWNUQJ/jtORA91Y4+k5iUTb1El5cEvV6JdADLLAOPUY2c2JxQWnOUdyRLmOLLyu83dk89APhAfUVTDc18/ZpejgbzyQvpezwKMR8kIML+IVqC4HrQF2C2XmMZIO4Kt6jM1vnYnDBJCq1XnDn+XmMUKZBTCW/ZskaNqFp0q0h6rapwrOYy+HZS0Aa1LPkKAiVqP0QEhgdwadk/+qo6hpp0Rz83FbgBX4GbmkwL60/Mcul0jI6xNmF5qnkWtOHz+XN5lrk5YaO9AEk9Ckxr0SR3t1RAPBWHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evM0GLG/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evM0GLG/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG24k1Rwyz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 11:28:05 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-369f3e9e431so126177eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320084; x=1793924884; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ux1Gd4wJ4i6CbO5kAuUr+fRClS71fFbOF44xw5i7O6M=;
        b=evM0GLG/O6ub8hTsiz9DM8xXlp3QqGMdTzSpHGUhHIJ44jBlQeUmgqMCXDZJRKKNqh
         lbcwou43KvLD3+iNazbusypA4cDfA/7IWdUiJV4QrTYiFON03cYeB+YD3WURkgt+rpWZ
         5I7itDmdVCIxza2mH5t9f4Hu9w40V9UqxblJZiQpzR7HxsQW6CgOPTvecuuwSCDn6vJG
         soNYxwP4feSwpsNfyAciykFyvqyWALpL4Gy2qvUYVn2EKOtZbZQWt5KxcCje7VKcBIR3
         ePMzZDIBcWEW6HU9uZKC58P8cai8t6xm05pFBQ6u/WGC7s5maNr3Zv1JWK0f6FxgWLFn
         DPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320084; x=1793924884;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ux1Gd4wJ4i6CbO5kAuUr+fRClS71fFbOF44xw5i7O6M=;
        b=p0X1cehq0/9ffMFqRj2spKHh2Ul1R6Z78Oxf1hbG/hM8k47vSCg6FvsjRQLbZYUTG8
         NpMNudkc+X2oJH2wAiuU6uLhCDf8hapXAhKy8xWYvemKoYNI8eCRPrxTGvfRXOpEf3J0
         oqW4xhBTVj1DDcHYSlyKLS1YVKtv67J76xXphNW36FUezQnf852MR2Sbb4KYA7DVcldy
         Yz73oCx6q0/a8MKBU5MskSn1Pvzcwn0WFGcQlbgtpqqAn/PKftohr4WYxnXe/GYsyuy7
         O5tO4C/mLtsYhC3L5/h96iQHsdsAbcluxSpAHlf3t/WEiT8IjqAA9WdK0HyJyO9hKTMU
         whSg==
X-Forwarded-Encrypted: i=1; AKwUvBwTDXN0FkVCOGH5JZ8XfqDe8p1b8B1snYDwmjIRa0Bu9DYZwVprttoh1yZuvW1wD2tx0yV14bT6SDbK5yc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJb0Qb1Wp/ZKmFfhKSA4RzLZh5jYt3j+MuMxIApUuWKIOZmNtM+
	kIifCP2TvFu26ubq1zkHdn2LuCT53d3U79zOsL0HrtiDJT8NF3Thr9AJ
X-Gm-Gg: AYBFou131yjgo+FcjI62d2PbII9OV2/Ht9I9lJB7Sqiraq8uEYHCYNhEbXJOf0WrGJO
	inHy3TCMuRWSt3GlDulUHJn1HBeD2DnQiNu3YjeIjjJjmwItBZZkHRpG32p+I/WUMNFuhWPEhkI
	YPHm/0wgqMPOZJ55sa9dBQbD1O/nkjDpOqMBsPTEWLPWpqttz6zyf0e7z5MHZMvFlB3Go73ncXS
	uVC0xxYtkYrsADSz0bfspfx8EYL9ZllfHrLN4gerVinrG5heNMQkWJHpOuqART4s4rMcYosx8jq
	Zk/uqjryQFSc+0DBiHd0WU91TlAWTxNR2jbC6yAoFf/Yl80tmbrhZh2aYE9Pb+GlH3Aj11jlxRN
	/l6ho5j/k7n8pbaWzfckv4nAr0xNtGqqMQwLtBO4R3p7QxIMU6lwxRAx/2vjvCsnn3T448um17U
	UXca0zwpmYwGUyAKpVWDsvJUiIj04TfkSD9/tpN34afDH/wdeFDIRPStaz62F6gkFYj93rAveBn
	3ZrAD9CAnV/u2XWpeC1o57Ho19I1x4F4Bssr/qVSLjQLNPevf8V+7HZEfDNpb1BQrnMycUNcyVj
	hRIe/0+vnJWv06Ca8H7lti3oZJyerKzEXQyhm17PjSir0QhX
X-Received: by 2002:a05:7300:d20f:b0:353:5d7a:cabe with SMTP id 5a478bee46e88-36a3002ea6amr5283586eec.13.1793320083521;
        Thu, 29 Oct 2026 17:28:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1easm1883940eec.5.2026.10.29.17.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 17:28:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Muchun Song <muchun.song@linux.dev>, Lance Yang <lance.yang@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Qi Zheng <qi.zheng@linux.dev>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/4] powerpc/mm: map shared vmemmap tail pages as read-only
In-Reply-To: <20261019090830.1917657-3-songmuchun@bytedance.com>
Date: Fri, 30 Oct 2026 05:56:16 +0530
Message-ID: <fqxovxsn.ritesh.list@gmail.com>
References: <20261019090830.1917657-1-songmuchun@bytedance.com> <20261019090830.1917657-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Muchun Song <songmuchun@bytedance.com> writes:

> PowerPC radix uses an architecture-specific vmemmap population path for
> shared tail mappings, so it does not inherit the read-only protection added
> to the common path.
>
> Protect these mappings as well so illegal writes fault instead of
> corrupting metadata shared by multiple tail pages.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks good to me. Thanks for taking care of powerpc path as well.
Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


