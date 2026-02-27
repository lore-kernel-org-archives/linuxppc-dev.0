Return-Path: <linuxppc-dev+bounces-17393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF821FEFB56
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:36:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMrW00mWbz3bmk;
	Sat, 28 Feb 2026 01:36:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772203004;
	cv=none; b=JpaDDfyyra4pFfHJlU5//vBdTwElTus8Av8L7sak4BLVqzAVRdJ673Z8W5Ybb0/JtkhnggtE8bSAuxy5i6BYjI+BgCUdFIiRV+JVCLZ5/v7ySkA+A+TNeho9pr+mNFJMuM480DpdYCu6L/JAxSXGXNtTvRiDOie7g8xTTvw2d/NV9+7IM/jAy/Wnttipqf53pUcPmgNTLJw4SchfW6CIRcKnFFOGQX6IaAWi0IDyL61liqXgxq5OJwKMwo+j7hfk+2Wdt0jNXCeuew7Tqt3Q9Ekip+GD5QmShcu4HhqWVE1Ze4qxATLlfX02HF2ep78Lbb9iO80BxD5M9clCxFrdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772203004; c=relaxed/relaxed;
	bh=sd4Dk0zWsQwDRJSs7bWqIQywpiYjqUPgxmAIc0fK68w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajROGW7a07oVfFLS1P25FGA6d9hT+jh+kgWmxKZ5xRCUUHw9GwaIuMSif0v4x4AysglVeRUIWUlKodJVOqhRCzFwJkx5Phh0NcZfBw4OUhxvcHWFUwBtGyj5dQjy/yP+2Lz0rNsHET60OPHBHG8BROqqqki/HuRS8FKDJ/d/4lFGnu+CUD6grZ32g4t76i2TyjHc+o6VOwq4loWBmLztGUssyVZXsml/hlVxkYKHBFzF6YhnZ/lpwuVq5tVM77PirHD3th96gKjt5LCpACKb6MuQYJEySwF+cCCOJf5kt7APY+A4HLr0b5jWpRkOsmiRXKGPm4wGxUi333Q5ua699Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KD1L4Etw; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KD1L4Etw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMrVx2HzZz30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 01:36:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sd4Dk0zWsQwDRJSs7bWqIQywpiYjqUPgxmAIc0fK68w=; b=KD1L4Etwagd1eSmxZlo6KzsMbM
	fONwzvtpqLYChdBJfr8NDHR8cZXcrwPHL+6MIUnFqjzp0jZOeTwkR++VxiE9mZ1Fxo7dbV/s6M719
	JXFDIXO8UCIWQEeT56dTega0MPjMh5tY7+yrFo7oX79K+n7Q70KOFxLusSqDmlcp0JTF6MuobaJLg
	ZSmFE4SvOnGKM4aBqQQdA/ZFNBGOvBjLR8Shx1hs85uSqO4Qz/GeLsp1DyW7Ixx3MzD/enr49FEf0
	39cX6Lvq4zVc/FsVzQUKO0QukCMVTZ+GAl9JRmO5cYgboNvRfsG10Yh9iL/+2tvOLVN16tQiiLj7h
	ldkMSYYw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvywq-0000000DG9M-0aeA;
	Fri, 27 Feb 2026 14:36:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF18E300462; Fri, 27 Feb 2026 15:36:06 +0100 (CET)
Date: Fri, 27 Feb 2026 15:36:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 25/25] xor: use static_call for xor_gen
Message-ID: <20260227143606.GI1282955@noisy.programming.kicks-ass.net>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-26-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-26-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:37AM -0800, Christoph Hellwig wrote:
> Avoid the indirect call for xor_generation by using a static_call.

Nice!

