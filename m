Return-Path: <linuxppc-dev+bounces-19669-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF0CEBFD20
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:01:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvLx51gqbz2yrZ;
	Mon, 13 Apr 2026 19:01:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776070873;
	cv=none; b=DodQN2fFoTfaPfoNVs89SuWS1V/clqZz9X/bdIjcFPjYUqglGU8+ffKGcnGarpfkibwv03fPYawXfJwuYPHe1W3nzJyD1H5HfM5EOsFhmUhCbho87u2ZG16vclxbkx4irHiEOG6hmH1pDNdAmYG14jfxHn5Bij7XDZItcgRvjJ4pUvuE0VktbaS4RFGNxTm+KO8ivaDTyPxuGXxio0t6J1rI68nLVZQ1MYC291QJJ0gftkbSKUJM+TA/XKDwDmDisxxI0scp1NEKQVHx4TMtRrciU7au09mfTyU06xfua9o7A4jtR5n2qkwGbVvyBu0ObtvSFOH7NeINfS4xeigx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776070873; c=relaxed/relaxed;
	bh=6tn1tr/EOCjX/U3xON55GSnIaEvRsYLTCTnfd5yyfW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EisdEnJMDV6E6SPijRIYbQ18bFpfXRGq6t/IxeiEwoFydgOXIv7zOLGLoq/GZ5NzHSAW2C/57aoFa9a3tb+W97fkQHyf3chrNGl4v0zxxNSvvqBWG1IIpPpl1k9lhV+o1v4ykeZwcGc3EJ7/kvyAWO6Fm3XUVkHwWXI/xj7upNPAtNBDYtZ/d6LGa8CDMnzCZY8EjFy4Y5NYczVJEfVDsX6EkVsJpvuoAfg0of35WcaJlBWizaY2jUTAIPB/kV/5JDdoUKO9LWZKrXrpMdY/5rz+b2S1CLpcZqDSuryIoCV2/zhPkxIo7OcfEU+0MHiPQv1t/OCvqI1eSfRj2kg3mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bfyW73rE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bfyW73rE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvLx40NKxz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:01:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3123160172;
	Mon, 13 Apr 2026 09:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57513C116C6;
	Mon, 13 Apr 2026 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776070868;
	bh=NmWTXdFZa2PXaXxihxiBwP6/fcqhMPMR8Odd5UUj3qI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bfyW73rEx6WunGZVvr1kdbuQhIZW0auQdr185ZFOdqezYfVI8EqIl4RV+jZMHErnf
	 HHqywW91vp7CVLzZ8tl9LuEsJL2nKmijW0OQ98WRnNBsFsW1LYo4ZFpZLLA1RAeRqi
	 fLF9xsDW37jcs+y2EAiBEgZnfjWYwDz/hvRsB2Ow2oVioAmoaeXLVkxbmWKx3ILDyy
	 OFKArZB3La00uc7rhVgunFkOn3bZFgPE1fuUov3rdMuNp+wqIMsO2YWxMIl1vusQFL
	 bBAU79v+8ddAl2Ytb2JX6K5ckn/0H32ur+wYUjKyGCCdFu1O+cEC54vJcUyB4ZJ+rF
	 y0fFboG7dTA8g==
Message-ID: <67c579d4-4e7e-4b3a-a2b9-7ba669664bdf@kernel.org>
Date: Mon, 13 Apr 2026 11:00:57 +0200
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
Subject: Re: [patch 14/38] slub: Use prandom instead of get_cycles()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, "Harry Yoo (Oracle)" <harry@kernel.org>,
 Hao Li <hao.li@linux.dev>
References: <20260410120044.031381086@kernel.org>
 <20260410120318.525653921@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260410120318.525653921@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 14:19, Thomas Gleixner wrote:
> The decision whether to scan remote nodes is based on a 'random' number
> retrieved via get_cycles(). get_cycles() is about to be removed.
> 
> There is already prandom state in the code, so use that instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: linux-mm@kvack.org

LGTM.

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


