Return-Path: <linuxppc-dev+bounces-17826-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58748FCB613
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 15:31:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS9NN4sQ7z2ySS;
	Sat, 07 Mar 2026 02:31:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772811060;
	cv=none; b=eT2MGw0fLyc7U/tFzF6th02oNdyfkHDH0bBGQc4iz6oN9If63VInq/Ikt+XWSgYd4EeQjASiATA080CHOF/o8y4oYEfu19XZ1rkN/tmu6lE4coYUM33J3EajGr0hxF0yOUmXml2Chl40w3VN3LRTQjkAVRieBfdrcVGR8sE9KbFI0m9EovV1Itnkb90NTb0ZssEVzWDx9i6MyJ20YtiUmeF//yzZJk735rWDwX3Y/Oica2vWSyfLzZss3rK5QkZAkHHJTBuUxzuu39K3SBP2CFOjnz4yDmUoLy36mXfaTkQyqM1HM3YsPIXPLIKbewcSyYGv8Veby2wVGrhF64Mr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772811060; c=relaxed/relaxed;
	bh=vUfo6geUlLgmheYj0TiS5OJJ5PkiuTaIbtAjZT9aCig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI/k/FV0yEGIMh6cnEWcNRpE+tNZk/MWwttK4zpoplwWVgJlpGGcbe4jiiPLne0gXGE8SrkYxg4N44wg56IobSg8AR0MRxB/6sfsy20ffjM3GlVjiELkvGPQRwDjlRGtNGRRkRoeUpi7fpr8uOAJsmO11pIoYWgQ6Azun0Vp9du+57sPtTpShgm7dx/POycw1cKv6aUzBxYjy5xfoVWZslo41uOcuOIhMf9aTxb87x6HDnXOF5SrHXw/k1fg+TkGRu4BkZTQ11h948VXS+MH7xBYA2KFsHjIu2nRIrN9f0Y0xBYJ2ePed4zjCjsl9Ev80PmycKzg94lLWenFoG2hng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NoF4well; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NoF4well;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS9NM523rz2xqm
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 02:30:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 63CBE44445;
	Fri,  6 Mar 2026 15:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C18C4CEF7;
	Fri,  6 Mar 2026 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772811057;
	bh=FI8J0CjY0WXJD6/7B/GSNXzO95+rzP9IqNX3Ca1r71Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoF4wellfs0vfiQzzobsNQGra3x4pLi0cJws1pr+x30i0RlpCqJKZZQVnD5XctHLE
	 g4y/n6YSj8XujqnVBpKz31Y7JnvL7UdCI++Y0SE/oEzTSRkMPbe7ByH7OH4D3BASg+
	 CBo1HJsAMYGWlG30XfhhShBCL7RW1zdWCcyOy3irWZwJ1a3rHtXW66CQ3+CBkdx13c
	 bA2kvLRek/KpwCumfN4HNI3bTSoGzTxTXr9CpyY/7TbPZphiKH/pcruk7h3JU8hnnU
	 eRuhStXyC+hP6o+ghWOC/UBwAHjRz2QPAFfMVpGkg1hsRmeOSLZmW9rqScbJlP7Ohl
	 8c5r5taPhJVdA==
Date: Fri, 6 Mar 2026 17:30:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 0/4] mm: move vma_(kernel|mmu)_pagesize() out of
 hugetlb.c
Message-ID: <aarzJeKhv9S9QOnW@kernel.org>
References: <20260306101600.57355-1-david@kernel.org>
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
In-Reply-To: <20260306101600.57355-1-david@kernel.org>

On Fri, Mar 06, 2026 at 11:15:56AM +0100, David Hildenbrand (Arm) wrote:
> Looking into vma_(kernel|mmu)_pagesize(), I realized that there is one
> scenario where DAX would not do the right thing when the kernel is
> not compiled with hugetlb support.
> 
> Without hugetlb support, vma_(kernel|mmu)_pagesize() will always return
> PAGE_SIZE instead of using the ->pagesize() result provided by dax-device
> code.
> 
> Fix that by moving vma_kernel_pagesize() to core MM code, where it belongs.
> I don't think this is stable material, but am not 100% sure.
> 
> Also, move vma_mmu_pagesize() while at it. Remove the unnecessary hugetlb.h
> inclusion from KVM code.
> 
> Cross-compiled heavily.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> 
> David Hildenbrand (Arm) (4):
>   mm: move vma_kernel_pagesize() from hugetlb to mm.h
>   mm: move vma_mmu_pagesize() from hugetlb to vma.c
>   KVM: remove hugetlb.h inclusion
>   KVM: PPC: remove hugetlb.h inclusion
> 
>  arch/powerpc/kvm/book3s_hv.c |  1 -
>  include/linux/hugetlb.h      | 14 --------------
>  include/linux/mm.h           | 22 ++++++++++++++++++++++
>  mm/hugetlb.c                 | 28 ----------------------------
>  mm/vma.c                     | 21 +++++++++++++++++++++
>  virt/kvm/kvm_main.c          |  1 -
>  6 files changed, 43 insertions(+), 44 deletions(-)

For the series:
 
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> base-commit: f75825cdfc4c5477cffcfd2cafa4e5ce5aa67f13
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

