Return-Path: <linuxppc-dev+bounces-24049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F877C43458
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Jul 2026 16:45:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyF1d0GV1z2xlZ;
	Sun, 12 Jul 2026 02:45:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783788324;
	cv=none; b=RTN7u0ed3EvOK1qTwHmJDd2NpCWP/8HpVqr7mjAdJ22lWtrnv4ED7oVlkTf/R1mfEf5Yhee951ueACOE1ope89qv5A299FT4beyCMsM247JhpWLCn2pDPcUtDhkR1RgqxSL/7PGssHJRSXVQ7iqjKgxEdOYoGnCe43FDgw9ous/nQlHQhuownou9x2rCSyXCImPRt2+xe6es0UFIhdXnvik4Qp4KAITlR2Tz0LWqBRQl4ora+MBEd1UTgE2ANmtq/ncYMxlVsoNC5TitcagHCjQmj58XcLQWPlXFOCZLe8J1/nDmC0TRvY787YsLjXneRWH71itmnfm6uVqvhqaIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783788324; c=relaxed/relaxed;
	bh=wyycO0T/E4ygtisRzkqVLShoTPRgxuh1j7TtfC7wXl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dzl4eUaSF3V2c2EWCvTYQ42+0hQbWsbi2UVR53Y679jAAURRGgEpK2BpxeuOKrh3p93yq388RMcfLcoTvrvNn9B0+3khrUuceYxj+wQfCDpuWAzTvhgvc6w4UQQYhkOBC97vFCr0x0cI3V3P0WLS7/hNaU3uwZVe80kWlvyaQW4QRzjiPSkwpTbTgXGJta0a1HiHAtMV3fw5feRu6b31vZieTCf7p5OjPo4EmSVcKcHFLqH7cjsQLc2XQh/JOgU8S1PBC1Z3XthxyUc56dq/lp5+nb5+62+qB5grTyjpE4SWsi3HuCGyR7DprJvEopkMg9+nswitA+cwNvtQPQWIKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQeTQQM7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQeTQQM7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gyF1b6GjTz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 02:45:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C698560052;
	Sat, 11 Jul 2026 16:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368D01F000E9;
	Sat, 11 Jul 2026 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783788320;
	bh=wyycO0T/E4ygtisRzkqVLShoTPRgxuh1j7TtfC7wXl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQeTQQM7/zogPNVpPumivekv/Dm65tJwKSGkKyUaN15OK2ePQoOxgmoczQXNeufyu
	 mPB2SeO/+jaR+zlJiyLVdyWAwHg7D0CKx8xMhyA5MDEdHDSR6TPUNUJn+Nzb/es+VO
	 1AGLLXVLTi7PuZQkYtNin4NBM5SzIQlt5sWd9Tt0MOCtyaJ26niLtZLm/iWL4WgjoE
	 nytqWs/CMB6G26FmrITyykLrDBQPn0ehby972yRXsbQJ2wOYF8M/bvBoXBfucUYQHe
	 8/x2mtOwd5qD3Tv70Taj9RQTidlVV5lxGicVGK4dGGf0RiLlLhHP5bQmNpx1vNrQvn
	 rYrD/ste49T1Q==
Date: Sat, 11 Jul 2026 17:44:53 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, l.stach@pengutronix.de, inki.dae@samsung.com, 
	sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org, 
	peter.griffin@linaro.org, jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com, 
	rodrigo.vivi@intel.com, tursulin@ursulin.net, robin.clark@oss.qualcomm.com, 
	lumag@kernel.org, lyude@redhat.com, dakr@kernel.org, 
	tomi.valkeinen@ideasonboard.com, hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
	thierry.reding@kernel.org, mperttunen@nvidia.com, jonathanh@nvidia.com, kraxel@redhat.com, 
	dmitry.osipenko@collabora.com, zack.rusin@broadcom.com, matthew.brost@intel.com, 
	thomas.hellstrom@linux.intel.com, oleksandr_andrushchenko@epam.com, deller@gmx.de, bcrl@kvack.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
	david@kernel.org, baolin.wang@linux.alibaba.com, liam@infradead.org, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	hughd@google.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jannh@google.com, pfalcato@suse.de, kees@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, linux-fbdev@vger.kernel.org, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 10/13] mm/vma: convert miscellaneous uses of VMA flags in
 core mm
Message-ID: <alJydQjYgboxmizG@lucifer>
References: <1e7d834c887b6a65627d730addcff13d458c6268.1782760670.git.ljs@kernel.org>
 <20260702131233.59026-1-lance.yang@linux.dev>
 <akaGxiTaJreEQn8T@lucifer>
 <DJTNXVOWGWJ4.3MDNLPMY0Y3RF@nvidia.com>
 <alJqjo_MZCFWj3Wt@lucifer>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alJqjo_MZCFWj3Wt@lucifer>

On Sat, Jul 11, 2026 at 05:23:39PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 08, 2026 at 09:52:19PM -0400, Zi Yan wrote:
> > On Thu Jul 2, 2026 at 11:46 AM EDT, Lorenzo Stoakes wrote:
> > > On Thu, Jul 02, 2026 at 09:12:33PM +0800, Lance Yang wrote:
> > >>
> > >> On Mon, Jun 29, 2026 at 08:25:33PM +0100, Lorenzo Stoakes wrote:
> > >> >Update various uses of legacy flags in vma.c and mmap.c to the new
> > >> >vma_flags_t type, updating comments alongside them to be consistent.
> > >> >
> > >> >Also update __install_special_mapping() to rearrange things slightly to
> > >> >accommodate the changes.
> > >> >
> > >> >Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > >> >---
> > >> [...]
> > >> >diff --git a/mm/vma.c b/mm/vma.c
> > >> >index b81c05e67a61..ab2ef0f04420 100644
> > >> >--- a/mm/vma.c
> > >> >+++ b/mm/vma.c
> > >> >@@ -3417,23 +3417,27 @@ struct vm_area_struct *__install_special_mapping(
> > >> > 	vm_flags_t vm_flags, void *priv,
> > >> > 	const struct vm_operations_struct *ops)
> > >> > {
> > >> >-	int ret;
> > >> >+	vma_flags_t vma_flags = legacy_to_vma_flags(vm_flags);
> > >> > 	struct vm_area_struct *vma;
> > >> >+	int ret;
> > >> >
> > >> > 	vma = vm_area_alloc(mm);
> > >> >-	if (unlikely(vma == NULL))
> > >> >+	if (unlikely(!vma))
> > >> > 		return ERR_PTR(-ENOMEM);
> > >> >
> > >> >-	vma_set_range(vma, addr, addr + len, 0);
> > >> >-	vm_flags |= vma_flags_to_legacy(mm->def_vma_flags) | VM_DONTEXPAND;
> > >> >+	vma_flags_set_mask(&vma_flags, mm->def_vma_flags);
> > >> >+	vma_flags_set(&vma_flags, VMA_DONTEXPAND_BIT);
> > >> > 	if (pgtable_supports_soft_dirty())
> > >> >-		vm_flags |= VM_SOFTDIRTY;
> > >> >-	vm_flags_init(vma, vm_flags & ~VM_LOCKED_MASK);
> > >> >+		vma_flags_set(&vma_flags, VMA_SOFTDIRTY_BIT);
> > >> >+	vma_flags_clear_mask(&vma_flags, VMA_LOCKED_MASK);
> > >> >+	vma->flags = vma_flags;
> > >>
> > >> Maybe worth a vma_flags_init() helper here to mirror vm_flags_init()?
> > >> With this open-coded, we lose the soft-dirty WARN_ON_ONCE sanity check.
> > >>
> > >> Might be nicer to keep that check in one place ;)
> > >
> > > I really hate all the VMA flag accessors, they conflate things horribly - we
> > > should be explicitly taking VMA write locks when we need to (and often killable
> > > ones actually) not assuming that a VMA flags accessor does (they should at most
> > > assert).
> > >
> > > This case is even more terribly egregious - you are setting flags at an
> > > arbitrary time, why are we asserting something about softdirty?
> > >
> > > You may update them as part of initialisation, maybe not. It's far from a
> > > guarantee and feels like a lazy place to put it.
> > >
> > > BUT obviously it's an oversight not to open code that here, so I'll update the
> > > patch to do that!
> >
> > What do you want to open code here? softdirty WARN_ON_ONCE()?
>
> As you can tell I said this reflexively without checking the code :)
>
> >
> > vma_flags gets VMA_SOFTDIRTY_BIT just above vma->flags, why do we need a
> > check after that?
>
> And yeah it's completely unnecessary, indeed.
>
> >
> > BTW, if you think the check is needed, patch 9 will need to be updated,
> > since the same pattern appears in create_init_stack_vma().
>
> I'll check to see if it's valid there.

Exactly the same case as here, unnecessary :)

Cheers, LOrenzo

