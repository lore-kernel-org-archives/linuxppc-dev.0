Return-Path: <linuxppc-dev+bounces-18488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAEF108B8F1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:51:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcfWK5StQz2yYY;
	Fri, 20 Mar 2026 21:51:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774003885;
	cv=none; b=VBPsGk/8QgILRO2g8Pth4+HBmnYE0vtZlxj21NRvvMZfVTp3S1CT6mBAVJ1fteCQ2e3mXZm69843FL9hQJYwIZfidC5Gr2dwqoYm+VGn9jCdgCgO8ZjEWNwXukLxyItfS4D6NHgmhjXMW6BNeN8yKUDB4VFHQhAPjLXWH48bC+X8nhyC3CBWjsWjDFHs5oTrY/cpNwDvw4ghVm3CuXd6bHGlTQifmdtBIhiBCeP9uBHiNRFgjH3HnjnVs5iM6jBeEtVWPE7RCTD2fZLAL1jVWxfEp98yOUud0Je6V7V8EDpKe2f/hchLUCLfbltGn6mASM+VTCTIbKDXk60DnudeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774003885; c=relaxed/relaxed;
	bh=DKbCoQ3qBquckvlp019kFw7hXpGdetOvucEiY8aIUmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNlLEJ5snb11z6tOB4bK+b8zRjNzgxz14GBNLNSOx+SEOaC7aTZ5GoWQY0i8lb0ZtgxPpMyUdE7iRZKO1RphiJLSNPeMMiuooisUcjdr6aYLXd7L8KbAHyCj5BijuswSscAbvesda8S5iQ4aAhC2QqQhxgLeVpB70zm6RZF4T+K+HsxHDb8kv5dWnSOzbjTlGc5AAtxmiWHNFPuMtsucz3V4IVqf884w6FXMTEdzYZr1Lqc06uUsiy4yGLbpD+mj680V6sYSQ0gnjyn2bxFk8f1gFBw21Zho4/CMGvckNdXxDDLzfVFjgr2hyYfJjZ+bIhgbVFebVVHSj8Q9HjsuAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvQ6q+Lt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fvQ6q+Lt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcfWJ4DM4z2yY9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 21:51:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D6D6F60132;
	Fri, 20 Mar 2026 10:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3393BC4CEF7;
	Fri, 20 Mar 2026 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774003881;
	bh=1kycPrv8xITwEF0VVuzOopEOMjAdBs0UtmKgTytYl8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fvQ6q+Lt6csXQ3LFLwYm6cnCeDtBGCr02CIsjl1UXjYlr3fZ8BMsG3AFhxo458ZCa
	 +qYpGTorkZJUoSz2KLgM+8v53n1WJOnltl6z07l5stKzZpUnrWYEz5FYiN3Nd+Jdmh
	 8SClfiC2LO/qPw7ZNAT9I5oEK8JjSkMNRE+Nrm7ekRgipBjhHQB3OmHjgPWwn3piDZ
	 h9DkUtF/Zkavrff/L+X9y6IoV/GXTCjuHOFy4E/EZLIw/I9GYQQxnoeqCJ4GJE74BD
	 X+Z2q8v5Urpdb/OoxHDRr56qpMqMhQXXZ8oYFfyAhWL2CpRfz05crij8p1GJ5Qo9Ia
	 XZOMGmHBKHSXQ==
Message-ID: <077b237c-32ab-46a0-947e-17657cca5b54@kernel.org>
Date: Fri, 20 Mar 2026 11:51:08 +0100
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
Subject: Re: [PATCH v3 23/23] mm/vma: convert __mmap_region() to use
 vma_flags_t
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
 <c587f5ed177fd4f62b66cb8d5321fa56eeb6a69a.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <c587f5ed177fd4f62b66cb8d5321fa56eeb6a69a.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Update the mmap() implementation logic implemented in __mmap_region() and
> functions invoked by it.  The mmap_region() function converts its input
> vm_flags_t parameter to a vma_flags_t value which it then passes to
> __mmap_region() which uses the vma_flags_t value consistently from then
> on.
> 
> As part of the change, we convert map_deny_write_exec() to using
> vma_flags_t (it was incorrectly using unsigned long before), and place it
> in vma.h, as it is only used internal to mm.
> 
> With this change, we eliminate the legacy is_shared_maywrite_vm_flags()
> helper function which is now no longer required.
> 
> We are also able to update the MMAP_STATE() and VMG_MMAP_STATE() macros to
> use the vma_flags_t value.
> 
> Finally, we update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


