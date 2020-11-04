Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C1C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 09:46:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC1C2068E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 09:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC1C2068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CR1xz2TBGzDqZX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 20:46:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=osalvador@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CR1t00sCjzDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2020 20:43:00 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 268ECAF16;
 Wed,  4 Nov 2020 09:42:58 +0000 (UTC)
Date: Wed, 4 Nov 2020 10:42:55 +0100
From: osalvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 2/4] powerpc/mm: print warning in
 arch_remove_linear_mapping()
Message-ID: <20201104094255.GA4981@localhost.localdomain>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029162718.29910-3-david@redhat.com>
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
Cc: Michal Hocko <mhocko@suse.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 29, 2020 at 05:27:16PM +0100, David Hildenbrand wrote:
> Let's print a warning similar to in arch_add_linear_mapping() instead of
> WARN_ON_ONCE() and eventually crashing the kernel.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Rashmica Gupta <rashmica.g@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/mm/mem.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 8a86d81f8df0..685028451dd2 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -145,7 +145,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
>  	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
>  
>  	ret = remove_section_mapping(start, start + size);
> -	WARN_ON_ONCE(ret);
> +	if (ret)
> +		pr_warn("Unable to remove linear mapping for 0x%llx..0x%llx: %d\n",
> +			start, start + size, ret);

I guess the fear is to panic on systems that do have panic_on_warn (not
sure how many productions systems have this out there).
But anyway, being coherent with that, I think you should remove the WARN_ON
in hash__remove_section_mapping as well.

Besides that:

Reviewed-by: Oscar Salvador <osalvador@suse.

Not sure if the functions below that also have any sort of WARN_ON.
native_hpte_removebolted has a VM_WARN_ON, but that is on
CONFIG_DEBUG_VM so does not really matter.


-- 
Oscar Salvador
SUSE L3
