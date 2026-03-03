Return-Path: <linuxppc-dev+bounces-17602-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F61EDA693
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:07:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLKq0RNPz3c5c;
	Wed, 04 Mar 2026 03:07:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772554047;
	cv=none; b=KtQJ7uZPwvJQ2xxRJhYj/c/hduJnER4LH7ICMq3sYva4Tphi5yQbsgkSowNDl+bVRO2kw/bgUTGMl0akviYw8RydSalulJd4oBIqcuLkOQ8t4rKj0AWX/td+4qWJzxTU+Utgxd6s84ne1Jt6YYWyD/9X0mnm19p8XgawkQKyRJFbGuF+AiUFQe9xhTqKQB4a/yVY15Epzn8nMMlcZCp/LqFLiMfC8WaVm4Xl/lLjdg7msUtfLClqYHb7ycJiH83zZdVss/6mhwIjO4Vm3oREVHW7H3pLOyjomt1BIic+5beQ7kKlXKVaDfO8IB0YHZ3lgK2vMv6KRzAYjs0XaA0H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772554047; c=relaxed/relaxed;
	bh=r8lJVD/PQeT6XriIpZpNlanisKiLqrl1y5XP0+YUjGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeC46Wp2wVt+6sui8iLA3Z0dTAILHiROQLGRbCGPLqtPu0ZsUvpB3c2tSBK35byxohMEp7hukudGZdGegKZ5Qm35di3+fce0wgDigKxFK3gWkeJ5W5vWL4koUJC5/3Kpl5QzDoKaUr36n82O6NwH8VQzFt2PAjQJWlmz5Tt4k9s+drFBncV/vgEeOkuMxCReBIAdkyxBelTs//3Fqi70FMvLwytJEZ7BhavXs/YIEnKNyYNZT+8Cj/0onPCbnKB6o0LjqVmKN6YdDvkuVRXXS4+tVq2PVTxBcb9NcDNoi6ywg1zfv70A+8pET28Rm45KYotROznmkMZFxL8iGsRkug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLKp2jlMz3bsC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:07:26 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F76C68C4E; Tue,  3 Mar 2026 17:07:22 +0100 (CET)
Date: Tue, 3 Mar 2026 17:07:21 +0100
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
Subject: Re: [PATCH 21/25] xor: add a better public API
Message-ID: <20260303160721.GH7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260226151106.144735-22-hch@lst.de> <20260228065038.GH65277@quark>
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
In-Reply-To: <20260228065038.GH65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 10:50:38PM -0800, Eric Biggers wrote:
> The alignment requirements on the vectors should be documented, as
> should which values of bytes are accepted.  It looks like, at the very
> least, the vectors have to be 32-byte aligned and the length has to be a
> nonzero multiple of 512 bytes.  But I didn't check every implementation.

That would match the original use case in the md raid code and also in
file system uses such as btrfs, yes.


