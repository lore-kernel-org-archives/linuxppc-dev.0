Return-Path: <linuxppc-dev+bounces-21142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6935CD4F52
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 08:24:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKSQS3vzgz2yD6;
	Tue, 19 May 2026 18:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779179088;
	cv=none; b=iDlSbHN/VPj7JLoB7S0JK9rWkauVRgn/ia+V3apAN23tBXTy47bv5QPwE9BhNY4ITKPYU7xp/24Am5n1+ESJdjFS+UClLJ9dl6xs5GtaSRXl62g/p8d+F+v1ErvUfdO6pmfEtiPAlG8odoLmCmEhFmEQapdnRcHSbbYr6XfUmYJ877ODupG4N800XJmyiOjXRfzLw42ErhchEqQyDJFnnMnPT3DxO291XcYs360RN9usIcDubbPo6IwjERX1WhJ4+cpsOqSdFkOKHgzzKcuck+sReszCobRS/KSWyczaGuk/sgpj1ZBEjKjZqU706yGIVY+KBgau3BUTbpDEhWOIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779179088; c=relaxed/relaxed;
	bh=aqRGIKoiXWbmeXBHEq1fvqzZYieolD7YjRd/s5Lkrag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPyqRSpHcR9SMDpskiWEe1XCSw/U2DLZk/jsSkhkG/Uvcl0FgJ12bZq1/pa8eaAGdiO2sg+KDT+pVgUkfLPUqn638l5RApGrS6u7AXmQgmYab7UkzntuwRs+b71J7fBXM/S4bYO820N+Fp1of2FeS5CKBn5F6Ld/9o4zQw4PtO6e2oJCva3wzaIdSM1REnS98PQT4D+rbkTFCsvDu1xTX0+hL7jm1WGl4g5BTeuy+HtNixwq7rI88MzCPhECtuHOzKpNhd6Qwc0HiV0bP9A0TKvUVnCpCJ37AyV1+LkA5FSbGoQ/RueAshJbo8J+nRRzo66Wsd8dksEF2DyC4Fjjqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKSQQ5Cy3z2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 18:24:45 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9A0568D0D; Tue, 19 May 2026 10:24:33 +0200 (CEST)
Date: Tue, 19 May 2026 10:24:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID6 P/Q library v3
Message-ID: <20260519082432.GA14956@lst.de>
References: <20260518051804.462141-1-hch@lst.de> <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org>
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
In-Reply-To: <20260518141205.c100f76eec5f58e78bbbf7af@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 02:12:05PM -0700, Andrew Morton wrote:
> Cool, I'll add this to mm.git's mm-nonmm-unstable branch for some
> linux-next testing.
> 
> AI review found quite a lot to talk about:
> 	https://sashiko.dev/#/patchset/20260518051804.462141-1-hch@lst.de

Not a lot of it is very useful, though:

raid6: turn the userspace test harness into a kunit test

 - complains about basically adding need_resched, which we've decided
   we won't do now that we have lazy preempt.  This is probably going
   to come up in lots of places because of the old training data

raid6: use named initializers for struct raid6_calls

 - whining about keeping totally pointless comments
 
raid6: warn when using less than four devices

 - complains about warning for btrfs which is clearly documented as the
   outcome in the commit log
 - and also complaining that the enforcement isn't hard enough, but the
   WARN_ON is the best we can do here

raid6: rework registration of optimized algorithms

 - less registration causing less kunit coverage:  that's intentional
   as it keeps testing time down and similar to other arch optimized
   tests in crc and crypto code.  It also doesn't really reduce
   coverage as before this series there was none.

raid6: use static_call for gen_syndrom and xor_syndrom

 - doesn't seem to know that bool fails when an initcall fails

raid6_kunit: use KUNIT_CASE_PARAM

 - whining about the code style.  I don't really like it either,
   but the kunit case stuff is a mess

There are a few somewhat useful things, though.

raid6: hide internals

 - yes, the -I is duplicate and should be fixed

raid6: rework registration of optimized algorithms

 - avx2 instead of avx512 is probably the right thing for no
   benchmarking, but if it was intentional (it wasn't), that should
   be document.  So I'll just switch back to the previous version to
   keep the state of the art

