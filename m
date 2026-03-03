Return-Path: <linuxppc-dev+bounces-17601-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE146EDA68D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:06:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLJv3Zjbz3c1T;
	Wed, 04 Mar 2026 03:06:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772553999;
	cv=none; b=T1HD6Zm0PUWuVdqVffcELMbR2KXaSdFG27U+bxsOLHg9qdiK/nZFoPdm14vZmnObkZw5ns7c2ObtLONLok06LXQDLBcBxbWzylu2iRkdeb79GA11u5BII6xLkA6oEwH61mbIiW+aTgRQ0cw/lS5kwI2XQyekqa/2UBF2H2zs1sehxN+KkhiB6s2ZSYyE+Wp0+1AZN+R0/CLMkZQmAwNvEN0Gp8mWEKJsDnEMUcOBu5GINILqBJnG/BPQ2hU9yuefiFkrzt8LWuThIBKZ/3YlDor9ulfIpqLUPfHMAQ4LrKxNh0+Y722qdvYmuaMsGzQtk68laxyBlfZcmX6JO0IFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772553999; c=relaxed/relaxed;
	bh=XBJwlrTdNJjmPV0S2dY1ySmJaA0aEJhhqGpkqw0Qvdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl9faTDsqLmqgP4O8559HHgVd7/3Ujk40bEGo2P6oIFPXTx1J4gwbucGvgtaYvSvvbocwppN80FEtdwDXJ5YsyYDsKY1lNHdW2XI9iKvte/xPGPFIjY66km3uB5j4At2cfLCMqAxbspb9yVUe3Y3/A7G2ayMc8g+64VJ//v2+1oHEF53CaeYxGoA9CBkwfzO/esBqsFI84TcshHVn3dritiXfyCZPJkasU1r4I/8Ypdja2hm0kkmXecCv+elaU9UwHQ1vu46tVWcNJ93nb1pOLHswOwLrpgiAuNqs05T2CUzt5diSwkdG5Q8MIQ9DWKCox5T7LFD+kYZssYxZj4Y2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLJt4QyRz3bsC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:06:38 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B41BF68BFE; Tue,  3 Mar 2026 17:06:34 +0100 (CET)
Date: Tue, 3 Mar 2026 17:06:34 +0100
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
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260303160634.GG7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-21-hch@lst.de> <20260228064249.GG65277@quark>
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
In-Reply-To: <20260228064249.GG65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 10:42:49PM -0800, Eric Biggers wrote:
> On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> > diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> > similarity index 61%
> > rename from arch/um/include/asm/xor.h
> > rename to lib/raid/xor/um/xor_arch.h
> > index c9ddedc19301..c75cd9caf792 100644
> > --- a/arch/um/include/asm/xor.h
> > +++ b/lib/raid/xor/um/xor_arch.h
> > @@ -1,7 +1,4 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> > -#ifndef _ASM_UM_XOR_H
> > -#define _ASM_UM_XOR_H
> > -
> >  #ifdef CONFIG_64BIT
> >  #undef CONFIG_X86_32
> >  #else
> >  #define CONFIG_X86_32 1
> >  #endif
> 
> Due to this change, the above code that sets CONFIG_X86_32 to the
> opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
> CONFIG_X86_32.  So if the above code actually did anything, this change
> would have broken it for xor-sse.c.  However, based on
> arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
> CONFIG_64BIT, so the above code actually has no effect.  Does that sound
> right?

This whole thing looked weird to me.  I'll try to do a more extensive
cleanup pass on the um mess ahead of the rest of the series.


