Return-Path: <linuxppc-dev+bounces-17390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB66FEFB56
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 14:13:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMr0120YLz30Sv;
	Sat, 28 Feb 2026 01:13:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772201601;
	cv=none; b=A107pzWB3dt+ZYdNBpl/x957O1zjBE6K9HIGPxFtX42rGpj7O2B0WtZJr8tvZB7apjNmqSPLT+snWDMqreyWt4v3tkDSq18ttlU0APbBWOCIoEy5b4zfTfhSPm4yfMInXsGLtP0t1GjQAZhrBNHdDOCcJfYturEdpyeZuIFnx+pcZYdst5EFbQngrpYVZEg/6PSdtKijCfiJwgGBg+9bnfTXHpmuxsWcJn4zczyEy43ph3Tf4Yn4uylnj5SIcdqwwUuG0an1qMYA/0zntyABcNOZQWn9KavunpDb4R4eaKlA5QFriWUICNlql+fcoJNmswccOIf8kyricomroBTNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772201601; c=relaxed/relaxed;
	bh=80IGNiXGyIprTB+8xmwgbrN0mmksY+0aJKX1jK1vpHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAFm/Jeo05Ritz2jA+4JqCUTyfYr/0qpFIs8PWHSrx86ajGeexLohdjPxt9Rsj2/XC+xijZitD+5veTkwS3tnu+jdfnsrqqc8SJdNnjxk1nO9HbEQawLaHcsCG0X2chwccYoO+4KwprT9aQNlRsCCtkNvNdZOYcAUIOuubfOn1i+HVM5Q2T0S5yOvAi7faCquJnstY7tGgbOSdEep3d/nXOVOsmcn7vo9XiUuXYmnnJooxjGiFt0uVcsDP+x7PnGkInz/HwPoslkBvBKEPgO9f6kZf7Jjo/vfhF4KXKGkckDN6Gj2y1GrpTgydMh5ba+UE2j4beLzqiHoqmS2bgzxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMr000gg8z30N8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 01:13:18 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A9ED68B05; Fri, 27 Feb 2026 15:13:11 +0100 (CET)
Date: Fri, 27 Feb 2026 15:13:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 17/25] s390: move the XOR code to lib/raid/
Message-ID: <20260227141311.GA22216@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-18-hch@lst.de> <20260227090959.10882Af7-hca@linux.ibm.com>
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
In-Reply-To: <20260227090959.10882Af7-hca@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 10:09:59AM +0100, Heiko Carstens wrote:
> However, I just had a look at the s390 implementation and just saw that the
> inline assembly constraints for xor_xc_2() are incorrect. "bytes", "p1",
> and "p2" are input operands, while all three of them are modified within
> the inline assembly. Given that the function consists only of this inline
> assembly I doubt that this causes any harm, however I still want to fix
> this now; but your patch should apply fine with or without this fixed.

Two comments on that: I thin kin the long run simply moving the
implementation to a pure assembly file might be easier to maintain.

Also with this series you can now optimize for more than 5 stripes,
which should be the mormal case.  I'll try to make sure we'll get
units tests to help with that.

