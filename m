Return-Path: <linuxppc-dev+bounces-18152-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ED0106ACE2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 19:30:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWyQC043rz3cHS;
	Fri, 13 Mar 2026 06:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773343842;
	cv=none; b=S5Ts0/77XSJkdMdprX3uk4l0g6VGylwgaoyL9UBI5oRhQwwHiQzXkay+7IFdAOhgVX8Ey4eJagsdA4gY0tZ2AR7cN4CCLcW8uUvf4Wx/ryeaR19EkptAyOWf98V6rUsjatb3bY/81AFSGMVab7uNqBZc6tlgb7xlcm1KzqXcyMNRAHxD5lsCFhfzGwan73albsYNLLJO8o/yvHnZLwfZu+XHi3xbVIM4GEjwPeikVoIb9uabO4F0x4r3+DHPLXpxBQBs0Z5h15VIba4/9Cixw7ssktFZ4wVKHcXoBFQ9U3/gtOLbUUo0v28aDAmPytO1kavqjWKngDh3nbmveN8YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773343842; c=relaxed/relaxed;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh02OOgI4V7vBJ87a8yJRVPiFc/narsvB7yyJQ3+n6wn4uqcNarbPqXcJpWqxjd1ecx0LcDVTgG9lnmP9DClPneUI4+GUmY7CwwUPodNcr4hXPbSMN3355VYYD5m1DmEKZHjVsUD5znYSmMHi+X927D5KzQ2u6u2yEcq3tGNDcjG/Gq0U9wSl4cpeHmA5L8U0hmEmXO+lFRrWO6oHpDR4vNQF7D7USM/eCRUYuJAGINX2rPKn2koq5p3h39eM11h+lApbRhaDfBVYDGuSc5NKYI81MU3H1JsDCOQ0qzm/kqIO32TUE4rcV0CkFdXmS+rD4rxAvYhDk2//v+bsGwIjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MpZymGjS; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MpZymGjS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWyQB2mNlz3cGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 06:30:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 406E160142;
	Thu, 12 Mar 2026 19:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7617AC4CEF7;
	Thu, 12 Mar 2026 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343839;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpZymGjSfeezPsAxTR8is/y91vPi0xEPN0K7IFHZz77hM83w5Vj26pRQa3IjU+zwy
	 tbXTe0vQVq6U2m+k9m9HlIImXQzU1M/vS/yGyO63HG8DiJ/vWb+uh3H//T9IyA4hRD
	 LHmNXH5dbPF1f5a6PD6COunVyQVhVzAFmLKrarzr4fRbA4mQYsRv3xiTnLsrX7/jL3
	 WHpFX+yadIsp2XaB8uyt+zH82bPt5Vn2z3z5NgdxkOECEMl6n7PpL7zmNASsxMRVme
	 OdW87Byykc4nbucZ93idCIAIBC9mWbsdzDxSrxwiqiZl0Wrvakg+Vhl50YtatzUzD4
	 wIPQgYElJZvAQ==
Date: Thu, 12 Mar 2026 19:30:38 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
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
Subject: Re: [PATCH 02/20] tools/testing/vma: add unit tests for
 vma_flags_[empty, diff_pair, and]()
Message-ID: <9198d18c-a1a9-4321-bf34-13e48172eab4@lucifer.local>
References: <cover.1773340636.git.ljs@kernel.org>
 <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>
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
In-Reply-To: <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>

(Please ignore this patch, it was sent by mistake, the correct 2/20 is [0])

[0]:https://lore.kernel.org/linux-mm/ae25ef9cd48e20553babaad3868da1cf74f16af1.1773342102.git.ljs@kernel.org/

