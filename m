Return-Path: <linuxppc-dev+bounces-19156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0675D107637D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 14:22:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm6cr4CnKz2yhY;
	Thu, 02 Apr 2026 01:22:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775053324;
	cv=none; b=AihZza7dQ/zfMu7ONp+bWVnvyMH/SILNA6FNvq9aIHIQQSOkv1JzQ1/OVbCaVAkXabaDuG8lBLF2R8gvRKm7noiZHra5ubzIYyf71lQ42l4LfmlcL3SVPmn8n3OKH6PBm6LLg8cOLxNMURV1pOAPVNUXDUSmSrIS7Og0N+EvGvlgtgm7FweNNFZK54Uufdsq6fu8LpRmbla2o5NGijR+IEYWQ8BDuXJhmvLQQ8B+2vujc3iYq6Is5RoKjn+cBuJhvZLdWnwxtn0yKU/up0RlUXG3ky5zaZNVBGLwqrB9nN10HMu/l1g6QmJCGyHA0RBaHu5NUZvxoa0RGcjtP1g/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775053324; c=relaxed/relaxed;
	bh=Udu62aiUEQcvvl3iN/QpcXDAHXiWfOoTUovuy6wG5ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YNCRZ6/mkFedhHKajNEMF+fDoD/8/elJP9wVWNlZ/JjRU+eTpxA4ujZNQyiQkFzmCOai/JCrjyeCJh2DQKps5rdm3knTsbVZLCL2O7kH+TLIiTlRJrt9CWvRLBHcHwhVB/SSKLNO6+hhkV3EA4tXPIZ5kl6xPlOstfXBOBTloMGI3SkdBeD6dA/QdHsA7U8BN68A3H+RGkgiafLGSpj2zLC3BXXs3ERMxQkAppbvWwF5IT4XoFKWWyhEVXWMgsXEG4+C2cDPgO8BiQWNuYkrXi07WHNlwY7yFLUzK3ezQKkAYLHjgJsbh4FiSzUzEmpi5g3OO4wFRqdax4RtHhkcAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f801QttQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f801QttQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm6cq38h9z2yhG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 01:22:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 16A05600C4;
	Wed,  1 Apr 2026 14:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA86C4CEF7;
	Wed,  1 Apr 2026 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053320;
	bh=Z33pYm24qbSvYLg3avP20eCSmcuudyAdxkucbIxFgJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f801QttQuTDTdEug++TXlbPQYcGwCgqDN19BY676yqfaczi4em00rtie+1epsL2uV
	 MhCJ7qmAWnh5SFl3tHZQi4yrsSvvaYgZu8/S56CJxizHoD4xCSPPOyNDKQhK1WgNun
	 bQB2dzI1VOjGQ5BL3YOgMbmS/jIUXG6esDRtAp/7fqqCfSxCZcfruuF3rSoha8Wxzl
	 Pjy5mpBddDIHQ9/Bn/R+HLjeQfhHcUxC48da58+1PICwZ7WDOUIMjkr7dC6E/MPo3e
	 OnTv6usFWdMqfkzWa4bA666Z997TUHktcBwCkpMUyQ1u+drN4FEyoa36g71VySGYeK
	 Fg92NM9zrxGpQ==
Message-ID: <ee15d52f-45df-415b-b0d9-3d267d147e5c@kernel.org>
Date: Wed, 1 Apr 2026 16:21:55 +0200
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
Subject: Re: [PATCH v3 08/13] selftests/mm: ensure destination is
 hugetlb-backed in hugepage-mremap
To: Sayali Patil <sayalip@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <cover.1774591179.git.sayalip@linux.ibm.com>
 <3b6ffba238a4b59de891acf896fa25d7d3193228.1774591179.git.sayalip@linux.ibm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <3b6ffba238a4b59de891acf896fa25d7d3193228.1774591179.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 08:16, Sayali Patil wrote:
> The hugepage-mremap selftest reserves the destination address using a
> anonymous base-page mapping before calling mremap() with MREMAP_FIXED,
> while the source region is hugetlb-backed.
> 
> When remapping a hugetlb mapping into a base-page VMA may fail with:
> 
>     mremap: Device or resource busy
> 
> This is observed on powerpc hash MMU systems where slice constraints
> and page size incompatibilities prevent the remap.
> 

That is weird. An mremap(MREMAP_FIXED) is really just an munmap() + move.

Are we sure this is not some actual problem in the hugetlb implementation?

> Ensure the destination region is created using MAP_HUGETLB so that both
> source and destination VMAs are hugetlb-backed and compatible. Also add
> MAP_POPULATE to the destination mapping to prefault hugepages,
> matching the behaviour used for other hugetlb mapping in the test and
> ensuring deterministic behaviour.

But then the test suddenly requires more hugetlb pages, no? I don't see
a good reason for the MAP_POPULATE, really. It will be discarded either way.

> 
> Update the FLAGS macro to include MAP_HUGETLB | MAP_SHARED |
> MAP_POPULATE so that both mappings are hugetlb-backed and compatible.
> Also use the macro for the mmap() calls to avoid repeating
> the flag combination.
> 
> This ensures the test reliably exercises hugetlb mremap instead of
> failing due to VMA type mismatch.
> 
> Fixes: 12b613206474 ("mm, hugepages: add hugetlb vma mremap() test")
> Acked-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
> ---
>  tools/testing/selftests/mm/hugepage-mremap.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
> index e611249080d6..48c24a4ba9a7 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -31,7 +31,7 @@
>  #define MB_TO_BYTES(x) (x * 1024 * 1024)
>  
>  #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
> -#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
> +#define FLAGS (MAP_HUGETLB | MAP_SHARED | MAP_POPULATE)
>  
>  static void check_bytes(char *addr)
>  {
> @@ -121,23 +121,20 @@ int main(int argc, char *argv[])
>  
>  	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
>  	unsigned long suggested_addr = 0x7eaa40000000;
> -	void *haddr = mmap((void *)suggested_addr, length, PROTECTION,
> -			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> +	void *haddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
>  	ksft_print_msg("Map haddr: Returned address is %p\n", haddr);
>  	if (haddr == MAP_FAILED)
>  		ksft_exit_fail_msg("mmap1: %s\n", strerror(errno));
>  
>  	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
>  	suggested_addr = 0x7daa40000000;
> -	void *daddr = mmap((void *)suggested_addr, length, PROTECTION,
> -			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
> +	void *daddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
>  	ksft_print_msg("Map daddr: Returned address is %p\n", daddr);
>  	if (daddr == MAP_FAILED)
>  		ksft_exit_fail_msg("mmap3: %s\n", strerror(errno));
>  
>  	suggested_addr = 0x7faa40000000;
> -	void *vaddr =
> -		mmap((void *)suggested_addr, length, PROTECTION, FLAGS, -1, 0);
> +	void *vaddr = mmap((void *)suggested_addr, length, PROTECTION, FLAGS, fd, 0);
>  	ksft_print_msg("Map vaddr: Returned address is %p\n", vaddr);
>  	if (vaddr == MAP_FAILED)
>  		ksft_exit_fail_msg("mmap2: %s\n", strerror(errno));


-- 
Cheers,

David

