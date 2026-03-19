Return-Path: <linuxppc-dev+bounces-18458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC9109025E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:31:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcCRY4whdz2ynv;
	Fri, 20 Mar 2026 04:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773941497;
	cv=none; b=I8B5ak+pVD54gw91WURf6Pmkq0cd7tz0/0brUeUmFPssdjziyKweNA9nlyXQ/HX2qFOIA8ZfsGTQTH1mRe/ruUUHevoCea9brisBiCtWCm9hfCQrE+AL138DjA6amMkAcZVkElpRYufEY/RK6fEs/3M4LL7aQEPOqCRy0cs+yU9I8LFZYFZD0HL8xVZ5tlfyyWJze3J+zPsR5noTa9jUe9LFZDTwuMElwK/875pWSF5AP1W4RColW6ZHsCpexXUPiP3LqUU2nFOktExVDwPR6Dm/k9L0WdIuX7Zfhe9V/xeidUFWwdq/OMgLCG6HHQiX6qtbJB7IBY+2UM8zyHrNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773941497; c=relaxed/relaxed;
	bh=4bl9t42B4LXiBnZarf9/q3l/mzIDatsBzDzzQR7YZIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D61xRSozUqHeh4RxXG6q50AWA0vjqqXe5qOVTZQmNjNfEVdXmRum45s+yvxwiqJO8TfVDX7qPgJBXCnY1ISsg1jVY+rHGHQUJnwIIkLvlixHSAr2k4KsQvioHEL/mpm20tTTYHLqnVJsUbx1NWhuI3eBbErhAFe130XWfIH9uPbvGpSFrTyLwIuUnxzYuoQC5cDaajLvqAs5ylrZ03sRSE/nXJFNjAAVqPhnwo3fqnYsdCOvwRkpqBx4lpsF+sp5jddoh8YvIx5XfScmnSf7GpWjd6gRghfc67nMIL/CmSB8QazAlE1KHPlk4i8RxGIUa8LLfamMSvZIyHSkAvx/IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SO7vfJuT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SO7vfJuT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcCRX5qXFz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 04:31:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C91160053;
	Thu, 19 Mar 2026 17:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13691C19424;
	Thu, 19 Mar 2026 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941493;
	bh=5DppXj3QcNzrGmdgZID5IYobrhntHlZzGlg5qMCJioE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SO7vfJuT4xUudvKFdjyC/XRHnDWKzUW5zhPZGOW4NkcLJWB/0zaBAPUZDEbzNniLu
	 o6gtnAQILi1Xg5RGSgTnobL7eO04ZT32Gx2h3qfXV8nubgacMQGFufOtrVHdeNmWgM
	 pZkRzoFA3bJPOKRw3mhQGFNORsomWmRnmNuVBbUaFpZmVyH6WM0IdprCTCpaX8+qFC
	 9GF8H3rbnnwghtEQQ9Ex+hdnihLJcH+Gq6I/Fk+KprdszHQSk8Tg0pLI8axTqiBT2S
	 atwtkQeokLlmSyD0VHX0bighzaB+U0P3innYYSr/zVKdE8T5gI4Lh0EcWg4r+v5cRx
	 N/zcFeNPSI1JQ==
Message-ID: <12bb9812-d7c4-44da-aa57-689ad520cb17@kernel.org>
Date: Thu, 19 Mar 2026 18:31:20 +0100
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
Subject: Re: [PATCH v3 10/23] mm/vma: introduce vma_flags_same[_mask/_pair]()
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
 <028d03f1b980b7f65fcc556db2e97224c06af1a6.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <028d03f1b980b7f65fcc556db2e97224c06af1a6.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Add helpers to determine if two sets of VMA flags are precisely the same,
> that is - that every flag set one is set in another, and neither contain
> any flags not set in the other.
> 
> We also introduce vma_flags_same_pair() for cases where we want to compare
> two sets of VMA flags which are both non-const values.
> 
> Also update the VMA tests to reflect the change, we already implicitly
> test that this functions correctly having used it for testing purposes
> previously.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



