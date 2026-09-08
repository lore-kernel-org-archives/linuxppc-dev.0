Return-Path: <linuxppc-dev+bounces-26754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78479C79FAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:23:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfFm05qvgz2yDD;
	Tue, 08 Sep 2026 17:23:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788852208;
	cv=none; b=Pw9SJ7yfdJ8r+uVU36SCQxbGT3U6wps7aGGU/bnxUpfM3kTGKRVqXuJfOXTmLoKTKvcXf9ARYf8EZQ61r/SXuS3n64380TE3HoF7DqV9+Rvk7wuRWqRmox4ls/MGonM0rJNVXr5h11Aj8ATlalsfHfBtwWfjdOhnIXt0rclEwvFiNor5EHIVqc6+RLn0c30xQ00XTUgHdxy2VIKneync8d6sIaTaov4wYppq5tmCAO33+bt7jJl+Jy9jsrPLKG0/gAmzmb10uKz+oEDyR2+Jico6x8IeCtJAOh1WglSTiz3myDdm7gM5gPOTGWWbl+rSc207GyFbJL6qE6zTv5RT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788852208; c=relaxed/relaxed;
	bh=G7nz+2I01rp2LskTbFRR2FK0vPBroOC8XutcipcnIsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H9OPaqaRHIF4hU8j68jiWOSdHvu3Bh4TiihZSIZqBnsn8dYNhGq8AxdOg/qyhT6P3+BTeK1v9Nac/onghRoxU/DHDE1Fx3wp1nwKnhxl2LBRDKFzAXM0RAY4BS5kMg7RYd4NobK9HuJ+gbwIV4L48enX+D1yhvfW2vGudQwKp3hPIwxbim39HpV8mDhUrwxC5byTDxb/Pce2mAspHOvhzD04iWwitOV3xwEMvhqKx/K4IwRJYZvpWfVjML+t6v2gMwzSnKurNsHf+5jsDescnFL4mUlxHK/gSdDoe4EoAbHXiL3X/6n/UT0yicxk/1NIcNTUhnqjq7beldisJwpk4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hyaS2dA6; dkim-atps=neutral; spf=pass (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hyaS2dA6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.226; helo=canpmsgout11.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfFlw1NVrz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 17:23:19 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G7nz+2I01rp2LskTbFRR2FK0vPBroOC8XutcipcnIsM=;
	b=hyaS2dA64DcCg3GRIM7kcjDzC2hUqQBzbi0wYEmlK75paxqrzZ4Qk09vQIT+D6ItcGzT9PK7K
	+Fa6fiPBtKYscFQTRzVIbY6yweWimJ2oM5lKsGuwlq23S1Lfx1H1u//nCgErq4AFzAXXYPebOeM
	yjA4Etr6FTTSMfxdr1fEXw0=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hfFVy3mfZzKmVp;
	Tue,  8 Sep 2026 15:12:10 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D100C40586;
	Tue,  8 Sep 2026 15:23:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 8 Sep 2026 15:23:05 +0800
Message-ID: <92050fca-96ff-46e6-aca8-3cecd7cfb778@huawei.com>
Date: Tue, 8 Sep 2026 15:23:04 +0800
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
Subject: Re: [PATCH v4 05/12] LoongArch: kexec_file: Fix CMA page leaks in
 segment placement retry loops
To: Huacai Chen <chenhuacai@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<jic23@kernel.org>, <tan.shaopeng@jp.fujitsu.com>, <zengheng4@huawei.com>,
	<james.morse@arm.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <sourabhjain@linux.ibm.com>, <robh@kernel.org>,
	<coxu@redhat.com>, <tangyouling@kylinos.cn>, <hbathini@linux.ibm.com>,
	<adityag@linux.ibm.com>, <djbw@kernel.org>, <seanjc@google.com>,
	<liaoyuanhong@vivo.com>, <vishal.l.verma@intel.com>,
	<fuqiang.wang@easystack.cn>, <makb@juniper.net>, <piliu@redhat.com>,
	<ebiggers@kernel.org>, <jbouron@amazon.com>, <mclapinski@google.com>,
	<me@linux.beauty>, <graf@amazon.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<kexec@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260907125404.922123-1-ruanjinjie@huawei.com>
 <20260907125404.922123-6-ruanjinjie@huawei.com>
 <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CAAhV-H7qjJ7BPnJ2KoQZSyMUvX_6i9H=EfdadXnmXtNiiB4ROA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/7 22:05, Huacai Chen 写道:
> Hi, Jinjie,

Hi Huacai,

> 
> On Mon, Sep 7, 2026 at 8:53 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>
>> During kexec image placement retry loops, any midway failure causes
>> the loader to truncate `image->nr_segments` back to its initial state
>> to purge the failed segments.
>>
>> However, this truncation introduces a memory leak. The CMA pages
>> allocated via kexec_add_buffer() during the failed attempt are tracked
>> in the `image->segment_cma` array. Because the subsequent cleanup paths
>> only iterate up to the truncated `nr_segments` boundary, these allocated
>> CMA pages outside the new boundary are permanently leaked.
>>
>> Fix this by explicitly releasing the associated CMA buffers in
>> the failure paths before `image->nr_segments` is reduced.
> I'm not sure but does the elf version have similar problems as the efi version?

This issue does not exist in the ELF version, as the retry loop for
load_other_segments() does not exit here.

Best regards,
Jinjie

> 
> Huacai
> 
>>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: WANG Xuerui <kernel@xen0n.name>
>> Cc: Youling Tang <tangyouling@kylinos.cn>
>> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: stable@vger.kernel.org
>> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
>> Fixes: 55d990f0084c ("LoongArch: Add EFI binary support for kexec_file")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/loongarch/kernel/kexec_efi.c          | 1 +
>>  arch/loongarch/kernel/machine_kexec_file.c | 6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
>> index 5ee78ebb1546..15fd797ff3de 100644
>> --- a/arch/loongarch/kernel/kexec_efi.c
>> +++ b/arch/loongarch/kernel/kexec_efi.c
>> @@ -86,6 +86,7 @@ static void *efi_kexec_load(struct kimage *image,
>>                  * We couldn't find space for the other segments; erase the
>>                  * kernel segment and try the next available hole.
>>                  */
>> +               kexec_free_segment_cma(image, kernel_segment_number);
>>                 image->nr_segments -= 1;
>>                 kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>>                 kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> index 5412aa9f3568..62a5be102065 100644
>> --- a/arch/loongarch/kernel/machine_kexec_file.c
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -217,7 +217,11 @@ int load_other_segments(struct kimage *image,
>>         return 0;
>>
>>  out_err:
>> -       image->nr_segments = orig_segments;
>> +       while (image->nr_segments > orig_segments) {
>> +               kexec_free_segment_cma(image, image->nr_segments - 1);
>> +               image->nr_segments--;
>> +       }
>> +
>>         kfree(modified_cmdline);
>>         return ret;
>>  }
>> --
>> 2.34.1
>>


