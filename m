Return-Path: <linuxppc-dev+bounces-19945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F4F9B618
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 10:53:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0x0h6wYBz2yr8;
	Wed, 22 Apr 2026 20:53:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776855220;
	cv=none; b=YMFoGVNDiAd0IcxgdAzQcyPX8QM7M5fJT7KkFiKhxN7WZlTzRs/wXqrMjPhgXxxjV1wfOKjnEHGtMlVOU+BxbrSW7Nfwq9dnIZaKa1Ew/k4aMbzs7dBym0KisCpdkkQl4OAHNUgSa8KIgxBPyi+AVzHbPiWSTs5/XlSyItYEfvXVmN8Jw/lfIfUvGeBAq1lBPjfNEKiFTBEG1qHoLR+XbkQl2/u0VFJZ2fnR+8K1Iq7cEMKa3hmgFflp1rI5xLL46e3Lp/EAv60/L2fzL06hfWYBdI7dnRbLAB/BxhADP+t3Yb5HKXXyPvoiXqsVSzlpY8OF1+vz0TR5ZYev1xXN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776855220; c=relaxed/relaxed;
	bh=OwJcZ4HBLB54OI5AFfAOpO1ydlntoi9mPlZeNs7EY9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHe1K9TIoi1XLx764kS5KsMibKXMUHgEE5uO0UhgIfMy2CRmjpOVNsnt2tlZk96Ts/nV393gtE7gxzgxp7SAyjPjAAlMq/TZiWSutPTM+HPHqRqfy+Y8ziP0NPJBsQe1+jvfc9UnFICqbc8ThK5mcJaRamWnLM2vfpQooKaew9Ius54BWJJpMtpscf086+54FHvOz9E9ds5Xg02OIVNnsTS87Fxu6LB/dKAua0Yv3JBC0hyUl+Q9KevjDRItNHdL5PYy20JH0tUqjetVYGdDFmXTjau6fZkONfveumlXT90lGj5wEZhCaoCbTlJxRuLYPb5POzC+u1R9AV3uJB5sRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fUNttYnM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fUNttYnM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=horms@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0x0h0Fg6z2yr6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 20:53:39 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01698600CB;
	Wed, 22 Apr 2026 10:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B4DC19425;
	Wed, 22 Apr 2026 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776855216;
	bh=ft71bsoOUWGTJtW1ZFq6hY21ozdG2v4Dg7mr51X6pLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUNttYnMtOBg3D7mM/O3lX1Z0FGZo8PMNwpzoutfIDAn1mbNGCjRXJSl+TuSgdOyK
	 voHy0YijRIzCz++rwem8APKKdDeE8s793e91t43vmEdEhOj0EZnTwM105OAHoRQShU
	 auQ8TY+v1/K0im0i8CavgL8HaGtVtSHk+65Nw59rZpq7leNkAfWR+T89MjKp8I6Yg7
	 H0c1EwBiPYCgS2l4XJCJd1rF2F8DnoAnXtVcfcUCgQYfVXUUGhb+CzGEorgrtJKHoc
	 oAbdruxMz7gX4PABqsOKDE7h6be9BAug9JX4rJ2h/Sezp7wUDXbKZEZGrQEzonePmc
	 K3P9S60/wfmjg==
Date: Wed, 22 Apr 2026 11:53:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net,
	skhan@linuxfoundation.org, linux@armlinux.org.uk,
	tsbogend@alpha.franken.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, 3chas3@gmail.com,
	razor@blackwall.org, idosch@nvidia.com, jani.nikula@intel.com,
	mchehab+huawei@kernel.org, tytso@mit.edu,
	herbert@gondor.apana.org.au, geert@linux-m68k.org,
	ebiggers@kernel.org, johannes.berg@intel.com,
	jonathan.cameron@huawei.com, kees@kernel.org, kuniyu@google.com,
	fourier.thomas@gmail.com, andriy.shevchenko@intel.com,
	rdunlap@infradead.org, akpm@linux-foundation.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev,
	dwmw2@infradead.org
Subject: Re: [PATCH net-deletions v2] net: remove unused ATM protocols and
 legacy ATM device drivers
Message-ID: <20260422105324.GM651125@horms.kernel.org>
References: <20260422041846.2035118-1-kuba@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422041846.2035118-1-kuba@kernel.org>

On Tue, Apr 21, 2026 at 09:18:44PM -0700, Jakub Kicinski wrote:
> Remove the ATM protocol modules and PCI/SBUS ATM device drivers
> that are no longer in active use.
> 
> The ATM core protocol stack, PPPoATM, BR2684, and USB DSL modem
> drivers (drivers/usb/atm/) are retained in-tree to maintain PPP
> over ATM (PPPoA) and PPPoE-over-BR2684 support for DSL connections.
> 
> Removed ATM protocol modules:
>  - net/atm/clip.c - Classical IP over ATM (RFC 2225)
>  - net/atm/lec.c - LAN Emulation Client (LANE)
>  - net/atm/mpc.c, mpoa_caches.c, mpoa_proc.c - Multi-Protocol Over ATM
> 
> Removed PCI/SBUS ATM device drivers (drivers/atm/):
>  - adummy, atmtcp - software/testing ATM devices
>  - eni - Efficient Networks ENI155P (OC-3, ~1995)
>  - fore200e - FORE Systems 200E PCI/SBUS (OC-3, ~1999)
>  - he - ForeRunner HE (OC-3/OC-12, ~2000)
>  - idt77105 - IDT 77105 25 Mbps ATM PHY
>  - idt77252 - IDT 77252 NICStAR II (OC-3, ~2000)
>  - iphase - Interphase ATM PCI (OC-3/DS3/E3)
>  - lanai - Efficient Networks Speedstream 3010
>  - nicstar - IDT 77201 NICStAR (155/25 Mbps, ~1999)
>  - solos-pci - Traverse Technologies ADSL2+ PCI
>  - suni - PMC S/UNI SONET PHY library
> 
> Also clean up references in:
>  - net/bridge/ - remove ATM LANE hook (br_fdb_test_addr_hook,
>    br_fdb_test_addr)
>  - net/core/dev.c - remove br_fdb_test_addr_hook export
>  - defconfig files - remove ATM driver config options
> 
> The removed code is moved to an out-of-tree module package (mod-orphan).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - keep BR2684
>  - correct the claim that Traverse Technologies is defunct,
>    I'm still deleting the solos driver, chances are nobody uses it.
>    Easy enough to revert back in since core is still around.
>    The guiding principle is to keep USB modems and delete
>    the rest as USB ADSL2+ CPEs were most popular historically.
> v1: https://lore.kernel.org/20260421021943.1295109-1-kuba@kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>


