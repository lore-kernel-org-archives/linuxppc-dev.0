Return-Path: <linuxppc-dev+bounces-28270-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D7CC98332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 10:03:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsNSV4k09z2yd7;
	Sat, 26 Sep 2026 20:03:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790417018;
	cv=none; b=C8nZhismvbkkAVaxtxDbfBDBl8taprlcoG+S4M8gd2NNFecR/aBSj8Xbjs55jVO0/p02241+WQl1Sx9f6/CM3ir6RZvFeYIw8I9zOBTL7ls+1G0s/qm5T5DnGKL4/luhpaGtF+Da1N50ZWCltywTTA+ayz9WHHwD8q5bRUSYo1CebRbEP0J4T05jlyCgYkbJCm/TRpnbVaqnPyxrm81CQ90AscmlRfaSz1bSQX1hi/DgFIDorublUO3TRROJSfbug4KC7XLW2X0ew51TronWcnfndMEp8lCS9QDd2AJ/lDEbrfXnWcR3LIFO+kNoF429CsVdMoB5q+EZAZijm5tq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790417018; c=relaxed/relaxed;
	bh=Ti2172MLMPIXoYLD6wBNBUuG1vVW74lvR3yPAsyJ4Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BseCIGcYQn1/CMJ7AHw930QcjNMen2S0OhOkUjA+uhBULQ/d16F26pb8a2GQIN+NDD0QNHOSCiiMIFfIrbLbdhLh74fqJ9LKaq8BIoTv0sub1bOeQHOAHCfv3PXV9Wn6Av0RazQnmLgtIfhrQ72/2EmFN1OOj1CLTyHqzDs6DB9tlzhmSPRMzVPKJZvQ8RQpxoPPcQsuCMaH452MxLAK91PdVIdK0PVvRBduLtult51ne2GLURGMDn9b+/qwn5LsnszxdO2bkMeWS+b3MiYxdxLx80rdA/uJtnO8YcFXqnC2FhlLANqoOwnrpNRT+pr5PFGgArMYgHY85j1rNPHCPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PotPzrZ5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PotPzrZ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsNST4fqkz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 20:03:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E112243EF7;
	Sat, 26 Sep 2026 10:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F031F000FF;
	Sat, 26 Sep 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790417014;
	bh=Ti2172MLMPIXoYLD6wBNBUuG1vVW74lvR3yPAsyJ4Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PotPzrZ5JhDcKjnjPPw4xklb2BV2GvKf2hehW5Y+mTu9Ze/h0GvM2oipY5M9D+/cd
	 NRSteOJJVQwOgJ/Vk7qXpUvq2TlOQEyc8ylr6ggIIRLBObKxZ+LGlahTeOSiW1DP9A
	 NCr80n3Ix3unBLfTdBkNTu/U313Twxe7BdIULH0hZv4+HKf9SLfgwohoZjpf9YbuDb
	 pM/4foaBcqD6tdDoCnbsIxQUPKUzkTKJ14OcpqpL1z9ouoHn3tA5tZPlu8aWNsTXWH
	 kG0V3eJydf9/vQZMEDvq3aPanED3H3sJB4bqO1nejPbFwjDnaIc7Dx5neGDSzNUBqo
	 N5OxElMlwQ0bg==
Date: Sat, 26 Sep 2026 11:03:02 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Doug Gilbert <dgilbert@interlog.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, 
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 17/40] mm/vma: add and use vma_[flags]_is_fixed_mapping
Message-ID: <areX8JFWf2gJLVcf@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-17-4583d8a23bca@kernel.org>
 <DLOW5O2LS4KC.7BAL5Q24VJL@nvidia.com>
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
In-Reply-To: <DLOW5O2LS4KC.7BAL5Q24VJL@nvidia.com>

On Fri, Sep 25, 2026 at 10:27:15PM -0400, Zi Yan wrote:
> On Thu Sep 17, 2026 at 12:22 PM EDT, Lorenzo Stoakes (ARM) wrote:
> > This determines whether a VMA cannot be expanded or merged because what
> > they mapped was determined to be a set size at mmap time.
> >
> > This typically refers to kernel-owned mappings, however VMA_DONTEXPAND_BIT
> > is not reliably set alongside VMA_PFNMAP_BIT or VMA_MIXEDMAP_BIT, so we
> > must explicitly test for this for now.
> >
> > We also explicitly test for VMA_PFNMAP_BIT as VMA_DONTEXPAND_BIT may not be
> > set for VMA_PFNMAP_BIT's despite the one implying the other.
> >
> > Use this predicate in vma_flags_can_merge() and in check_prep_vma() in the
> > mremap logic testing to see if mremap() can expand the VMA. The criteria
> > for khugepaged and MADV_COLLAPSE eligibility in
> > __thp_vma_allowable_orders() are precisely those for mergeability, so use
> > vma_can_merge() there (with an expanded comment).
> >
> > This obviates the need for the VM_NO_KHUGEPAGED mask, so remove it.
> >
> > Hugetlb VMAs remain excluded from khugepaged as hugetlbfs always sets
> > VMA_DONTEXPAND_BIT.
> >
> > Also update the userland VMA tests to reflect the change.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 39 +++++++++++++++++++++++++++++++++++----
> >  mm/huge_memory.c                | 11 +++++++----
> >  mm/mremap.c                     |  5 ++---
> >  tools/testing/vma/include/dup.h | 16 +++++++++++++++-
> >  4 files changed, 59 insertions(+), 12 deletions(-)
> >
> <snip>
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 4cd917f77f3f..4d0acd9a1099 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -212,11 +212,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
> >  		return in_pf ? orders : 0;
> >
> >  	/*
> > -	 * khugepaged special VMA and hugetlb VMA.
> > -	 * Must be checked after dax since some dax mappings may have
> > -	 * VM_MIXEDMAP set.
> > +	 * khugepaged moves data from VMAs once collapsed, after they have been
> > +	 * faulted in, relying on refaulting for file-backed memory.
> > +	 *
> > +	 * Kernel-owned mappings cannot be reliably reconstructed from page
> > +	 * faults, and fixed mappings (including hugetlb) may not be marked as
> > +	 * kernel-owned - precisely the mappings which cannot be merged.
> >  	 */
> > -	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
> > +	if (!in_pf && !smaps && !vma_can_merge(vma))
>
> I wonder if a function alias would improve the code readability.
> Basically,
>
> #define vma_no_khugepaged vma_can_merge
>
> or just make vma_no_khugepaged static inline. And move the comment to
> the function.

Hmm yeah, I'm not sure, I think given it's here and commented it's OK and
avoids having to have a special snowflake entry for khugepaged, so unless
it were referenced again elsewhere it's ok like this?

If it gets used elsewhere in the THP code it could be relocated then maybe?

>
> Regardless, this patch makes sense to me.
>
> Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks! :)

>
>
> --
> Best Regards,
> Yan, Zi
>

--
Cheers, Lorenzo

