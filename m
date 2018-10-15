Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B983C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 13:17:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F08A21916
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 13:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F08A21916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Lq192wGBzDrF0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 00:17:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Lpyp28jVzDqfB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 00:15:29 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9F0lDBk027228;
 Sun, 14 Oct 2018 19:47:15 -0500
Message-ID: <9cfe508c687068853a6e5e030962a78467a8d313.camel@kernel.crashing.org>
Subject: Re: [PATCH 01/33] powerpc: use mm zones more sensibly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 15 Oct 2018 11:47:13 +1100
In-Reply-To: <20181009132500.17643-2-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
 <20181009132500.17643-2-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-09 at 15:24 +0200, Christoph Hellwig wrote:
>   * Find the least restrictive zone that is entirely below the
> @@ -324,11 +305,14 @@ void __init paging_init(void)
>         printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>                (long int)((top_of_ram - total_ram) >> 20));
>  
> +#ifdef CONFIG_ZONE_DMA
> +       max_zone_pfns[ZONE_DMA] = min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
> +#endif
> +       max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
>  #ifdef CONFIG_HIGHMEM
> -       limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
> +       max_zone_pfns[ZONE_HIGHMEM] = max_pfn
                                               ^
Missing a  ";" here  --------------------------|

Sorry ... works with that fix on an old laptop with highmem.

>  #endif
> -       limit_zone_pfn(TOP_ZONE, top_of_ram >> PAGE_SHIFT);
> -       zone_limits_final = true;
> +
>         free_area_init_nodes(max_zone_pfns);
>  

