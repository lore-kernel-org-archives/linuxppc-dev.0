Return-Path: <linuxppc-dev+bounces-19699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270B9F34C52
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 14:00:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvTZ34jJVz2ydn;
	Tue, 14 Apr 2026 00:00:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=58.251.27.85
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776085788;
	cv=none; b=eWNkjL5DOJdvEEgqEI7iauYZslurhALTlclieufhNoztaC6vcfMf/a8HY0TMrUvyQmLSgtdVH9RN4Vrp+JD/nkGLz7GcNydIaKqsHIVOvcAsE7yz5KT2B4yE69KopdmohZUy8MCnLKq/JwXloPHhgNFT0a9PkZpVBM1Q73fVaWviBeRiIvpGeoP180RG7pjWtbIOQ9wQKSwtpxJMxu7IYf/CmXnxZ3PU9ZTJq+7WWMlnfh66yNAQ1Nq5evAKvFfo4RI1VsxFvtob3cDZsVM+LnNkxNTy9HLX1XXeJgbyHzIt0L3PXkkcx4w0PYDNQLdoPYQFSxnEjDQi2sqe7Sox1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776085788; c=relaxed/relaxed;
	bh=4Q6hbO5VXAAEYtqFBS/tjKRelFU1z4l+PdprfQ8isB4=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=FF6c+/RtbzAj7sDWh1MgMXR7J91vQgyzTHF+0V908TZMWu7TUikNCUAOGhHdcQ9wKAIBFLInBJRaf3Dc7YM3eGSZROxbYboq19nBpCFdX7rVlnw4FYrbXg+w/7lmcVAlrWbyAptmcERJuzkH6jGKhjGr0PCDNltspPLPolUypv6jVNoiuNs//VXSMRWIZx1PHDzOmp16s7dX9Kmg0AtlqNNnzSKotkQsYzahrm0SZTL3h3dRg22qQmcEssJs/XkkRSo9Hff0XF/FdCK9pJtWlAkjb+bqXkWtsJlJfEMi2vh91G+U68Z99aytBBpXkXuLypwrpVe4ddT1SJSG8FdZgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass (client-ip=58.251.27.85; helo=mxct.zte.com.cn; envelope-from=hu.shengming@zte.com.cn; receiver=lists.ozlabs.org) smtp.mailfrom=zte.com.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zte.com.cn (client-ip=58.251.27.85; helo=mxct.zte.com.cn; envelope-from=hu.shengming@zte.com.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 386 seconds by postgrey-1.37 at boromir; Mon, 13 Apr 2026 23:09:47 AEST
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvSRv3P9pz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:09:46 +1000 (AEST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fvSJL6XM3z1DDv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:03:14 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4fvSJF25F6z5TCG0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:03:09 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fvSJ26Vzyz8Xs70;
	Mon, 13 Apr 2026 21:02:58 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 63DD2n3P010875;
	Mon, 13 Apr 2026 21:02:49 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 13 Apr 2026 21:02:52 +0800 (CST)
X-Zmail-TransId: 2af969dce97c49e-2c715
X-Mailer: Zmail v1.0
Message-ID: <20260413210252672ZfdcegJLJtyvlYdFAUBlr@zte.com.cn>
In-Reply-To: <adyyNeVTkXQlnh_2@hyeyoo>
References: 20260410120044.031381086@kernel.org,20260410120318.525653921@kernel.org,adyyNeVTkXQlnh_2@hyeyoo
Date: Mon, 13 Apr 2026 21:02:52 +0800 (CST)
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
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <vbabka@kernel.org>,
        <linux-mm@kvack.org>, <arnd@arndb.de>, <x86@kernel.org>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <m.grzeschik@pengutronix.de>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <dwmw2@infradead.org>,
        <bernie@plugable.com>, <linux-fbdev@vger.kernel.org>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>, <akpm@linux-foundation.org>,
        <urezki@gmail.com>, <elver@google.com>, <dvyukov@google.com>,
        <kasan-dev@googlegroups.com>, <ryabinin.a.a@gmail.com>,
        <t.sailer@alumni.ethz.ch>, <linux-hams@vger.kernel.org>,
        <Jason@zx2c4.com>, <richard.henderson@linaro.org>,
        <linux-alpha@vger.kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <chenhuacai@kernel.org>, <loongarch@lists.linux.dev>,
        <geert@linux-m68k.org>, <linux-m68k@lists.linux-m68k.org>,
        <dinguyen@kernel.org>, <jonas@southpole.se>,
        <linux-openrisc@vger.kernel.org>, <deller@gmx.de>,
        <linux-parisc@vger.kernel.org>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <pjw@kernel.org>,
        <linux-riscv@lists.infradead.org>, <hca@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, <hao.li@linux.dev>, <cl@gentwo.org>,
        <rientjes@google.com>, <roman.gushchin@linux.dev>
Subject: =?UTF-8?B?UmU6IFtwYXRjaCAxNC8zOF0gc2x1YjogVXNlIHByYW5kb20gaW5zdGVhZCBvZiBnZXRfY3ljbGVzKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 63DD2n3P010875
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.35.20.165 unknown Mon, 13 Apr 2026 21:03:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69DCE991.000/4fvSJL6XM3z1DDv

Harry wrote:
> [Resending after fixing broken email headers]
> 
> On Fri, Apr 10, 2026 at 02:19:37PM +0200, Thomas Gleixner wrote:
> > The decision whether to scan remote nodes is based on a 'random' number
> > retrieved via get_cycles(). get_cycles() is about to be removed.
> > 
> > There is already prandom state in the code, so use that instead.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: linux-mm@kvack.org
> > ---
> 
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
> 
> Is this for this merge window?
> 
> This may conflict with upcoming changes on freelist shuffling [1]
> (not queued for slab/for-next yet though), but it should be easy to
> resolve.
> 

Hi Harry,

Would you like me to wait for this patch to land linux-next and then
rebase and send v6 on top?

Thanks,

--
With Best Regards,
Shengming

> [Cc'ing Shengming and SLAB ALLOCATOR folks]
> [1] https://lore.kernel.org/linux-mm/20260409204352095kKWVYKtZImN59ybO6iRNj@zte.com.cn
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 
> >  mm/slub.c |   37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3302,6 +3302,25 @@ static inline struct slab *alloc_slab_pa
> >      return slab;
> >  }
> >  
> > +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
> > +static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> > +
> > +static unsigned int slab_get_prandom_state(unsigned int limit)
> > +{
> > +    struct rnd_state *state;
> > +    unsigned int res;
> > +
> > +    /*
> > +     * An interrupt or NMI handler might interrupt and change
> > +     * the state in the middle, but that's safe.
> > +     */
> > +    state = &get_cpu_var(slab_rnd_state);
> > +    res = prandom_u32_state(state) % limit;
> > +    put_cpu_var(slab_rnd_state);
> > +    return res;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_SLAB_FREELIST_RANDOM
> >  /* Pre-initialize the random sequence cache */
> >  static int init_cache_random_seq(struct kmem_cache *s)
> > @@ -3365,8 +3384,6 @@ static void *next_freelist_entry(struct
> >      return (char *)start + idx;
> >  }
> >  
> > -static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> > -
> >  /* Shuffle the single linked freelist based on a random pre-computed sequence */
> >  static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
> >                   bool allow_spin)
> > @@ -3383,15 +3400,7 @@ static bool shuffle_freelist(struct kmem
> >      if (allow_spin) {
> >          pos = get_random_u32_below(freelist_count);
> >      } else {
> > -        struct rnd_state *state;
> > -
> > -        /*
> > -         * An interrupt or NMI handler might interrupt and change
> > -         * the state in the middle, but that's safe.
> > -         */
> > -        state = &get_cpu_var(slab_rnd_state);
> > -        pos = prandom_u32_state(state) % freelist_count;
> > -        put_cpu_var(slab_rnd_state);
> > +        pos = slab_get_prandom_state(freelist_count);
> >      }
> >  
> >      page_limit = slab->objects * s->size;
> > @@ -3882,7 +3891,7 @@ static void *get_from_any_partial(struct
> >       * with available objects.
> >       */
> >      if (!s->remote_node_defrag_ratio ||
> > -            get_cycles() % 1024 > s->remote_node_defrag_ratio)
> > +        slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
> >          return NULL;
> >  
> >      do {
> > @@ -7102,7 +7111,7 @@ static unsigned int
> >  
> >      /* see get_from_any_partial() for the defrag ratio description */
> >      if (!s->remote_node_defrag_ratio ||
> > -            get_cycles() % 1024 > s->remote_node_defrag_ratio)
> > +        slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
> >          return 0;
> >  
> >      do {
> > @@ -8421,7 +8430,7 @@ void __init kmem_cache_init_late(void)
> >      flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
> >                    0);
> >      WARN_ON(!flushwq);
> > -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> > +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
> >      prandom_init_once(&slab_rnd_state);
> >  #endif
> >  }
> > 
> >

