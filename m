Return-Path: <SRS0=/PaX=OY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F9BC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 00:15:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6F8206A2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 00:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j532HYtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6F8206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GnxL0THczDrQH
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 11:15:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="j532HYtx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="j532HYtx"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Gnth3F4bzDrQ7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 11:13:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MYI4FR5Cx0ahm+Z7P280dKZ4U23RIOi/IfMmiaZjC/c=; b=j532HYtx+JMvZhYmY787A9Cdfu
 tHthA7l/a9a9NkKJ3KxTsp8uCG2D02VPr8JXualNRtAkClmfPEZBT1OyAT2+33s5eFHBLCs8F7szG
 UTE08jcEZlhB39NJawElRkFoibNzo2wpryBcwsa//tGQd5NDnhhRRqC7nEpVlakK7lj43NTa8K0nC
 HYfrJHH7c0H9LqBFr2aWoKIxJqox3Wjx8nWNpDnQ8kPD4tCvKXEtBWGRXtCbU/Zxs21Qo4ePW2ja7
 xzf7StXFwPXcgAFqieyqfgfFMndv7XN2oV09vFwQKsvCEP8CUIeOWQDX5msNTirSDXluE3c1OPMAz
 LcE34k8w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXxZB-0007Tg-2V; Sat, 15 Dec 2018 00:12:25 +0000
Subject: Re: [PATCH v1 9/9] mm: better document PG_reserved
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
References: <20181214111014.15672-1-david@redhat.com>
 <20181214111014.15672-10-david@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <03f65c6f-1287-4c63-6705-16e58d659d94@infradead.org>
Date: Fri, 14 Dec 2018 16:12:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181214111014.15672-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Pavel Tatashin <pasha.tatashin@oracle.com>, yi.z.zhang@linux.intel.com,
 linux-m68k@lists.linux-m68k.org, linux-mediatek@lists.infradead.org,
 Miles Chen <miles.chen@mediatek.com>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/14/18 3:10 AM, David Hildenbrand wrote:
> The usage of PG_reserved and how PG_reserved pages are to be treated is
> buried deep down in different parts of the kernel. Let's shine some light
> onto these details by documenting current users and expected
> behavior.
> 
> Especially, clarify on the "Some of them might not even exist" case.
> These are physical memory gaps that will never be dumped as they
> are not marked as IORESOURCE_SYSRAM. PG_reserved does in general not
> hinder anybody from dumping or swapping. In some cases, these pages
> will not be stored in the hibernation image.

Hi,
Thanks for the doc update.
Comments below.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Anthony Yznaga <anthony.yznaga@oracle.com>
> Cc: Miles Chen <miles.chen@mediatek.com>
> Cc: yi.z.zhang@linux.intel.com
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/page-flags.h | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 808b4183e30d..9de2e941cbd5 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -17,8 +17,37 @@
>  /*
>   * Various page->flags bits:
>   *
> - * PG_reserved is set for special pages, which can never be swapped out. Some
> - * of them might not even exist...
> + * PG_reserved is set for special pages. The "struct page" of such a page
> + * should in general not be touched (e.g. set dirty) except by their owner.

                                                               by its owner.

> + * Pages marked as PG_reserved include:
> + * - Pages part of the kernel image (including vDSO) and similar (e.g. BIOS,
> + *   initrd, HW tables)
> + * - Pages reserved or allocated early during boot (before the page allocator
> + *   was initialized). This includes (depending on the architecture) the
> + *   initial vmmap, initial page tables, crashkernel, elfcorehdr, and much

                VM map,

> + *   much more. Once (if ever) freed, PG_reserved is cleared and they will
> + *   be given to the page allocator.
> + * - Pages falling into physical memory gaps - not IORESOURCE_SYSRAM. Trying
> + *   to read/write these pages might end badly. Don't touch!
> + * - The zero page(s)
> + * - Pages not added to the page allocator when onlining a section because
> + *   they were excluded via the online_page_callback() or because they are
> + *   PG_hwpoison.
> + * - Pages allocated in the context of kexec/kdump (loaded kernel image,
> + *   control pages, vmcoreinfo)
> + * - MMIO/DMA pages. Some architectures don't allow to ioremap pages that are
> + *   not marked PG_reserved (as they might be in use by somebody else who does
> + *   not respect the caching strategy).
> + * - Pages part of an offline section (struct pages of offline sections should
> + *   not be trusted as they will be initialized when first onlined).
> + * - MCA pages on ia64
> + * - Pages holding CPU notes for POWER Firmware Assisted Dump
> + * - Device memory (e.g. PMEM, DAX, HMM)
> + * Some PG_reserved pages will be excluded from the hibernation image.
> + * PG_reserved does in general not hinder anybody from dumping or swapping
> + * and is no longer required for remap_pfn_range(). ioremap might require it.
> + * Consequently, PG_reserved for a page mapped into user space can indicate
> + * the zero page, the vDSO, MMIO pages or device memory.
>   *
>   * The PG_private bitflag is set on pagecache pages if they contain filesystem
>   * specific data (which is normally at page->private). It can be used by
> 

cheers.
-- 
~Randy
