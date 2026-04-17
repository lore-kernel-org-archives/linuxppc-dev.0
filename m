Return-Path: <linuxppc-dev+bounces-19825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B275F8E4BF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:58:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxnLv0494z2yh4;
	Fri, 17 Apr 2026 17:58:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776412710;
	cv=none; b=meSMovnlJjA+gizkYxih+1BnVgxLPBpPxwIatLrziaQII8DCPNQDhmijsq/AscvuFywAlQq+81trsIIhY46B3SPlsqdD51UuUDRRX9BlQ2ul6hufMqdgYgOfgdIMUIvDYgL5FAQMmNon6ANmfcVsu5K55G6pYrlwQw6FWTjm0JX9orlAejyzME/tsusqzksdqLAEXEJ4d9GnbYqHXfW0kZV1FB2WBScx6FnoiZlAsGSQG7nKjGOBk5FVSSbs/kxw+NUZWe3kCd41ivqtUo+ByhLXZgSwvXzCK2OwG7rUemZConJrVTqlGg0E1rvmtf6qEjnOR2GxO48qhrf5rgwSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776412710; c=relaxed/relaxed;
	bh=B9tw2tZGsXUMz/8zSZvqLbDzN0OphcNcggHmkLxSIf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayIhwZIUG2byrqbfp9pP9uISEgSYDXdU2du/Ta8soO83hNxnyyTORl6I7ariF/IOyZiYQavgAbd2YUCaTdmm86D4KHdis7cVBrOZg1HDJT55o7obeofAetyJqNFgtey9/jJjVulF0Ho32+ZVCcza/rS10CAZI0IvKk80Lk3MPnfla8STfP5/fvW3M5H4SfK8e55XN0lEMLbv1WBCr0bIGfO7iY5AMbKClHFBFsrCV7O7haetjEbKVdFy9bnV6iC347sULky3X+25LkfuOT3AkbS+v2Rk6zVBzv0uChRoRhyAZp19xEB5aWlArjG4EBRLIK+ZgiKwakXeJg6VoHNcmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IBOpVpJg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IBOpVpJg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxnLt1C3Bz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:58:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E09941842;
	Fri, 17 Apr 2026 07:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2086C19425;
	Fri, 17 Apr 2026 07:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776412707;
	bh=VQUKrR9nWoPJsROPvUoUyOlHujMLWC88AwwtyCd0cKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IBOpVpJgooMO5weqdtaWKIw5U1JbNTBM54JOf/4zV/Kr+ECkCLA9/Ho9PE3A+sei6
	 U/ynTePxGr4L9Gukk9q6spzWkSKR8CYi3uL6C7qylZgTDhMyE7p/X8Bgao+7TFvNnh
	 4ftsmv4HSqn9O9H1+yjQrKha24xFb3c2aMQAA+DXpmeFmzeRUZZM29X4EnErkFDMbg
	 KeP/iQ+3GI6mQlwTyfghpWZvCU4g2P6HF/iM2S2Df3kmYhy6jh5feLydOEb2rRxVHk
	 3h12d5X+jXELk5ev+/szz0RWCYnw3jvQVxar2pXcC0tT4dDBPk5sPTjwVvTlvhedyg
	 BJuDrbnFncZQA==
Message-ID: <b0c30cf3-751e-4f65-81ea-393c568dde56@kernel.org>
Date: Fri, 17 Apr 2026 09:58:21 +0200
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
Subject: Re: [PATCH] powerpc/perf/hv-gpci: bound sysfs formatting with
 sysfs_emit_at()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Kees Cook <kees@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 17/04/2026 à 09:48, Pengpeng Hou a écrit :
> systeminfo_gpci_request() and
> affinity_domain_via_partition_result_parse() hex-encode hypervisor data
> into the single-page sysfs read buffer with sprintf(buf + *n, ...).
> Both helpers only check PAGE_SIZE after the formatting loops have already
> advanced past the end of the buffer.
> 
> Switch these appends to sysfs_emit_at() and stop once the sysfs buffer is
> full.

You are changing several time a single lines by multiples lines that 
look pretty similar. Can you refactor in a helper function ?

> 
> Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
> Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   arch/powerpc/perf/hv-gpci.c | 56 +++++++++++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
> index 5cac2cf3bd1e..325b80f01629 100644
> --- a/arch/powerpc/perf/hv-gpci.c
> +++ b/arch/powerpc/perf/hv-gpci.c
> @@ -11,6 +11,7 @@
>   
>   #include <linux/init.h>
>   #include <linux/perf_event.h>
> +#include <linux/sysfs.h>
>   #include <asm/firmware.h>
>   #include <asm/hvcall.h>
>   #include <asm/io.h>
> @@ -134,6 +135,7 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   			size_t *n, struct hv_gpci_request_buffer *arg)
>   {
>   	unsigned long ret;
> +	int len;
>   	size_t i, j;
>   
>   	arg->params.counter_request = cpu_to_be32(req);
> @@ -176,9 +178,17 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
>   	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
>   		j = i * be16_to_cpu(arg->params.cv_element_size);
>   
> -		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size);
> +		     j++) {
> +			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[j]);
> +			if (!len)
> +				return -EFBIG;
> +			*n += len;
> +		}
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len)
> +			return -EFBIG;
> +		*n += len;
>   	}
>   
>   	if (*n >= PAGE_SIZE) {
> @@ -465,6 +475,7 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
>   			int element_size, char *buf, size_t *last_element,
>   			size_t *n, struct hv_gpci_request_buffer *arg)
>   {
> +	int len;
>   	size_t i = 0, j = 0;
>   	size_t k, l, m;
>   	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
> @@ -483,22 +494,49 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
>   	 */
>   	while (i < returned_values) {
>   		k = j;
> -		for (; k < j + element_size; k++)
> -			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> -		*n += sprintf(buf + *n,  "\n");
> +		for (; k < j + element_size; k++) {
> +			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
> +			if (!len) {
> +				*n = PAGE_SIZE;
> +				return;
> +			}
> +			*n += len;
> +		}
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len) {
> +			*n = PAGE_SIZE;
> +			return;
> +		}
> +		*n += len;
>   
>   		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
>   		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
>   
>   		for (l = 0; l < total_affinity_domain_ele; l++) {
>   			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
> -				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
> +				len = sysfs_emit_at(buf, *n, "%02x",
> +						    (u8)arg->bytes[k]);
> +				if (!len) {
> +					*n = PAGE_SIZE;
> +					return;
> +				}
> +				*n += len;
>   				k++;
>   			}
> -			*n += sprintf(buf + *n,  "\n");
> +			len = sysfs_emit_at(buf, *n, "\n");
> +			if (!len) {
> +				*n = PAGE_SIZE;
> +				return;
> +			}
> +			*n += len;
>   		}
>   
> -		*n += sprintf(buf + *n,  "\n");
> +		len = sysfs_emit_at(buf, *n, "\n");
> +		if (!len) {
> +			*n = PAGE_SIZE;
> +			return;
> +		}
> +		*n += len;
>   		i++;
>   		j = k;
>   	}


