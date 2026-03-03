Return-Path: <linuxppc-dev+bounces-17605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90E0EDA68D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 16:11:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQLQz2vMqz3cC6;
	Wed, 04 Mar 2026 03:11:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772554315;
	cv=none; b=PZDQJ5Gs/0FL2Nh9ewXHY1P8/Ut4P3nbl6qyTDTH4+2hVvB4gOx2kvJyqyfUsqo6YFZeIuCHWasMokJSUywHdDlTn4617baRaaVNdcQ7LvM/a4iQ1r3BnqB4dWsZTJJ8v6IdjDmjLlGoWG+nBfDAt/C6Ick6IbZbdxSYSTSrPt/sLCh31u/zOuAI7otHK5J9iCIEV7qqXwhUgwexu0jmtkHnKgnrkT+184eOQmBmxXb0LlvVL+6Sw2zNhzwSVLUJvff+g39WKziTOQKgpDRI5Zp5bu/15Ek2qQNGY1wgY49HuN0w7rnleVFNx68a8nlPYRI42aWGT4fv/RWHQeceSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772554315; c=relaxed/relaxed;
	bh=oN/fEll4fZvv2uEfMJ3TecbdzRhyRWVxsV4r7G2PpRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8TCQZhPuO8QfS8J6sgKC9WtFFnx5fplwTmPl/MjHnPDYv/63Lhlp9SeX5l5IIYXp8+C6N5jUhwTZr1eRUwkydNOAIfkpHRVpOF2u33Qno01sPgYdjilVPkNZpHrW+e4s5/tuFB9muPCYK039PVjkTloxhgVn6XVIWlJDcxumL7CN6gENT0NWDiNfLTOwwpbIAtf54m6K8wRy+PM1k8oCE13N8PwZeLcOjoF1cg7OqdtfFqaKLSkF2xXu/Chk6P/hnRemQb2jKt1LVeDa+e1rrLALBfo6czh4YLPpLmRXnUHdqspmxYFVDGcOWKxB49g7Cd84mOkBsZAHqOFT6959w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQLQx2k3Vz3c9y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 03:11:53 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4C7E68BEB; Tue,  3 Mar 2026 17:11:45 +0100 (CET)
Date: Tue, 3 Mar 2026 17:11:45 +0100
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
Subject: Re: cleanup the RAID5 XOR library
Message-ID: <20260303161145.GK7021@lst.de>
References: <20260226151106.144735-1-hch@lst.de> <20260228073553.GL65277@quark>
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
In-Reply-To: <20260228073553.GL65277@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 27, 2026 at 11:35:53PM -0800, Eric Biggers wrote:
> >     https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements
> 
> Overall this looks great.  xor_gen() really needs a KUnit test, though.
> Without that, how was this tested?

fio data integrity testing on degraded raid.  But yes, a unit test
would be nice.

> Later we should remove some of the obsolete implementations, such as the
> alpha or x86 MMX ones.  Those platforms have no optimized code in
> lib/crc/ or lib/crypto/, and I doubt anyone cares.

I'd rather leave that to the architecture maintainers, but overall I
ahree.

> Also, I notice that no one has optimized this for the latest x86_64 CPUs
> by using the vpternlogd instruction to do 3-input XORs.  That would be
> another good future project.

Yes, as would rewriting the routines to deal with more than 4 + 1 stripes
as that is a really narrow raid these days.


