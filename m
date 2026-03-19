Return-Path: <linuxppc-dev+bounces-18457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F11088E60
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:28:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcCMP4fkyz2ynv;
	Fri, 20 Mar 2026 04:28:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773941281;
	cv=none; b=XyfOzuf2644tc9ryqWxV7G3Ex+f9VZY3scm/YlPlIEqMfluU1OdWeu/y1kDpkMqrqasIzkZl/Xtfqg1JBsw50GPa8R9ByGnKV4sXzkOSUKQTIojNeike55pOE/dwXFt7GiRgeDjuc/Y81PFdJAFTunv0OEAAbk4JQ67yLV/lS2niZMl/KaMW/3XUGXSucZbhGfufi6G2t1jwRLrSkwSd0wihiUrqTbWYnbzTj0si5M2H2v2g5vOkKYJms0NSMs75uMwWtLxkLmBMc9v5b+OHkKPr98VnUjP0PcYgH+8GSSloodRoe5/srtgYevlHujsTEN91xdL674Mg0oogm18z6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773941281; c=relaxed/relaxed;
	bh=Yq0Z4EvpFDaoTFhe2HEhJ8Ykr3BfFmyB7X6eG+YCHX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ny7onHF1zdngLKWUF8Nstz3LhDWF+uK/nxdeBcOuMQxffgN1lVvIbXIra5osMa5jwLzxm2hB+97h54SG871A1WGOdmBZN18qIAyRiQ+55IEjdhT+aZ958GDbX644ar3mshn+r092xSqZB7xgGWlfa9Oq+BJIVKMWsJ9JuVZSdzGmUGLEiZwO1K7bzLXJ7kLSsfpVC56C+33M4xnFKbCH4ekdbHHkShHUe3MrX2FOMsLZfomtsuVIo9eAR1CMZIlbOARa5HJI7V0j53POOjgUmugy0C6M5JXb/cV/EWsLvjOyfYQEuje0pbIzrCAUt3CshJcr1dn7sxNhCDlvT4YzmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ni11x5qH; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ni11x5qH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcCMN3nk8z2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 04:28:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C229960053;
	Thu, 19 Mar 2026 17:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C008C19424;
	Thu, 19 Mar 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941277;
	bh=wnmsKZ1D1KfzQIEHQIk8Eq+6eKtEf+x/yXH1sCkJxLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ni11x5qHEQ6U2LG6CI2Vjyjh8t7GcOt+96zl91V9r2Di7PZwwNlUqIZVECtb5H2w5
	 aQAItB7sZ8iybPVrttsTi0XPAtP+zr/ASNQ1euqvkmHf5ydGP6UZqDwpxf8ALEXyxe
	 8pCPJtXU8n7uKWcfbNhSoQVeIfHgpw1D/+DaX6oVnt1IqKlW7ofgHpLFNeb9PCwYJO
	 z9xyzSEe9mrHUJmqAXRi85ear0h0WPeoMl9z5fS+NVNSAnh6OhiWOJtu46EqEDWHpx
	 ropdkm9HGkEYmJPnTkidmpipti0N5Xx1ibqNhPY2cRQYPPciTZ+SLEtNcx/Gs/2xYI
	 UmlXn7wXZROVA==
Message-ID: <624d9f1f-656a-4a63-888c-e953b90bf56e@kernel.org>
Date: Thu, 19 Mar 2026 18:27:44 +0100
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
Subject: Re: [PATCH v3 09/23] mm: unexport vm_brk_flags() and eliminate
 vm_flags parameter
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
 <297c7690f17257ba11a7b8c94fe54709a64d89fb.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <297c7690f17257ba11a7b8c94fe54709a64d89fb.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> This function is only used by elf_load(), and that is a static function
> that doesn't need an exported symbol to invoke an internal function, so
> un-EXPORT_SYMBOLS() it.
> 
> Also, the vm_flags parameter is unnecessary, as we only ever set VM_EXEC,
> so simply make this parameter a boolean.
> 
> While we're here, clean up the mm.h definitions for the various vm_xxx()
> helpers so we actually specify parameter names and elide the redundant
> extern's.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  fs/binfmt_elf.c    |  3 +--
>  include/linux/mm.h | 12 ++++++------
>  mm/mmap.c          |  8 ++------
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index fb857faaf0d6..16a56b6b3f6c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -453,14 +453,13 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
>  		zero_end = ELF_PAGEALIGN(zero_end);
>  
>  		error = vm_brk_flags(zero_start, zero_end - zero_start,
> -				     prot & PROT_EXEC ? VM_EXEC : 0);
> +				     prot & PROT_EXEC);
>  		if (error)
>  			map_addr = error;
>  	}
>  	return map_addr;
>  }
>  
> -
>  static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
>  {
>  	elf_addr_t min_addr = -1;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0c35423177bf..42d346684678 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4005,12 +4005,12 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
>  #endif
>  
>  /* This takes the mm semaphore itself */
> -extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
> -extern int vm_munmap(unsigned long, size_t);
> -extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
> -        unsigned long, unsigned long,
> -        unsigned long, unsigned long);
> -extern unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
> +int __must_check vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec);
> +int vm_munmap(unsigned long start, size_t len);
> +unsigned long __must_check vm_mmap(struct file *file, unsigned long addr,
> +		unsigned long len, unsigned long prot,
> +		unsigned long flag, unsigned long offset);
> +unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
>  		unsigned long len, unsigned long flags);
>  
>  struct vm_unmapped_area_info {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79544d893411..2d2b814978bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1201,8 +1201,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	return ret;
>  }
>  
> -int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
> +int vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec)
>  {
> +	const vm_flags_t vm_flags = is_exec ? VM_EXEC : 0;
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	unsigned long len;
> @@ -1217,10 +1218,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>  	if (!len)
>  		return 0;
>  
> -	/* Until we need other flags, refuse anything except VM_EXEC. */
> -	if ((vm_flags & (~VM_EXEC)) != 0)
> -		return -EINVAL;
> -
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  
> @@ -1246,7 +1243,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>  	mmap_write_unlock(mm);
>  	return ret;
>  }
> -EXPORT_SYMBOL(vm_brk_flags);
>  
>  static
>  unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,


