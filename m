Return-Path: <linuxppc-dev+bounces-18788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2467D109C059
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 19:58:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgyQF4gNFz2yYJ;
	Thu, 26 Mar 2026 06:58:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774468709;
	cv=none; b=E+jJwiz/AjG8ND5Z7P61DtVlrwauKo9IZVHNaHm0tnNPdvfovYNd6ahr8/gVcYMmH3m6pQfTjFOuSQr8AlebnEi675ypwyruPQue2e5f/kgVK2UWweZm7cmWAZdnqEkmnbiKNiAKtz6aL1VLYnTGMFtupg4yYKhnRMkj//JVz9eN1YG07kjwygzNKSM5iaBMi3ANiURYmvIcS8ricuP3N33lyw4sc/w7axsorJ1v79zE52ckjxK3Kv4912njmi7eBhCxBMqPDOJPoY4FkTTofaSBs3aOMBvYHIfJB9opF+zBT6LsBkK2mj+H2ANXY5SvgfItdWW4/HtTtJXjkqfIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774468709; c=relaxed/relaxed;
	bh=nONzcx8W390CboKOO06vi2+gLPQClQqV0TNZoiEU8YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVQZd1L56jF2JYq0N4YcQBKd2P1RQ7Esagqjhq199WxoPEvQrSiC9oLtMMP7glVkU3re+kGAUzJXjyuekez4DN7V+x7bCmFtliZyfROMdsuR6ytPwyHm7BQJGElgL2br5JbdShkhZ8XetzDYGA5Ij8WnC2C9lXmBfVsjS/JVTspJmVa+lAbyYRYCUPLszcPhYe8+jph8ENw0xKh1yFTTl6JZ3MyvsxO2gUGDvB8c03ZjTj6iinEGO58weSJU8Buj8qc0iOwVspb8MBUMWm70D8yivqQ31qI8LXgjQTMwvp0TiVA6MqHI1XPinxLCxLjarwSRbIUfcADeAcCqYjOSfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ge5aalab; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ge5aalab;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgyQD34Jmz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 06:58:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8107B43A4A;
	Wed, 25 Mar 2026 19:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D017C4CEF7;
	Wed, 25 Mar 2026 19:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774468705;
	bh=sejDKf3P8sESG5dibTCxwy1iyZIw53jwzdWcE7qNmpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ge5aalabCqZpp2QV5kqs/vYycoJuqkRoa8OBOAkbF709CENIyaMYwhDvGA5ZmhPZt
	 uwKdRiC3Cl5ZK3d5Un9FUbs9cKXxNKCY6gkKzPEXJOUXDaqwkeVNlPxvdAJwqG7YKW
	 lIYxvZcgfmDmflgygmhJEUImKL9vwBOfEzSiOFGHgfj3Klvy6w4NQMdlJgbR9hMqrG
	 H4++cneHOvL+Ujzn+CcEgc7qA05317D8Q9rBGN3xJLw1p1s1oXuLQklwmmcYGJXV2A
	 FM+3W2mqWxh2TwuA4BQio+NeDp+0q0ezZAW3u3LQYmFQINgb4M2bbIWWEdcCh46Isa
	 Z617FMBDSIq2Q==
Date: Wed, 25 Mar 2026 12:58:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 02/17] raid6: remove __KERNEL__ ifdefs
Message-ID: <20260325195821.GD2305@quark>
References: <20260324064115.3217136-1-hch@lst.de>
 <20260324064115.3217136-3-hch@lst.de>
 <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com>
 <fa11e4d3-1c70-4fa7-9f03-8772c002be6a@zytor.com>
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
In-Reply-To: <fa11e4d3-1c70-4fa7-9f03-8772c002be6a@zytor.com>

On Wed, Mar 25, 2026 at 09:13:16AM -0700, H. Peter Anvin wrote:
> On 2026-03-25 08:13, H. Peter Anvin wrote:
> > On 2026-03-23 23:40, Christoph Hellwig wrote:
> >> With the test code ported to kernel space, none of this is required.
> > 
> > I really *really* don't like this.
> > 
> > The ability of running in user space is really useful when it comes to
> > developing new code for new platforms, which happens often enough for this code.
> > 
> 
> That being said -- and I do say this as the original author of this code --
> this should be reduced to the maximum extent possible to a (minimal) set of
> #ifndef __KERNEL__, which should be localized as much as possible. The actual
> user space components, even such a thing as a simple #include, should be moved
> to a separate user space header.
> 
> But pretty please do leave the ability to debug the algorithms in user space.
> This is hard code to write and debug; it is not just about regression testing.

While I do like developing code in userspace as well, I've been doing it
less over time as the kernel's tests and benchmarks have been improved.
Running the KUnit tests is pretty straightforward and fast.

The issues with providing userspace build support in the tree are that:

- It has to be maintained.
- It's fundamentally a bit of a hack that is used only by developers
  (who always have the option of doing something locally that is
  tailored to the specific function they're working on)
- It diverts effort from the kernel's actual test and benchmark.

So while the faster iteration speed that userspace development enables
is definitely nice, I do think we should be cautious with committing to
maintain it in the kernel tree.  If it's causing problems for the
ongoing refactoring, dropping it for now seems reasonable to me.

I would suggest adding a benchmark to the KUnit test similar to the
crypto and CRC ones, though.

- Eric

