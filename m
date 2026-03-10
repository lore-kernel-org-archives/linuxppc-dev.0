Return-Path: <linuxppc-dev+bounces-17943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6790FCC9D1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 06:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVPqc205xz3bjb;
	Tue, 10 Mar 2026 17:58:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773125932;
	cv=none; b=h4dLLHTjtaE/JJzuSIBDR5kox7eDDozoDrzgwROFHnPOaeXoXP+MCvT9UavqK9BpW/wDK76Fra4xcD/AC27011fZzAEgrc9JFtwCnAywLPgOuDh8BXMHQtHl9PM107H4KyNgujYwVRRBiIWH8w9D2ypmSNC0PbHw9176qKH91+NJEbdDAKybN+DuSEJlJWMKYspXhN5EYPEv0OmcsjshcT0FC9efLtILpkrAma1NzYNsNkhuAKlkRXpwt51HEtd75niVc3VsmmY+c59ZPJtKeXzmtX7YraTm2nTeRsKuSXwLizDJsCY/MmjBKjq6vVoaAL87/iVd3wUdRqqHmZP7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773125932; c=relaxed/relaxed;
	bh=0Ah7Wu2DCLVKZbjG52xH4VxSemU6UyDO7HEM5lRKrUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvKPa7/vt2Fz0ZynPFqL2f+Jejf16MxoiAWsbZWDmib7B19BXGiy0Q5UZqT8ji0c2of+ymzkKfyl6TzIiz5awSSxHWFWX7MYAYQIrgtgOg5EwFhzQVMWGIj79AV77sLtv5EN0m5UKyBNihx0rVYHNW+MtgebqPT74ya56dxKnJjK8hH6aLhbHMBJk6WYV2wUWxCe2cLm+y6vjWzRB5Nckg1wxTxBPMeTw2BB4JcOQQODqDkQCmaYy4+ta/3L2UYhpF5xiae8+I/o5IdFPimrpwMd9tCC+M520RV7PSDL1DEAo9+DhKWabTEUOkHNeCRk+XyzFEiwo2S6jV4EH/zaEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVPqb1FQSz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 17:58:49 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7056668AFE; Tue, 10 Mar 2026 07:58:40 +0100 (CET)
Date: Tue, 10 Mar 2026 07:58:40 +0100
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
Message-ID: <20260310065840.GA10296@lst.de>
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
> > +void xor_gen(void *dest, void **srcss, unsigned int src_cnt,
> > +		unsigned int bytes);
> 
> srcss => srcs
> 
> Ideally the source vectors would be 'const' as well.

I looked at the constification, and it's a bit painful because the
same source arrays are also passed to the raid6 code by the callers.
I'll clean up the raid6 API first, and then will give it another
spin.


