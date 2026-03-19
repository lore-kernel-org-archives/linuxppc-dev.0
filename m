Return-Path: <linuxppc-dev+bounces-18459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB54F108E1DE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcCc42C32z2ynv;
	Fri, 20 Mar 2026 04:39:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773941940;
	cv=none; b=Rzju/jnLEAzOQAi07Wgb1ZAemBvfiIFsUsEmbtmoSMGC0NFV85oh4w3/j4q6EXazxNWYxRhFaEBn7v0jJUL6lL+DIcohIjasiQ3dJl69izrbpiECai87JSS8MDi0XxjfPFGZuuocjS7BzDSiL2vfb4eVYW3KTAcvW06rzTJnqXGUHlgobi3zlFTjLn2b4/GBqMDorixlUdJZ7/hkmWi+SsHm353s+RyZyvdSioMKDbscjlnbynEbfWjvqU5eMH3xOG81HUfewg7tRAvu+z5advgvOpEt1ca2G0NDeDE9K2sAG8eWJEzFazJc6TogvxCa334OpKR2G9SZZp0MXFbAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773941940; c=relaxed/relaxed;
	bh=EuEjoftA1+hiXPIV+9bi9DU3ZElxVyYPyAtLVA/TK/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuH41j7DALb0CDqZxFG+jAeTr/H6vBJroBONBBd00NTspdmT8itbCaVYnY9bJluDxrCzp4NtoKEgMESZ3uLQ0ShvfdXBjijD8eObwTwanZJYitPavwfg9PIvOSKnfx/95kwJ17dRi3WjW9sl4D7ULSSFCqgj8e7BS0l10fnT1ddM47biw6cXmJt+b6CLP+FZnj5eVrMf3T1mUSrbmpkwvX9LWL5KGA8ptA9u6nhz7YCY8aGKaBFtbEndjfwxpaosWx/4TvrKbNz8w5qZ8XX6ECGMfJipFPlhfojmp1OSgHNqeZZRIG69qzqadR74aMN0pDOnPZbgHpU14ZBmY3Uexw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AwsdLrRj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AwsdLrRj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcCc314Hbz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 04:38:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82C9640786;
	Thu, 19 Mar 2026 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179C3C19425;
	Thu, 19 Mar 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941936;
	bh=Hivr+4pDKuDtiIkYu2gbJDWvORBSel+6FMp1v9HmeG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AwsdLrRji7S/5bKRIRoLy9oMGfPTq7CI03hWA5bepga8vECo4/3RvNVeYeizQKIwW
	 R9UN16H8ZaF5yK8yAVtizkZh9zEgm8LSZqWA/t1UeGp3EhNubKGLgbwTBmjS9ANHPQ
	 CKr7ivIecBornjtAgZMvvL1T+6+bs5ktKzdaTNRhc0LyaeH1C0j44VGifmhwvaAXJM
	 POmn8ELyxElL1bT/10KjExBS16LBEqK+xysiliEZ0LVwQMpB+qDKVPe4l/rYse1i4L
	 PzUuZBXSFeyQ5M9ynh9jcooBzTBMkDLSF06baAlOeNctRGjpEyjMmt7dSbkQmkwwU3
	 AvDqZkxp71zew==
Message-ID: <b5f6f86a-3321-46ee-a481-23c2ee219618@kernel.org>
Date: Thu, 19 Mar 2026 18:38:43 +0100
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
Subject: Re: [PATCH v3 11/23] mm/vma: introduce
 [vma_flags,legacy]_to_[legacy,vma_flags]() helpers
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
 <4fdffd05ee7fabe2dc313850a4300bf184beba69.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <4fdffd05ee7fabe2dc313850a4300bf184beba69.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> While we are still converting VMA flags from vma_flags_t to vm_flags_t,
> introduce helpers to convert between the two to allow for iterative
> development without having to 'change the world' in a single commit'.
> 
> Also update VMA flags tests to reflect the change.
> 
> Finally, refresh vma_flags_overwrite_word(),
> vma_flag_overwrite_word_once(), vma_flags_set_word() and
> vma_flags_clear_word() in the VMA tests to reflect current kernel
> implementations - this should make no functional difference, but keeps the
> logic consistent between the two.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


