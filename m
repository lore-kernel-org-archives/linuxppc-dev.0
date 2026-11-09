Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpk7qFuM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNCkh0YPxz2xfK;
	Mon, 09 Nov 2026 13:03:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794189835;
	cv=none; b=GUlAMcPOqjTeJg1guo8TPlZf5sv5BZI8pQLVh/oiJliIGNevz6wx4EyvTyCMLE8pfRg5kK4Z7z2x4o1MFEU6IfoMfN52Pdvcak+KiMB24E4/C2SF2R/ejp/pFvBuimsN1LgixLpSU2w+a+rCKkUqa/mIAEemJMhBCx1Pg+SE7jV0OeWZLW1NLa1bOTUK9i1/IObogHBI6SxaxUVs/FWrucqNNoJZ304Z26C+AQ0LkWE8iPQv9XE9eWiv8s/1O+mCNaz5JBpNDCPjIISZJ3RpYvKDMsVGYBBNSlBiR5c56Hag+g3KJOgPxT6hNwrTUCfxPsVpt5b0ER1lPzXutM+9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794189835; c=relaxed/relaxed;
	bh=e5KGXFtLIP4zXwl3CaHAlUnWSxZc9jYkQR01vVD5bYM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jyRnnJsUNS5u38ZbZhAy7exVkAXT1AyFz2PLFvGQsf1U7iWUn03i0e2oU8hA/tn6yM18UOaDHkpfUC/7Ss7FGBFPwiLRwQ9s71mRodz77xZQHBhmylHz3ENUFatK7N/Z9Vs9ZJOrImO7KUjm6S8zy5v5m5vupTPm6hKvi3xDfF7ljT9xE7LQWDPxYaGmP1KNJzlOib+4X5xBtrTUtuevH6lyTSrxb/KcEsK9AEA25CJE6QsSzRdkpvaLa19VnblFDLOJhAJr5x9w9+8h1q5RZXoACNdai4YIMnj49ZM8tLlTXIIOR3gDNdC850sCOJ8Esd9RlEPzPaGalZq1Et/Fhg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpk7qFuM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jpk7qFuM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNCkf29vvz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 13:03:53 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso769642eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 18:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794189830; x=1794794630; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e5KGXFtLIP4zXwl3CaHAlUnWSxZc9jYkQR01vVD5bYM=;
        b=jpk7qFuME7xxduqBpUcRl9X/zZyXXQydd4izNGtTfzXYrNw4zwTq1ktxYUX4NUBML2
         WruzkPPgmMcW8bveTr4SDsn7QnyzQxJz+TSJO2T1wjMl7tAj9Y/vwfRXv1kC2kJv+tNd
         kDHwv1O3mdJKEv/VqR76/XtRDY8DTThf5DA1QhQ+4gMS06lqs74tDlcUxl1rab4Ye12k
         3yP+U60nxo+FE89FVLwW8RWIxMm9oelI/wzf4SvoWSD9cFEVkMgmONkn+SngD4KXX15c
         0+tLAI964JpzzsATMhqn4Akbt0dzzc7Nbvm05G3YwkW4uv8oWpEJELJNtqLvKCnmzWC2
         MfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794189830; x=1794794630;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5KGXFtLIP4zXwl3CaHAlUnWSxZc9jYkQR01vVD5bYM=;
        b=F2jLaz0lYFLYZ/jQjb8ZpHby8G+chEQ+/Gy6GgmmgGT1ge9TxhSFXQcH0I9RIDByNu
         D34ukJl3xsiYP0IQXbthkA7BUB+DtFPb/Iqpnd0KSHMXX758JKOpHtuS/eDJuau255yT
         nCEJjjwoH5gS3uKvKZ+qYk1lbR3qxmp+4cq9OBO9Naz4vnf0w5/VT/LshUQ1f0TJspPi
         h4QQZETgXM6qRmzhvoT6Vm+ky6FKTHWU+bOXJMrqbbw0N6743H2JC+oIVEaPeokCSj4r
         UlcZSotZBP0wYFH1UKaA8tRXy2wV35WYz8qtKm2+HbRv75TIlWNcrBvjy9zpIQufJkk1
         MAFw==
X-Forwarded-Encrypted: i=1; AL+hErFt+eNozm7UVjrUAi/ZFvWx5MUYLqjgfAytryp0PgSD3fzru+4TXRjqIP0Xiug05rX6rqPB/QbY//jTblU=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9UFR6uAIcVoKrIUqxF1Bg5KXSkORqYSuE8tY30B0mSXFsT32Ty
	4fxZOEgevzHH2Z4I3yhvr6mh1SEyJS2YzTrEOTEIUC/QLczZozu6/BKfAMiopsCH
X-Gm-Gg: AYBFou18sQ5nV8bTluLh7rGyLQI7YfbLBPpVRUTwrCH1y3YwdUe6eavXNf4evduGixQ
	t06llj8Zo0Qxk2Kc5zJn+3eziuGF1ooyvjmWTVSbXT9Y5qEuughJl3jV8Z48z+PmUXefbAJKOjt
	vVcvQL+2LthQUJYNiHdqxei3Hsato1NBBJdVv//2s0hRAeGhER8xRWbaglrKnj7/zBTyOv9lQbW
	cGMUTk1bp96zJ/3bCIgDH6CFeN3dEc8hNSbi8bF+KMeedKwIzKenFOGPBaBASL60qoj0jpPd+zX
	iJWUjZuG9LdHmLVrglcjLi52hPB4RPyrWoWyP2RpSIEDyncBuaBDMuqRUGsWAq5GA6k8LnvKuv8
	iFl/JYpD82RuNyjHwtStUM2aJkxU8i5Vv/uUaoKUzU4DBnWl6bXEsl1HVvjX55129oQ6mEXR+K+
	iPsIN2sUkO0iZHvpCX+mAFOon8etyLnt5uxx8kSPjkTRN/u6K8myygQaqv2YPD6wGJIPCJ7kwk1
	76PXtqKp8KaIPOf1vxpmLZQFbE7LOSiPNdNe837EvStTNL4NLqF1RE2Ta7FjZOoeFQKR03RIM8s
	2PVrTBCxjiUOOxhIb0lUz35VlEn9VeFMp3GdP92sNDBlpUiX
X-Received: by 2002:a05:7300:680e:b0:36b:d3dd:2e85 with SMTP id 5a478bee46e88-372575c63fcmr5237251eec.36.1794189829714;
        Sun, 08 Nov 2026 18:03:49 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726039c635sm8670520eec.0.2026.11.08.18.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 18:03:48 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>, Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>, Pavithra Prakash <pavrampu@linux.ibm.com>, Muchun Song <muchun.song@linux.dev>, stable@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] dax/pmem: fix unaligned compound devmap initialization
In-Reply-To: <20261107030126.90894-1-songmuchun@bytedance.com>
Date: Mon, 09 Nov 2026 07:27:12 +0530
Message-ID: <cxseojgn.ritesh.list@gmail.com>
References: <20261107030126.90894-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

> Static pmem Device DAX namespaces reserve space for namespace metadata
> before the user-visible data range, and may also include padding needed
> to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
> dax_region range to start at the data range, but the dev_pagemap range
> still starts at the beginning of the namespace.
>
> That is not valid for compound devmap mappings whose memmap is stored in
> system RAM. Compound page initialization requires the start PFN to be
> naturally aligned to the compound page size, because the head and tail
> struct pages are initialized according to that geometry. If the pgmap
> starts before the aligned data range, memmap_init_zone_device() can build
> compound page metadata from an unaligned PFN.
>
> The resulting struct page layout is inconsistent with the Device DAX
> mapping. A later mmap fault can then resolve the user-visible PFN through
> invalid compound page metadata and hit a kernel panic while inserting the
> DAX folio.
>
> Fix this by rounding the pgmap start up to the Device DAX alignment for
> non-altmap mappings. This gives compound mappings the required naturally
> aligned start while retaining full-section vmemmap savings when the
> original start is already aligned. The altmap path remains unchanged
> because memmap_init_zone_device() skips the altmap reservation itself.
>
> Fixes: 14606001efb4 ("device-dax: compound devmap support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com

Tested v2 also on my Power dev test setup. With this patch the reported
problem is fixed. I am no more hitting the following warning and crash:

[    3.071811][    T1] WARNING: mm/mm_init.c:1175 at memmap_init_zone_device+0x144/0x470, CPU#0: swapper/0/1
[    3.082276][    T1] NIP [c000000000596604] memmap_init_zone_device+0x144/0x470
[    3.082763][    T1] LR [c0000000006d72b8] memremap_pages+0x3b0/0x974
[    3.083345][    T1] Call Trace:
[    3.083629][    T1] [c000000006d86e00] [c000000006d86e40] 0xc000000006d86e40 (unreliable)
[    3.084975][    T1] [c000000006d86f10] [c0000000006d72b8] memremap_pages+0x3b0/0x974
[    3.085449][    T1] [c000000006d86fe0] [c0000000006d78b8] devm_memremap_pages+0x3c/0xa4
[    3.085891][    T1] [c000000006d87020] [c00000000125c084] dev_dax_probe+0x264/0x3d0
[    3.086339][    T1] [c000000006d870c0] [c000000001259a28] dax_bus_probe+0x140/0x1c8
[    3.086778][    T1] [c000000006d87110] [c0000000011ce640] really_probe+0x108/0x580
[    3.087218][    T1] [c000000006d871a0] [c0000000011ceb84] __driver_probe_device+0xcc/0x284
[    3.087668][    T1] [c000000006d87230] [c0000000011ceea0] driver_probe_device+0x5c/0x10c
[    3.088123][    T1] [c000000006d87270] [c0000000011cf05c] __device_attach_driver+0x10c/0x1e8
[    3.088582][    T1] [c000000006d872f0] [c0000000011cab70] bus_for_each_drv+0xc0/0x13c
[    3.089035][    T1] [c000000006d87350] [c0000000011cf65c] __device_attach+0xdc/0x2b0
[    3.089467][    T1] [c000000006d873f0] [c0000000011cfaac] device_initial_probe+0x80/0x98
[    3.089910][    T1] [c000000006d87420] [c0000000011cac44] __bus_probe_device+0x58/0xf4
[    3.090358][    T1] [c000000006d87470] [c0000000011c8030] device_add+0x850/0xa78
[    3.090778][    T1] [c000000006d87530] [c00000000125b040] __devm_create_dev_dax+0x1c0/0x638
[    3.091236][    T1] [c000000006d875d0] [c00000000125b6c8] devm_create_dev_dax+0x44/0x7c
[    3.091676][    T1] [c000000006d87600] [c00000000125dbe8] __dax_pmem_probe+0x238/0x27c
[    3.092120][    T1] [c000000006d87770] [c00000000125dc4c] dax_pmem_probe+0x20/0x44
[    3.092542][    T1] [c000000006d87790] [c000000001237a14] nvdimm_bus_probe+0xcc/0x370
[    3.093097][    T1] [c000000006d87830] [c0000000011ce640] really_probe+0x108/0x580
[    3.093610][    T1] [c000000006d878c0] [c0000000011ceb84] __driver_probe_device+0xcc/0x284
<...>
[    3.099405][    T1] ---- interrupt: 0 at 0x0
[    3.099837][    T1] Code: 7c0802a6 fa8100b0 faa100b8 fb8100f0 7d574030 7d4a4030 f8010120 fbe10108 3917ffff 7d294038 3109ffff 7d284910 <0b090000> 3d2201c5 7bb53664 7ed607b4
[    3.101209][    T1] ---[ end trace 0000000000000000 ]---
[    3.104702][    T1] BUG: Unable to handle kernel data access on write at 0xc00c000000210000
[    3.105209][    T1] Faulting instruction address: 0xc000000000596394
cpu 0x0: Vector: 300 (Data Access) at [c000000006d86aa0]
    lr: c0000000005962c4: memmap_init_compound+0xac/0x2a8
    sp: c000000006d86d40
   msr: 8000000002009033
   dar: c00c000000210000
 dsisr: a000000
  current = 0xc000000006d33e00
  paca    = 0xc000000005010000   irqmask: 0x03   irq_happened: 0x01
    pid   = 1, comm = swapper/0
Linux version 7.3.0-17056-gc0944ee4a2c4 (powerpc64le-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #111 SMP PREEMPT Mon Nov  9 07:25:29 IST 2026
enter ? for help
[c000000006d86e00] c0000000005968f8 memmap_init_zone_device+0x438/0x470
[c000000006d86f10] c0000000006d72b8 memremap_pages+0x3b0/0x974
[c000000006d86fe0] c0000000006d78b8 devm_memremap_pages+0x3c/0xa4
[c000000006d87020] c00000000125c084 dev_dax_probe+0x264/0x3d0
[c000000006d870c0] c000000001259a28 dax_bus_probe+0x140/0x1c8
[c000000006d87110] c0000000011ce640 really_probe+0x108/0x580
[c000000006d871a0] c0000000011ceb84 __driver_probe_device+0xcc/0x284
[c000000006d87230] c0000000011ceea0 driver_probe_device+0x5c/0x10c
[c000000006d87270] c0000000011cf05c __device_attach_driver+0x10c/0x1e8
[c000000006d872f0] c0000000011cab70 bus_for_each_drv+0xc0/0x13c
[c000000006d87350] c0000000011cf65c __device_attach+0xdc/0x2b0
[c000000006d873f0] c0000000011cfaac device_initial_probe+0x80/0x98
[c000000006d87420] c0000000011cac44 __bus_probe_device+0x58/0xf4
[c000000006d87470] c0000000011c8030 device_add+0x850/0xa78
[c000000006d87530] c00000000125b040 __devm_create_dev_dax+0x1c0/0x638
[c000000006d875d0] c00000000125b6c8 devm_create_dev_dax+0x44/0x7c
[c000000006d87600] c00000000125dbe8 __dax_pmem_probe+0x238/0x27c
[c000000006d87770] c00000000125dc4c dax_pmem_probe+0x20/0x44
[c000000006d87790] c000000001237a14 nvdimm_bus_probe+0xcc/0x370
[c000000006d87830] c0000000011ce640 really_probe+0x108/0x580
<...>

Feel free to add:

Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


