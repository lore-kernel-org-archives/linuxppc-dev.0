Return-Path: <linuxppc-dev+bounces-17493-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33717D58E78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 07:39:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPW6K5MfQz2xc8;
	Mon, 02 Mar 2026 18:39:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:242:246e::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772437177;
	cv=none; b=AOcwVh6gjl7NqXL7u2+GZAVMq43jB543xvRZg+r2eLHi/ec/SZxQhcBqC6Bzhzvb/OtM2zDJhBCLR33J8epD34cgk6OL1UHNpC+uusUxhzZ8KSDs4HGqdHhsNWmlfgwPy5VxYBarwj15iDDnIWs/4hthlfDc5mmkUzuEVPpYtlX/U1Q2rTTsJFJNhnrQiSW9Ki+0I5FFp7H0nxmE7mBug2yP2UnPhWPTFiaUzmMHxHpc0ngJEchzmLSktWRwgNZx7+usbolRyeegJ99vBZxmrp0EUjQ5Ds6b/awGBRgQvT7v9hREDBFAn3PFnDgRNMy7Lai0hNpM6ip8gbd+WZNkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772437177; c=relaxed/relaxed;
	bh=s0B14b5FSBUEgAk+L55J5WroPPngMpauRKzhBytrof4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnRaP02b3mMxtZ2xI34LIdmpnlzpI3WmO8LV6qfVZenZWbCeB5H/NXR1LA8JWfi9WYnTT8QNY+bZcPlggi3A7ZRGObe2G2b+1xBRLUxeuW1ZXEJfBs/4WfZF8DQjBEQviqh6OmZXI4KCOYRyGYs9WXPEV03fGj+yqJ9YjaGCxr6GVftT4cLCUWh63mHUXb8vt9sY5EjVH8M3VjostKSopbmh701IpSXfcbjI+tXV8/oPM0348DcNTmL+HXd5xU+/mPyKdeXlAE/TEJ+7XzHnoaHSzUqRwHtom6KqhsKdZnbksEZkvBrKphWyAJe5dBDB68AxYF6B4Sdn0ZeE1E6rLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=TKl3kCzC; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org) smtp.mailfrom=sipsolutions.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=TKl3kCzC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sipsolutions.net (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPW6J4Rlcz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 18:39:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s0B14b5FSBUEgAk+L55J5WroPPngMpauRKzhBytrof4=;
	t=1772437176; x=1773646776; b=TKl3kCzCAXiuzt4uD6S6sxf1SalmAA5cIjLL6O5QWudu1C2
	6/BFfp3uf3q0XsPs/Y+8eUsMrxUzimpCPwTrtdCaO4AmRyWyxtfMRAGb0C9igYGiGqHhpMCX0XM64
	b/jyzBvPvLl4MO9g6W8BE6+ShsCoM0QnOpAW2GF+GN2m+ECDDETSQogZ+xu9JUW5+ODMQrHxNqlPD
	tkQ22WsIqFS8q8f6tRZ4RtlCSKntt9WniBL11R8vDMjdhFFngU/OCIL3lUdwFE4YzzFY0n4iNfnSG
	KXQBm6OvjBK+iuzLUpB8xMx0BJ47JPUOzQhu8rvJuNZqN/6jPPEXqgYKMDCinAwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vwxrd-00000005zul-3cbJ;
	Mon, 02 Mar 2026 08:38:50 +0100
Message-ID: <3e3f46aca653cf99799111279fc554b4ca31f6b7.camel@sipsolutions.net>
Subject: Re: [PATCH 03/25] um/xor: don't override XOR_SELECT_TEMPLATE
From: Johannes Berg <johannes@sipsolutions.net>
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Henderson	
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas	 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai
 Chen	 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan	 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin	 <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  Paul Walmsley	 <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens	 <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev	 <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>,  Sven Schnelle
 <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson	 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov	 <anton.ivanov@cambridgegreys.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen	 <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>, Dan Williams <dan.j.williams@intel.com>,
 Chris Mason	 <clm@fb.com>, David Sterba <dsterba@suse.com>, Arnd Bergmann
 <arnd@arndb.de>,  Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
 Li Nan <linan122@huawei.com>, 	linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, 	linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, 	linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, 	linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-raid@vger.kernel.org
Date: Mon, 02 Mar 2026 08:38:47 +0100
In-Reply-To: <20260228043006.GA65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
	 <20260226151106.144735-4-hch@lst.de> <20260228043006.GA65277@quark>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-malware-bazaar: not-scanned

On Fri, 2026-02-27 at 20:30 -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:15AM -0800, Christoph Hellwig wrote:
> > XOR_SELECT_TEMPLATE is only ever called with a NULL argument, so all th=
e
> > ifdef'ery doesn't do anything.  With our without this, the time travel
> > mode should work fine on CPUs that support AVX2, as the AVX2
> > implementation is forced in this case, and won't work otherwise.
>=20
[snip]

> I'm not following this change.  Previously, in TT_MODE_INFCPU mode,
> XOR_SELECT_TEMPLATE(NULL) returned &xor_block_avx, &xor_block_sse_pf64,
> or &xor_block_8regs, causing the benchmark to be skipped.  After this
> change, the benchmark starts being done on CPUs that don't support AVX.

Yeah the commit message is confusing - the change itself is really
trading one (potential?) issue (CPUs w/o AVX) against another old issue
(benchmark never terminates in TT_MODE_INFCPU).

However, since commit c055e3eae0f1 ("crypto: xor - use ktime for
template benchmarking") the latter issue doesn't even exist any more, so
it now works without it, though it doesn't really benchmark anything.
But that's fine too, nobody is going to be overly concerned about the
performance here, I think, and if so there's really no good way to fix
that other than providing a config option for an individual
implementation.

johannes

