Return-Path: <linuxppc-dev+bounces-18360-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A4F103E18F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:41:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWjB1Zfvz2yjV;
	Thu, 19 Mar 2026 01:41:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773844862;
	cv=none; b=gTB8bOrPl8KgOIc/+IU18ZNBDI1lSpkU4aKtWhCCP3hho8ImbjXHSw5skn/owpj1DYV/kq/pN771B78gD9+maxQb3aD8cbhkJ2052XcYzMG9LW9SBu7BURWdsJS0Di2gdW7UdIKRZFDhsnNKt9nM+heuuvU2QzDdf8P771MTXoTUj6+YOTL/51GWjKVTHojzma5uJK9VKiNGkqcy7KFVqIljxiudOsfQQFuxEBmoQCHjIUxaJXQM1W1DXpUWOjVFat77t+AWT6sWmcB/GrrI4437bj2olZLaaVs8WzXQtM7TV+6M207AkV+OIUvk0jrTRQS/z2LaPM6/P8QI0vFsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773844862; c=relaxed/relaxed;
	bh=f6SQBnbLtk/tDiFJtuG2lyke9l9pURsRfwk7gcmlJ5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSgmeXor8JP9rA4wON5tm4FqXaDReTFKZdgJV5In5Xu+8BCx/otX7z6aO1aFKQ/lqg9rxnLISBZ/aWaHPl7V6iibmSTIL7XliY2qKzUJktjR+/Ej6RvkS7eYEr51/mCwE8mUFAqfYTEt3SuQ/KhopNUdxp8mnRzQlctO3Pfthjjg3QjdyAyeZzPIDRA/FiCI80S0CittOQtWxTLN7B6LLHwoDAwgEltTfIg/5MbTWCA0JgHzVlEpj3fvSwtBsvTLN1ST1vMUh+iwf+Je+Jd5DqNLlQvAyxrONkUVjRGllJRXM2ZMPNatut0ktsxu3nWKSMirfA0bWhmS3LIR2s405g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ngbdPPAx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ngbdPPAx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWj91vFRz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:41:01 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 773FE432F4;
	Wed, 18 Mar 2026 14:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F29C2BC87;
	Wed, 18 Mar 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844858;
	bh=QPe6wXvdAXZ1WsVrzW/I1Ea8rZgbDN6tCubJm34Z2So=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ngbdPPAxWjFSAiZvMouaeaCI+yNsZe/5Ks8XfwK23bbuJ+JwMl7yKx8wLk1AN3mNT
	 TMgJMbhcekeQl6cZDmfGyt8APhVYsofGCMvUz7w5d4VSUqCEDHmA0FWwHmr908obc6
	 Ca6I5aFuRQUI1yi4z3tpGvtErfL8rr5nKPdU3xQY3LcDhPRgWknRM3aO06irdxNWBm
	 2TlgtJ0ipwGbJWHORKvyo/BwbM/qZgR2EjBk9w3ApuIqc+XrUbVpU21pCoE11NYSNq
	 L1oljmENCVJ0s9YwPt8FVfCFDTEwjEsGgigo721LFalxDK0WN06IRwXdh82jFvxUSk
	 UiZTvvvmHDYJQ==
Message-ID: <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>
Date: Wed, 18 Mar 2026 15:40:45 +0100
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
Subject: Re: [PATCH v2 01/23] mm/vma: add vma_flags_empty(), vma_flags_and(),
 vma_flags_diff_pair()
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
References: <cover.1773665966.git.ljs@kernel.org>
 <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> Firstly, add the ability to determine if VMA flags are empty, that is no
> flags are set in a vma_flags_t value.
> 
> Next, add the ability to obtain the equivalent of the bitwise and of two
> vma_flags_t values, via vma_flags_and().

Nit: "two values" is vma_flags_and_mask(), while vma_flags_and() takes one
value and list of flags, no?

> Next, add the ability to obtain the difference between two sets of VMA
> flags, that is the equivalent to the exclusive bitwise OR of the two sets
> of flags, via vma_flags_diff_pair().
> 
> vma_flags_xxx_mask() typically operates on a pointer to a vma_flags_t
> value, which is assumed to be an lvalue of some kind (such as a field in a
> struct or a stack variable) and an rvalue of some kind (typically a
> constant set of VMA flags obtained e.g. via mk_vma_flags() or equivalent).
> 
> However vma_flags_diff_pair() is intended to operate on two lvalues, so use
> the _pair() suffix to make this clear.
> 
> Finally, update VMA userland tests to add these helpers.
> 
> We also port bitmap_xor() and __bitmap_xor() to the tools/ headers and
> source to allow the tests to work with vma_flags_diff_pair().
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


