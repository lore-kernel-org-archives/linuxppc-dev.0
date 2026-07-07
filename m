Return-Path: <linuxppc-dev+bounces-23748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7303C43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 22:29:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvwrf115mz2xnp;
	Wed, 08 Jul 2026 08:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783463378;
	cv=none; b=fGOrlG2CVlbfF+inCbGvIhulSwRb9AnSdXXu1I4hsKME6fcODvV3PVmLUcA/uGJHCzVvf3YczUzpBhS7Kn+B0WSO5+btrjcTojQX0OyEGw7uOAGaTdvkOMkhNXOsB9rVotnDRWbk+vPG1+VCBY5zJdlppZBDrF+MylvH11NIVObbMO80WVimLU0ocKqxCLW9JgYINDw34wrFRLUVpzXh3pHSlNe+actwciJNLrm7sxcUj5e2npJXF9/0r+o0jeTGxiAMAxCcqzrN298npOnjxjwT00T462vUE3U64rB32wEcMs2n00OkcMwzOZLd628RFwdggSBnO37QjnuLgdmEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783463378; c=relaxed/relaxed;
	bh=AZhsVbg+pGpdN+LoqPtk1yF43RbR2KSyGy50RUBXUK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PW+U5UkbV2nIDXX9kzHGS23qUpmbxvHK1bUWObrEmoRdHzie46hxAjXQnc1eBrC01guPYSDZBGjutBl/SRq2rgL9i+AluKf2X9BKtm7ZkBXM9dl8iX1a/u2QjpJ8MxJlS4HgrG+vKAsbq5N3CZAripElRWDBQxP4RLxNhhZ2PVC+D9/8ORH373di/SZq+nYzbEsv40gWxqij4EVc2oDWFEdZVC1QIvo8kVBtDjNKXB+rkCZZ70Sf7ZaN8nolYkit4raaD9pw+M8jWDJKH3GBBkppIKCizD51RygsD7rNzSMoUWu4SJoHSNahkJ++Kz9Bm2+sutPDviKaVLPX3qjldw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Or+9ysIy; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Or+9ysIy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvwrd0hQhz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 08:29:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 578A540139;
	Tue,  7 Jul 2026 22:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A18A1F00A3D;
	Tue,  7 Jul 2026 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463370;
	bh=AZhsVbg+pGpdN+LoqPtk1yF43RbR2KSyGy50RUBXUK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Or+9ysIydRJTTAmJSj0I5DWOTDMV8z+insajMqA+tXpscLj8XffwtjCWQIOwgLF9b
	 kOBeHKlD397Jl1ihy9/LI+iHpVxPQ37I1vs+0VKKVH9XilyZKQZyUePhWmYjma+wJQ
	 nyVUHvIeuyYNnUN49Gob8cVX12KgQGrpDMpyZAiBRatmbwJMjlmQrFonqul660gX7L
	 W5Xc2cFsm7/za20peyS8gc3mrd+x6ouFura0Tf9D780Fxo1Wf5211n/xAg49jFLVB7
	 TtZkO2/iHKVbuMRdxnuloQgH2k1In8d0QKwO+OAIP4SqakzoKN6y98ncnoYPQsT3lp
	 iKTqXb0M/Zo/w==
Message-ID: <98d65de7-e5aa-4197-85bd-219eab01e572@kernel.org>
Date: Wed, 8 Jul 2026 00:29:26 +0200
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
Subject: Re: test_bitmap fails on ppc/ppc64 on kernels v7.1.3, v7.2-rc2
To: Erhard Furtner <erhard_f@mailbox.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel@vger.kernel.org
References: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 06/07/2026 à 21:27, Erhard Furtner a écrit :
> Greetings!
> 
> I don't get this on my x86_64 machines, but on ppc32 (PowerMac G4 DP) 
> and on ppc64 (Talos II, POWER9) running Gentoo Linux. This dmesg snippet 
> is from the G4:
> 
> Total memory = 2048MB; using 4096kB for hash table
> Activating Kernel Userspace Access Protection
> Activating Kernel Userspace Execution Prevention
> Linux version 7.2.0-rc2-PMacG4 (root@T1000) (gcc (Gentoo 15.3.0 p8) 
> 15.3.0, GNU ld (Gentoo 2.46.0 p1) 2.46.0) #1 SMP PREEMPT Mon Jul  6 
> 20:22:47 CEST 2026
> 
> [...]
> 
> test_bitmap: loaded.
> test_bitmap: [lib/test_bitmap.c:397] bitmaps contents differ: expected 
> "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
> test_bitmap: parselist('0-2047:128/256'):    912
> test_bitmap: scnprintf("%*pbl", '0-32767'):    5977
> test_bitmap: test_bitmap_read_perf:        1191082
> test_bitmap: test_bitmap_write_perf:        1270153
> test_bitmap: failed 1 out of 208655 tests

On QEMU (pmac32_defconfig) I get:

test_bitmap: loaded.
test_bitmap: parselist('0-2047:128/256'):	2200
test_bitmap: scnprintf("%*pbl", '0-32767'):	26440
test_bitmap: test_bitmap_read_perf:		1819760
test_bitmap: test_bitmap_write_perf:		18189840
test_bitmap: all 208655 tests passed

On QEMU with your confirm I get:

[    1.162486] test_bitmap: loaded.
[    1.177069] test_bitmap: [lib/test_bitmap.c:397] bitmaps contents 
differ: expected "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
[    1.180599] test_bitmap: parselist('0-2047:128/256'):	2920
[    1.190105] test_bitmap: scnprintf("%*pbl", '0-32767'):	65560
[    1.427378] test_bitmap: test_bitmap_read_perf:		9546321
[    1.438769] test_bitmap: test_bitmap_write_perf:		9344481
[    1.457679] test_bitmap: failed 1 out of 208655 tests

So there is something with your config

> 
> 
> Full dmesg available at request. Kernel .config attached.
> 
> Regards,
> Erhard


