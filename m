Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AADC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:03:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95AEA20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gmw+rb+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95AEA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDY22pwlzDqgS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:03:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gmw+rb+V";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=rafael.tinoco@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gmw+rb+V"; 
 dkim-atps=neutral
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D8LG4GMdzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 03:54:14 +1100 (AEDT)
Received: by mail-qk1-x741.google.com with SMTP id 189so6861056qkj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:subject:to:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4E/A4XqGwktpScqeqeYZIvgoC7FcBTRDxKDPbLw2eKY=;
 b=Gmw+rb+VDP/lXIa+o1QmGeclT5AayLA2m5FiiqZUMwT9qiPJgnvJgpGgSaOTIeUfEC
 iagAhuU1PBTRAIte/H/Mm+y2dRGMUMGiiGA/ORU9P3cwXkAjuuFX9ndr0aHIyjCWZSFc
 8MaeMjU2Jmdhzz55JVTOvXy8V5l9AArT2pVVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:cc:subject:to:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4E/A4XqGwktpScqeqeYZIvgoC7FcBTRDxKDPbLw2eKY=;
 b=THHVM0Iemx2cq6n2B9Edeqt9r0d0l+UEgTTMy7nr4DT8bsl5ReixA/L9xopjax+AF9
 Vg3uCGf/Tu12khVSCeQQjj4iIHMofga9X5r/GOcNJoSTlahD4dYPeYfQWfdDQ4t+xyjd
 RXvRB4Az7hLLFjWwaJSnzeyi1BhASxNSkiz/4kmK+8QtqK7CP+90CsMa7p9/KbJoB9xf
 0Sv9bjrYicfkUDprX1TL4ZvwCLuzuM+iHDk6hGr5d6kBAzoGqHPrQTJM5Rh4HixOuMK4
 bh6lnjlXOB+70aFC+XLO2B1HC1eOzzpL8FmDwYFYQb/Jm0qDpj+eNd3WG1mEJiwZXk+E
 kcMA==
X-Gm-Message-State: AA+aEWZePqein8fPgJPNHUcFA+lQJL9j8zC7L/fjqkpPWAXXhePb0qMc
 MqJ/j+0YQac3OumSMVqxAiyvgA==
X-Google-Smtp-Source: AFSGD/XNuYjq6tS9Wow3fFdrMPaBVPlJ+qr/6ZOBItkHSOGeeT3YrqHbFHiNvFQrfn14k12Y+NUYGA==
X-Received: by 2002:a37:2cc2:: with SMTP id s185mr11328178qkh.74.1544460852144; 
 Mon, 10 Dec 2018 08:54:12 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.7])
 by smtp.gmail.com with ESMTPSA id u16sm8952639qkg.14.2018.12.10.08.54.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:54:11 -0800 (PST)
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <4da655ec-a1ac-c524-1eb4-5cbd18b265ef@arm.com>
 <20181210150551.GE30658@n2100.armlinux.org.uk>
From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <27fb9417-fc55-f01e-c575-8c18862a282e@linaro.org>
Date: Mon, 10 Dec 2018 14:53:59 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210150551.GE30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 11 Dec 2018 06:55:18 +1100
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Khalid Aziz <khalid.aziz@oracle.com>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
 Nitin Gupta <ngupta@vflare.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Rafael David Tinoco <rafael.tinoco@linaro.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>,
 Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Minchan Kim <minchan@kernel.org>, Paul Burton <paul.burton@mips.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/10/18 1:05 PM, Russell King - ARM Linux wrote:
> On Mon, Dec 10, 2018 at 02:35:55PM +0000, Robin Murphy wrote:
>> On 10/12/2018 14:21, Rafael David Tinoco wrote:
>>> On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
>>> physical frame number might be so big that zsmalloc obj encoding (to
>>> location) will break, causing:
>>>
>>> BUG: KASAN: null-ptr-deref in zs_map_object+0xa4/0x2bc
>>> Read of size 4 at addr 00000000 by task mkfs.ext4/623
>>> CPU: 2 PID: 623 Comm: mkfs.ext4 Not tainted 4.19.0-rc8-00017-g8239bc6d3307-dirty #15
>>> Hardware name: Generic DT based system
>>> [<c0418f7c>] (unwind_backtrace) from [<c0410ca4>] (show_stack+0x20/0x24)
>>> [<c0410ca4>] (show_stack) from [<c16bd540>] (dump_stack+0xbc/0xe8)
>>> [<c16bd540>] (dump_stack) from [<c06cab74>] (kasan_report+0x248/0x390)
>>> [<c06cab74>] (kasan_report) from [<c06c94e8>] (__asan_load4+0x78/0xb4)
>>> [<c06c94e8>] (__asan_load4) from [<c06ddc24>] (zs_map_object+0xa4/0x2bc)
>>> [<c06ddc24>] (zs_map_object) from [<bf0bbbd8>] (zram_bvec_rw.constprop.2+0x324/0x8e4 [zram])
>>> [<bf0bbbd8>] (zram_bvec_rw.constprop.2 [zram]) from [<bf0bc3cc>] (zram_make_request+0x234/0x46c [zram])
>>> [<bf0bc3cc>] (zram_make_request [zram]) from [<c09aff9c>] (generic_make_request+0x304/0x63c)
>>> [<c09aff9c>] (generic_make_request) from [<c09b0320>] (submit_bio+0x4c/0x1c8)
>>> [<c09b0320>] (submit_bio) from [<c0743570>] (submit_bh_wbc.constprop.15+0x238/0x26c)
>>> [<c0743570>] (submit_bh_wbc.constprop.15) from [<c0746cf8>] (__block_write_full_page+0x524/0x76c)
>>> [<c0746cf8>] (__block_write_full_page) from [<c07472c4>] (block_write_full_page+0x1bc/0x1d4)
>>> [<c07472c4>] (block_write_full_page) from [<c0748eb4>] (blkdev_writepage+0x24/0x28)
>>> [<c0748eb4>] (blkdev_writepage) from [<c064a780>] (__writepage+0x44/0x78)
>>> [<c064a780>] (__writepage) from [<c064b50c>] (write_cache_pages+0x3b8/0x800)
>>> [<c064b50c>] (write_cache_pages) from [<c064dd78>] (generic_writepages+0x74/0xa0)
>>> [<c064dd78>] (generic_writepages) from [<c0748e64>] (blkdev_writepages+0x18/0x1c)
>>> [<c0748e64>] (blkdev_writepages) from [<c064e890>] (do_writepages+0x68/0x134)
>>> [<c064e890>] (do_writepages) from [<c06368a4>] (__filemap_fdatawrite_range+0xb0/0xf4)
>>> [<c06368a4>] (__filemap_fdatawrite_range) from [<c0636b68>] (file_write_and_wait_range+0x64/0xd0)
>>> [<c0636b68>] (file_write_and_wait_range) from [<c0747af8>] (blkdev_fsync+0x54/0x84)
>>> [<c0747af8>] (blkdev_fsync) from [<c0739dac>] (vfs_fsync_range+0x70/0xd4)
>>> [<c0739dac>] (vfs_fsync_range) from [<c0739e98>] (do_fsync+0x4c/0x80)
>>> [<c0739e98>] (do_fsync) from [<c073a26c>] (sys_fsync+0x1c/0x20)
>>> [<c073a26c>] (sys_fsync) from [<c0401000>] (ret_fast_syscall+0x0/0x2c)
>>>
>>> when trying to decode (the pfn) and map the object.
>>>
>>> That happens because one architecture might not re-define
>>> MAX_PHYSMEM_BITS, like in this ARM 32-bit w/ LPAE enabled example. For
>>> 32-bit systems, if not re-defined, MAX_POSSIBLE_PHYSMEM_BITS will
>>> default to BITS_PER_LONG (32) in most cases, and, with PAE enabled,
>>> _PFN_BITS might be wrong: which may cause obj variable to overflow if
>>> frame number is in HIGHMEM and referencing a page above the 4GB
>>> watermark.
>>>
>>> commit 6e00ec00b1a7 ("staging: zsmalloc: calculate MAX_PHYSMEM_BITS if
>>> not defined") realized MAX_PHYSMEM_BITS depended on SPARSEMEM headers
>>> and "fixed" it by calculating it using BITS_PER_LONG if SPARSEMEM wasn't
>>> used, like in the example given above.
>>>
>>> Systems with potential for PAE exist for a long time and assuming
>>> BITS_PER_LONG seems inadequate. Defining MAX_PHYSMEM_BITS looks better,
>>> however it is NOT a constant anymore for x86.
>>>
>>> SO, instead, MAX_POSSIBLE_PHYSMEM_BITS should be defined by every
>>> architecture using zsmalloc, together with a sanity check for
>>> MAX_POSSIBLE_PHYSMEM_BITS being too big on 32-bit systems.
>>>
>>> Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
>>> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
>>> ---
>>>  arch/arm/include/asm/pgtable-2level-types.h |  2 ++
>>>  arch/arm/include/asm/pgtable-3level-types.h |  2 ++
>>>  arch/arm64/include/asm/pgtable-types.h      |  2 ++
>>>  arch/ia64/include/asm/page.h                |  2 ++
>>>  arch/mips/include/asm/page.h                |  2 ++
>>>  arch/powerpc/include/asm/mmu.h              |  2 ++
>>>  arch/s390/include/asm/page.h                |  2 ++
>>>  arch/sh/include/asm/page.h                  |  2 ++
>>>  arch/sparc/include/asm/page_32.h            |  2 ++
>>>  arch/sparc/include/asm/page_64.h            |  2 ++
>>>  arch/x86/include/asm/pgtable-2level_types.h |  2 ++
>>>  arch/x86/include/asm/pgtable-3level_types.h |  3 +-
>>>  arch/x86/include/asm/pgtable_64_types.h     |  4 +--
>>>  mm/zsmalloc.c                               | 35 +++++++++++----------
>>>  14 files changed, 45 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
>>> index 66cb5b0e89c5..552dba411324 100644
>>> --- a/arch/arm/include/asm/pgtable-2level-types.h
>>> +++ b/arch/arm/include/asm/pgtable-2level-types.h
>>> @@ -64,4 +64,6 @@ typedef pteval_t pgprot_t;
>>>  #endif /* STRICT_MM_TYPECHECKS */
>>> +#define MAX_POSSIBLE_PHYSMEM_BITS 32
>>> +
>>>  #endif	/* _ASM_PGTABLE_2LEVEL_TYPES_H */
>>> diff --git a/arch/arm/include/asm/pgtable-3level-types.h b/arch/arm/include/asm/pgtable-3level-types.h
>>> index 921aa30259c4..664c39e6517c 100644
>>> --- a/arch/arm/include/asm/pgtable-3level-types.h
>>> +++ b/arch/arm/include/asm/pgtable-3level-types.h
>>> @@ -67,4 +67,6 @@ typedef pteval_t pgprot_t;
>>>  #endif	/* STRICT_MM_TYPECHECKS */
>>> +#define MAX_POSSIBLE_PHYSMEM_BITS 36
>>
>> Nit: with LPAE, physical addresses go up to 40 bits, not just 36.

Hum, I got it from where it was being defined when having SPARSEMEM
enabled (#define MAX_PHYSMEM_BITS 36 in
arch/arm/include/asm/sparsemem.h), since without SPARSEMEM it would
default to BITS_PER_LONG.

> Right, with that set at 40, we get:
> 
> #define _PFN_BITS               (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
> 
> == 28
> 
> #define OBJ_TAG_BITS 1
> #define OBJ_INDEX_BITS  (BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
> 
> == 3
> 
> #define ZS_MAX_ZSPAGE_ORDER 2
> #define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
> 
> == 4
> 
> #define ZS_MIN_ALLOC_SIZE \
>         MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
> 
> == 4 << 12 >> 3 = 2048
> 
> or half-page allocations.
> 
> Given this in Documentation/vm/zsmalloc.rst:
> 
> On the other hand, if we just use single
> (0-order) pages, it would suffer from very high fragmentation --
> any object of size PAGE_SIZE/2 or larger would occupy an entire page.
> This was one of the major issues with its predecessor (xvmalloc).
> 
> It seems that would not be acceptable, so I have to ask whether
> using an unsigned long to store PFN + object ID is really acceptable.
> Maybe the real solution to this problem is to stop using an
> unsigned long to contain both the PFN and object ID?
> 
