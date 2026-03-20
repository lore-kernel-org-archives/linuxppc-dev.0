Return-Path: <linuxppc-dev+bounces-18482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678C1093192
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 08:59:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcc2F0TdHz2yYY;
	Fri, 20 Mar 2026 19:59:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773997172;
	cv=none; b=n092qCaXOkZRynMmZ0Qbp8U+laOa0oVmXapzC+lo0G/eMbXb4i7xefR1fhGh2HvLzq+G4AQ0JwdEZ4gfWFXXm53+eGGNEpqJGOwmTmZLaQgSltbAxoVv/nAQfGA1dWM3rOvc6Oh+AU6xUQHIWIM5pGkHzLiC1yeDAhoEcVHsidJgHKJ5rPfYJ5b1FTVIUjWWQ/GU7ZeAOJvxdw+6Dm+i/NIr8MQIryn0tibztAuM1eO2iXpM70A7eyBk59vDLAgqQY7TCUY8+qyYMZnucmLtRbs5yDc4PV31Gwwr0mOmyyDN5NrUi2zLx1+kO2xN6PC/8cy5BAAuCR6t795E7gBXNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773997172; c=relaxed/relaxed;
	bh=qE1a8eSDmA7XKLylBZoZ2ff1KFzqTNT21inTj4bjszg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWPK/lp4oOxsYkKPJWBzX+YyHnSCujQx+Fr9k6fAyLei546p1YS2pn/QCFbr2fQce+fN2DY6is726FecxoKjdBuUlFKtE5YgRfIwqVV1ShEZurwrb1Wz+VFmgMkTjFRw7A9Vdk2/8KFJDSjobo/e3Sj+WVGvtugKlQVlBP54Zr4gzzigNnOWNsAC3XOqY5x0qrMoyDdgu4dYUwCz7TREyM+6LLT1G5xntM34X8PKXQJmRv9OTMf1FA7rhrs3mh5Xy6XhXZAyiAcSXdWtIbVSbxyZrRVjDFYgVFiGCQMQCSea1YnRkeGkLLCLEk9p7oHzVN7VRwI5VKzXpbsqlTiOOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vnv5g+fa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vnv5g+fa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcc2D0v1fz2yY9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 19:59:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2603160121;
	Fri, 20 Mar 2026 08:59:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99035C4CEF7;
	Fri, 20 Mar 2026 08:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773997168;
	bh=gZ7mo8VD+NAhXZQb0GYWny9AT9mHJxVOkGXSXRSlXkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vnv5g+fajJemAepqRKZRz47c22+umNsA8K+bcibnuhBXHBu1d5YmKqWsG7qOfUFHJ
	 CztV2PyO5tXV2ndgWUvx38ZhYgi/lqkSfU/R+xvcHnxYaqLoT/e6BRXTA0NdY6badP
	 onDLOW/x64CNFEUrBONrSFSXSn2B8FQntJuy/TT5vt3gBjuLsep153gxDZT/dirYhC
	 CVXFpifY9igf7fwFZwHhAhTf6uDN0JdiB+PEafeRbGrcMqNb+21IkikxadesfcAOxw
	 W1QaWfzU+BhIh3qR/LFIA31TyjFUkVqrJLl/fZ5m//RUqAkbCbCMSFvmboEAlRrHUw
	 pulfK6egziujA==
Message-ID: <c45932ed-844c-48ab-9481-9973bd0193c3@kernel.org>
Date: Fri, 20 Mar 2026 09:59:15 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/23] mm: introduce vma_flags_count() and
 vma[_flags]_test_single_mask()
Content-Language: en-US
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1773846935.git.ljs@kernel.org>
 <02a6b26542ab70d60175e0125cff5fd00073c7ae.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <02a6b26542ab70d60175e0125cff5fd00073c7ae.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> vma_flags_count() determines how many bits are set in VMA flags, using
> bitmap_weight().
> 
> vma_flags_test_single_mask() determines if a vma_flags_t set of flags
> contains a single flag specified as another vma_flags_t value, or if the
> sought flag mask is empty, it is defined to return false.
> 
> This is useful when we want to declare a VMA flag as optionally a single
> flag in a mask or empty depending on kernel configuration.
> 
> This allows us to have VM_NONE-like semantics when checking whether the
> flag is set.
> 
> In a subsequent patch, we introduce the use of VMA_DROPPABLE of type
> vma_flags_t using precisely these semantics.
> 
> It would be actively confusing to use vma_flags_test_any_single_mask() for
> this (and vma_flags_test_all_mask() is not correct to use here, as it
> trivially returns true when tested against an empty vma flags mask).
> 
> We introduce vma_flags_count() to be able to assert that the compared flag
> mask is singular or empty, checked when CONFIG_DEBUG_VM is enabled.
> 
> Also update the VMA tests as part of this change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


