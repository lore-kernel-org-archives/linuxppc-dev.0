Return-Path: <linuxppc-dev+bounces-17194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03783FD3769
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 15:49:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLfCN5zKHz3f57;
	Thu, 26 Feb 2026 02:49:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772034544;
	cv=none; b=m/UkVCv67Hp0cXlFPJAd6kXaWq2CFbRmz3MoX+HDmtn1TnK9BNHrr6PjgVXTPHZ/bP9xguZ9Jm2cAtIWYyEl+IgVbvk2hv6gL877QtDiCV6fEEvPTSfwr+JYI23TlLD85/HI7r5S5zEPu9zvIFSW3d5zzT4aTnFAJar4yEzaYpKDtr4hqQEgH+DZ4zvFDnEVDkY6aiVmUUDXDuhhufDhQy0rTBwqUis/qTXrsPADWKXrY9BxrbELgZPmvR3WlxPaDrN33JWkyMngFxxXevl1LT8A2m9iydnPhMSVb0KAGcljf4o+AV95YTKumnA/9YdU1CzO8eym+UyXtlo5EIv9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772034544; c=relaxed/relaxed;
	bh=/SqL8P2eQPWNIxR7mONXmHFpjjLpWCZnldNIKloYObE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA66zKD8s9Fz2iSAh62qQxc7aBDc2+glRDCD632PRVngN3TnvnL2LRVlRXjUcXXtOfR3pwBfF41zOcARDa8OddcTb8pm+qL18p5TFR2103Vy6nohwGdfLNHCdCASnqeqKosyq9xbZizXIZqcdKEAwAEF5hOHLxGZlEbbtKkEDp3/IJkDccUFXORaYbDvasmXKYj5VVN0bDQ2K9aHhQOCvWq7pAkwfeVCT0P0OBYfXmM7uNvM3phPjxLd3uzOftwHir4leGz/7d355etVdZryHjZ8IU9WR315hbzC4ZHVe5SqRGKKxgBRs4+eLrcTNMsECVdTjZ7esr8WtFsDetnRsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I532EFVb; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I532EFVb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLfCN0dKTz3f4W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 02:49:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A66F40302;
	Wed, 25 Feb 2026 15:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FE8C116D0;
	Wed, 25 Feb 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034541;
	bh=pZbjdg50KRzQ422ePCSptr4aHcihMfDCR1tS1O1TEsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I532EFVbqE8GHVn3wRpwoiLj0xwBUMITr7qrrtSKpJfbKKP2U/jR/Ni/Xh5FwubUQ
	 jrXuYjxxcGNKvyfvMLOzJTh8WpizKg9jXQ+SIgnrUBkOvnrS/UQQfOCywEFDs+14MG
	 VpQfSsfwndpTxDyTJi1RmrnGh747jM4VFDZfl/9mjXQdhFDHJJ5GhvxFi41iW4ufFr
	 gGwS9ktAeJD8zfB+zANO2NWjTrPQl3JcenJ3IBlSv2Zoo4hbDHTzH7P7+NLi/p1hT8
	 Ej6MKtOO9hHHUpDMRg6/ChlWZatqgw3xueHfPQ7IsX+e4bjL/EzBH94u6Sx1SQv5NA
	 Q3SR4khoEgBhg==
Date: Wed, 25 Feb 2026 17:48:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	pmladek@suse.com, dapeng1.mi@linux.intel.com, kees@kernel.org,
	paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de,
	ardb@kernel.org, leitao@debian.org, cfsworks@gmail.com,
	ryan.roberts@arm.com, sourabhjain@linux.ibm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, samuel.holland@sifive.com,
	kevin.brodsky@arm.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	fuqiang.wang@easystack.cn, jbohac@suse.cz, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v6 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <aZ8Z2WXw3QwaXRo8@kernel.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
 <20260224085342.387996-5-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224085342.387996-5-ruanjinjie@huawei.com>

On Tue, Feb 24, 2026 at 04:53:41PM +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Add Acked-by.
> v2:
> - Free cmem in prepare_elf_headers()
> - Add the mtivation.
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/arm64/kernel/machine_kexec_file.c          | 8 +++++++-
>  arch/arm64/mm/init.c                            | 5 +++--
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb850e5290c2..497f63b76898 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1121,7 +1121,7 @@ Kernel parameters
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  	crashkernel=size[KMG],cma
> -			[KNL, X86, ppc] Reserve additional crash kernel memory from
> +			[KNL, X86, ARM64, ppc] Reserve additional crash kernel memory from
>  			CMA. This reservation is usable by the first system's
>  			userspace memory and kernel movable allocations (memory
>  			balloon, zswap). Pages allocated from this memory range
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index c338506a580b..c8862a762eb3 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  #ifdef CONFIG_CRASH_DUMP
>  unsigned int arch_get_system_nr_ranges(void)
>  {
> -	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
>  	phys_addr_t start, end;
>  	u64 i;
>  
> @@ -64,6 +64,12 @@ int arch_crash_populate_cmem(struct crash_mem *cmem)
>  		cmem->nr_ranges++;
>  	}
>  
> +	for (i = 0; i < crashk_cma_cnt; i++) {
> +		cmem->ranges[cmem->nr_ranges].start = crashk_cma_ranges[i].start;
> +		cmem->ranges[cmem->nr_ranges].end = crashk_cma_ranges[i].end;
> +		cmem->nr_ranges++;
> +	}

Why do we need to add cma ranges here? They are anyway will be excluded in
crash_exclude_core_ranges().

The same comment applies to riscv patch.

>  	return 0;
>  }
>  #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 96711b8578fd..144e30fe9a75 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -96,8 +96,8 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
>  static void __init arch_reserve_crashkernel(void)
>  {
> +	unsigned long long crash_base, crash_size, cma_size = 0;
>  	unsigned long long low_size = 0;
> -	unsigned long long crash_base, crash_size;
>  	bool high = false;
>  	int ret;
>  
> @@ -106,11 +106,12 @@ static void __init arch_reserve_crashkernel(void)
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base,
> -				&low_size, NULL, &high);
> +				&low_size, &cma_size, &high);
>  	if (ret)
>  		return;
>  
>  	reserve_crashkernel_generic(crash_size, crash_base, low_size, high);
> +	reserve_crashkernel_cma(cma_size);
>  }
>  
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

