Return-Path: <linuxppc-dev+bounces-17606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2ADEDA698
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLVk5Dwsz3bnr;
	Wed, 04 Mar 2026 03:15:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772554510;
	cv=none; b=ezIDli2nRaF/hLMuIcihkW0k7t/C4Hf2nuJ1NZSz9ufabhfLWWwsWHC9YZl4fRnepbc2Aje8vw2jfHT4GOHm3rUqGYPHg5wAvQeuky1Tod8Cm5piNg9cG40YXQookzIbk9gz9tQGDzS4C/VclwyrGU90oOEKq6GLW+zbCeiEe0+X/Sq9bw2Cu0m2JCdKVKPzGeSqA43Kp7l0vd0vubmkdJjnyuDReO6ROy0ZST2tk0HyrAKvHf6y0oevpuonl5iP/skTKnN3W+ag+SUxEbPtsuTw+AI+1o4dGNklupbgKLmNm15w7SRNCYZFCkTXau2NYxqK0gQfbIMKWbETKQQDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772554510; c=relaxed/relaxed;
	bh=rJRp/y7VgPI6vyHfr+t6GYOFYk0QK/kcXciT+38Vnow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMtluNRaemELoUEYrhOLZYz1whjCR+b7k+1+RLo69Nk7SbfeAIygq1xqAxn0W78zt0sTWP1uZONNA9HHoW4i/T39uiZLoR9xZF7gz4q560zIdA2N64UvzeCoXWcNoL0Ty1eqMqenE8IsorWnEkc+XtHSiFMefB7ibOWl2zUrH220ujn73re9Po7nH4wm/DGs4QeupvBbuiKXMURF8o7MI4QbY8msnX0ZEVXTFZ3L5i4VqFFFYc8393rS0MkRPcp25yp/4CGxUB8RCBUx0+EgbUaunmWGYd1coHkkUo5uVFqe+abOZe6tn+TJre6BXy6ZgFSZsoJfwwIQ2fdB3PfSJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLVj6rVzz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:15:09 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 59EE368BEB; Tue,  3 Mar 2026 17:15:00 +0100 (CET)
Date: Tue, 3 Mar 2026 17:15:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH 07/25] xor: split xor.h
Message-ID: <20260303161500.GA8975@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-8-hch@lst.de> <20260228044355.GD65277@quark> <20260303160309.GD7021@lst.de>
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
In-Reply-To: <20260303160309.GD7021@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 03, 2026 at 05:03:09PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 27, 2026 at 08:43:55PM -0800, Eric Biggers wrote:
> > On Thu, Feb 26, 2026 at 07:10:19AM -0800, Christoph Hellwig wrote:
> > > Keep xor.h for the public API, and split the struct xor_block_template
> > > definition that is only needed by the xor.ko core and
> > > architecture-specific optimizations into a separate xor_impl.h header.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/arm/lib/xor-neon.c       |  1 +
> > >  arch/s390/lib/xor.c           |  2 +-
> > >  include/linux/raid/xor.h      | 22 +---------------------
> > >  include/linux/raid/xor_impl.h | 25 +++++++++++++++++++++++++
> > >  lib/raid/xor/xor-core.c       |  1 +
> > >  5 files changed, 29 insertions(+), 22 deletions(-)
> > >  create mode 100644 include/linux/raid/xor_impl.h
> > 
> > arch/arm64/lib/xor-neon.c needs to be updated to include xor_impl.h.
> 
> As of this patch it is not using anything from that header (but
> neither from the public xor.h).

Actually looks like we do need it because it pulls in
arch/arm64/include/asm/xor.h.

Anyway, I think I'll actually move this patch to the end so that the
impl header does not need moving to it's final place.

