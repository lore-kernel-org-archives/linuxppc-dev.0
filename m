Return-Path: <linuxppc-dev+bounces-22914-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C2ECDB479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 04:22:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gksPB1fC3z2y71;
	Tue, 23 Jun 2026 14:22:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782188574;
	cv=none; b=h99RJvWRcMd9zVS2rnQ0yRmV1M1bHSD8M9Ry/iHnbV9v/cjvm43uHJj6RvZ4+xYUgubF1YkoNZ8myawDRjsqKDll2+U4UZkgDJO8SgwQouEjpWoDPMByuM5ukdL7wrr4CExPUfvci68CBLoHM0eQd9Hx74eQqYjTSMgL/Lh14c3zhnvMihRJLtsBPKV09QOfh7iqPrYVgAdgGN+ZDWcQZqw5GVddU1OYDL1+mQuJNk2oRFmgkolIFFmkhedpfvssc6QLXty8aG6GVtdo8qDnKr9psC7zGfW5URx5fZ7nAw4Z6427RRFlxBrkiYoG9aWycy5FfNHDnFH9TfwYePhb/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782188574; c=relaxed/relaxed;
	bh=iCeZzcSVN670PFFl9OXDzKKPTpZS94DK0FINkgJfL0o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=gARE+UQCMQlP/FJODeKnIMLiW3Ze1wSipYYitq2Z/9IW4cc9DKHVTBf1EiBQU+FUJglv/sIpH78E1YAxbX0lQsnjuJ03FzxTM+qzW4JrUwbNnxDF7mnkpNtCbefh3dhgJGSzyuNE1fcno2Ceva3JLHj2sWgFGo1MO57XY46Ws4kHT1SkCVWmY3Vi2EQW8wtCxr/yQ7vkt4QHSKWwTRusE/t/TCPrUcbT5NWRu3DxILLcya/PEU1nghKOtHFoMX97oazWajSBw/VdfFkk4cN7pWECtv6s6ZutbjZF2nVGJxpbwYnViOMdblEozW1pYoSD/YQJmnLoCbkZaEktnM+gZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dnbv5H5s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dnbv5H5s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gksP82gcXz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 14:22:51 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so3169707a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 21:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782188569; x=1782793369; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCeZzcSVN670PFFl9OXDzKKPTpZS94DK0FINkgJfL0o=;
        b=Dnbv5H5s8YxYB8KeDdiBl5o4xyY3Mwy7apehZuPqVCVUBrxmbLmKh0vM3/xPU1YOsY
         R3+ZosmmvIXR5J5KnxMzH2QSA3LhY0M9C03GKHnCb2F5n3PFqhBteF6ePCPCK7wyeSuL
         8coDLqDisO1CvNUq7BD5WetrzPS4ThqSvJVsgwUKFbQjYqMgBT5Zq/6cS4vB9Z9tbn4x
         1DePOlIrfdrPAHJEPht1OTrMGeYGto5tUEKM8zlAyuZqRFMXlaBYOtRFgsy1RTFB6T/q
         t9TPf/YL9mcDukmq/BJ7KVb8cq2I4NO1HMcJgT3rFY6u+i3ujP4tlnHjzEwCTNANLOix
         nEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782188569; x=1782793369;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCeZzcSVN670PFFl9OXDzKKPTpZS94DK0FINkgJfL0o=;
        b=DxtPD7lz0jLV/qKW7cqrT1wejCPo2K51rk3lR/1o8YpV98Yo6xwm0nuiHtzZJ1wGIp
         R0a9is82p8wZe5Fnv7NH4BZdLG96lsSBQE4FMea07mCUoRGf1RJ+omXfVopzFMcogc2s
         iaqrzi3yyvzbLD/d+cQfk2JPs21T0mdZZ+n03SR8HBIWU3ynceiu9UzcrAqHzw0xxLQm
         BpnVmeZOAvc58GCxd8mfE7tbXLGqDjX0O4Fd1FWHPMy+/U97GXmQMA1szFcftFQGy4O3
         maC1ekgjOx1IhAShTZ4ZxPfC1hy/v1kwNRuzda9p5I+G7rk8wNXeK1rE43sZ2lXJvK+W
         Fuew==
X-Forwarded-Encrypted: i=1; AHgh+RrK1hBSoxaLYFsGXqKSw0LuiBuHeCN+89CTpk5O/PDQMzsX8qdyz/+8EIfUNRSl9DQqTOhWLGImIua5hes=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyaVlG3s1J3iLc6ZoSGIAQyOQfFqJJm3R8tdscVOna6OzbuPr+M
	KWuvUCwQ+MCnOBZzaLbD/couKVoM+V3OZzVRvece12mnTwFbW7eZBiad
X-Gm-Gg: AfdE7cmD5K9wOFDdV+NexsSBrLK+utL6G5dXncira/wG4YQmlso767KHXNg2nvq3cc5
	EXvwMFTU28OsDc/j7QennUu5Pdb4ON9fPU0flmo3fjMxipurZgFPfi/By89jgxUiWTCbXLZejk/
	ChkwV/XGPbm1Xfd2x2ardA0gLsxyS4qFA7MQ2XUCl04USj1RxCoGBF0I42druSd0q3ivPJfx1xg
	DNmDiURrkbnWZrTauKEvuLPseevV97JHOdGk7wYdURdvCxzJm1ERNIRnu8Fqk2Elbpqe8/1od5x
	zn0qB2CaGZAt0skwtDJBwyJZnZX6ZdrbBa1aIzsJlDHc/he0BEdE4sLCoENp2xJO4BLYu9r9zGc
	W1UghXDpWRR92sK5BZplIif9WhTtPns1+H/aDTBTeCv+935KFEqbQ6M6E8uFae0APeJ+AX66afG
	gg1rC+EaSZdwI7M88=
X-Received: by 2002:a17:90b:5346:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-37dd0d30e19mr1352554a91.7.1782188568802;
        Mon, 22 Jun 2026 21:22:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1536b541sm11397460a91.1.2026.06.22.21.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:22:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Barry Song <baohua@kernel.org>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [PATCH v4 1/3] mm, swap: make SWAPFILE_CLUSTER runtime
In-Reply-To: <CAGsJ_4y++uh_4Dqso-fafywFCAvTLd-JSRJ8RZ6HvNLDkaLUJA@mail.gmail.com>
Date: Tue, 23 Jun 2026 09:41:48 +0530
Message-ID: <4iityjy3.ritesh.list@gmail.com>
References: <cover.1781843449.git.ritesh.list@gmail.com> <e519e98f51be2d310367e39df0935da79001e535.1781843449.git.ritesh.list@gmail.com> <CAGsJ_4y++uh_4Dqso-fafywFCAvTLd-JSRJ8RZ6HvNLDkaLUJA@mail.gmail.com>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Barry Song <baohua@kernel.org> writes:

> On Fri, Jun 19, 2026 at 12:41 PM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
>>
>> On PowerPC Book3S64, MMU is selected at runtime, so macros like
>> PMD_SHIFT are effectively runtime variables in the Book3S64 code. THP
>
> Not an expert on Book3S64—could you explain the runtime variables in
> more detail? Does enabling THP_SWAP on PowerPC cause any build issues?
>

yes, build issues. We cannot declare array sizes by using runtime
variables. That's what this patch series fixes.

>> swap code uses these macros to size some of its array data structures
>> based on PMD_ORDER e.g. SWAPFILE_CLUSTER macro is used for this very
>> purpose.
>> Hence this patch makes the users of SWAPFILE_CLUSTER to use this macro value at
>> runtime and also modifies swap_table and swap_memcg_table which were earlier
>> using this macro for defining the number of table entries.
>>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  mm/swap_table.h |  6 ++----
>>  mm/swapfile.c   | 17 ++++++++++++-----
>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/swap_table.h b/mm/swap_table.h
>> index e6613e62f8d0..90e2a7852300 100644
>> --- a/mm/swap_table.h
>> +++ b/mm/swap_table.h
>> @@ -8,16 +8,14 @@
>>
>>  /* A typical flat array in each cluster as swap table */
>>  struct swap_table {
>> -       atomic_long_t entries[SWAPFILE_CLUSTER];
>> +       DECLARE_FLEX_ARRAY(atomic_long_t, entries);
>>  };
>>
>>  /* For storing memcg private id */
>>  struct swap_memcg_table {
>> -       unsigned short id[SWAPFILE_CLUSTER];
>> +       DECLARE_FLEX_ARRAY(unsigned short, id);
>>  };
>>
>> -#define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) == PAGE_SIZE)
>> -
>>  /*
>>   * A swap table entry represents the status of a swap slot on a swap
>>   * (physical or virtual) device. The swap table in each cluster is a
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 78b49b0658ad..4bf11c5b87eb 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -129,6 +129,8 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
>>         .lock = INIT_LOCAL_LOCK(),
>>  };
>>
>> +static bool swap_table_use_page __ro_after_init;
>
> Does a static key help here?

That IMO won't give much benefit, given the allocation by either kmem or
alloc pages, anyway dominates the cost. Also I believe this is exactly
the usecase where branch predictor helps signficantly and reliably given
the variable is ro_after_init.

>
> Best Regards
> Barry

Thanks Barry for looking into this.

-ritesh

