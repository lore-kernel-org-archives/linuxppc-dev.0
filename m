Return-Path: <linuxppc-dev+bounces-25118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011C1C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:33:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sBc1qCZz2yDs;
	Fri, 31 Jul 2026 00:33:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785422008;
	cv=none; b=E4gEd8MgiwRQgsFSPFy0ZQnmYWllhZi82o/pHg+zR8LyZwX5IHBoXoPcGmJFbxftnRpJ/PzPFd+JIIL0g51E1ZkmVPUfTNnlyswOm3xUMnBXEzPWd/vp3g1GCSeP/6wa/noMbDmSOb0lkm8qIofIVTUz9YtEHfLxUEIyfXCbuiWM6IQ4yJhNnwOyv2hDEzcnceHSH+qeAajpySD5MonSIeFcKjRDyPq6f+ZAbsAy3RuSV3QWyZ/JbBRXJyqlNM9XNqywOAAg1GxvCXqEc6NyaYvnDcWWAfzMWpYtL+/oxqsOCenMtkGLxlhuLJ2ejx7yE3qdK6Mgril7BZSmVi5q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785422008; c=relaxed/relaxed;
	bh=6ZHqHPyn9esPSjQFHnHllZM176p2EyCQfO0nPMuXAdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boqpFzfMrb1ibz+cP2ag011x8WqedEsr3CmHXdCEvwI3iFIFq0SUc89Db5oV1bgCYYVVBjNF1+NCyNW6ehwMiwqeQF068v0qbtm5Xj96L3kcGr9RBdp420uuRL/Y6ZOzpi/28Ni8ut8QkM278rhrUYWIGMeIcCRCaxugMvXbSxbCgmsdWZ3HBFr9nSVaZx3e4XexEdkKAxzrYhiiAUsArYSpx3BV2Ol/Dp/TISHOV26rllbh6zmDUNU1dGe6ngXeJZASGGo9/BPQKTu8W1f0bu77fa0shvTFOubE6uMJu8gexiTFuVH2gpBq6/oya114k/FicwJmhov3Pp4LR2iAFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtdSMADP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtdSMADP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sBb2V3Fz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:33:27 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8FC6341B06;
	Thu, 30 Jul 2026 14:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0271F000E9;
	Thu, 30 Jul 2026 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422004;
	bh=6ZHqHPyn9esPSjQFHnHllZM176p2EyCQfO0nPMuXAdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gtdSMADP6PTwim+s/ByaPoCCJNsnpeFcBwCjK1dihUMAlMkGFmrQUnUZIWEUIEWJx
	 yiek0iDpXbnH7PIeVYpjO/R+sPbJLTa2uVW9P4ijmyg7AdCmbE55jtbeh15csaGz25
	 QG84dclbmlUL2a8VNvzWsJ0hf5xB8rGfqwPpSiwfWqnq8/EXvuzK9cm0HVh7mZkeIc
	 ubrwFThbSdboBvYPrLFlQ8gS4oCivtEocxUJUC3sJXGxzU2q5hDLNtKq9tut1viswB
	 3/mlemDfIV4fANzDayMW4qP1o+mfVekKbAE9rx7NIAiD9cf/d5ss25FVuv99nuznE6
	 IdCyxLdx8i2YA==
Message-ID: <42ab7c21-25cd-4ed1-b43f-b155e82db1a0@kernel.org>
Date: Thu, 30 Jul 2026 16:33:18 +0200
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
Subject: Re: [PATCH] powerpc/kexec: Simplify kdump_extra_elfcorehdr_size()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260730131940.597739-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260730131940.597739-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 15:19, Thorsten Blum a écrit :
> Return the size directly and drop the extra_sz variable to simplify
> kdump_extra_elfcorehdr_size(). The two warning paths now fall through
> to the existing return 0 at the end of the function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/powerpc/kexec/file_load_64.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
> index c3503d698428..d0c544079e03 100644
> --- a/arch/powerpc/kexec/file_load_64.c
> +++ b/arch/powerpc/kexec/file_load_64.c
> @@ -377,16 +377,12 @@ static int load_backup_segment(struct kimage *image, struct kexec_buf *kbuf)
>   static unsigned int kdump_extra_elfcorehdr_size(struct crash_mem *cmem)
>   {
>   #if defined(CONFIG_CRASH_HOTPLUG) && defined(CONFIG_MEMORY_HOTPLUG)
> -	unsigned int extra_sz = 0;
> -
>   	if (CONFIG_CRASH_MAX_MEMORY_RANGES > (unsigned int)PN_XNUM)
>   		pr_warn("Number of Phdrs %u exceeds max\n", CONFIG_CRASH_MAX_MEMORY_RANGES);
>   	else if (cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES)
>   		pr_warn("Configured crash mem ranges may not be enough\n");
>   	else
> -		extra_sz = (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);
> -
> -	return extra_sz;
> +		return (CONFIG_CRASH_MAX_MEMORY_RANGES - cmem->nr_ranges) * sizeof(Elf64_Phdr);

I don't understand.

Previously, when cmem->nr_ranges >= CONFIG_CRASH_MAX_MEMORY_RANGES you 
would return 0. Now you will return something different. For instance if 
cmem->nr_ranges is (CONFIG_CRASH_MAX_MEMORY_RANGES + 1) you will return 
(unsigned int)(-1 * sizeof(Elf64_Phdr))

>   #endif
>   	return 0;
>   }


