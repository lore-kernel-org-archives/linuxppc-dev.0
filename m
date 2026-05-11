Return-Path: <linuxppc-dev+bounces-20698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E75CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 11:28:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDcsb1sMZz2xlh;
	Mon, 11 May 2026 21:28:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778498883;
	cv=none; b=R0Bpc0f/q2Fr7ykGZPeeXFzGIMtG3Ki0SINGlIbnp9oGwFn/fHa1k0B2Ra5eyynkpc6LjPJR/9KQ0hzS+SU02xlZuUAqkTsyoiPy4CXMB10WrYSDylHWMVIosPJ7IYn/0xZV5/+qO81LkV1BC67TbpPPp8dnFZNb8gajCGiGsNWREvLilEVjbpT+IAd7sZKRJimQsD6RfdlPck2RFUV/qSOHsAxB3HKlbdOAgAhws1gt6QGZ4c1UHj9rkPWHeui6azMfer0i0BxlIFyEG9L6EghbedTZfSmw+u0kQ3bu3i7xD516D6A7w+keG90UGTKFEjzoDTFGkWjyWbaOh+gv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778498883; c=relaxed/relaxed;
	bh=F0P1PDju6jr9cv9Ksne7vALVWTPLR6/ufkLvnSbh3J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl1ECzcoivzDU4sLgp3JxdkE+6S3IpjR6733XNY7rlWfzJvtcaEHPGgV8tNGCXBCuk373uvNZ/rTINYHYZBmsAk9gWdH/EGJ5SPzvYtoTYY5xFQnYlQ14irHA+jbisUedWasmjlK64FPLWGD29nWKoUaXvhf+77SyG+WcLZv9bJS9w07Vl6xNcrnvY90OqY7ExtM9NnAsMzlLawexb/tAeoGreAXZM7bwi8TSO41AS/9sVOPczaSWWvR6GEN1tnR++XOO6yLifPBh6is4CMmQI5KV2gYSIn1XhiMjMFl7HoYZQHfltn+KnVryltPIj0yqH8tvDLzWz9ffom1uIuPPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FZ/aUVrV; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org) smtp.mailfrom=suse.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FZ/aUVrV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=mhocko@suse.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDcsY4Lf4z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 21:28:00 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so49200955e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 04:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778498877; x=1779103677; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0P1PDju6jr9cv9Ksne7vALVWTPLR6/ufkLvnSbh3J8=;
        b=FZ/aUVrVSBJCNZJORXUTQOwaSoDsJZJ8PqrIBHq5bx8MrEB2/abrvs5o4WnS24K4BN
         mtAcNBEuM60hJzJLqnt67NzYT4vy2eL1LlXahTSWlmqUL0HdbQfHTMY1myoTMgrOroTa
         PHrjSjivh5mleg66Du7+eyRqiLTx4JAOpzasPNZMNhOW5w5p1fqSLIyLNBzlaK0au78P
         0t+w4EPTt99fWJkGhC5dyXpzkT+zxpWb0L0wuRXdyd3Y8gNzT93XgcTqLXB7Tb2TBGTe
         bdTRHPcetaHnTVOAMbFIwDIhhofF9oAFE5gE7tuCxQymabO+vvAxqpAGCrKH0wMM0Ly5
         mmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778498877; x=1779103677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0P1PDju6jr9cv9Ksne7vALVWTPLR6/ufkLvnSbh3J8=;
        b=j3hPN1i0vvMrX4ycZ3T8Bu30YvmclBz9w1K8zLefbXQGjQKrFEXE3naC+4M6RgWTc5
         /LqjLl3/mo9UcC9w1QAJ8urUJrTewIFqGN9b/YN8fZWIpYn6pgSL0aKhW+8dAFGhkRP2
         VdTEPjOkUy4Y8zd/0hroS1YoTCTB3CRhbPiycy0rj4LL935U+VtRABo95dll/yXEx2W0
         YJgwHoXkLKARaTJD19cJoVs97tgvHVefV8b8IIhCLpaw+EQbpWCjkXbzu78S4QazDfna
         Vh/hcvWDvOKELHP3y5gk2CoviYij0dBt2b68yXJgqKLOCiIYU26g2/H/rO9irx5O971x
         fP4w==
X-Forwarded-Encrypted: i=1; AFNElJ+/ZofFAVepnYbKcmX6w4SjwTDec7DblNxZ2e2eilxpNGKkSGoWe23Uue2vIAEffnxVTnmzcK1lucFSlEA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxR5dP99xfBAFHUlmI1XM3NUYSrujsn/CTl9i1+9+1AcBdBKQTy
	BzV6uYHKQMevalCRzdvyRWp1HDaGPXWJH9dhAIDnJyoHdx6FExUF+omTFDbRajBFT9Q=
X-Gm-Gg: Acq92OHvPIltnZm5+E3g383SOnumyeDI4mhadlDBK6tHYR8mdvlexocSm6/FCxpwD6k
	TF7MP2DIk3yTCFw/371QP2LE6pKO05iCGW12TcdGdEfnLRiyfuGuUYAzrMJi7uNSynozPjsvn2P
	22AhhrXHgo47878HvP9nhLNbaN7F4EhmuNF39KtuVtXY6+aES4VVi2puYPcWaLkVL8qgadzNQk3
	WXSnVgRBePp7OJUTaGs1iRT/EIeyeg7tpD1NcgykcRmfvey4F0r4n+Cjwxg2qiTYw67bqDNp7uO
	KMAQxDd1Nys6bEwFHX652HmnyEhksW/K3W8E/ee3tf4/Xb6cH8ba7p9CVNK51L03Im7kRWVCL84
	3NfTb7JbKsQrGLpuJ2ACOOJ9P0Qckqe/g1hYwzGYqEsjW71P1Ux1wsuqUhQrO+J5z0Wk38U18j8
	Fdm0/EPTGW/qhL73LeQYyFlynaYH9UEYZbTjqi
X-Received: by 2002:a05:600c:4695:b0:48e:5d91:cffb with SMTP id 5b1f17b1804b1-48e706c0662mr144541925e9.10.1778498876533;
        Mon, 11 May 2026 04:27:56 -0700 (PDT)
Received: from localhost (109-81-87-110.rct.o2.cz. [109.81.87.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e701e957asm181011495e9.6.2026.05.11.04.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 04:27:56 -0700 (PDT)
Date: Mon, 11 May 2026 13:27:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-mm@kvack.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [PATCH] drivers/base/memory: make memory block get/put explicit
Message-ID: <agG9O2_6nx5eNOCf@tiehlicka>
References: <20260511111800.2181785-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260511111800.2181785-1-songmuchun@bytedance.com>

On Mon 11-05-26 19:18:00, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), and collapse the
> redundant section-number wrapper into a single block-id based lookup
> interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>  drivers/base/memory.c                         | 38 +++++++------------
>  drivers/base/node.c                           |  4 +-
>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>  include/linux/memory.h                        |  7 +++-
>  mm/memory_hotplug.c                           |  5 +--
>  6 files changed, 35 insertions(+), 50 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 75f85a5da981..94f3b57054b6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -164,13 +164,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  
>  static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>  {
> -	unsigned long section_nr;
> -	struct memory_block *mem_block;
> -
> -	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> -
> -	mem_block = find_memory_block(section_nr);
> -	return mem_block;
> +	return memory_block_get(phys_to_block_id(lmb->base_addr));
>  }
>  
>  static int get_lmb_range(u32 drc_index, int n_lmbs,
> @@ -220,7 +214,7 @@ static int dlpar_change_lmb_state(struct drmem_lmb *lmb, bool online)
>  	else
>  		rc = 0;
>  
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>  
>  	return rc;
>  }
> @@ -319,12 +313,12 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>  
>  	rc = dlpar_offline_lmb(lmb);
>  	if (rc) {
> -		put_device(&mem_block->dev);
> +		memory_block_put(mem_block);
>  		return rc;
>  	}
>  
>  	__remove_memory(lmb->base_addr, memory_block_size);
> -	put_device(&mem_block->dev);
> +	memory_block_put(mem_block);
>  
>  	/* Update memory regions for memory remove */
>  	memblock_remove(lmb->base_addr, memory_block_size);
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 11d57cfa8d72..5b5d41089e81 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -649,7 +649,7 @@ int __weak arch_get_memory_phys_device(unsigned long start_pfn)
>   *
>   * Called under device_hotplug_lock.
>   */
> -struct memory_block *find_memory_block_by_id(unsigned long block_id)
> +struct memory_block *memory_block_get(unsigned long block_id)
>  {
>  	struct memory_block *mem;
>  
> @@ -659,16 +659,6 @@ struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  	return mem;
>  }
>  
> -/*
> - * Called under device_hotplug_lock.
> - */
> -struct memory_block *find_memory_block(unsigned long section_nr)
> -{
> -	unsigned long block_id = memory_block_id(section_nr);
> -
> -	return find_memory_block_by_id(block_id);
> -}
> -
>  static struct attribute *memory_memblk_attrs[] = {
>  	&dev_attr_phys_index.attr,
>  	&dev_attr_state.attr,
> @@ -701,7 +691,7 @@ static int __add_memory_block(struct memory_block *memory)
>  
>  	ret = device_register(&memory->dev);
>  	if (ret) {
> -		put_device(&memory->dev);
> +		memory_block_put(memory);
>  		return ret;
>  	}
>  	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
> @@ -795,9 +785,9 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
>  	struct memory_block *mem;
>  	int ret = 0;
>  
> -	mem = find_memory_block_by_id(block_id);
> +	mem = memory_block_get(block_id);
>  	if (mem) {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		return -EEXIST;
>  	}
>  	mem = kzalloc_obj(*mem);
> @@ -845,8 +835,8 @@ static void remove_memory_block(struct memory_block *memory)
>  		memory->group = NULL;
>  	}
>  
> -	/* drop the ref. we got via find_memory_block() */
> -	put_device(&memory->dev);
> +	/* drop the ref. we got via memory_block_get() */
> +	memory_block_put(memory);
>  	device_unregister(&memory->dev);
>  }
>  
> @@ -880,7 +870,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  		end_block_id = block_id;
>  		for (block_id = start_block_id; block_id != end_block_id;
>  		     block_id++) {
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (WARN_ON_ONCE(!mem))
>  				continue;
>  			remove_memory_block(mem);
> @@ -908,7 +898,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		return;
>  
>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>  		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));
> @@ -1015,12 +1005,12 @@ int walk_memory_blocks(unsigned long start, unsigned long size,
>  		return 0;
>  
>  	for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
> -		mem = find_memory_block_by_id(block_id);
> +		mem = memory_block_get(block_id);
>  		if (!mem)
>  			continue;
>  
>  		ret = func(mem, arg);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		if (ret)
>  			break;
>  	}
> @@ -1228,22 +1218,22 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  void memblk_nr_poison_inc(unsigned long pfn)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>  
>  	if (mem) {
>  		atomic_long_inc(&mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>  
>  void memblk_nr_poison_sub(unsigned long pfn, long i)
>  {
>  	const unsigned long block_id = pfn_to_block_id(pfn);
> -	struct memory_block *mem = find_memory_block_by_id(block_id);
> +	struct memory_block *mem = memory_block_get(block_id);
>  
>  	if (mem) {
>  		atomic_long_sub(i, &mem->nr_hwpoison);
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  	}
>  }
>  
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 126f66aa2c3e..b3333ca92090 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -847,13 +847,13 @@ static void register_memory_blocks_under_nodes(void)
>  		for (block_id = start_block_id; block_id <= end_block_id; block_id++) {
>  			struct memory_block *mem;
>  
> -			mem = find_memory_block_by_id(block_id);
> +			mem = memory_block_get(block_id);
>  			if (!mem)
>  				continue;
>  
>  			memory_block_add_nid_early(mem, nid);
>  			do_register_memory_block_under_node(nid, mem);
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  		}
>  
>  	}
> diff --git a/drivers/s390/char/sclp_mem.c b/drivers/s390/char/sclp_mem.c
> index 78c054e26d17..6df1926d4c62 100644
> --- a/drivers/s390/char/sclp_mem.c
> +++ b/drivers/s390/char/sclp_mem.c
> @@ -204,7 +204,7 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  	addr = sclp_mem->id * block_size;
>  	/*
>  	 * Hold device_hotplug_lock when adding/removing memory blocks.
> -	 * Additionally, also protect calls to find_memory_block() and
> +	 * Additionally, also protect calls to memory_block_get() and
>  	 * sclp_attach_storage().
>  	 */
>  	rc = lock_device_hotplug_sysfs();
> @@ -231,20 +231,19 @@ static ssize_t sclp_config_mem_store(struct kobject *kobj, struct kobj_attribute
>  			sclp_mem_change_state(addr, block_size, 0);
>  			goto out_unlock;
>  		}
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> -		put_device(&mem->dev);
> +		mem = memory_block_get(phys_to_block_id(addr));
> +		memory_block_put(mem);
>  		WRITE_ONCE(sclp_mem->config, 1);
>  	} else {
>  		if (!sclp_mem->config)
>  			goto out_unlock;
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(addr)));
> +		mem = memory_block_get(phys_to_block_id(addr));
>  		if (mem->state != MEM_OFFLINE) {
> -			put_device(&mem->dev);
> +			memory_block_put(mem);
>  			rc = -EBUSY;
>  			goto out_unlock;
>  		}
> -		/* drop the ref just got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		sclp_mem_change_state(addr, block_size, 0);
>  		__remove_memory(addr, block_size);
>  #ifdef CONFIG_KASAN
> @@ -294,11 +293,11 @@ static ssize_t sclp_memmap_on_memory_store(struct kobject *kobj, struct kobj_att
>  		return rc;
>  	block_size = memory_block_size_bytes();
>  	sclp_mem = container_of(kobj, struct sclp_mem, kobj);
> -	mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(sclp_mem->id * block_size)));
> +	mem = memory_block_get(phys_to_block_id(sclp_mem->id * block_size));
>  	if (!mem) {
>  		WRITE_ONCE(sclp_mem->memmap_on_memory, value);
>  	} else {
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  		rc = -EBUSY;
>  	}
>  	unlock_device_hotplug();
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 5bb5599c6b2b..29edef1f975c 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -158,7 +158,11 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(enum memory_block_state state, void *v);
> -extern struct memory_block *find_memory_block(unsigned long section_nr);
> +extern struct memory_block *memory_block_get(unsigned long block_id);
> +static inline void memory_block_put(struct memory_block *mem)
> +{
> +	put_device(&mem->dev);
> +}
>  typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>  extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  			      void *arg, walk_memory_blocks_func_t func);
> @@ -171,7 +175,6 @@ struct memory_group *memory_group_find_by_id(int mgid);
>  typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
>  int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>  			       struct memory_group *excluded, void *arg);
> -struct memory_block *find_memory_block_by_id(unsigned long block_id);
>  #define hotplug_memory_notifier(fn, pri) ({		\
>  	static __meminitdata struct notifier_block fn##_mem_nb =\
>  		{ .notifier_call = fn, .priority = pri };\
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 462d8dcd636d..890c6453e887 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1417,14 +1417,13 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
>  		struct vmem_altmap *altmap = NULL;
>  		struct memory_block *mem;
>  
> -		mem = find_memory_block(pfn_to_section_nr(PFN_DOWN(cur_start)));
> +		mem = memory_block_get(phys_to_block_id(cur_start));
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
>  
>  		altmap = mem->altmap;
>  		mem->altmap = NULL;
> -		/* drop the ref. we got via find_memory_block() */
> -		put_device(&mem->dev);
> +		memory_block_put(mem);
>  
>  		remove_memory_block_devices(cur_start, memblock_size);
>  
> 
> base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
> -- 
> 2.54.0

-- 
Michal Hocko
SUSE Labs

