Return-Path: <SRS0=CBJl=7E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A161C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 07:23:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A563A20679
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 07:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDaWIoTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A563A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Sydg07n2zDr0N
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2020 17:23:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=jiakernel2@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=vDaWIoTI; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49St5J0SVRzDqwy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2020 13:58:38 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id f6so4389890pgm.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2020 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=GTCRS5itnhr1mF/qxix34YoD9buZ+IJ+Kp8+rInUWII=;
 b=vDaWIoTIRHXzzZ3IA67i/cjCOtcGp88y+O8jyIDLaixqV8pz490fe22V8IP7iTQfe1
 YwtcB0HXkIAL18fDGByNvpebTUqZeqxG3FlwKcZJ1Rym7igoGACDWDHdcDBYqJJuNLOI
 oZn65R21HDSkTDywMd4YyKKdZqHI8Xl/970SsXN17v9J/1Kg2jzRKPsMbuWWObylBAmc
 W9QoRKVSiHMEi/BkfW/W7rWjSbhmbs/f0NpoEeE3KtEJmsy2KSw3a6vcQ/BGxaFPyVrb
 3deUq6U9z9ks+56TV3IJRzy8XC0zMZTSeUpI7Sk5rvdeo5JtniS9vK2H1HU2EfckOjdn
 AIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=GTCRS5itnhr1mF/qxix34YoD9buZ+IJ+Kp8+rInUWII=;
 b=CEJJNCl0OVQ/MSQQpsmZz9/5nclOnaaTbBCaS3cq9HtI8M5WDYluc6kyI/RSLvu05B
 /o5vVWM+c8vvFrJPEtkaFcAoL5MxU6ECULflt3CV0PfSArw1FabTnc+WBTh3qcQ+fvmT
 ign6Y/TGa+6kyG/eDTT893/rLhTMd6VLxTSAfyS1xcr7L6BMUgADtvfPBRTFAWRN+Z00
 tGuN2NW3ea0mZZfGTfVIC8x6irLUgQDwRNGCIhx6JjMM/QKhjkkFz5909hs4ZKgMUBVS
 4WMLfQN6pEPC/plmKnSNZRDa25qvrllr9p60d7hf+MpbrrCKCeMmXY0Lpxh0SE0mWqfO
 SNmQ==
X-Gm-Message-State: AOAM5334JIf8ezXRBFub7YviSK3/1oO2c409Ksyuc1Z4rKiX4/iz/24g
 dIlySuMfwp9zCGhtdufb9AU=
X-Google-Smtp-Source: ABdhPJx/4KdYW3Afcw6UEXV6omcwrg39GzRW/S4XSWQxqsjDVfrymkFMOI5pi2hIOfpxCf9XMGqlMg==
X-Received: by 2002:a63:7453:: with SMTP id e19mr4549034pgn.139.1590119915296; 
 Thu, 21 May 2020 20:58:35 -0700 (PDT)
Received: from [0.0.0.0] ([45.76.223.48])
 by smtp.gmail.com with ESMTPSA id o25sm4993865pgn.84.2020.05.21.20.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:58:34 -0700 (PDT)
From: Jia He <jiakernel2@gmail.com>
Subject: Re: [PATCH V3 0/3] arm64: Enable vmemmap mapping from device memory
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
References: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <4853d33f-d524-8209-4f8d-c26ee1eaa85b@gmail.com>
Date: Fri, 22 May 2020 11:58:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1585631387-18819-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 22 May 2020 17:22:03 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@samba.org>,
 linux-ia64@vger.kernel.org, linux-riscv@lists.infradead.org,
 Will Deacon <will@kernel.org>, jgg@mellanox.com, aneesh.kumar@linux.ibm.com,
 x86@kernel.org, "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Mike Rapoport <rppt@linux.ibm.com>, Kaly Xin <Kaly.Xin@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 rcampbell@nvidia.com, Pavel Tatashin <pasha.tatashin@soleen.com>,
 jglisse@redhat.com, Andy Lutomirski <luto@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, dan.j.williams@intel.com,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 robin.murphy@arm.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

On 2020/3/31 13:09, Anshuman Khandual wrote:
> This series enables vmemmap backing memory allocation from device memory
> ranges on arm64. But before that, it enables vmemmap_populate_basepages()
> and vmemmap_alloc_block_buf() to accommodate struct vmem_altmap based
> alocation requests.

I verified no obvious regression after this patch series.

Host: ThunderX2(armv8a server), kernel v5.4

qemu:v3.1, -M virt \

-object 
memory-backend-file,id=mem1,share=on,mem-path=/tmp2/nvdimm.img,size=4G,align=2M \

-device nvdimm,id=nvdimm1,memdev=mem1,label-size=2M

Guest: kernel v5.7.0-rc5 with this patch series.

Tested case:

- 4K PAGESIZE, boot, mount w/ -o dax, mount w/o -o dax, basic io

- 64K PAGESIZE,boot, mount w/ -o dax, mount w/o -o dax, basic io

Not tested:

- 16K pagesize due to my hardware limiation(can't run 16K pgsz kernel)

- hot-add/remove nvdimm device from qemu due to no fully support on arm64 qemu yet

- Host nvdimm device hotplug

Hence from above result,

Tested-by: Jia He <justin.he@arm.com>

> This series applies after latest (v14) arm64 memory hot remove series
> (https://lkml.org/lkml/2020/3/3/1746) on Linux 5.6.
>
> Pending Question:
>
> altmap_alloc_block_buf() does not have any other remaining users in the
> tree after this change. Should it be converted into a static function and
> it's declaration be dropped from the header (include/linux/mm.h). Avoided
> doing so because I was not sure if there are any off-tree users or not.
>
> Changes in V3:
>
> - Dropped comment from free_hotplug_page_range() per Robin
> - Modified comment in unmap_hotplug_range() per Robin
> - Enabled altmap support in vmemmap_alloc_block_buf() per Robin
>
> Changes in V2: (https://lkml.org/lkml/2020/3/4/475)
>
> - Rebased on latest hot-remove series (v14) adding P4D page table support
>
> Changes in V1: (https://lkml.org/lkml/2020/1/23/12)
>
> - Added an WARN_ON() in unmap_hotplug_range() when altmap is
>    provided without the page table backing memory being freed
>
> Changes in RFC V2: (https://lkml.org/lkml/2019/10/21/11)
>
> - Changed the commit message on 1/2 patch per Will
> - Changed the commit message on 2/2 patch as well
> - Rebased on arm64 memory hot remove series (v10)
>
> RFC V1: (https://lkml.org/lkml/2019/6/28/32)
>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Will Deacon<will@kernel.org>
> Cc: Mark Rutland<mark.rutland@arm.com>
> Cc: Paul Walmsley<paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt<palmer@dabbelt.com>
> Cc: Tony Luck<tony.luck@intel.com>
> Cc: Fenghua Yu<fenghua.yu@intel.com>
> Cc: Dave Hansen<dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski<luto@kernel.org>
> Cc: Peter Zijlstra<peterz@infradead.org>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: David Hildenbrand<david@redhat.com>
> Cc: Mike Rapoport<rppt@linux.ibm.com>
> Cc: Michal Hocko<mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)"<willy@infradead.org>
> Cc: "Kirill A. Shutemov"<kirill.shutemov@linux.intel.com>
> Cc: Andrew Morton<akpm@linux-foundation.org>
> Cc: Dan Williams<dan.j.williams@intel.com>
> Cc: Pavel Tatashin<pasha.tatashin@soleen.com>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Paul Mackerras<paulus@samba.org>
> Cc: Michael Ellerman<mpe@ellerman.id.au>
> Cc:linux-arm-kernel@lists.infradead.org
> Cc:linux-ia64@vger.kernel.org
> Cc:linux-riscv@lists.infradead.org
> Cc:x86@kernel.org
> Cc:linuxppc-dev@lists.ozlabs.org
> Cc:linux-mm@kvack.org
> Cc:linux-kernel@vger.kernel.org
>
> Anshuman Khandual (3):
>    mm/sparsemem: Enable vmem_altmap support in vmemmap_populate_basepages()
>    mm/sparsemem: Enable vmem_altmap support in vmemmap_alloc_block_buf()
>    arm64/mm: Enable vmem_altmap support for vmemmap mappings
>
>   arch/arm64/mm/mmu.c       | 59 ++++++++++++++++++++++++++-------------
>   arch/ia64/mm/discontig.c  |  2 +-
>   arch/powerpc/mm/init_64.c | 10 +++----
>   arch/riscv/mm/init.c      |  2 +-
>   arch/x86/mm/init_64.c     | 12 ++++----
>   include/linux/mm.h        |  8 ++++--
>   mm/sparse-vmemmap.c       | 38 ++++++++++++++++++++-----
>   7 files changed, 87 insertions(+), 44 deletions(-)
>
-- 

---
Cheers,
Justin (Jia He)

