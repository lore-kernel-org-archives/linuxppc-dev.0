Return-Path: <linuxppc-dev+bounces-16395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9365DD358FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:11:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1xKM6v3Dz2xnh;
	Thu, 29 Jan 2026 22:11:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769685079;
	cv=none; b=GsE9usvEadM0zTUivovouedoa8KwNNoBhZXoNb14c40EoPwSWyhQderJ6oDMCHzoWaT2sysYS/5dh2zm0Mbvmo7oOBqqQSPqglcTXPe6euyO1JoqGyA7p5e9+BHqNb4VAxUkinFUcaKOD/kv93j7918mk2346bZQ/okP744kK1Za6qtagzFb1/rfetl5ZoWhXtBsTx3zdAS0SgZfzws4pkePCEmSdYEe/JgF72RwkwALg6Se09wqnjqNB5oeQUhAxfZ9z+MiPxu4jyAtqgjqLbkPXbSsaulpxwKU9h/9p4lUrIjUxWhsTPiqcUzcZzFEJC8cfiFEEQoEV/+1neGMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769685079; c=relaxed/relaxed;
	bh=fCOg+Vr+1pkQkn7jSacyO8tSOkEjiKDLkkPtwyOfo8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gm2LLCHj2v67ACqN6JTikFwIL7nbj46HnN//cGWC58aSGIGlyWAc5SStt2qZ6g+6udNsK5oyxVylaFPXidjgoHOftXyoHG+rDSb3JzqX7eLKDPdMwTa6IxsR55jIYXVW4UF/B12trK44O4169ZN0+2BP46pvnQeqMj5t1e0mlHua5B4KQRPxldoAs7dEJTyR51TgBY/MrPetymON1PkFRzXxyYvPOr87fHIA9HCyl2HB2jMqhhzDDxPLaKx5LOnY99KKEuPXUH5g1dTUIHJM65P7El1EvZ2KxYJA1iE6iJ2SDYTWsbI2l6B8QvndzJnMlrljxsc1PpSa/27+pyoTKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=egajm808; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=egajm808;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1xKM02G8z2xlF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2026 22:11:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E03A540673;
	Thu, 29 Jan 2026 11:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D00C4CEF7;
	Thu, 29 Jan 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769685075;
	bh=9Mj9fmfw6bq524BRF+/munvNYqAqgwilJJI8hE5YfC4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=egajm8087TXTn8ylQ+uBCRTkRb5hcW34LT4WDUss7w8rgOODjwprojyzNI/+wZmTy
	 Z6vpdsklBml2L7OgghLyshQ5W4YXwhm9Y5g6MeXLm11xX+bROcHavR2J21E2Su9oas
	 Az8ZOjBparxk5IM3i0L9j1VdYGSROeAvQnt9/UsfukzYOu4eLis8i0+/wBryxHMWIX
	 D7May8KTA/Zpsi03CyQ0R5vwqg9gQTUMNYbwPeITucLjjrymtrGSw/5HENlcI9dXJV
	 q/NFj92HfJPgjR3+5NdEau9xpXBHN3YNIDgleCc5LEHjov1COOmcaFoKx/k4e8ua/Q
	 ysHMkRwNF8yAQ==
Message-ID: <e23c7d00-2938-442e-9b23-1f730794e3f7@kernel.org>
Date: Thu, 29 Jan 2026 12:11:12 +0100
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
Subject: Re: Failure to build with LLVM for the Wii
To: Link Mauve <linkmauve@linkmauve.fr>, linuxppc-dev@lists.ozlabs.org
References: <aXs8sgAcci9FKKpx@luna>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <aXs8sgAcci9FKKpx@luna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/01/2026 à 11:55, Link Mauve a écrit :
> [Vous ne recevez pas souvent de courriers de linkmauve@linkmauve.fr. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> I’m trying to build the kernel for the Nintendo Wii, using LLVM instead
> of gcc, in order to bring Rust support to this architecture (and also
> because my distribution doesn’t ship a cross-compiling gcc), but I get
> this build issue near the end:
> ```
> % make O=wii LLVM=1 ARCH=powerpc -j1
> make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
>    GEN     Makefile
>    CALL    ../scripts/checksyscalls.sh
>    DESCEND objtool
>    INSTALL libsubcmd_headers
>    WRAP    arch/powerpc/boot/dtbImage.wii
> objcopy: Unable to recognise the format of the input file `vmlinux'
> make[3]: *** [../arch/powerpc/boot/Makefile:394: arch/powerpc/boot/dtbImage.wii] Error 1
> make[2]: *** [../arch/powerpc/Makefile:236: zImage] Error 2
> make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
> make: *** [Makefile:248: __sub-make] Error 2
> ```
> 
> I believe it should use $(OBJCOPY) instead of objcopy, which is set to
> llvm-objcopy, but couldn’t figure out where it is misconfigured.

Must be here I guess:

arch/powerpc/boot/wrapper:${CROSS}objcopy $objflags "$kernel" "$vmz.$$"
arch/powerpc/boot/wrapper:    ${CROSS}objcopy $4 $1 \
arch/powerpc/boot/wrapper:    ${CROSS}objcopy -O binary "$ofile".elf 
"$ofile"
arch/powerpc/boot/wrapper:    ${CROSS}objcopy -O aixcoff-rs6000 
--set-start "$entry" "$ofile"
arch/powerpc/boot/wrapper:    ${CROSS}objcopy -O binary "$ofile" 
"$ofile.bin"


