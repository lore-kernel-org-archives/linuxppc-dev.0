Return-Path: <linuxppc-dev+bounces-26919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A990AC79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 12:09:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg03873qXz2ypW;
	Wed, 09 Sep 2026 22:09:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788955748;
	cv=none; b=dUGLpoNmp3hrhxYLcqVxiO2jrbUpHcnJd3wQHlkUCO0Igm9G3v8RgwTVIowaSRWj3O8SNI5ZtkXWcmtuIhzfAGLMaRNVT4t3EcT7MgUvpDrsxUmGKHLiuqqSbPJrJDNkKm5iHENGjxianPycHE2sjshhDmtrrM8EjUymwaYKMdTqiJo6WMfB5i+0tOC7VhUe/lRyEVm4JcpLv7mib83IKOtdR4lMQbkmws3ASDgEjCx5eikyePAb77Dsg5ieWkmn9n1qOU4IuYcIG+5mq/rmqImFKznsuY/RW5Bh5yyB+zMTS9JVmLZhPWe1EOcsj3PQFIhWiZ/VvkYxHt2yZ3q8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788955748; c=relaxed/relaxed;
	bh=+vl7JXesMvOyLvN4TqdpRFvW5tHWQV0Z6fTfMaOZcos=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQQb92gSVYYVpcEhNpZ2DwVwOjTNSZxQtw5kxEpSIZHfBewL8iUHEaby7RMSebWr4lsI7wXDxw64dn0ZETXpSUTG5y0XfAafJ0a4TIIlVTxSvRsQ+Sa1rlakmOVxO5LWj9xpT+BMC7YYQx6l1jmzaTPZJk9oBXJyNjj4PHge8UPLh7U7emGvTzhvT8ZOCBm5qR3sWlZmGxPFDchNfJFtXDNvE9062vcVKF8ipR1hDH+IjuDfuoPZSDIG4ED/ELS9x3q8cmtKWjHm70TyXVKoDvSUWOJv0TDXMBFh5/1R0PHv6+/IsImOKwvuGodo6y7K+8SSk6E8LVvQNft9F6wcrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSBO7XfB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QSBO7XfB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg0352Ht7z2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 22:09:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B45743668;
	Wed,  9 Sep 2026 12:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC671F00A3E;
	Wed,  9 Sep 2026 12:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955739;
	bh=+vl7JXesMvOyLvN4TqdpRFvW5tHWQV0Z6fTfMaOZcos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QSBO7XfB9eJuCgdZw4woX9h6hLVv1DAAKEMcqqTtIlfNGaiMpuLvQbzhC/HsUDqDy
	 15tzsyERcKb/dCy0KrTkU176RhbTCcy21TSs/XRVe0a2CeHrpUDlqlX+4eqWNdQmSP
	 ZwfdXLWGjYgxyEXXB+UjA+lgDSAN24eS4K+Y/at+9+bmLKnF2sQtudlKc4XZf2yWBT
	 GWiqoV+03Qgq8XKU5kEPlMdYwMF4DBOmSD8P6FFdNW88ziMwb+5x2tUJ7KBFC2OEkv
	 y0F1ASE9ljvI2KQ6gM2g9pgM4YchyP5SgcvLLQZd8YcLUPlszfpfiqg7ho1AxZsTq8
	 3yCEIs6vu9sRQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1x4H6m-00000006flL-2cBD;
	Wed, 09 Sep 2026 12:08:56 +0000
Date: Wed, 09 Sep 2026 13:08:55 +0100
Message-ID: <86wlsu39uw.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Doug Gilbert <dgilbert@interlog.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Jaya Kumar <jayalk@intworks.biz>,
	Simona Vetter <simona@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Sebastian Reichel <sre@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 28/39] mm: drop some redundant checks around hugetlb VMAs
In-Reply-To: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-28-dacf19cce22b@kernel.org>
References: <20260908-b4-mmap-prepare-vma-flag-sanify-v1-0-dacf19cce22b@kernel.org>
	<20260908-b4-mmap-prepare-vma-flag-sanify-v1-28-dacf19cce22b@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
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
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ljs@kernel.org, akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, jannh@google.com, pfalcato@suse.de, david@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org, dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, leon@kernel.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, perex@perex.cz, tiwai@suse.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, dgilbert@interlog.com, James.Bottomley@HansenPartnership.com, mkp@kernel.org, jayalk@intworks.biz, simona@ffwll.ch, deller@gmx.de, sre@kernel.org, jhubbard@nvidia.com, peterx@redhat.com, mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen
 @linux.intel.com, x86@kernel.org, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, riel@surriel.com, harry@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de, muchun.song@linux.dev, osalvador@suse.de, willy@infradead.org, jack@suse.cz, oupton@kernel.org, catalin.marinas@arm.com, maddy@linux.ibm.com, anup@brainfault.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com, viro@zeniv.linux.org.uk, brauner@kernel.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, chrisl@kernel.
 org, kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, youngjun.park@lge.com, hannes@cmpxchg.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, mhocko@kernel.org, miklos@szeredi.hu, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-d
 evel@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 08 Sep 2026 21:01:32 +0100,
"Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> 
> Adjust code which inadvertently perform redundant checks on hugetlb VMAs
> and clean them up:
> 
> * hugetlb VMAs have VMA_DONTEXPAND_BIT set so a VMA_SPECIAL_FLAGS check
>   suffices. (migrate_vma_setup() regains an explicit hugetlb test later in
>   the series, once VMA_SPECIAL_FLAGS is removed.)
> 
> * hugetlb VMAs unconditionally set vma->vm_ops, so they are never
>   anonymous.
> 
> * hugetlb VMAs do not set VMA_PFNMAP_BIT so checking for this is redundant.
> 
> While we're here also drop a VM_BUG_ON() which the simplified check above
> makes unreachable, and use the new VMA flag API.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/arm64/kvm/mmu.c         | 4 +---
>  drivers/gpu/drm/drm_gpusvm.c | 3 +--
>  mm/migrate_device.c          | 4 ++--
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index a7968f8d24bf..3c1240ffc38d 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1463,14 +1463,12 @@ static int get_vma_page_shift(struct vm_area_struct *vma, unsigned long hva)
>  {
>  	unsigned long pa;
>  
> -	if (vma_is_hugetlb(vma) && !(vma->vm_flags & VM_PFNMAP))
> +	if (vma_is_hugetlb(vma))
>  		return huge_page_shift(hstate_vma(vma));
>  
>  	if (!(vma->vm_flags & VM_PFNMAP))
>  		return PAGE_SHIFT;
>  
> -	VM_BUG_ON(vma_is_hugetlb(vma));
> -
>  	pa = (vma->vm_pgoff << PAGE_SHIFT) + (hva - vma->vm_start);
>  
>  #ifndef __PAGETABLE_PMD_FOLDED

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.

