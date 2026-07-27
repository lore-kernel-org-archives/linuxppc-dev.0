Return-Path: <linuxppc-dev+bounces-24898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED157C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 13:17:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7zfS49HYz2yhb;
	Mon, 27 Jul 2026 23:17:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785158256;
	cv=none; b=BdXEmL+ni9N6Fn4DBf8byfkGQ7r/dlxVHNmSGqD5X8Cd00dxNYuc7REOCnJtgjMPFGPylgJ4qDJtrUflyjysoAUcM//sY+fGZgpriteOmccQmqLYQw3hhljwIMn8ThPkAw3aK5XoclRKg2xnwL/OhZG1ca1OnBDYAFQsDTaMCSuDrOFa/h1MN50itaF+UpZaRpQVFlaUoZO1Ak4O/qZPrqRqnEfDUqJ1Idxzf6kjS5AzuutqizX7XhFXVKa9doohAuU4ohouzToYBmdL0AsD0DJIDvkrF+pW0xnJP/nd1yOCrzlBG594c8BHQWDuSFgTzooz6FzRwvxXQBkiYQgzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785158256; c=relaxed/relaxed;
	bh=0dhGY5qOyKg1HnUm1GdMZpZ5x5pm3RsSCxu7+yDtRaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvJxiPjrJgOSHYn7nnWIsX1YQZr1AgTabpGPdQI+vodNOR3awrXXdSPqYPkN30O5DlMIqOi9C9l6zFodpYSBKjUPuOzaiplXSvbcgPXrs4Urs3a6krZqgs5lp0aT2fjh8heP7oi8QeQLmsixa0aEWVgthvLp6t9zIX5nI2PnnN8q/THh2KhcCSimALIVLpcbwygib6QLDrOH7t/ysM5GxYqUMAL5WvhdfZk3BtvLgyx7LcGEQ93O0WKOyDhYxgKx8pkYxjdRZix3Cw7ggbGhkQ2C1b1kP8hFW9t0x8Ov22Hcvee7XHGx0VAjr4M0vAW/BfpsrD/UG7BCm96QdFlwxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXLUnOUT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXLUnOUT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7zfR74VYz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 23:17:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 23DC1600DA;
	Mon, 27 Jul 2026 13:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 345681F000E9;
	Mon, 27 Jul 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158253;
	bh=0dhGY5qOyKg1HnUm1GdMZpZ5x5pm3RsSCxu7+yDtRaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DXLUnOUTKKtpodftG0pQNozDQ7a0nwj4fCmO1svt1LoEJ/xuf865NztgdFQdcPumz
	 2CY2dDA62wDuf0yorSbW5AHH/CGbsL+GoAmgtySoyDulzHp2vH32bpHlyc+m79wg+0
	 vAH/ZAEEhU4/AJZ/ECpB9IDFgVIMQlDWMHxu/0DLg3Bjt5Gy6sC69r5Sev58VoXGrD
	 GaLJQm3dv0jKxJ+oJfBwiBzJurifsUJX7inWFHZlbTRf9x//bv6xRRXByvuJ3IVz8z
	 jMMlGlGnpIRiTV0EAMZev8xRnScDGjUQPIhrgCZLYtpeFdzZJa9k3hkkWnmDHpCuen
	 GlvYehZhW2siw==
Message-ID: <6aa7b8f1-f614-4d54-a95e-eb658d0a251b@kernel.org>
Date: Mon, 27 Jul 2026 15:17:31 +0200
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
Subject: Re: [PATCH v2] powerpc/ps3: Remove unused struct table in
 setup_areas()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260713091731.97212-3-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260713091731.97212-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/07/2026 à 11:17, Thorsten Blum a écrit :
> The local table structure is not used - remove it.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
> Changes in v2:
> - Drop the %0 change because it is valid kernel-doc markup (Amit)
> - v1: https://lore.kernel.org/r/20260712151300.3664-3-thorsten.blum@linux.dev/
> ---
>   arch/powerpc/platforms/ps3/spu.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e817def7f424..2c785bc72565 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -190,8 +190,6 @@ static void spu_unmap(struct spu *spu)
>   
>   static int __init setup_areas(struct spu *spu)
>   {
> -	struct table {char* name; unsigned long addr; unsigned long size;};
> -
>   	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>   					      sizeof(struct spe_shadow),
>   					      pgprot_noncached_wc(PAGE_KERNEL_RO));


