Return-Path: <linuxppc-dev+bounces-26424-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF1FC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 01:10:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZPmf1n9jz2y2h;
	Wed, 02 Sep 2026 11:10:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788311442;
	cv=none; b=e2yhKFCCuKoezR5UUsbuSuIkD1A2lcDQuw15KDpu3DcRQvuoRrMeUTI6+X5d/SK3hYvmV+b8gMVWjBgU1ZOwAhp6v97xQOQkq3Y6K9rk5+8qz186y4UV4r+iXL8+RfrTSGgz2X24r4iCuW/m5drkekwzLVMGdmi5nTjE8fsvjRSPKfat9i05qePEQ1MGckUJX/eC3RAsqea5WnjPwUHNiWBv7cPq2d5Epe0254cx29eNf8wjDddowjORIKhnQ+F8mt6CQur9Z7ABiD16CnLaBdZ9mK3KsZqFBT/ppCgm/sJPk/pwAVKdCZSK3t9Uf69U1tNpTEsz8ChiCZXtaFmFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788311442; c=relaxed/relaxed;
	bh=ueZfUdbICpbFc4QJdF1KNCrnQsrHgevLIv0afVFUmZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tqa/G9/U7REOq47BPFXKZtNIK10TnpRde2lmiRoYWKy8EmhDAttLw0NJJdwuuTctSkYIMQj4sKBCTkMkhCZVQ4Fz4L9C/W10zgXmkMxcENtCEpUu2h2uOOzVgc+/fIKz21zGwYzvBu8gafOyMzAlVDaXh0aU3PpP8+Epcjxik/hEjkHWJaGKyyr9ZXhbt4r/DqLL8GgDvK12q4tt9mUshsns293+p7BwwVYa7qkS1aRb453etjTuZSr9dHlsf+xT4EEZsRUl29cUdu5oL09sp+ra9B6UevB0uJ5YUCc0u0IQ0FxJCV3bRlDAZEhmy2dd3bigsE1YNqfhhuDev6tV0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gxQtifHk; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gxQtifHk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZPmY3w1Dz2xlv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 11:10:34 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ueZfUdbICpbFc4QJdF1KNCrnQsrHgevLIv0afVFUmZM=;
	b=gxQtifHkaLPw22BF6n0KMEk10IuxeqmsMYYop/hUPqKEf8knsZeKMkjksoN1EG/Q1sd/O9Di/
	MWC9d9+IV55CGBmQmL79IAHmaox4lGW98FrA6ZXZh/7XOquukuCJCl9vL3nrYSwO4ytzpow/EiG
	bZELp1KK04KMfSbcfFS8Feg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hZPWl0vM1z1K96m;
	Wed,  2 Sep 2026 08:59:31 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 13A854048B;
	Wed,  2 Sep 2026 09:10:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Sep 2026 09:10:18 +0800
Message-ID: <bf0e158e-4bd0-4495-a9e2-983556e4041b@huawei.com>
Date: Wed, 2 Sep 2026 09:10:16 +0800
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
Subject: Re: [PATCH v3 01/17] kexec: Record allocated CMA pages to fix release
 size mismatch
To: Mike Rapoport <rppt@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<gshan@redhat.com>, <jic23@kernel.org>, <james.morse@arm.com>,
	<ardb@kernel.org>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <coxu@redhat.com>, <tangyouling@kylinos.cn>,
	<hbathini@linux.ibm.com>, <adityag@linux.ibm.com>,
	<ionut.nechita@windriver.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>, <robh@kernel.org>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-2-ruanjinjie@huawei.com>
 <178829364020.3691424.12323275610442178748.b4-review@b4>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <178829364020.3691424.12323275610442178748.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500011.china.huawei.com (7.185.36.131)



在 2026/9/2 4:14, Mike Rapoport 写道:
> Hi,
> 
>> The CMA pages allocated for a kexec segment are released using the
>> segment's memsz to calculate the number of pages. However, some
>> architecture loaders modify the segment's memsz after allocation
>> (e.g. arm64 subtracts text_offset), causing the release function to
>> free fewer pages than were originally allocated, leaking the remaining
>> CMA pages.
>>
>> Add a per-segment `segment_cma_pages` array to store the number of
>> pages actually allocated from CMA. Populate it during
>> kexec_add_buffer() using the aligned memsz, and use it in
>> kimage_free_cma() to accurately release all allocated pages.
>>
>> This avoids relying on the potentially modified segment->memsz and
>> prevents silent CMA memory leaks.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Baoquan He <baoquan.he@linux.dev>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
>> Cc: Pratyush Yadav <pratyush@kernel.org>
>> Cc: Brian Mak <makb@juniper.net>
>> Cc: Pingfan Liu <piliu@redhat.com>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: Justinien Bouron <jbouron@amazon.com>
>> Cc: Li Chen <me@linux.beauty>
>> Cc: stable@vger.kernel.org
>> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
>> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0af8ae4fdd087..83c296c0eb6cc 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -349,6 +349,7 @@ struct kimage {
>>  	unsigned long nr_segments;
>>  	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
>>  	struct page *segment_cma[KEXEC_SEGMENT_MAX];
>> +	unsigned int segment_cma_pages[KEXEC_SEGMENT_MAX];
> 
> Can we universally use unsigned long for number of pages?

Hi Mike,

unsigned int is used here because the second parameter of
arch_kexec_pre_free_pages is unsigned int.

static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int
pages) { }

> 
>>  
>>  	struct list_head control_pages;
>>  	struct list_head dest_pages;
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index dc770b9a6d053..611b15bb1369e 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -560,7 +560,7 @@ static void kimage_free_cma(struct kimage *image)
>>  
>>  	for (i = 0; i < image->nr_segments; i++) {
>>  		struct page *cma = image->segment_cma[i];
>> -		u32 nr_pages = image->segment[i].memsz >> PAGE_SHIFT;
>> +		unsigned int nr_pages = image->segment_cma_pages[i];
>>  
>>  		if (!cma)
>>  			continue;
>> @@ -568,6 +568,7 @@ static void kimage_free_cma(struct kimage *image)
>>  		arch_kexec_pre_free_pages(page_address(cma), nr_pages);
>>  		dma_release_from_contiguous(NULL, cma, nr_pages);
>>  		image->segment_cma[i] = NULL;
>> +		image->segment_cma_pages[i] = 0;
>>  	}
>>  
>>  }
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 59fb9d71e9d86..bfae3fee7f2f9 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -670,7 +670,7 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
>>  
>>  static int kexec_alloc_contig(struct kexec_buf *kbuf)
>>  {
>> -	size_t nr_pages = kbuf->memsz >> PAGE_SHIFT;
>> +	size_t nr_pages = PFN_DOWN(kbuf->memsz);
>>  	unsigned long mem;
>>  	struct page *p;
>>  
>> @@ -756,6 +756,8 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>   */
>>  int kexec_add_buffer(struct kexec_buf *kbuf)
>>  {
>> +	unsigned long nr_segments = kbuf->image->nr_segments;
>> +	size_t nr_pages;
>>  	struct kexec_segment *ksegment;
>>  	int ret;
>>  
>> @@ -763,7 +765,7 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>>  	if (!kbuf->image->file_mode)
>>  		return -EINVAL;
>>  
>> -	if (kbuf->image->nr_segments >= KEXEC_SEGMENT_MAX)
>> +	if (nr_segments >= KEXEC_SEGMENT_MAX)
>>  		return -EINVAL;
>>  
>>  	/*
>> @@ -789,12 +791,18 @@ int kexec_add_buffer(struct kexec_buf *kbuf)
>>  		return ret;
>>  
>>  	/* Found a suitable memory range */
>> -	ksegment = &kbuf->image->segment[kbuf->image->nr_segments];
>> +	ksegment = &kbuf->image->segment[nr_segments];
>>  	ksegment->kbuf = kbuf->buffer;
>>  	ksegment->bufsz = kbuf->bufsz;
>>  	ksegment->mem = kbuf->mem;
>>  	ksegment->memsz = kbuf->memsz;
>> -	kbuf->image->segment_cma[kbuf->image->nr_segments] = kbuf->cma;
>> +	kbuf->image->segment_cma[nr_segments] = kbuf->cma;
>> +	if (kbuf->cma) {
>> +		nr_pages = (unsigned int)(PFN_DOWN(kbuf->memsz));
>> +		kbuf->image->segment_cma_pages[nr_segments] = nr_pages;
> 		kbuf->image->segment_cma_pages[nr_segments] = nr_pages;
>> +	} else {
>> +		kbuf->image->segment_cma_pages[nr_segments] = 0;
>> +	}
> 
> I suggest to rename nr_pages to nr_cma_pages, initialize it to 0 at
> declaration time and make this

I agree with this.

> 
> 	if (kbuf->cma)
> 		nr_cma_pages = PFN_DOWN(kbuf->memsz);
> 	kbuf->image->segment_cma_pages[nr_segments] = nr_cma_pages;
> 


