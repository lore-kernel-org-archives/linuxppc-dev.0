Return-Path: <linuxppc-dev+bounces-24245-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76972C4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:05:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h02fl4x6cz2yMn;
	Wed, 15 Jul 2026 01:05:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784041519;
	cv=none; b=UyEdz8wTDKP6OwvAApZURbq4aQQ62szjGub6vP349Qp/jty787uYZHPHkQZeKU22YJV/TXn5eh9Gea7jQRdQqXug9/oST3tBpaReP0Cz82Y2Pm8jag42jgRWVosDH8+Xvz0Aes9FssvcGrXppyUvxhcMwhtzm8B2T0I9z0calm5W+qhdEm3aVvc7tb7yOmnyGx+YealFlT4JgN1WH5hBrklls+QT5/OYU++w9fH+6k+xzxG0CDcHYzDek0RBbnw9hHWwffkTIWotAjO4EOz70amSHbB0NmGFkMviXjpBqqvEA9qRlwFBRp4SqRE+EL50wQrUeKMDj0VD4A3irLa7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784041519; c=relaxed/relaxed;
	bh=AYjyETDBZwm0j/cPjjIgSYujcuHtX92Lh9M1By4BrMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnUJAj8CPda1qJPeXjzHbCwilzrDqNdCCLbiYcu8DNf8OV9jMyerHJm6QL4SbEKD72lklZKS6GrNWw5mDOKYNNk/P0VcHTggapyKJcUIB1pFjCXUufckaZJyk8SS1AwP8dim2TWLFIAp3fWT0iaEVlNXbiLO9miHQJrlP1J0OpYIre8SQqQkkJSA/HJK8iDCKbnu0e5oNujuForFhLUKpfdIT8kV6zxIDkk6i3c7CzCjdZZVeJJPhc4AjF39w9AxW9JHYa/biuoaqzIqg90SwO8LmRDVw7/6He1OXYge69HhZwzNXr7jZzr3/enNFZUOXJgCVzuVh9AdSt/kZ71YVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crOD2NmJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crOD2NmJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h02fk3LMlz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:05:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B803C60103;
	Tue, 14 Jul 2026 15:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AA51F000E9;
	Tue, 14 Jul 2026 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784041514;
	bh=AYjyETDBZwm0j/cPjjIgSYujcuHtX92Lh9M1By4BrMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=crOD2NmJDWob7tNH4b0nB1FiZnokFnKZDkP0Ght7V6I9Wl8zmC+0pmKCW+kuXLlLH
	 OdZHmkh/T/9BB42ZvoZwp60T/mYLQwb+uOSlwDUb+jGK/rXpggWk3voCs1+1oCHlIy
	 LXTlYETzj3M++Bh5NzIk2buDSGg3fmS7KG1J0rfl/O/1fHossnuwmJ7LiswfHs+0P0
	 ffWQo61tvdjoVoC7hXSzokGWOo+sPo7j+/6Jfs2msT1jdScy1yBzSMh3QvyUVNtNcz
	 99aBb5YGUL9jfl1vNkXPGp7NC4uErRwi1ismiMLOqmhMcboruizzYkE3vXwJGQsEgm
	 RUE53xPNgB+iQ==
Date: Tue, 14 Jul 2026 16:04:52 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-arm-kernel@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ning Sun <ning.sun@intel.com>, x86@kernel.org, tboot-devel@lists.sourceforge.net, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	linux-efi@vger.kernel.org, Vishal Moola <vishal.moola@gmail.com>, 
	Alistair Popple <apopple@nvidia.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
Message-ID: <alZOs30ziqa7l_Lq@lucifer>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
 <71045fa8-89fe-4a0b-a05b-67e19ce89834@intel.com>
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
In-Reply-To: <71045fa8-89fe-4a0b-a05b-67e19ce89834@intel.com>

On Tue, Jul 14, 2026 at 07:47:43AM -0700, Dave Hansen wrote:
> On 7/14/26 07:03, Kevin Brodsky wrote:
> > +static inline bool mm_is_kernel(const struct mm_struct *mm)
> > +{
> > +	return mm && mm_flags_test(MMF_KERNEL, mm);
> > +}
>
> Could we give this some nice comments explaining what a kernel mm is,
> please? Part of the problem with the init_mm checks is that they're
> magic and it's not always clear what's special about init_mm.
>
> Maybe start with this list?
>
> 1. There's only one of them.
> 2. All kernel threads share it. tsk->mm is the same for all kernel
>    threads.
> 3. It holds the reference copy of the kernel page tables
> 4. Userspace can't be entered when it is the current mm
> 5. It has different TLB flushing rules than userspace mms
>
> I _think_ those are universal across all architectures.

Well point 1 isn't true of efimm or tboot_mm so we possibly need a better
name :)

"Special" is overloaded too much already. I quite like "eternal" so:

	static inline bool mm_is_eternal(const struct mm_struct *mm)
	{
		return mm && mm_flags_test(MMF_ETERNAL, mm);
	}

:)

Cheers, Lorenzo

