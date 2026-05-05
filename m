Return-Path: <linuxppc-dev+bounces-20476-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629B8FF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 11:41:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8xRt5YNtz2xfB;
	Tue, 05 May 2026 21:41:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777981290;
	cv=none; b=Xbh0yD5gN7fXUVXmr1ICKVZ3Sq7D+dwqCHd8vodCrNg6C/VIhkmJbZqwIdIeoPP2ZTjhMSOiQqWSVbtughVVgxUzatmMMbIR9B2RpVSZlncnhuA7IhAdKguH+s3iw3J3AkqilDgnaF37CQYmhxf/JcUA0TS02NOlNGbxpXi5zL7C0/ieMWfqNTnbfAXso35iImzjtShp6JWVkQ6WCbju/3kQGOVTsqLqh6Dakj/g0hJoA6t0fYtzYTnu3nyuj9Oz98Fopj9/NRlWYT8z80xi56rfmhT7hsbRkq8Up8d3QLIni8lhAK6LfuHo22n2udivZFCwMnByo3IewPctYhitiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777981290; c=relaxed/relaxed;
	bh=yFBmDMiqVVdvXI0VWnfnnQuotGbmMWFyRknnB3DwonA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfKXvX2CrhuRaAOFlwC96AlDQMfQXqxKmmKaWwigyy6Sgr9qHmrf+p8ZEKLe4PdUxXlRf81wxolr8x+JSPEI3dDNFwowzicYjZHIGH9CMa+RMIJ+pFK3sWadVgM5bm0V1L4tp8ippacm0bF9PHUb39RUHXkCsa0gFIQhqjEf85j9jXun/x+EhUF4dz7w8MHAXZ27CQJv52hbZSiDs5dIzxzjqUG1QjVYnlr2NXxewK23l9HO5KR/SZztWbUP/oH1HCSR557h+HqoryvzZry6FnH/sqeQ1gq99Zbb9Yz6qriIbQUmyRBTlrex1RJcZY3EO/MjsA30blxQ73mryhl0Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bQPhnhR1; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=bQPhnhR1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8xRj4Z5jz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 21:41:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yFBmDMiqVVdvXI0VWnfnnQuotGbmMWFyRknnB3DwonA=; b=bQPhnhR1wdVG2cEHidi7ur8gMd
	xp4YArmFshZwqdmpwhYlb3oWfHCn2kM0rmrLrEZdk3xK8oJH/WxEvolgyMUtJiLkTfvz+CXuzQPWG
	wyrfV2hh6uzrlJIDf6lHJdij6hkWE2SJuFAnYAiTWCJtVIiS8oWel1M+LbLD5r8Lkdon4CeuIJKoR
	X1HY07bxr5tcJw787TdgYAonuSGWWlqa3cLkSen4p9bsE2Cpsqw39tT/mnYWFA7LIZbI0oAqpiIdD
	+VIhZvOs5EwpgS5grReVmB+rowu8g+I7wolRrWFsHtaXXeNuriDCkNJnWSvTdsGEdEMPSEA/zkwe9
	tTXBIf9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKE8y-00000002gt8-0xg3;
	Tue, 05 May 2026 11:40:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CA0D4300969; Tue, 05 May 2026 13:40:50 +0200 (CEST)
Date: Tue, 5 May 2026 13:40:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Cc: nathan@kernel.org, nsc@kernel.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	jpoimboe@kernel.org, ojeda@kernel.org, masahiroy@kernel.org,
	lossin@kernel.org, tamird@kernel.org,
	thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
	ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
	aliceryhl@google.com, elver@google.com, kees@kernel.org,
	legion@kernel.org, ardb@kernel.org, yuxuan.zuo@outlook.com,
	alexghiti@rivosinc.com, alexandre.chartre@oracle.com, bp@alien8.de,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 0/6] objtool: Fixup alternate feature relative
 addresses
Message-ID: <20260505114050.GW3126523@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
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
In-Reply-To: <20260505084628.17940-1-sv@linux.ibm.com>

On Tue, May 05, 2026 at 02:16:22PM +0530, Sathvika Vasireddy wrote:
> This patch series implements build-time fixup of alternate feature
> relative addresses for powerpc.
> 
> Previously, Nicholas Piggin proposed a build-time solution using a
> custom PowerPC tool [1], which provided the foundation for this approach.
> The current implementation leverages objtool's existing ELF parsing
> infrastructure to do the same.
> 
> This patchset applies atop powerpc/merge branch.
> 
> [1] Original PowerPC tool approach:
>     http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170521010130.13552-1-npiggin@gmail.com/
> 
> Testing:
> Build and Boot tested on ppc64le, ppc64be, and ppc32be configs.
> 
> Sathvika Vasireddy (6):
>   objtool/powerpc: Add build-time fixup of alternate feature branch
>     targets
>   objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
>   objtool: Fix "can't find starting instruction" warnings on vmlinux
>   objtool/powerpc: Skip jump destination analysis and unnanotated
>     intra-function call warnings for --ftr-fixup
>   kbuild: Add objtool integration for PowerPC feature fixups
>   powerpc: Enable build-time feature fixup processing by default

Ooh, so 2/3 are because you're not running objtool on vmlinux.o, but
you're running it later in the link stage?

AFAICT ELF_F_LAYOUT should not hurt the normal objtool run, but it
shouldn't be needed either, because we run much earlier, before sections
are placed.

And that also explains why you're the first to have trouble with 'can't
find starting instruction'. vmlinux.o will have unplaced sections that
are all relative 0.

Hmm... perhaps this ftr fixup should be its own command, like klp. Not
munged into check thing. Josh?

