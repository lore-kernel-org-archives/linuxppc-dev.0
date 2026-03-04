Return-Path: <linuxppc-dev+bounces-17725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD861EF8FF4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:07:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQwxs6H9gz3c1T;
	Thu, 05 Mar 2026 02:07:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772636833;
	cv=none; b=UPgWIgd2bKntUjZoL1MW98U8hdxWlOEEIuT+kOPYqgdK2OdinkQCIgyWtI4E/fnLKby6iOXgnuiIu5aWBaTrKvSfRa0vjtU2dV7xoGT/n/ckuRG0m1BvJlOXr42xa462aCuOaiT7RpS5Z7cKZzWm9MUsuYQlH1Yqkxnbx0YzrQtNwcUL5eX9JbjOR4fPdnvGO1ZL2YCYV3Q66ytfA4qSMFLTa+If7X4wxTKuOPc47aioWZsNbEjHOOtbnmG0NbLgzSC3CZ1qzuL7WY/fz2bmCMIAocVAx2ZSNLtaxSbTzg3AepffjerBgDAXTqBIEjJoz/2Vm1aDzgs2MBAGZdlX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772636833; c=relaxed/relaxed;
	bh=iW3zfO2CTrC6/poAO+d0nmHzr1OWHmvKQJevQ4s+9cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKtCWPJWAXyteLqRGa7AlBlqLfCC3RRrced6u6bi/NghZ2P89Oq28skdWpOdhVGwEy4cFOEC5NZC15/KEb3KNnGyu/9w9KGCO+IBtEn20GyZYZ00ZGcDGCuUWFlEGtpl94p4n38IPyK6EmWV0redirgxD6ZmtFW609OmELAZyYetdsSPJQ1NGk+uHkujP14ebCslt86laurE+GQzZ4/pbiOXtYZ38q4L0x9twTvXR/6xUl+i+s4b+tEjNK5DK0YN9zD1IvfWDNqW2BPMAq8ZyCk4BFS1kDBoES0iMjyB6oP2HA8qeQxI8C0ECuaypY47Rhj90fwb3om5aV6311/c/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQwxs0K40z3btw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 02:07:12 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61CD968AFE; Wed,  4 Mar 2026 16:06:59 +0100 (CET)
Date: Wed, 4 Mar 2026 16:06:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 01/25] xor: assert that xor_blocks is not called from
 interrupt context
Message-ID: <20260304150659.GA23393@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-2-hch@lst.de> <20260227142455.GG1282955@noisy.programming.kicks-ass.net> <20260303160050.GB7021@lst.de> <20260303195517.GC2846@sol> <20260304150142.10892A0b-hca@linux.ibm.com>
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
In-Reply-To: <20260304150142.10892A0b-hca@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 04, 2026 at 04:01:42PM +0100, Heiko Carstens wrote:
> > Because of that CPU feature check, I don't think
> > "WARN_ON_ONCE(!may_use_simd())" would actually be correct here.
> > 
> > How about "WARN_ON_ONCE(!preemptible())"?  I think that covers the union
> > of the context restrictions correctly.  (Compared to in_task(), it
> > handles the cases where hardirqs or softirqs are disabled.)
> 
> I guess, this is not true, since there is at least one architecture which
> allows to run simd code in interrupt context (but which missed to implement
> may_use_simd()).

I'd rather have a strict upper limit that is generally applicable.
Currently there is no non-task user of this code, and while maybe doing
XOR recovery for tiny blocks from irq context would be nice, let's defer
that until we need it.  There is much bigger fish to fry in terms of
raid performance at the moment.

