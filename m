Return-Path: <linuxppc-dev+bounces-18361-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335A6103E17A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 14:42:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbWl569qXz2yjV;
	Thu, 19 Mar 2026 01:42:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773844961;
	cv=none; b=LNxmQvJWkP96GCH2NiiuizYV0lwUEwmVCG32wdTch6Pu2xi7Vgu1cZDM7QQkgTBQ0XIA70kRJSPCWXBpd2kvepUCrXhKN/3RbIgn6fOfJOO/FHhwpRXN1j+FOiuZmLTUp79k16jPksy5iGeWEZ7rwfWDJya3/gLCA0TTyUjpf7npt1cc/lPo77CeEcEzEA1L9aO0DISrRs5UrdMGZqjXAyzbYq3/4yx4BBLdSpwU6z4Eee8lnpSbFV4UXsvzYV7wm7y4tzwaWoBfI0ObgXUqmN2wh7A5NMK4SKmSnX0C0mVSUbAbwHWMVJVHdtXF/VNPB2UlDfGMhMOZm7ndbiFb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773844961; c=relaxed/relaxed;
	bh=FYBZKpgI6tybeKvEVdsHvPcDW9/RMvTX7D+4dmU7p0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdWRCoSV0/M61IZy5u2qYJ2mFMy/blnaeW/sd985cGMHIJvjO9H3SyzlCEm746GR5+oxgfg8rKpWerTkIafT2OBc4ja/WfqZGmSPkHQNek5dm63OPFv08BXCshpYlgVXCIlqCD35iYc8IlPsh0SYCOMPXYTsjUpmS0jT6g0z4mKaRpeIhGYhyBvWGEJYYLo7oUxdE0PmQItFU6bCHXj/IeMUDn6IGgoNSbSYnRehrL7s/CVxma9Nn8IEROuZlSTvmcrYK97Fj2nBJj46S1D1lOo16n4Dx4Ub9M+mAjj9KgAjfC7YdyS5AdlrbdSsI6VHI5P2j0+JB+7kqjAczcXaVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Brfo6kwq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Brfo6kwq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbWl46YjLz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 01:42:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 616DA600C4;
	Wed, 18 Mar 2026 14:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9AC19421;
	Wed, 18 Mar 2026 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844958;
	bh=o3Vqfegoze9voxgxHT8hNS1xVKI7tWzSZbrQEQde8dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Brfo6kwquW7beM2eQzf+4i3bKNLjG6pitESp5wXj5j3/u4EMe+7TKVtW2kDQi189b
	 ksXjz2HFO5CzN39JGKjLjl5Cz6xte8b16X4vUnfN0qyNtCbUwrFXww9J7LQMWeH4tV
	 XxLcTaXa36dEp3pR9f5ACT1A0MF31tlrAm2w9z71HsxNJA+lhDEy4wTslHSjno+Jr+
	 oUiTxttBYh7Xfz9WqNET76CHoWG5D2z7or5j/VSvQHP6oD/BMerKadPNSlJmAi/h8i
	 4hOfDPVsWi8QZQJI/KS7nt3ccmQBTwTGOCza7YTyeCo9Fsju2QNwapLG0bKt1L3tAC
	 KTJlXh0jWxX4A==
Message-ID: <b706a64f-c142-419d-a151-931847cf8444@kernel.org>
Date: Wed, 18 Mar 2026 15:42:24 +0100
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
Subject: Re: [PATCH v2 03/23] mm/vma: add further vma_flags_t unions
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
 <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> In order to utilise the new vma_flags_t type, we currently place it in
> union with legacy vm_flags fields of type vm_flags_t to make the transition
> smoother.
> 
> Add vma_flags_t union entries for mm->def_flags and vmg->vm_flags -
> mm->def_vma_flags and vmg->vma_flags respectively.
> 
> Once the conversion is complete, these will be replaced with vma_flags_t
> entries alone.
> 
> Also update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


