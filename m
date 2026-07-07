Return-Path: <linuxppc-dev+bounces-23699-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F6C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 10:17:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvcbm38Xnz2xm3;
	Tue, 07 Jul 2026 20:17:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783419444;
	cv=none; b=EHWOaYv0wbvawDvNMBSH4kD9Y865M+SYPCvk/e2KTDvqCdcRi6M+XmwfMWYu11NcBYjs/Os36UuE0jsWEgg9ZBkgfOQonwnk4thBa8ncwNFlwzxejc8lTZd7pY8nK/FXh8Ow0nwuh8QJx3ndudjPZKwJwmqraGQXLtWtGDkNfDAEC+vcDrsrZmCUob2ZNxrIDE6uj8ZpIPmZLEGpn2Xmejc6CHVGpyeNK55D4M3J33xfZJI5dp+ncODCQtunU6J5w867ez3Tif4Uu4cCXlTRbKcY/XRHrdlCAscr9GrVPbnK/XA3yj63mBpSbpssgArBwjnZAbtKFeLSh1NFUrGLQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783419444; c=relaxed/relaxed;
	bh=mnyEnVNjUbkl63yjftBd6ZAUslZHuhLMLE5i1q1dbiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofp1bxTPTXFwA7FNLpAzflAHTV5LRhgEfW+qV9tyBGhoDTEBEFYUWJAOs+rm4IPiqLoVuVRQ+c9+EI9d1Zr6nb+d3sHqaQ5GPkSGzu3YGeblb824QjVf+wgNP7j5nkivZSQu20mgc2C4W40gyvzLPG5fa1tjd84O6V0jVaNiSEgxCmJtqK30/lDkx31IEvVoheeberLvL7HnDk5/fqKF+/RyQEIoaWa4AvlzXD5GULerSqXXBC3L8JmT9S2jVGSNbMA9dNmubNTjhghdE2Pg9y2ZgllW8kwMuIEIURw/7t5vY0wmFZdExEkJmvLcVhIZFutihhTILaXOkKb/UbmOVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGH+4V3q; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGH+4V3q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvcbl4kTrz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 20:17:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 86145419A0;
	Tue,  7 Jul 2026 10:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122461F000E9;
	Tue,  7 Jul 2026 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419441;
	bh=mnyEnVNjUbkl63yjftBd6ZAUslZHuhLMLE5i1q1dbiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGH+4V3qnWn/h2ntR4JOMP1MeFASTJyb/ukIFIKga6vmMPs4hWnZeyozgnP8o9zcj
	 4aOepXlE5yG0XgvATIbejO38So9984JOSQXxfemV7MrbXTQdbQqJryZ7by0rmLtk6g
	 KbyecrBlOO6RxZhZHoEJHQvN3lfQ+IRVIfllVkFrcFe5jzAzy0lAaGw02N38CG8Xem
	 bIuNc24pIIBeQZLitf75XKOixE/v2BoAd9XaTV+y7NflJFaBKiVOSfh8s3qL1kjbV3
	 QtnOkHzUZcffKxdXoostqrwbOmOdDgDEYFoMQefdIk5SYi6OuZQQ8BSF6bkbad2igD
	 ZZ2I4X8hc6i0g==
Date: Tue, 7 Jul 2026 11:16:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Lucas Stach <l.stach@pengutronix.de>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Zack Rusin <zack.rusin@broadcom.com>, 
	Matthew Brost <matthew.brost@intel.com>, Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, 
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Helge Deller <deller@gmx.de>, Benjamin LaHaise <bcrl@kvack.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, 
	linux-fbdev@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 03/13] mm: convert __get_unmapped_area() to use
 vma_flags_t
Message-ID: <akzR7JQuaKEQpH5Y@lucifer>
References: <cover.1782760670.git.ljs@kernel.org>
 <b1ad7c4443f5cba622e4c48c5a9ef15427001a93.1782760670.git.ljs@kernel.org>
 <DJRZGEZU5ESV.3IP5LEAUQJCBK@nvidia.com>
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
In-Reply-To: <DJRZGEZU5ESV.3IP5LEAUQJCBK@nvidia.com>

On Mon, Jul 06, 2026 at 10:28:24PM -0400, Zi Yan wrote:
> On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> > Update __get_unmapped_area() to be parameterised by vma_flags_t rather than
> > vm_flags_t as part of the effort to move VMA flags from a system word to a
> > bitmap.
> >
> > We cascade the changes up to arch_get_unmapped_area_topdown() and
> > arch_get_unmapped_area(), where, for now, we use vma_flags_to_legacy() in
> > order to propagate the VMA flags.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  fs/hugetlbfs/inode.c     |  3 ++-
> >  include/linux/huge_mm.h  | 10 +++++-----
> >  include/linux/mm.h       |  6 ++++--
> >  include/linux/sched/mm.h | 12 ++++++------
> >  mm/huge_memory.c         | 21 ++++++++++++---------
> >  mm/mmap.c                | 27 ++++++++++++++-------------
> >  6 files changed, 43 insertions(+), 36 deletions(-)
> >
> <snip>
>
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 95d0040df584..b301ec90740a 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -193,12 +193,12 @@ unsigned long mm_get_unmapped_area(struct file *filp, unsigned long addr,
> >  				   unsigned long len, unsigned long pgoff,
> >  				   unsigned long flags);
> >
> > -unsigned long mm_get_unmapped_area_vmflags(struct file *filp,
> > -					   unsigned long addr,
> > -					   unsigned long len,
> > -					   unsigned long pgoff,
> > -					   unsigned long flags,
> > -					   vm_flags_t vm_flags);
> > +unsigned long mm_get_unmapped_area_vmaflags(struct file *filp,
> > +					    unsigned long addr,
> > +					    unsigned long len,
> > +					    unsigned long pgoff,
> > +					    unsigned long flags,
> > +					    vma_flags_t vma_flags);
>
> Want to use two-tab indentation while at it?

Yeah sure will fix on respin!

>
> <snip>
>
> > @@ -812,19 +811,20 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> >  }
> >  #endif
> >
> > -unsigned long mm_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
> > -					   unsigned long len, unsigned long pgoff,
> > -					   unsigned long flags, vm_flags_t vm_flags)
> > +unsigned long mm_get_unmapped_area_vmaflags(struct file *filp, unsigned long addr,
> > +					    unsigned long len, unsigned long pgoff,
> > +					    unsigned long flags, vma_flags_t vma_flags)
>
> Ditto.

Ack will fix!

>
> LGTM.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks!

>
>
> --
> Best Regards,
> Yan, Zi
>

Cheers, Lorenzo

