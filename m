Return-Path: <linuxppc-dev+bounces-18486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61299108B8ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:16:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcdkh6n4hz2yYY;
	Fri, 20 Mar 2026 21:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774001772;
	cv=none; b=dhmUeQcggVMiDCoGRaX25AlPa4AMUktO5QCshjAXLjVc7NtDAFQihcmPj8dKPOiaVfHoN2DT0dfmfo56glGnctN8YvxsXjtpNfkcF0jIQtFrLepqcYFgiRvOhyp7aL3GwK9TufSlogwzTTALHzwCAIouSOM6zAuiQWyIRITRENIcKBHrYbYsYEhTU1EWO4mYURSf3qbG643nu0HbDUA8Qa9QQZaSiWoCvcVZJZ6+dwiXOQDnQhoUekkQ/65WJV8Ukpv+Dkp2+9VN56bIMsxpYAinOoSrvDsSl4+iBvFDfZKF/ZNU6NGHDbkf4hbnqps9A0zKTEA+VCbMWwGdt1TkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774001772; c=relaxed/relaxed;
	bh=TycOeWVZquacUlciRj5W3aWhpreqS3TXqwdxrkjDt0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYy4ORLaRQmOcV8rnGCHJriypmE5KnRzDSIMNqC9vW+MsRlo5MmwjqkFrp1XtnN6R35luHteyVjg8U/dBwdF9Jjeoyf9jErh1GmMNzNrV5xj92puBGZa2d8nwx+IJaWoHrp2sDDRwQ/8qPFuyk/6+R33PP9VZX5+T7s1HpS4Hdw+9S+BgcDvQMFOqbjQV7BW1ATk++YCtJ3Nxfuzs6y22YvIyaUp2MiHRnVHQsupuQvHmA1Xs8AteKa0P8z6PO9YnyaD5xzjezLEKZ8fMRds05/cUtPWXB/c6lKon1Dvv6uag1Uw1mwSZxtWW72UejiGQw1qG77KBwSraWstOf6cTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VpGnIYfO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VpGnIYfO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcdkg720Rz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 21:16:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A6B0436C8;
	Fri, 20 Mar 2026 10:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FF9C4CEF7;
	Fri, 20 Mar 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774001769;
	bh=ap9t23GAznSjlYBwe3WH7nSlcvQ4uwkCMM8JPtwfdBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VpGnIYfOhfS5un78DFGTJ5loTHw41DGnYvLF83kfJLhLDtl86vDxsK7+kZYUzaYnE
	 5V9zcIkNRIqSzj4tbwQLydHMYDPmXOCMLIySJ4ULjxFk/lefzNfI9hnLeFOCIGnnDl
	 mAxr5fguFL4uy3itIhWz2Fy0cYKrzKJpZhkuV6STy5rmqivM3mA46b4dMOAVIm8aX5
	 aL1J/e+lrGnyidQShydB7ZP25CoL8lbUtLPYsSX+m708iSuLKQWfBy+aNV3CStt/8O
	 sw5JQcZVkYlp6nZd/W4kU0jl8JC6+CIhgGnco8oF5shbFK5ws3inZ7cQkjFITK2eiJ
	 D0/iPE2qO9fcw==
Message-ID: <a7535063-abaa-4f67-a090-4a47098f10e7@kernel.org>
Date: Fri, 20 Mar 2026 11:15:52 +0100
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
Subject: Re: [PATCH v3 21/23] mm/vma: convert as much as we can in mm/vma.c to
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
 <44a952b98d68fc231ab231de6de04b077866bab8.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <44a952b98d68fc231ab231de6de04b077866bab8.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Now we have established a good foundation for vm_flags_t to vma_flags_t
> changes, update mm/vma.c to utilise vma_flags_t wherever possible.
> 
> We are able to convert VM_STARTGAP_FLAGS entirely as this is only used in
> mm/vma.c, and to account for the fact we can't use VM_NONE to make life
> easier, place the definition of this within existing #ifdef's to be
> cleaner.
> 
> Generally the remaining changes are mechanical.
> 
> Also update the VMA tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Nits:

> @@ -2338,8 +2339,11 @@ void mm_drop_all_locks(struct mm_struct *mm)
>   * We account for memory if it's a private writeable mapping,
>   * not hugepages and VM_NORESERVE wasn't set.
>   */
> -static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
> +static bool accountable_mapping(struct mmap_state *map)
>  {
> +	const struct file *file = map->file;
> +	vma_flags_t mask;
> +
>  	/*
>  	 * hugetlb has its own accounting separate from the core VM
>  	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
> @@ -2347,7 +2351,9 @@ static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return false;
>  
> -	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
> +	mask = vma_flags_and(&map->vma_flags, VMA_NORESERVE_BIT, VMA_SHARED_BIT,
> +			     VMA_WRITE_BIT);
> +	return vma_flags_same(&mask, VMA_WRITE_BIT);

Another case of possible refactor, if you agree with those pointed out in
earlier patch.

>  }
>  
>  /*

> @@ -2993,7 +2998,8 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  	gap = vma_iter_addr(&vmi) + info->start_gap;
>  	gap += (info->align_offset - gap) & info->align_mask;
>  	tmp = vma_next(&vmi);
> -	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> +	/* Avoid prev check if possible */
> +	if (tmp && (vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS))) {

The parentheses around function call not necessary?

>  		if (vm_start_gap(tmp) < gap + length - 1) {
>  			low_limit = tmp->vm_end;
>  			vma_iter_reset(&vmi);
> @@ -3045,7 +3051,8 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  	gap -= (gap - info->align_offset) & info->align_mask;
>  	gap_end = vma_iter_end(&vmi);
>  	tmp = vma_next(&vmi);
> -	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> +	 /* Avoid prev check if possible */
> +	if (tmp && (vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS))) {

Same.

>  		if (vm_start_gap(tmp) < gap_end) {
>  			high_limit = vm_start_gap(tmp);
>  			vma_iter_reset(&vmi);

