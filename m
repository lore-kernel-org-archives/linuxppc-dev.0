Return-Path: <linuxppc-dev+bounces-24897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9EBC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:17:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7zdw663tz2yhD;
	Mon, 27 Jul 2026 23:17:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785158228;
	cv=none; b=WLmh+09qtdI3oBdjhL1tzKiOkRLNzWKaMDv5kBIzqb3MPqihQn3WrioXBNLvAU3eLkyxsHINs5fh724/z2b4/Xzpj3PqLeWxq1KA4kVQe0o+P9FBj61aGOxUslfxWojDDJOKGdV8c7NLBY7DJ98iVns5gDkrbtVlam5mh8TzGwmvvIuLHj0eiF3ZpMNBtKoQ7v5b709bpfZY+bgPmutJmEeb1s2MTvY93GQwZ23loNFBMQ9XbbRHfsYv5eXPoGKmspHwtP5iZOzHrgV5uxpjABIm31IC13G/rlxT3NtyRWjKEa825HNFO1mgpvhHZQaQ/99s9cwL/08KRmwS/Ui5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785158228; c=relaxed/relaxed;
	bh=zdQJhbrsQHteHSYcPe9nSiBD4ItXTowiBtFndGbCnO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoFO5d4py1GBQ1P0btVVurfhhXAeKudHVeGCzCAg76GS5j2ElVeBy1opb5vBRTgYp61W1n64XFhIEAE6zbrR7BTp4w6Szn9FvhJHfwNYyqr464JjcdAOa3uHgP61NkQosPVVDrZxIs8YIKLComAjIRI0xLADUdOLEwzqAwAcM4ZrsxdtmkyzfFNon2qG2eRmdv/avgMEzXZktLyJl2ZhPzSjTBILUrzaiHSWZYHqdchfvRewk1a7N4/3RDzrZS60VDnDkhoHrAdODaYr5FXhip4XKZYA+Z8U8mExNZdeF2+WHBpJlTKgtbYgfFZo2a0R7oq15SruaaobPAepshHjTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOVwXt2B; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EOVwXt2B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7zdv73Chz2ygn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 23:17:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 21283600AA;
	Mon, 27 Jul 2026 13:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4CD1F000E9;
	Mon, 27 Jul 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158224;
	bh=zdQJhbrsQHteHSYcPe9nSiBD4ItXTowiBtFndGbCnO8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EOVwXt2BblgCHd+f1rWS50HK1CY5ebCT70jTTiU/Fyi6HFo5Y1FJ9y7UKDNX8x65k
	 Hpj78ABHSjQpCjZoeUSZtt+AslXzwm9jQZxRTTm/5ca6xp8NMHF4QKmZpb/+mXphZp
	 73aSjtLBGflzKRMCwd2B9cD15A4riTKdpCjasq3T1ZlvUmmDmdJzW89AxwphcIegaw
	 3Z/VJOoZ9c1j+THr8prCD46I5kKf8vYf0G1y4ir4j+RC7HMfOJE7LP9wygfOaNNKAb
	 HFnGGe3TWcRzfGpVpICnVbNWOwZQVyzLwpSYXr1EOA/VlfUYd5gylXbqnT5mRT1uq+
	 Eqi1BYPdYLxog==
Message-ID: <a7f327e0-072b-41c9-ba95-361c948ddfa9@kernel.org>
Date: Mon, 27 Jul 2026 15:17:01 +0200
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
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260712151300.3664-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/07/2026 à 17:13, Thorsten Blum a écrit :
> The local table structure is not used - remove it.
> 
> Remove % in the comment while at it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks like it's never been used since commit de91a5342995 ("[POWERPC] 
ps3: add spu support") that introduced it.


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

I have no opinion about the %0 versus 0, is it worth the change ?


> ---
>   arch/powerpc/platforms/ps3/spu.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e817def7f424..c904f9fa1caa 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
>    * The current HV requires the spu shadow regs to be mapped with the
>    * PTE page protection bits set as read-only.
>    *
> - * Returns: %0 on success or -errno on error.
> + * Returns: 0 on success or -errno on error.
>    */
>   
>   static int __init setup_areas(struct spu *spu)
>   {
> -	struct table {char* name; unsigned long addr; unsigned long size;};
> -
>   	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>   					      sizeof(struct spe_shadow),
>   					      pgprot_noncached_wc(PAGE_KERNEL_RO));


