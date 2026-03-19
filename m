Return-Path: <linuxppc-dev+bounces-18455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF01090253
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:50:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcBX42jLsz2ynn;
	Fri, 20 Mar 2026 03:50:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773939028;
	cv=none; b=J1qgAO1RiWmHDPvkxtgI/JfYK1GIDVCf5SIH+VtF5irQgIZcoexJXEPnabXk4/xcBzQQ5lTzCzA1ysNvNyiNZhp45/XvRLX4GNuuEN99fUg/wLN1mV+buVBNGmYHWZ6JpiN4aU2Z9CG2Zi738lnCYbnBxEl6AZQY4iLk2hA3EgN3ROdTu4dTlHwiB7mK6NzFjWp79nmEfMdGV8c9z6D3VUXrTHsyG0Dw0xffEX4BZ9oayvNXJDnA0Kwc1CmGb1hqcA0Cch53oO2psqwwlN7S6Xm9H15WYrQAbQG5Dx740AhTk7geeO612VREIzEqgDv1i7/LOP9+nJlaEWG9aI+byA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773939028; c=relaxed/relaxed;
	bh=ySKX/SdqeoTiP9pwQcgZ94qbw5sb0oTPtV3x6ZUzB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELm+0GJaBLOXoZxKt5Q7obPHVUmDwtl7R7OSa/B9yYE+4HE515qAGqtQTIyl4KFY5NLaUxT3evMnTWOc+DkdQTwXUdsMtXJGOpOD1mTGJ6Zab/VkF7UAusc15335/On3CEGOTKGJq3yfIrrrgIa2dK6g4qMuURz5UfEKM+nQJOxW8nk35b/mN9NE8PZ3A/9v6qzfIajjpLCCwQbLOAjuipDauQnBLtrhY6FYwapiw/J8ZvX+jY6f/C1m+ZBJhNw81a200RtdMEj/ADJFTOqXuK07z7c4aVAxIc47Z6Jzj9Ha3NODO0abaNqB5YuoVcEuQpbKx5sBhdQY9XLV3LGBAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YgTWHgcw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YgTWHgcw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcBX30JL8z2yng
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 03:50:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AA6760097;
	Thu, 19 Mar 2026 16:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41945C19424;
	Thu, 19 Mar 2026 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773939024;
	bh=ySKX/SdqeoTiP9pwQcgZ94qbw5sb0oTPtV3x6ZUzB64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgTWHgcwTFKs1gBYxdYW33eFt5gNoD63sWPX8mdYVejWbKUuDdrFkJsiURNl6lSLi
	 XYkJpx/wRyyEkQGRCONtUVwp8dlhSmjpJmDCO67CtepROdANquLF914vAvs8F03t4f
	 bTPzUwW9A/1agL8G//3eqOLaaV9TNMSiL0J0t6/c4zk5axQdTYHz2ZOVPKnbSwlk6K
	 qocxlmnDCy6A8nO8NHNs/bLSd9OhmFGiAmqwSf3sFUuUX0nCndmYw9sGuphDXOX2tS
	 i4TA+BApsD8Pt+tqXbprswARO/rjXi7FaX5y7BenKplS9DF3okpkWVua6BEbY/FEZi
	 KOJGjMYMEW9VA==
Date: Thu, 19 Mar 2026 16:50:08 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 01/23] mm/vma: add vma_flags_empty(), vma_flags_and(),
 vma_flags_diff_pair()
Message-ID: <3cf675e3-d333-45f1-bcf9-466c7b16f916@lucifer.local>
References: <cover.1773665966.git.ljs@kernel.org>
 <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
 <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>
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
In-Reply-To: <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>

On Wed, Mar 18, 2026 at 03:40:45PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> > Firstly, add the ability to determine if VMA flags are empty, that is no
> > flags are set in a vma_flags_t value.
> >
> > Next, add the ability to obtain the equivalent of the bitwise and of two
> > vma_flags_t values, via vma_flags_and().
>
> Nit: "two values" is vma_flags_and_mask(), while vma_flags_and() takes one
> value and list of flags, no?

Sorry missed this. Yeah should be 'via vma_flags_and_mask()', or a better
description of vma_flags_and() :)

>
> > Next, add the ability to obtain the difference between two sets of VMA
> > flags, that is the equivalent to the exclusive bitwise OR of the two sets
> > of flags, via vma_flags_diff_pair().
> >
> > vma_flags_xxx_mask() typically operates on a pointer to a vma_flags_t
> > value, which is assumed to be an lvalue of some kind (such as a field in a
> > struct or a stack variable) and an rvalue of some kind (typically a
> > constant set of VMA flags obtained e.g. via mk_vma_flags() or equivalent).
> >
> > However vma_flags_diff_pair() is intended to operate on two lvalues, so use
> > the _pair() suffix to make this clear.
> >
> > Finally, update VMA userland tests to add these helpers.
> >
> > We also port bitmap_xor() and __bitmap_xor() to the tools/ headers and
> > source to allow the tests to work with vma_flags_diff_pair().
> >
> > Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>

