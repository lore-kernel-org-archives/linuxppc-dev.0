Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FF606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSNE5M0H
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZTHG6W5Cz2xwP;
	Thu, 26 Nov 2026 05:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795632554;
	cv=none; b=S4q6Z15qrVbZyejZf6CzmIkQjl3aSvg2DCcsd4HnYT7wqDOCeCP3QihD5gyTdzt3bpbkM/fWqN53htrpUoey6J7vTOsjObQ0m42cLvu8vLwf4iVUzvVTySJ62fIaywXRbu6cdWvhLmce2NeBACeGse9KG0NSz2ubc67kcV2PNl2/imvPiw6D6GISYLiK3+MicNtiGDQa1wX8O7B5XAOZnF6CWzmyV4tC/5R/tJphzfzXZ6M23cQ7y3++2WKXCmCrVPU04DE83jdCyHrLiEt2s7KAmuONQrPSchZDMB0qcD43cItG2hQTyjPkTrQC92iPuU+dv2uNWFUVJq79XJVDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795632554; c=relaxed/relaxed;
	bh=IcBbbIZ4kprYihX6PWRB+1nNTwBXZH4y418KmCgh2Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgvVGxAobvOV/lwP+PkIkZbpEyGZ/r+VHD1PDiGHiafl8FswiSB91gbkJQg2b3naBITCjB1oIfPGXnIJDauBz+JaBBmiF53FCVbpTBs52EDKucAoZVEnd2hFPrjSY1zrENYIywETCGEPiqzGI983iz9ars/pkD/FBPjnC1UtWckV2QY7XHYupgwKhNZijGEyJms3TnOqsbfAoIaHEIrSf+wFKGbpN3dmL3zWyJjgf92jzEEcuelb2AJ4J0pWnFJzinBXn4RK7umB9z8UnC8OGCJPrII7HMjDv7Jen1a3xu6NZHUKZhciEcKtjVKONPrATNcmgPQnYYSmvWjPGMODVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSNE5M0H; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XSNE5M0H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZTHG0Ktyz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:49:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A660362907;
	Wed, 25 Nov 2026 18:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291931F000C0;
	Wed, 25 Nov 2026 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795632551;
	bh=IcBbbIZ4kprYihX6PWRB+1nNTwBXZH4y418KmCgh2Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XSNE5M0HumztNXfXGCi2vR/TB3+dmoswmYgZi21Jywix4Zzi0lrXkb9vBy6/he/9B
	 w4O7r9k8Rq0mx9J9/VkHMld+FysHlAPMu7mZ0s7am76HtbEKk709aSkErEfftS8bVE
	 g9fo1B3zjNUvG8vLLp3ylhmChgyt2r8xQ4LaP6je6BqueysmXUBXdMnFQnQlDubQUa
	 QbRfkExnIk91QYQb4hRFvE9o/BxBLHl4XWc9bDNezZ+4fO2U6umDyyCA6COyHv2d5i
	 xLKSIO5lfScAJbQIQrQKSxqPFA/ZGHn4Esq3YEsCW0YPG4xlcB7VRXFjIvResVq4Tb
	 edyJlxmz5knog==
Message-ID: <e6876775-fe6a-45d2-aab5-995b30c43971@kernel.org>
Date: Wed, 25 Nov 2026 19:49:06 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/4] powerpc/execmem: Don't leave kprobes insn pages W+X
 when CONFIG_MODULES=n
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
References: <cover.1795625038.git.ritesh.list@gmail.com>
 <5f5185b80df2a3a4e85ca711b5071096f36a7892.1795625038.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <5f5185b80df2a3a4e85ca711b5071096f36a7892.1795625038.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 25/11/2026 à 17:52, Ritesh Harjani (IBM) a écrit :
> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
> CHECK_WX default STRICT_KERNEL_RWX.
> 
> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
> we can see the following warning splat at boot:
> 
>      powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>      WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>      NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>      LR [c0000000000ac200] note_page+0x4d8/0x4fc
>      Call Trace:
>       note_page+0x4d8/0x4fc (unreliable)
>       ptdump_pte_entry+0x70/0x94
>       walk_pte_range_inner+0x15c/0x260
>       walk_pgd_range+0x6d8/0xd5c
>       walk_page_range_debug+0xa4/0xf0
>       ptdump_walk_pgd+0xec/0x304
>       ptdump_check_wx+0xd8/0x154
>       kernel_init+0x94/0x26c
>       ret_from_kernel_user_thread+0x14/0x1c
>      Checked W+X mappings: FAILED, 1 W+X pages found
> 
> This happens because CHECK_WX noted a writeable + executable mapping.
> 
> This happens because execmem_arch_setup(), checks for
> struct_modules_rwx_enabled(), while kprobes depenency on modules was earlier
> removed via commit 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
> Since the insn slots are only written with patch_instruction(), which does not
> need this mapping to be writable. This patch fixes it by checking for
> strict_kernel_rwx_enabled() instead.
> 
> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/mm/mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index b617b69452cd..77b63b52d8f2 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
> 
>   struct execmem_info __init *execmem_arch_setup(void)
>   {
> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>   	unsigned long fallback_start = 0, fallback_end = 0;
>   	unsigned long start, end;
> --
> 2.39.5
> 


