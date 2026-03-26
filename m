Return-Path: <linuxppc-dev+bounces-18792-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C27D109E536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 05:25:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhC0p54gKz2xlM;
	Thu, 26 Mar 2026 16:25:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774502746;
	cv=none; b=aeZSNT2kp2ihZq392RAHxSL+jFMS0+tF1+0iD72cgbX2Em28rQ1m6Gm1swsrAvBHSfrRtz2lJPAvv4imkXo86YlPnmyv6xI1eZhxvmbhSj7hcFrwWhzkRVz4JyobqxBQAjGMbmZdSQjNxeL1cy7U8hAkcnZBhKK2IKzltbbl6VcfvcUZcMx36jYnB3vxIbTh6wNPbcyrq7MkUh/RuFhoPebvSc+IqOWDwPE9AqmqPlond+WXIoCoTXhkEyDzjEBSQv6Y1962YoreLRcAN+/G+q+7b6zctFSEib3EnPoRgtnPtl5eZAxiGulz5v9bElDbf4UlZAmd+wb1r3zR4KGdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774502746; c=relaxed/relaxed;
	bh=k0Mm08aIFiF5zpq4bYNO01/wtBzLMMKeGfZKZE1A0Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4q9NLg87OJkTkhTyykh0V/2wiqBZ9JMZeaXAtr5O835SmXBk61FTewPzuPQ2MB+Xr9v2RzwitxQZXGLnZxuZ8AnJDhryiFsO1Xr0DxwcMe1bZOgQX4/CPk5JQrw4UnT34+zXCVlQHzx8vOESQ/0VDiFFnG2WzvbPz4fqzM5YCv7tqnJ2/5jreZR5B7UvpfjndLFng3pLghx0jGX2rJx4zeutVUvDmTCpJcoFfBIDDIJw/EFRj+WoN6+Ttsrse1CWodZCOYjjRdveSPuZZrFM26BrQKKZjski4zUc916aTtrOEE/hKFUiozf6bAkQ8l69dwQfAfzTqVwS85KRrjMzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhC0n35pXz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 16:25:45 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2636068BEB; Thu, 26 Mar 2026 06:25:38 +0100 (CET)
Date: Thu, 26 Mar 2026 06:25:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20260326052537.GA23044@lst.de>
References: <20260324064115.3217136-1-hch@lst.de> <20260324064115.3217136-3-hch@lst.de> <59d1d178-c141-4229-81e9-a6c23fa81f2f@zytor.com> <fa11e4d3-1c70-4fa7-9f03-8772c002be6a@zytor.com> <20260325195821.GD2305@quark>
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
In-Reply-To: <20260325195821.GD2305@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 12:58:21PM -0700, Eric Biggers wrote:
> While I do like developing code in userspace as well, I've been doing it
> less over time as the kernel's tests and benchmarks have been improved.
> Running the KUnit tests is pretty straightforward and fast.

Yes.  I would have totally subscribed to hpa's position when he initially
wrote the code, but 20+ years later things look different.  In fact these
days I often write code intended for userspace in the kernel first to
benefit from lockdep primarily, but also other checkers that are in theory
available in userspace but as easy to use.  Now of course lockdep doesn't
really matter for the algorithms here, but the rest still stands.

I also find the point of developing new code for new platforms
interesting: in this decade we had two new platforms added: loongarch
and riscv and all other changes were to the wiring up and not the
algorithms.  And of those riscv only had the compile in userspace
support added 8 month after the algorithm, so it doesn't really look
like development was aided by it.  We also plan to add new optimized
code, and getting the library in shape and dropping the hard to
maintain userspace code is actually prep work for making that not
painful.

> 
> The issues with providing userspace build support in the tree are that:
> 
> - It has to be maintained.
> - It's fundamentally a bit of a hack that is used only by developers
>   (who always have the option of doing something locally that is
>   tailored to the specific function they're working on)
> - It diverts effort from the kernel's actual test and benchmark.
> 
> So while the faster iteration speed that userspace development enables
> is definitely nice, I do think we should be cautious with committing to
> maintain it in the kernel tree.  If it's causing problems for the
> ongoing refactoring, dropping it for now seems reasonable to me.
> 
> I would suggest adding a benchmark to the KUnit test similar to the
> crypto and CRC ones, though.

The code already has a benchmark used for runtime selection, although
that could be improved on and run for bigger data sets from kunit.


