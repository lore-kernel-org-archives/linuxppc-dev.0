Return-Path: <linuxppc-dev+bounces-23150-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E269C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:39:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFQc4dmGz2yY1;
	Tue, 30 Jun 2026 17:39:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805160;
	cv=none; b=kx826qrq+FB7+wxiSyaqpieASgwBlMeEtaQmHaPyZd0L3ycFAHMBIIFRCRg5zZUzlJ+unRH4kxQ78vCSQvjwlfh5ztNYi477n2qB4KE6l8iZBH7a8rRGzrcJVP9gwEnU0NtN24WeFKZFIMr6tATfOqrSUe2SuLS8ha+qjVjqOc909iU2UDS/f303di2GVoNl7J1BnGPsE+sfnZjqQt6RQuylAVSxo1XLeMh7WEUCyu1OpuFZIgBgoyX2Y/qacn9kgDMkZYMaaN5I6Qbl5n5jIwY/0HSrRwlR6kGoSgYVhWFlqnRlil5PPMz/AFXu4+YL8rHiEJd+Oj0kiT0h/cCVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805160; c=relaxed/relaxed;
	bh=QFTirDmiRXM2E2UxDPivyHpH5WU8vmAPSC3LpjlrT8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGUdBcrACJMa2DTF4ucOf3hjxTiuS7J+fLO1S2lQVA851Msm0F0uclz+PKK82F3xS0wLuwyVloB9FRJ44D+aQZxQNW6ggU2q+5XldjkzO/bFp8UqM0p0Wd1kgJSgLw4kim9dI7NgW0u+p9lYfYJfPW9fsRYF4jIxfvkOEQslABh9aF3/735JpipJXpgCBryXphB9qCYam8PRJks1caEGLx+oYPRFn0fae+MHI3Sv0HjStkaqC8uK5nFZY2sFixq1VkAN/tMCDNmkkWhnjRabOMmtTPq3TJ0VlXsKgioiv3s2XXOjnzOmkvb74BAE4ugVP5DexVmIxfo7lUttoWQWkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDaf4ZqW; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDaf4ZqW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFQb0jhzz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:39:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3547140B7E;
	Tue, 30 Jun 2026 07:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F3C1F00A3D;
	Tue, 30 Jun 2026 07:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782805156;
	bh=QFTirDmiRXM2E2UxDPivyHpH5WU8vmAPSC3LpjlrT8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fDaf4ZqW3PD9fY8acsrJCsXc7pOEzc4lLsW2jgJhfYGl7NXG5KcVo4Pxek2Uz+Nla
	 tOcu2NuZHwmic0JpBPUEEgMmuaTGNKExmRCbT0ES7+8QhHL9YqeimbRUf62O0HtMfs
	 LYny1udM2eWLdF0sRgHD+bBsvogcyV+srg+CrLasOfuUZDDcJr8dZlygrFZBfDoggP
	 p2mllhEamdnPs77YGrH3WGaXXIkqv4Xgyt7g+R7YVqHEf/NFyfi55aJUF3SRsQX/b0
	 NUbVhpaMaUvlKWWtDdlDlkLmrVKracrOVgHvCwNbE5g49j/+vG6Xvy5Wxh+acQ6BjY
	 MYjz8K0OvlQ3A==
Date: Tue, 30 Jun 2026 08:38:51 +0100
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
Subject: Re: [PATCH 01/13] mm: introduce vma_flags_can_grow() and
 vma_can_grow()
Message-ID: <akNucoP3eaDN2_Vz@lucifer>
References: <cover.1782760670.git.ljs@kernel.org>
 <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
 <DJLTDCPWMXDL.4ICZ77A1LPZZ@nvidia.com>
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
In-Reply-To: <DJLTDCPWMXDL.4ICZ77A1LPZZ@nvidia.com>

On Mon, Jun 29, 2026 at 04:26:18PM -0400, Zi Yan wrote:
> On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> > These test whether the VMA has stack sematics, i.e. is able to grow upwards
> > or downwards depending on the architecture.
> >
> > In order to account for arches which do not support upward-growing stacks,
> > introduce VMA_GROWSUP whose definition depends on the architecture
> > supporting it, and use vma_flags_test_single_mask() in vma_flags_can_grow()
> > to account for this.
> >
> > Update the VMA userland tests to reflect the changes
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 21 ++++++++++++++++++---
> >  tools/testing/vma/include/dup.h |  4 ++++
> >  2 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 868b2334bff3..cf7df1569052 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -472,6 +472,7 @@ enum {
> >  #define VM_SAO		INIT_VM_FLAG(SAO)
> >  #elif defined(CONFIG_PARISC)
> >  #define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
> > +#define VMA_GROWSUP	mk_vma_flags(VMA_GROWSUP_BIT)
> >  #elif defined(CONFIG_SPARC64)
> >  #define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
> >  #define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
> > @@ -483,6 +484,7 @@ enum {
> >  #endif
> >  #ifndef VM_GROWSUP
> >  #define VM_GROWSUP	VM_NONE
> > +#define VMA_GROWSUP	EMPTY_VMA_FLAGS
> >  #endif
> >  #ifdef CONFIG_ARM64_MTE
> >  #define VM_MTE		INIT_VM_FLAG(MTE)
> > @@ -1563,11 +1565,24 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
> >  		vma->vm_end >= vma->vm_mm->start_stack;
> >  }
> >
> > -static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
> > +static inline bool vma_flags_can_grow(const vma_flags_t *flags)
> >  {
> > -	int maybe_stack = vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
> > +	if (vma_flags_test_single_mask(flags, VMA_GROWSUP))
> > +		return true;
> > +	if (vma_flags_test(flags, VMA_GROWSDOWN_BIT))
> > +		return true;
> > +
> > +	return false;
> > +}
> >
> > -	if (!maybe_stack)
> > +static inline bool vma_can_grow(const struct vm_area_struct *vma)
> > +{
> > +	return vma_flags_can_grow(&vma->flags);
>
> Would it save vma_flags_can_grow() if we do below?
>
> return vma_test(vma, VMA_GROWSDOWN_BIT) || vma_test_single_mask(vma, VMA_GROWSUP);
>
> I find these two functions when I am reading mm.h.

Yeah but we require vma_flags_can_grow() for code in mmap.c, the majority of
checks of this have only vma_flags_t to work with not a VMA :)

>
> > +}
> > +
> > +static inline bool vma_is_temporary_stack(const struct vm_area_struct *vma)
> > +{
> > +	if (!vma_can_grow(vma))
> >  		return false;
> >
> >  	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) ==
> > diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
> > index 5d7d0afd7765..6f5bcd7fbcd8 100644
> > --- a/tools/testing/vma/include/dup.h
> > +++ b/tools/testing/vma/include/dup.h
> > @@ -245,8 +245,10 @@ enum {
> >  #define VM_STACK	INIT_VM_FLAG(STACK)
> >  #ifdef CONFIG_STACK_GROWS_UP
> >  #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
> > +#define VMA_STACK_EARLY mk_vma_flags(VMA_STACK_EARLY_BIT)
> >  #else
> >  #define VM_STACK_EARLY	VM_NONE
> > +#define VMA_STACK_EARLY EMPTY_VMA_FLAGS
> >  #endif
> >  #ifdef CONFIG_ARCH_HAS_PKEYS
> >  #define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
> > @@ -315,6 +317,8 @@ enum {
> >
> >  /* Bits set in the VMA until the stack is in its final location */
> >  #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
> > +#define VMA_STACK_INCOMPLETE_SETUP append_vma_flags(		\
> > +	VMA_STACK_EARLY, VMA_RAND_READ_BIT, VMA_SEQ_READ_BIT)
> >
> >  #define TASK_EXEC_BIT ((current->personality & READ_IMPLIES_EXEC) ? \
> >  		       VM_EXEC_BIT : VM_READ_BIT)
>
> Why are VMA_STACK_EARLY and VMA_STACK_INCOMPLETE_SETUP added here but
> not in mm.h?

Yeah urgh oops my bad. It doesn't really break anything but I'll fix it if a
respin is needed...

>
>
> --
> Best Regards,
> Yan, Zi
>

Thanks, Lorenzo

