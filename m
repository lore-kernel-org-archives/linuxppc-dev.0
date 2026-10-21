Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7160A2639
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=earth.li header.i=@earth.li header.a=rsa-sha256 header.s=the header.b=U3WKM5qY
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8s240zpWz2xjv;
	Thu, 22 Oct 2026 01:22:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1098:86:4d:c0ff:ee:15:900d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792574098;
	cv=none; b=ixwsqz/V/LPgE6Sb4mqCPXek5KZRL4BJYUXpmJXxermISwyn8FT/dCGIlWZQW+K6op4tpx+mgnJciR6LBKt4tMC6tXTf44dHVvNMv6sPE6GH9r8pN/ds0LERE8pTjGf8NTn0C2I7VsZhvj7E661tb3U1sDEM8KYwqJOuG9A/CUgrKtW9IwGNgqQYCpaYAmA7SpmKsISzubVN9rqjX6+lIEkcaL4+Y4lr+Zvizv2uC+kElKZBj/I4fdEZ7jsYhqvWIxMsZVeLGSYFva4C+g9WJ+2mI8hM8CN3rj2vAh7mSrFfCHQG+imNrlt4qMomtirFtXZFPZ0x9Ng7taNJocCJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792574098; c=relaxed/relaxed;
	bh=AOzqjtOMrdyYNSpa99+/UPGhu5nVwE5WpHEubCFaf5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLSPUXuIB091sx4KTb1HhfB/boTk0ON+n3qUAKjM9kkv5YcGlM+I1ipQjR0XuLQ+3Ybjm7RPwJ1YbRYfLABU0FaEl2+YC3ug4FyOac+XSof18cCNFD8/CMLljMpzm6mnEVAfCG5bhulSBXDlmX8zqI87U5LfwOBPRCY6Ubznp3zRmIfMZVEFOVRym0a+u3klSVNxBFk4QwS+uzLdK0AaQtvtqDULJYexeNUnhyekjHpiv26ZgPnRs0bKha78HKoHwTnO0FOzOz+KD1hOJlX007N3MbZo0hi2QcO6ovHiu0HQXwwNUWT/fXb5bpZWvcRmMhVBej9EmfKSwgxUTQhQjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=earth.li; dkim=pass (2048-bit key; unprotected) header.d=earth.li header.i=@earth.li header.a=rsa-sha256 header.s=the header.b=U3WKM5qY; dkim-atps=neutral; spf=pass (client-ip=2a00:1098:86:4d:c0ff:ee:15:900d; helo=the.earth.li; envelope-from=noodles@earth.li; receiver=lists.ozlabs.org) smtp.mailfrom=earth.li
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=earth.li header.i=@earth.li header.a=rsa-sha256 header.s=the header.b=U3WKM5qY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=earth.li (client-ip=2a00:1098:86:4d:c0ff:ee:15:900d; helo=the.earth.li; envelope-from=noodles@earth.li; receiver=lists.ozlabs.org)
X-Greylist: delayed 2198 seconds by postgrey-1.37 at boromir; Wed, 21 Oct 2026 20:14:55 AEDT
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8kBl1Z4cz2xPW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 20:14:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AOzqjtOMrdyYNSpa99+/UPGhu5nVwE5WpHEubCFaf5I=; b=U3WKM5qYuUTXR4j3PnsdOXCn8d
	hUOrdeBn8f28fXuqP8owg8bfXv0XP52dwZmKyFCp7/uDoH8ijZigjM4ST7QKm2B8oGxJdV8R28Ojh
	weF4yGa/cnqEZhQ+tw0f05NmOz4DlcXcmYCo3TOlVHY0dkNDWesFksDJo5SHkACyjTo8wZJ3+TF76
	FIEmLKlO0haAZjrmihdwsrjSU24hNEXF8/1DRXRM2UNHYMatnRoIm+pDBmtB9pLmkYd4GIFpMwuNs
	olG5oBlqmNEma0F+AVEP9RWpkBh/8bEDcDeKB6W+AfW5CuALH/tv3LvI/KfmXzKmJK615WqYzsReS
	+VVBXHRA==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1xJRpX-00000000gFP-2wKS;
	Wed, 21 Oct 2026 09:37:51 +0100
Date: Wed, 21 Oct 2026 09:37:51 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	zohar@linux.ibm.com, noodles@fb.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
Message-ID: <ath534EEbFntir8j@earth.li>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:37:27AM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> buffer location through setup_data, not through the device tree, so the
> buffer is never found and the IMA measurement list is not carried over
> across kexec.
> 
> Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> and select it for the architectures that pass the IMA buffer location
> through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> powerpc and riscv). Build the device tree implementation of
> ima_get/free_kexec_buffer() only if the new option is enabled.
> 
> Select the new option also on LoongArch, to preserve the current behavior
> and avoid a link failure. LoongArch does not pass the buffer location to
> the next kernel yet; this will be addressed separately.
> 
> Finally, don't select it for x86, and use x86's own setup_data-based
> implementation regardless of CONFIG_OF_FLATTREE.
> 
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-By: Jonathan McDowell <noodles@meta.com>

I think my original intent when adding the ACPI x86 passthrough was to 
ensure I didn't break anything for anyone who'd been trying to use OF 
with x86 and pass it through, but if it wasn't even wired up there then 
that's not a concern.

> ---
> 
> v2:
> - Reworded the commit message (no code changes), suggested by Mimi
> 
>  arch/arm64/Kconfig      | 2 +-
>  arch/loongarch/Kconfig  | 2 +-
>  arch/powerpc/Kconfig    | 2 +-
>  arch/riscv/Kconfig      | 2 +-
>  arch/x86/kernel/setup.c | 2 +-
>  drivers/of/kexec.c      | 4 ++--
>  kernel/Kconfig.kexec    | 4 ++++
>  7 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef944..4b7e248b6c91 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1697,7 +1697,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2067d1f2ad7a..b5420d482da4 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -690,7 +690,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	depends on KEXEC_FILE
>  	select KEXEC_ELF
>  	select RELOCATABLE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>  
>  config ARCH_SUPPORTS_CRASH_DUMP
>  	def_bool 64BIT
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..096c6061893b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -643,7 +643,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select KEXEC_ELF
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>  
>  config PPC64_BIG_ENDIAN_ELF_ABI_V2
>  	# Option is available to BFD, but LLD does not support ELFv1 so this is
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f8e26c4bed2b..161bf8a65beb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1118,7 +1118,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>  config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>  	select KEXEC_ELF
>  
>  config ARCH_SUPPORTS_KEXEC_PURGATORY
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index cda6adb9f69c..bc17e353c099 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -421,7 +421,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>  #endif
>  }
>  
> -#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
> +#ifdef CONFIG_HAVE_IMA_KEXEC
>  int __init ima_free_kexec_buffer(void)
>  {
>  	if (!ima_kexec_buffer_size)
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 029903b986cb..724f29fef0c0 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -116,7 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_HAVE_IMA_KEXEC
> +#ifdef CONFIG_HAVE_IMA_KEXEC_OF
>  /**
>   * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>   * @addr:	On successful return, set to point to the buffer contents.
> @@ -196,7 +196,7 @@ static void remove_ima_buffer(void *fdt, int chosen_node)
>  	size_t size;
>  	const void *prop;
>  
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC_OF))
>  		return;
>  
>  	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..c6ed60f04ea4 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -17,6 +17,10 @@ config KEXEC_ELF
>  config HAVE_IMA_KEXEC
>  	bool
>  
> +config HAVE_IMA_KEXEC_OF
> +	bool
> +	select HAVE_IMA_KEXEC
> +
>  config KEXEC
>  	bool "Enable kexec system call"
>  	depends on ARCH_SUPPORTS_KEXEC
> -- 
> 2.43.0

J.

-- 
... "You are in a twisty little maze of lookup tables, all different." --
    Joe Zeff, The Scary Devil Monastery

