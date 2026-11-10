Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CF606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNcF2hrX
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNsR714D4z2xfK;
	Tue, 10 Nov 2026 14:22:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794280963;
	cv=none; b=UMQcnEf5qzLXI1RyDeE34MyGZaYv/6/4K2kFXYvlH7L3EjIP4eF7zfBVNc/yeS3dSL+5uy+iqLgdoZPAgzYCVmkD3+Pj45PRZhskMJ6vAX24g2j+fh5ZFrweI5Q9iNJ3IaUTZHU3+D1E8/RoNi2LYAdNf1JzoWH7sZqCwajjfFR8qPMrR56Nr4SeFLmNJDhL16vibude+qOrtyGn+446QwDFBPVAHqU1IGlo5yJlQLTsyf1HUpsULXurmIMaNddcXaw6Gtfyp8sAXSJElxoDK3vEPpEViLRlEjO9R6964cKdBQvldCp3IPkYIOv7s5AjtH+2J2Lzk9yuWTOl3CK4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794280963; c=relaxed/relaxed;
	bh=W/wp6KJO63iMMRJlz6HcbO/i7czGvSk/CyVD5tv8Mv8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=opksgSTn00mgPPcJlckzNvZixFtbPg7SMn8bYcOrVzMeq+ZyP0bfNAU1v8LRkJt3cbRss4fOphHM2aMwyljiAQNZKmt9xVbVs/uAnofBxkPPr+UNcMRrjbbckwLqiq8lGZ1VkRy2gvmrT9UKh7aEkYbMIwEm3buD41J+ksKgnm0rByX3c4GPpdiKmpApg/O9sFiY3JjvFK1ErCWFOT6bUCPx+tbmIFb5ufksfVt2vsUOuH4P3sm/IGOXtgIfc6I8aLrJCqSF3pBl+VSaq7kTnrG/S7CRfVChyCgogsdGFIrrS7BoEv386P0W36EwshJMjJETMSG5yrhjlOjeNcr8xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNcF2hrX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dNcF2hrX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNsR53DDqz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 14:22:40 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so2105409eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 19:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794280957; x=1794885757; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W/wp6KJO63iMMRJlz6HcbO/i7czGvSk/CyVD5tv8Mv8=;
        b=dNcF2hrXQQ36yfqkQibpAtzk/+umOo8U76zfuaAer93WreATIUIuS7wM7mF47zSH0M
         RTn36qAotRqAPviW1wrVt5EopflEoF8KuMXH5JsBaSjPi6muhJIJjf0J+NV+nW4WD/iT
         LGiUFHeIL55FZd4+AMwKg+Sxial9NefkQJxgqqgpCU8rEG0QPVepnQiJ5EGo3s8yg+qf
         sh3n3Oxnwfs/HiDG+MGMyGWs/hv8bxnTemzrwUXuVGN8X4cK/zrj7FROcr6RmXmzb/QY
         3vSCF1HgEzTrDoZ25q4we/Sso8Y/+exVbDPDHxHfYJ9cHTTul9P9GhIcOJm5x6Is0Mgz
         GFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280957; x=1794885757;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W/wp6KJO63iMMRJlz6HcbO/i7czGvSk/CyVD5tv8Mv8=;
        b=DkXaRl+uKk0fDPOPvOM+8Z5y3PO030oCIaBSWIyC6kIGNfjBJ9qCaJRti1aDVvuE1f
         n5BwhK2TYvOqAFPGKEdfmYAByFVqzeWNQd1OCHtiKWI/C9ZYHcXOZNEdzgvcSt9ea0Hd
         JP8VTrLReQfKjb1V3gRnbKL/QynRM972yikNGanXhYBDIZn2uwJxRUsQZD+78XhDizvO
         k3Mcv2sXji2nSSsuM0Eom9/fQNbAaehi4WFi+mz0kH56QGFsG17xNXl7srhswyP5vljg
         JDBhlyw+UlilTTz1JULpgFCOgjCONQjdXZZoxkdVMZu2LYSkkaIh225V1zVg+XZmVw8c
         mUWA==
X-Forwarded-Encrypted: i=1; AL+hErHQpQy99M0IiasBJGNlmVbRmOTACoRJ0pB1zJC45zYGeF9FnxIl5kUUUSoxP7NeNfTWdsBBPAV14Oej9Oc=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8fUPClH4c3amHdpnomy08e6jB+vrosytQrM4EnJxUAtY0lTx6O
	J0nLyRLvYbRrY+2rShHJzuO6TEyDYdipNJC8fJ8VfutQMi46eKBQYJtQ
X-Gm-Gg: AYBFou2MWO79ob/LdZnibk81HpKic1ek7Gmppzr5T4WXskYXk4fSV446AUch2zWtvx4
	sqLjSGMgv+ZZR4gZttBDD2dDtgzOqXOhMR3HcxvSwMUMXP978JKzt/hWMEewo0wVfRlIvN+d0fF
	9/LqI//lcvfv+V8aaLOVjegjJAnT2eHEoEuN0u0XaIB/Pbo6O/bv73PtsxJSvEfJIhL+mTMe6rQ
	j8Bkvx2zH31UoCZPKOBUKhJn0807MVXYzghy4CFyQVm5nHFS6xCrAg3sR5a18+LjYMisF5axPqA
	mxygsMUfbfVh4KtcwePFoWPoKbgj5Wsl+zvs3hOO/RkgWTYJUJKS8sdWCtKQd+ZCCGM2oUItE2e
	XDQPUqZsNWOBpdECrUB24EH9BGRwm51g0gJ6fUaVt+cK/oaEi4vZPepthmZHopZ8rAfueN4nSkZ
	68QIg6NavBzwh20v6SJFT1ATw8ot7rYDdaZu9miyFQz01p5lH68jhRgmlGt/0yNnU3hT7rMOpH8
	lA8WtomR4QInzrMvRs+gTwzL1B2H1sNgOrX0wxdpVpUQsECE2HEEDinSmDRiaV41GyEXF+TYw13
	h0xNWOexKHHndadtqyiav4PEe75s
X-Received: by 2002:a05:7300:3b03:b0:366:2893:7421 with SMTP id 5a478bee46e88-3751e6acd4cmr2378114eec.10.1794280957102;
        Mon, 09 Nov 2026 19:22:37 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm4159008eec.16.2026.11.09.19.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:22:36 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>, Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, =?utf-8?Q?Lo?=
 =?utf-8?Q?=C3=AFc?= Molinari <loic.molinari@collabora.com>, Lorenzo Stoakes
 <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, Madhavan
 Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Konstantin Khorenko
 <khorenko@virtuozzo.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 3/4] mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
Date: Tue, 10 Nov 2026 08:30:44 +0530
Message-ID: <pkwd8k6b.ritesh.list@gmail.com>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com> <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-3-c56d0d26f970@virtuozzo.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Konstantin Khorenko <khorenko@virtuozzo.com> writes:

> copy_huge_pmd() reads a special PMD without the page table lock and
> copies that value to the child. The mmap write lock held by fork does
> not stop unmap_mapping_range(): it zaps under i_mmap_rwsem and the PMD
> lock.
>
> The zap visits the parent VMA before the child's, as dup_mmap() links
> the child right after the parent in i_mmap. If it clears the parent PMD
> after fork has read it, and passes the child before fork copies it, the
> child keeps a mapping the driver has revoked, for example:
>
> - vfio-pci: the child reaches the BAR after the device memory was
>   disabled or the device was reset, instead of getting SIGBUS;
> - panthor: the child maps the pages of an evicted buffer object after
>   the driver has released them.
>
> The same branch deposits no page table under the copy. ppc64 in hash
> mode keeps the hash slot array of every huge PMD in that table, so the
> child dereferences a NULL table on the first hash fault, in
> __hash_page_thp(), and on the zap, in hash__pmdp_huge_get_and_clear().
>
> Take the locks first and let vm_normal_page_pmd() tell a PFN mapping
> from a folio under them, as copy_present_ptes() does with
> vm_normal_page(). The zap clears the parent PMD under the same lock, so
> either fork finds it none and skips it, or the copy is in place before
> the zap reaches the child.
>
> The copy of a PFN mapping then goes through the same tail as a folio:
>
> - it gets a page table where the architecture needs one;
> - in a shared mapping it is marked clean in the child, as a PTE is;
> - in a CoW mapping, which only VM_MIXEDMAP allows, both sides are write
>   protected instead of a warning being printed.
>
> Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
> Fixes: d1503aa9ab80 ("powerpc/64s: Add support for huge pfnmaps")

Thanks Konstantin, for fixing this. Without this patch I can reproduce the problem on Hash
on Power (on my test dev setup), after fork(), when child touches those pages.

[   62.543247][  T242] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[   62.544992][  T242] BUG: Kernel NULL pointer dereference on read at 0x00000000
[   62.545335][  T242] Faulting instruction address: 0xc0000000000a0ee8
cpu 0x0: Vector: 300 (Data Access) at [c00000002035f9d0]
    pc: c0000000000a0ee8: __hash_page_thp+0x218/0x560
    lr: c0000000000a0e14: __hash_page_thp+0x144/0x560
    sp: c00000002035fc70
   msr: 8000000000009033
   dar: 0
 dsisr: 40000000
  current = 0xc00000001fb08480
  paca    = 0xc000000005010000   irqmask: 0x03   irq_happened: 0x09
    pid   = 242, comm = vfio-fork
enter ? for help
[c00000002035fc70] 0000000000000000 (unreliable)
[c00000002035fd30] c000000000098a40 hash_page_mm+0x688/0x8d0
[c00000002035fe10] c000000000098dc8 do_hash_fault+0x140/0x368
[c00000002035fe50] c000000000008be0 data_access_common_virt+0x210/0x220
---- Exception: 300 (Data Access) at 0000000010001b60
SP (7fffde6dd7b0) is in userspace

With this series, I see that the issue is fixed. Thanks for helping in
fixing it. Please feel free to add:

Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #PowerPC






> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  mm/huge_memory.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e00632edb3856..9cb5f99aba87f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1961,25 +1961,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	int ret = -ENOMEM;
>  	bool writable;
>  
> -	pmd = pmdp_get_lockless(src_pmd);
> -	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
> -		     !is_huge_zero_pmd(pmd))) {
> -		dst_ptl = pmd_lock(dst_mm, dst_pmd);
> -		src_ptl = pmd_lockptr(src_mm, src_pmd);
> -		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> -		/*
> -		 * No need to recheck the pmd, it can't change with write
> -		 * mmap lock held here.
> -		 *
> -		 * Meanwhile, making sure it's not a CoW VMA with writable
> -		 * mapping, otherwise it means either the anon page wrongly
> -		 * applied special bit, or we made the PRIVATE mapping be
> -		 * able to wrongly write to the backend MMIO.
> -		 */
> -		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
> -		goto set_pmd;
> -	}
> -
>  	if (vma_is_anonymous(dst_vma) || arch_needs_pgtable_deposit()) {
>  		pgtable = pte_alloc_one(dst_mm);
>  		if (unlikely(!pgtable))
> @@ -2021,7 +2002,9 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		goto copy_pmd;
>  	}
>  
> -	src_page = pmd_page(pmd);
> +	src_page = vm_normal_page_pmd(src_vma, addr, pmd);
> +	if (!src_page)
> +		goto copy_pmd;
>  	VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
>  	src_folio = page_folio(src_page);
>  
> @@ -2061,7 +2044,6 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	}
>  	if (src_vma->vm_flags & VM_SHARED)
>  		pmd = pmd_mkclean(pmd);
> -set_pmd:
>  	pmd = pmd_mkold(pmd);
>  	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
>  
>
> -- 
> 2.43.0

