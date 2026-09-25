Return-Path: <linuxppc-dev+bounces-28203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4886C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 12:51:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrrDV0pQzz30MZ;
	Fri, 25 Sep 2026 22:51:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790340682;
	cv=none; b=AvXWLt79uy7a8hTLf1v2e9IdnO0OmhHPKSCZdCrCEIR46/MPISMDQd613g3/V4Ry1D176QYJZiz/ylfZfaNOBxpSNOUgs0uxYEslR1W4oQTp6eOIBsBlsqZAFU8eAkT7AhjMyLnJhmblzK+mKc3BX7hqTTdzXmkdHLNfy2MVBi+6vpdw8A9jqGFgm5EbqlZJvH8tCP7Qs2yhrUXRTpkRro9gtJz2PU3CHKlHFggLUwUUS06cz5tI4seGf4b8qvr28Ua+QqTo6DDZd1ntJkltiOnNzsZsgdybPCzS1za0TlAdnqvOv+0rsD+DoztbMJ/aH2sNWS8GM/EDMId5+SqWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790340682; c=relaxed/relaxed;
	bh=D3elFlAcGaZH0VbYl18NIe5+45MZxJu3tV5JyNgmc1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g485tRcPyu7OdKTxbb5kx0XrVEvS9wK2ecVaKZVmzu3yXM+Wc9XJbE8M4EAVD6d4fpKZwAYOPEwxS3L5ejELgeu+pt6oldcOQ4AL6ELqZLXwhE0/TUynpRZl+6t0OnU6WdqLA++FQtTGrgCyPmhzhCytEAYSLMdX10dxBKtInZKdXaEhIZirOqe/f7m08LTid0KD79Hj4t91ZuVgPMsH0+MlI1Vkt9x5MfslqqmaKW+RQWOYTdK1RAc1zNih2BwZj6Yp5knashshbCfSl6HF2NB7EIqW/SesH4WhAvtPQqlHXlQBltfDgalHKjszGu0e592TmeeyLW9tl9bLl1f9ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y53djdWl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y53djdWl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrrDS4YMSz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 22:51:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2880740D6E;
	Fri, 25 Sep 2026 12:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E621F00898;
	Fri, 25 Sep 2026 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790340678;
	bh=D3elFlAcGaZH0VbYl18NIe5+45MZxJu3tV5JyNgmc1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y53djdWlLd4diT/AvrOcXi2GrVkUMfZOD6dmk5wrBuqGrapZjitCvRDfrBfg9d5x0
	 BnTKh4bxCfiX0tMKCdrW8JtFurhbBTQYO3LW88thuG01Cb/ZYE7hw59evarzLYTO38
	 7wZU6lEFZdgk6ZZ7hHn/Dp2Lao89/ocNv/c66cAQXdIQWZDLRciBbhbYw+b5WFshwd
	 SgfnG/v9weC791zQC+pDBEFG7GNZuzILu4ouO1eex0u514XgRGL7lU1F1WRmmHIXhs
	 yqzMlC0qHyJaHLn+n3KPUNM1XrW75NKKVif7jm3AOyuuULaCC+82pdP6bc1SuqvtsJ
	 b7HBLAWBmeiCg==
Date: Fri, 25 Sep 2026 13:51:09 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 04/40] mm: consistently validate VMA state after
 mmap[_prepare] hooks
Message-ID: <arZriK1tyOC7DjBw@gremlin>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-4-4583d8a23bca@kernel.org>
 <arVW5i8pvySq6Co2@gourry-fedora-PF4VCD3F>
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
In-Reply-To: <arVW5i8pvySq6Co2@gourry-fedora-PF4VCD3F>

On Thu, Sep 24, 2026 at 01:17:28PM -0400, Gregory Price wrote:
> On Thu, Sep 17, 2026 at 05:22:13PM +0100, Lorenzo Stoakes (ARM) wrote:
> >  static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
> >  {
> ...
> > +	err = mmap_hook_validate(prev_start, prev_end, &prev_flags, vma);
> > +	if (unlikely(err)) {
> > +		vma->vm_start = prev_start;
> > +		vma->vm_end = prev_end;
> > +		vma_close(vma);
> >  	}
> > +
> > +	return err;
> >  }
> >
>
> I indepdeantly validated the sashiko report on this chunk.  Seems like
> close() should be deferred until after __map_new_file_vma() calls
> unmap_region().

Ack perhaps too quickly dismissed that one...!

>
> suggested fix is to drop vma_close() from mmap_file()  and update the
> cleanup in __mmap_new_file_vma()
>
> if (error) {
> 	UNMAP_STATE(unmap, vmi, vma, vma->vm_start, vma->vm_end,
> 		    map->prev, map->next);
> 	vma_iter_set(vmi, vma->vm_end);
> 	unmap_region(&unmap);
>
> 	/* Release driver state only after its mappings are gone. */
> 	vma_close(vma);
>
> 	if (map_same_file(map))
> 		fput(map->vm_file);
> 	vma->vm_file = NULL;
>
> 	return error;
> }
>
> Example race:
>
>   Thread A                              Thread B
>
>   mmap(MAP_FIXED, address A)
>     driver remap_pfn_range(A, page P)
>                                          load/store at known address A
>                                          hardware finds the new present PTE
>     validation fails
>     ->close() frees page P
>                                          UAF
>     unmap_region()
>     TLB shootdown
>
> With that fix

Ack, yeah. It's kind of a situation that should never happen, but if validation
is supposed to actually be run against things then we should keep the kernel
stable when we do it :)

Will apply for the respin.

>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks!

>
> ~Gregory
>

--
Cheers, Lorenzo

