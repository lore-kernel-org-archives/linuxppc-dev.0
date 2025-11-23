Return-Path: <linuxppc-dev+bounces-14430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5CFCFA46B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Nov 2025 14:57:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dDsWM0WBzz2yvM;
	Mon, 24 Nov 2025 01:57:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763909855;
	cv=none; b=CqAKJSCZ7kpmXvtL/WUzJoDoTH91Bs8XNlwDrwcuhOLMPJQx9oFmIEG5Igfdw7qZSvUgFVSFjepPPzQO6WLzqVA1GTowg1WKYk1tu0D3V89Hj/qmAv91SlcDyjsiQPpxGGcXqdj1QnSfSoMevdBcAQtGdVVJ4sx+A7h0la93OW7HQ4l0kVk4+dInubueqbBVgqnWT9IgU4tv3V5T0eq4bTnJXBBt5BXogkQ7HVjgCroMhc8t5th79zpGT1IE3Pdzzwbt4V7TjNvlQzb+0qJu1/7sWDdnplsqMgl+73TQJuJpD8xh3uL+iYFWmw+Dj1BTirHeqvXk1InbT4PbaIUM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763909855; c=relaxed/relaxed;
	bh=rtcA7Uc2HIlApvW4klg1wPonZEbY7o0wvIbGAFYXJ+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yw4dkwToIemYxV/P+3pDD7muTS3+DQck9lqVmQNW91owFYBJSsE6gERSeBW9fnAXbwexh8DWmerZQhZCSb8L2mw0Mx0Q6nFD2+BwL56gzbTD093ZDRQoTjjEZhJYR6lqLiMaCBwSmXzlYg8+nOVP8FhBvJLKXbeptnwP5z+sVFXDy0sUIC+roqigpzx2XhkkRAFGSVbDjATO79NX5d87Qa0KxGNVsZOkRKmjezUkDM/g+3j7H3IIpl4Mlln2JuoVwJMV2461vK+SNYIyrXCqx2q7KpSyCmzxlXMkGWwgrp9uAXdF1q/+AU762YmlxobS8Ns6XIg6ff+frnzZ3fyU3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kuKqZjYN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kuKqZjYN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dDsWJ1q1Fz2yv7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Nov 2025 01:57:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 27546402B2;
	Sun, 23 Nov 2025 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4ABC113D0;
	Sun, 23 Nov 2025 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763909849;
	bh=K3ub+XN+dK5BebXb5mWR26pjcLIx/qIluZdqNfZ1t+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kuKqZjYNy9zZsGzAmW+DCx7ZL6pFdTlkY2Sr1vt0WEsR6UHdn1wWoreBt1bhiAT5p
	 BMxN69x+BPfEkoCBLGvuFIfsnxAp4aiWtumrcj+2neGxfxc5hg4VOWNr6NlQhHsTKh
	 +dtvqylXTj4n/+dSVrzvF/2aW3lVhCM66ALuuRCcELxlICgvdI2Z8c8i9dhFk5BSaI
	 0RNeuWy7ADL93Gmyf8oNMW7k3w+4D54LjGTKbG/xKbsFYCGh9tbba6q+PZvoQCBVhh
	 NAxYz4LWYU0dRaE+1IOoHV8DE0ExHZ9f1eQrY09PAYdm0x9T1akiYDaL+1eYmAdhCG
	 wHtVGTzhbDJaQ==
Message-ID: <d69d7167-00d1-49c5-90ee-6bc0b7e8295f@kernel.org>
Date: Sun, 23 Nov 2025 15:57:24 +0100
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
Subject: Re: [PATCH V2] modpost: Amend ppc64 save/restfpr symnames for -Os
 build
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20251123.131330.407910684435629198.rene@exactco.de>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <20251123.131330.407910684435629198.rene@exactco.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/11/2025 à 13:13, René Rebe a écrit :
> Building a size optimized ppc64 kernel (-Os), gcc emits more FP
> save/restore symbols, that the linker generates on demand into the
> .sfpr section. Explicitly allow-list those in scripts/mod/modpost.c,
> too. They are needed for the amdgpu in-kernel floating point support.

Would have been interested to know with which version of GCC the problem 
started.

By the way you seem to fix the problem for modules, but does it also 
work when amdgpu is in kernel ? I would have expected a need to add 
functions in arch/powerpc/lib/crtsavres.S as well, just like following 
commits:

8fe9c93e7453 ("powerpc: Add vr save/restore functions")
7fca5dc8aa7a ("powerpc: Fix module building for gcc 4.5 and 64 bit")
da3de6df33f5 ("[POWERPC] Fix -Os kernel builds with newer gcc versions")


> 
> MODPOST Module.symvers
> ERROR: modpost: "_restfpr_20" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_restfpr_26" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_restfpr_22" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_savegpr1_27" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_savegpr1_25" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_restfpr_28" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_savegpr1_29" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_savefpr_20" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_savefpr_22" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "_restfpr_15" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> WARNING: modpost: suppressed 56 unresolved symbol warnings because there were too many)
> 
> Signed-off-by: René Rebe <rene@exactco.de>
> ---
> V2: description
> Theoretically for -stable, but no previous commit that broke it.

In that case you have to add Cc: stable@vger.kernel.org
Add indeed it is likely a gcc upgrade that broke it, not a previous commit.

> ---
>   scripts/mod/modpost.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 47c8aa2a6939..133dfa16308a 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -602,6 +602,10 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
>   		/* Special register function linked on all modules during final link of .ko */
>   		if (strstarts(symname, "_restgpr0_") ||
>   		    strstarts(symname, "_savegpr0_") ||
> +		    strstarts(symname, "_restgpr1_") ||
> +		    strstarts(symname, "_savegpr1_") ||
> +		    strstarts(symname, "_restfpr_") ||
> +		    strstarts(symname, "_savefpr_") ||
>   		    strstarts(symname, "_restvr_") ||
>   		    strstarts(symname, "_savevr_") ||
>   		    strcmp(symname, ".TOC.") == 0)


