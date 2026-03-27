Return-Path: <linuxppc-dev+bounces-18917-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9516910BA43C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:27:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhv070ZL5z2yrD;
	Fri, 27 Mar 2026 19:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774600055;
	cv=none; b=SfVkHyIHhThEacSMchLVb6jfxuq7vcO8DntJ9NrM1301BLKMU2GHFKO/1pnLucNrRQy0cKgzSXIhuyxZuQ4mLF4jLUwES0rL9oZARpDycDK7aYKi7HVASgyFThsua4K4f+ALCehBvu74clFYd+38C23dDjCn4qQ6L2gam5vzGzpTiwro1R1mmpw4Sk3e9vDJCUxnr9roIsxbwDunJouj7BFIAV6GNDyU2UUGr1CqWEVDouK2U8inXrGjaFm3ZAWsY9rLXQgdHPSUbUODu3SaVpgGPneKhS+i21ZcsER8+gy5impbE1eW25vcSLYaHcnILt4F3aGJ5zAsViaga6vFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774600055; c=relaxed/relaxed;
	bh=DoxlJLpzOFREqNzYvxXK+7Wyu48MgzL3nY3gxnlOqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhqMFsBeCWWGb7SDfz0Da371M30hBcFiCBPyQAQTAhnAKpLQlLEQWPVN6VqU/s5XPlOh50SblMiwZdPjiFzucGl0gvwfa0lXjL1DcPDAr6CFGm8GbmvHcRuFcxO/PIfPjNqYbtkBWKRhRLU4VFga9zRHCmvpWhcmnjcw4qwcC1D8BUzaQQKPBE+9Tj54sgMY+jv3crpC1xt6n5dcT4y9baEh9OtsVzA5GEd1cMHr0b59cfStIIEhDmzAXjAm5jlMaqN+rxV75uHw4A/YCZ0ZrdbDChPvxV2s2ZJHVpPJJY1ooev0NtKPyjIxF17w+eFymcG6EUhf4byGk9Fty7lzJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R1FdErCm; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R1FdErCm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhv060Nf2z2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 19:27:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DE7C6132B;
	Fri, 27 Mar 2026 08:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE27CC2BC87;
	Fri, 27 Mar 2026 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774600050;
	bh=rkUuEott97cRG5EOSGam/2vURy0iz3AdOFQvnDvFuRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R1FdErCmpRUfW0Lp5ZacGDOniuT0AwJlAxVfVuljmrw2wCU7cAUPkqPI98IpTty16
	 NBIRt4fVUPiLgcyTUvdyX/EfQJaP/Fn+rUGOf8JpxGhClHrnG7f8KRPoQz2OYh1WaJ
	 H5o9DZM6WUru2OjwRibUTWgPS0u+3sPFUJBa/UzXV6LBqi+UjomHjJiBFcJiETq+MT
	 87z1mRd67LAk1ZwXpjMe9nbD7JZY1/qttMJlLYp/x5WS7qVfoyPw2boeixrn5xIQMI
	 FsKHOJV0ipEd+DPBQwi0B3HVifAvbXhgvRqUcdTuwlnZX1A9XjKSccTw9hYhAHIm+3
	 pgbO2wr7F/yFQ==
Message-ID: <c9bec45c-3312-46a7-a7bc-a7dba95bcda7@kernel.org>
Date: Fri, 27 Mar 2026 09:27:16 +0100
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
Subject: Re: [PATCH v4 00/25] mm/vma: convert vm_flags_t to vma_flags_t in vma
 code
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
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
References: <cover.1774034900.git.ljs@kernel.org>
 <20260326225031.87e04d2c652923bc10aef0ee@linux-foundation.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260326225031.87e04d2c652923bc10aef0ee@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 06:50, Andrew Morton wrote:
> On Fri, 20 Mar 2026 19:38:17 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
> 
>> This series converts a lot of the existing use of the legacy vm_flags_t
>> data type to the new vma_flags_t type which replaces it.
> 
> Series has nine unreviewed patches.

I think I only skipped those that were tools/testing only, because I'm lazy.
In case a tag is missing in a non-test patch, let me know please.

> Again, I plan to upstream this as-is - lots of Lorenzopatches remain
> unreviewed and I'm OK with that.

Ack, thanks!

