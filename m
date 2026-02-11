Return-Path: <linuxppc-dev+bounces-16801-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5044EA3F27
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 09:55:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9v1s6Jsmz2xlp;
	Wed, 11 Feb 2026 20:55:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770803729;
	cv=none; b=KBvPIS4eHT11KppJBgvfmt+IMSdKJB7bZ/O4PbKURfk6/DUVxx7YLC33Hdux5wbBX0e+E4K0uoeHjj6ppR6oVeicduBLPu5YABr6s+BkkA5vyTrdcAYWA6wo3PXsURnL0w8dp3IpMxXU4lxWq2djaaN2DNjUUvPjLNgcJDHVO7I4qvsa4SQt4Hw1SHKQWkmhnUVSBADuEQ6G2fk4OpVIH+jtYFOuvF8zFdM5sBTEVdTzrPaFe6jj7UXmOPKZUwwZxm3fJjlHXu0nBtrqvhX24xMiw5ZbGGIaj1Lag0vtTYb3EBFHPjtWGF2/fH11/GbnD+iRxG/sYRvyUGX3g6LLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770803729; c=relaxed/relaxed;
	bh=EA00nQCuRht5p3xpLEM73K63L/ah0hrG4IBrwVxJKZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WvO6+owuHHPTOr+pcvUPU02x3hyNk3BwXacuDsr7gzCacxLPCVQkovUa81C2zyRqcrAlWOsISa2wBWzfXbqMlyAk8q8ZDC4v58wagHZtIAvtM8oIG9vNfBGKwwGMbTAknKqdu2l4TBx8rkVv5w/DHi6i0PwmuPOzt/c8LmL/K32B433SEo4K2JqVSWOxaVx2hxgpRylD6wSeM+ghY8SzDH1D9hwAoUR0pdlm9LuyDLy5aAGCbinFJG7WTNrklUQGFh/QENj1Gx3epUdRUw9FKhTa5YYsQ7GKmhmFfxL6lp7DhF4SdbapvQ6hKwm125GKJxtuNNXfmmapDkO79ntXuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AqX8gw98; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AqX8gw98;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9v1r4xnyz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 20:55:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D211860053;
	Wed, 11 Feb 2026 09:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C04C4CEF7;
	Wed, 11 Feb 2026 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770803725;
	bh=ficnapCkCf+khatK2N0Ft9F3rB7FAZW78An8VQMxafM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AqX8gw98dFxJpmNqPCzOMtORCM+znj0QtTax6ydhaKXUKRLQ6hvD2Mca14wt6jhme
	 OgLLSYM08TJPbKIUYsZ+9RwVM46VCxfCsTc2/fTJcq7RkbIpPx+8NXJ58U3jKdtvyz
	 DpNTszqlwLSQodgfBpNaNhs2qonpmtJS8y+M6ODrFMz0cUSI5GyY6PL2p9oOSzidLd
	 JRYwur4nfHICeJmev2M2QAhAePQ41d3/G0i9BdVg56pftCswAk7lxuf0Oqz1+eMnom
	 9QJfYHHaIbOUbaooUMcYSaEMld0XmcJUgaziC4oxrtxjR+n8uaNDUT/TcbWplghTou
	 rL4QYRQvAusFw==
Message-ID: <423a3431-1271-4c35-94fe-8ca880679ed9@kernel.org>
Date: Wed, 11 Feb 2026 10:55:17 +0100
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
Subject: Re: [PATCH v4 2/2] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
 Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Thomas Staudt <tstaudt@de.ibm.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Saravana Kannan <saravanak@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260211082401.2407853-1-coxu@redhat.com>
 <20260211082401.2407853-3-coxu@redhat.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260211082401.2407853-3-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/02/2026 à 09:24, Coiby Xu a écrit :
> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>   - Kdump kernel may not be able to decrypt the LUKS partition. For some
>     machines, a system administrator may not have a chance to enter the
>     password to decrypt the device in kdump initramfs after the 1st kernel
>     crashes
> 
>   - LUKS2 by default use the memory-hard Argon2 key derivation function
>     which is quite memory-consuming compared to the limited memory reserved
>     for kdump.
> 
> To also enable this feature for ARM64 and PowerPC, we only need to add

What do you want to say exactly with 'only' ?

> a device tree property dmcryptkeys [2] as similar to elfcorehdr to pass
> the memory address of the stored info of dm-crypt keys to the kdump
> kernel. Since this property is only needed by the kdump kernel, it won't
> be exposed to user space.
> 
> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20250502011246.99238-1-coxu%40redhat.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0aa5f3b34d694b23b0cc08de6946f66c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639063950684962054%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8uCc%2Bg6YNojymf8UpZhmJY19vpWXJCC9KIf3qMyQ3dI%3D&reserved=0
> [2] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-schema%2Fpull%2F181&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C0aa5f3b34d694b23b0cc08de6946f66c%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639063950684987003%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1s5NPHgF1LsXdrDXBhawduFXOqnHPlkbohQHHvolLw4%3D&reserved=0
> 
> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Thomas Staudt <tstaudt@de.ibm.com>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   arch/arm64/kernel/machine_kexec_file.c |  4 ++++
>   arch/powerpc/kexec/elf_64.c            |  4 ++++
>   drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>   drivers/of/kexec.c                     | 19 +++++++++++++++++++
>   4 files changed, 48 insertions(+)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 331646d667b9..2967e4aff807 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -866,6 +866,26 @@ static void __init early_init_dt_check_for_elfcorehdr(unsigned long node)
>   		 elfcorehdr_addr, elfcorehdr_size);
>   }
>   
> +static void __init early_init_dt_check_for_dmcryptkeys(unsigned long node)
> +{
> +	const char *prop_name = "linux,dmcryptkeys";
> +	const __be32 *prop;
> +
> +	if (!IS_ENABLED(CONFIG_CRASH_DM_CRYPT))
> +		return;
> +
> +	pr_debug("Looking for dmcryptkeys property... ");
> +
> +	prop = of_get_flat_dt_prop(node, prop_name, NULL);
> +	if (!prop)
> +		return;
> +
> +	dm_crypt_keys_addr = dt_mem_next_cell(dt_root_addr_cells, &prop);
> +
> +	/* Property only accessible to crash dump kernel */
> +	fdt_delprop(initial_boot_params, node, prop_name);

Shouldn't this property be deleted regardless of whether kernel is built 
with CONFIG_CRASH_DM_CRYPT or without ?

> +}
> +
>   static unsigned long chosen_node_offset = -FDT_ERR_NOTFOUND;
>   
>   /*
> @@ -1097,6 +1117,7 @@ int __init early_init_dt_scan_chosen(char *cmdline)
>   
>   	early_init_dt_check_for_initrd(node);
>   	early_init_dt_check_for_elfcorehdr(node);
> +	early_init_dt_check_for_dmcryptkeys(node);
>   
>   	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
>   	if (rng_seed && l > 0) {

