Return-Path: <linuxppc-dev+bounces-18935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1944210F2863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 17:51:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj7Vs51LZz2xmX;
	Sat, 28 Mar 2026 04:51:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774633893;
	cv=none; b=a2l9/LiaS1hk0Fv2snIMgN87tNTmdV9WC6FU5zIFG+XKpqQGnhlAFf8EI3ng8ept/2mMhGY1XAXFhu9GzDTB1OT2RtBQ3YXNL7BeyuOUC1j1r87Uq91tjCDVyrSLY5yvUWec1j2N44Rqguh/HhHU+OsgbqbcblTOFZ5a6X7jHtm9mcqM/Aut+tCNcmUGwxn9F/RFYGZG2frHsYWazRNtE7vdXH8kfotqp4jemcEMQ0PyhnHAk9d//uPOUp0V2Eb9I8vPFX3Kgmyn8Agt/8K6iioBIssjGsi9E1w65ks1MXA/Y2WXl4K2v+Q/Mi1Q9tOm4KobvKDY2ISc4nA3ujV4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774633893; c=relaxed/relaxed;
	bh=NEcgHCbJlBBYTZQ+XgLbmm3KVd9zLogDyBiIDz8me5A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=POAscOO9EfFLAk4jVDa0buEusGxjq/UjakNPVjfjhlIbwCfOcYE15wbMsYlil9j1oM7WQz9MlpFgUr6hl0KAN4ZRpG2FI9T2bpJo+/FC8vJCrhxN/n8yTShz2HULBxfP5SPzNF/DV463rBJytAndKafmBmn8nKys+9YFUMzLPUUKEnzEkdguPBjJxjUf1lDpWk6v+0Ws3piQO6dpo/3qQg1kMgfP+owTZB0UgRVCF8aexDnyn+NqcMKtrahrG93Se0KAfhpFuVFo8nu2QlflYdY+JlCrj+3ND87ZXWuNFrmSu4ncU7SJN5k1RpWKmzx0qlmA9hS9GvXiCNZBSyzJyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tDB0MgLH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=tDB0MgLH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj7Vr4NPbz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 04:51:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8BA7343C23;
	Fri, 27 Mar 2026 17:51:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF370C19423;
	Fri, 27 Mar 2026 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774633889;
	bh=ut3C5Oibhu02lZBarl5gtLhPMmjWlwAPsAficDpw9oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tDB0MgLHz5uhVLWEaFReNs99y5u/YY74Iml33dpseoOBD0A8VJRFFQYeU9FvqxCuP
	 nyqAUmYCNk1T74zARlT1dAb3bA7OmvIjh9mNwh7l1JQENaDWThwxkEsSuzSKK+Qc4+
	 obJODpvlMAd7z/q0AZNLNKGt9R6dV77UeQmuFqzk=
Date: Fri, 27 Mar 2026 10:51:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Dan Williams
 <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, Song Liu
 <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, Li Nan
 <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 23/28] xor: add a better public API
Message-Id: <20260327105127.1a1f3895adb14681141a0a30@linux-foundation.org>
In-Reply-To: <20260327061704.3707577-24-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
	<20260327061704.3707577-24-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 07:16:55 +0100 Christoph Hellwig <hch@lst.de> wrote:

> xor_blocks is very annoying to use, because it is limited to 4 + 1
> sources / destinations, has an odd argument order and is completely
> undocumented.
> 
> Lift the code that loops around it from btrfs and async_tx/async_xor into
> common code under the name xor_gen and properly document it.

Something funny here - two different patches with the same title and
changelog.

If you can send over new versions of title&changelog I can paste that in.

