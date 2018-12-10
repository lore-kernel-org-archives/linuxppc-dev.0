Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D48C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09B920672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gYUdTEfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09B920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D62g5DyKzDqyj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:10:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gYUdTEfJ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="gYUdTEfJ"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D5zw2rZ6zDqtv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 02:08:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GuqSKY6uJELXXF4HdEubR423WKhWObkR4oB3tErzw4=; b=gYUdTEfJbSUBmsBE8nBM8nCXI
 ehWFi+KCqX9/X+yiYcFB05r3owBJAkfefmmEcUIkZ0awi1CHwsnVjeh+Udds3OJNLz+zQX6EpRC0X
 o5iV250ikzdnioI2yfnPJF4qAVLc6ziphzse9y8+2uw4J9JVCLToHtUo6a+xOughG4NEk=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:56510)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gWN8B-0000wU-3P; Mon, 10 Dec 2018 15:05:59 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gWN86-0002sP-4I; Mon, 10 Dec 2018 15:05:54 +0000
Date: Mon, 10 Dec 2018 15:05:51 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Message-ID: <20181210150551.GE30658@n2100.armlinux.org.uk>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <4da655ec-a1ac-c524-1eb4-5cbd18b265ef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da655ec-a1ac-c524-1eb4-5cbd18b265ef@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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

On Mon, Dec 10, 2018 at 02:35:55PM +0000, Robin Murphy wrote:
> On 10/12/2018 14:21, Rafael David Tinoco wrote:
> >On 32-bit systems, zsmalloc uses HIGHMEM and, when PAE is enabled, the
> >physical frame number might be so big that zsmalloc obj encoding (to
> >location) will break, causing:
> >
> >BUG: KASAN: null-ptr-deref in zs_map_object+0xa4/0x2bc
> >Read of size 4 at addr 00000000 by task mkfs.ext4/623
> >CPU: 2 PID: 623 Comm: mkfs.ext4 Not tainted 4.19.0-rc8-00017-g8239bc6d3307-dirty #15
> >Hardware name: Generic DT based system
> >[<c0418f7c>] (unwind_backtrace) from [<c0410ca4>] (show_stack+0x20/0x24)
> >[<c0410ca4>] (show_stack) from [<c16bd540>] (dump_stack+0xbc/0xe8)
> >[<c16bd540>] (dump_stack) from [<c06cab74>] (kasan_report+0x248/0x390)
> >[<c06cab74>] (kasan_report) from [<c06c94e8>] (__asan_load4+0x78/0xb4)
> >[<c06c94e8>] (__asan_load4) from [<c06ddc24>] (zs_map_object+0xa4/0x2bc)
> >[<c06ddc24>] (zs_map_object) from [<bf0bbbd8>] (zram_bvec_rw.constprop.2+0x324/0x8e4 [zram])
> >[<bf0bbbd8>] (zram_bvec_rw.constprop.2 [zram]) from [<bf0bc3cc>] (zram_make_request+0x234/0x46c [zram])
> >[<bf0bc3cc>] (zram_make_request [zram]) from [<c09aff9c>] (generic_make_request+0x304/0x63c)
> >[<c09aff9c>] (generic_make_request) from [<c09b0320>] (submit_bio+0x4c/0x1c8)
> >[<c09b0320>] (submit_bio) from [<c0743570>] (submit_bh_wbc.constprop.15+0x238/0x26c)
> >[<c0743570>] (submit_bh_wbc.constprop.15) from [<c0746cf8>] (__block_write_full_page+0x524/0x76c)
> >[<c0746cf8>] (__block_write_full_page) from [<c07472c4>] (block_write_full_page+0x1bc/0x1d4)
> >[<c07472c4>] (block_write_full_page) from [<c0748eb4>] (blkdev_writepage+0x24/0x28)
> >[<c0748eb4>] (blkdev_writepage) from [<c064a780>] (__writepage+0x44/0x78)
> >[<c064a780>] (__writepage) from [<c064b50c>] (write_cache_pages+0x3b8/0x800)
> >[<c064b50c>] (write_cache_pages) from [<c064dd78>] (generic_writepages+0x74/0xa0)
> >[<c064dd78>] (generic_writepages) from [<c0748e64>] (blkdev_writepages+0x18/0x1c)
> >[<c0748e64>] (blkdev_writepages) from [<c064e890>] (do_writepages+0x68/0x134)
> >[<c064e890>] (do_writepages) from [<c06368a4>] (__filemap_fdatawrite_range+0xb0/0xf4)
> >[<c06368a4>] (__filemap_fdatawrite_range) from [<c0636b68>] (file_write_and_wait_range+0x64/0xd0)
> >[<c0636b68>] (file_write_and_wait_range) from [<c0747af8>] (blkdev_fsync+0x54/0x84)
> >[<c0747af8>] (blkdev_fsync) from [<c0739dac>] (vfs_fsync_range+0x70/0xd4)
> >[<c0739dac>] (vfs_fsync_range) from [<c0739e98>] (do_fsync+0x4c/0x80)
> >[<c0739e98>] (do_fsync) from [<c073a26c>] (sys_fsync+0x1c/0x20)
> >[<c073a26c>] (sys_fsync) from [<c0401000>] (ret_fast_syscall+0x0/0x2c)
> >
> >when trying to decode (the pfn) and map the object.
> >
> >That happens because one architecture might not re-define
> >MAX_PHYSMEM_BITS, like in this ARM 32-bit w/ LPAE enabled example. For
> >32-bit systems, if not re-defined, MAX_POSSIBLE_PHYSMEM_BITS will
> >default to BITS_PER_LONG (32) in most cases, and, with PAE enabled,
> >_PFN_BITS might be wrong: which may cause obj variable to overflow if
> >frame number is in HIGHMEM and referencing a page above the 4GB
> >watermark.
> >
> >commit 6e00ec00b1a7 ("staging: zsmalloc: calculate MAX_PHYSMEM_BITS if
> >not defined") realized MAX_PHYSMEM_BITS depended on SPARSEMEM headers
> >and "fixed" it by calculating it using BITS_PER_LONG if SPARSEMEM wasn't
> >used, like in the example given above.
> >
> >Systems with potential for PAE exist for a long time and assuming
> >BITS_PER_LONG seems inadequate. Defining MAX_PHYSMEM_BITS looks better,
> >however it is NOT a constant anymore for x86.
> >
> >SO, instead, MAX_POSSIBLE_PHYSMEM_BITS should be defined by every
> >architecture using zsmalloc, together with a sanity check for
> >MAX_POSSIBLE_PHYSMEM_BITS being too big on 32-bit systems.
> >
> >Link: https://bugs.linaro.org/show_bug.cgi?id=3765#c17
> >Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> >---
> >  arch/arm/include/asm/pgtable-2level-types.h |  2 ++
> >  arch/arm/include/asm/pgtable-3level-types.h |  2 ++
> >  arch/arm64/include/asm/pgtable-types.h      |  2 ++
> >  arch/ia64/include/asm/page.h                |  2 ++
> >  arch/mips/include/asm/page.h                |  2 ++
> >  arch/powerpc/include/asm/mmu.h              |  2 ++
> >  arch/s390/include/asm/page.h                |  2 ++
> >  arch/sh/include/asm/page.h                  |  2 ++
> >  arch/sparc/include/asm/page_32.h            |  2 ++
> >  arch/sparc/include/asm/page_64.h            |  2 ++
> >  arch/x86/include/asm/pgtable-2level_types.h |  2 ++
> >  arch/x86/include/asm/pgtable-3level_types.h |  3 +-
> >  arch/x86/include/asm/pgtable_64_types.h     |  4 +--
> >  mm/zsmalloc.c                               | 35 +++++++++++----------
> >  14 files changed, 45 insertions(+), 19 deletions(-)
> >
> >diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
> >index 66cb5b0e89c5..552dba411324 100644
> >--- a/arch/arm/include/asm/pgtable-2level-types.h
> >+++ b/arch/arm/include/asm/pgtable-2level-types.h
> >@@ -64,4 +64,6 @@ typedef pteval_t pgprot_t;
> >  #endif /* STRICT_MM_TYPECHECKS */
> >+#define MAX_POSSIBLE_PHYSMEM_BITS 32
> >+
> >  #endif	/* _ASM_PGTABLE_2LEVEL_TYPES_H */
> >diff --git a/arch/arm/include/asm/pgtable-3level-types.h b/arch/arm/include/asm/pgtable-3level-types.h
> >index 921aa30259c4..664c39e6517c 100644
> >--- a/arch/arm/include/asm/pgtable-3level-types.h
> >+++ b/arch/arm/include/asm/pgtable-3level-types.h
> >@@ -67,4 +67,6 @@ typedef pteval_t pgprot_t;
> >  #endif	/* STRICT_MM_TYPECHECKS */
> >+#define MAX_POSSIBLE_PHYSMEM_BITS 36
> 
> Nit: with LPAE, physical addresses go up to 40 bits, not just 36.

Right, with that set at 40, we get:

#define _PFN_BITS               (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)

== 28

#define OBJ_TAG_BITS 1
#define OBJ_INDEX_BITS  (BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)

== 3

#define ZS_MAX_ZSPAGE_ORDER 2
#define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)

== 4

#define ZS_MIN_ALLOC_SIZE \
        MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))

== 4 << 12 >> 3 = 2048

or half-page allocations.

Given this in Documentation/vm/zsmalloc.rst:

On the other hand, if we just use single
(0-order) pages, it would suffer from very high fragmentation --
any object of size PAGE_SIZE/2 or larger would occupy an entire page.
This was one of the major issues with its predecessor (xvmalloc).

It seems that would not be acceptable, so I have to ask whether
using an unsigned long to store PFN + object ID is really acceptable.
Maybe the real solution to this problem is to stop using an
unsigned long to contain both the PFN and object ID?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
