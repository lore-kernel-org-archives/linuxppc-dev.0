Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA82BC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 08:27:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC6623333
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 08:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC6623333
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gaisler.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DG0tv61vhzDq9T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 19:27:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gaisler.com (client-ip=195.74.38.227;
 helo=vsp-unauthed02.binero.net; envelope-from=andreas@gaisler.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gaisler.com
X-Greylist: delayed 914 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Jan 2021 19:01:03 AEDT
Received: from vsp-unauthed02.binero.net (vsp-unauthed02.binero.net
 [195.74.38.227])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DG0Hz6zMBzDqtp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 19:01:02 +1100 (AEDT)
X-Halon-ID: 27ebd293-5573-11eb-a076-005056917f90
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se
 [98.128.223.123])
 by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
 id 27ebd293-5573-11eb-a076-005056917f90;
 Wed, 13 Jan 2021 08:44:33 +0100 (CET)
Subject: Re: [patch 1/4] sparc/mm/highmem: Flush cache and TLB
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
References: <20210112170136.078559026@linutronix.de>
 <20210112170410.905976187@linutronix.de>
From: Andreas Larsson <andreas@gaisler.com>
Message-ID: <8a55c407-4fad-1a2f-5540-152e28b71617@gaisler.com>
Date: Wed, 13 Jan 2021 08:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112170410.905976187@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Peter Zijlstra <peterz@infradead.org>, Paul Cercueil <paul@crapouillou.net>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 2021-01-12 18:01, Thomas Gleixner wrote:
> The recent conversion to the generic kmap_local infrastructure failed to
> assign the proper pre/post map/unmap flush operations for sparc.
> 
> Sparc requires cache flush before map/unmap and tlb flush afterwards.
> 
> Fixes: 3293efa97807 ("sparc/mm/highmem: Switch to generic kmap atomic")
> Reported-by: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>   arch/sparc/include/asm/highmem.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/arch/sparc/include/asm/highmem.h
> +++ b/arch/sparc/include/asm/highmem.h
> @@ -50,10 +50,11 @@ extern pte_t *pkmap_page_table;
>   
>   #define flush_cache_kmaps()	flush_cache_all()
>   
> -/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
> -#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
> -#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
> -
> +/* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
> +#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
> +#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
> +#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
> +#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
>   
>   #endif /* __KERNEL__ */

Yes! I found, just an hour before your patched was posted, that an
equivalent fix helped back where the switch-to-generic patch first
occurred. This patch was successfully tested on master.

Tested-by: Andreas Larsson <andreas@gaisler.com>

-- 
Andreas Larsson
Cobham Gaisler
