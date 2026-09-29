Return-Path: <linuxppc-dev+bounces-28502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E658C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:26:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvL844FPJz30W9;
	Wed, 30 Sep 2026 00:26:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790691972;
	cv=none; b=A5xMAEjp9+AxpEOvTf5qaMG01udRhA+dmPBzq5SdES4Z9KbaKKsyM9qBR4OdMeP7GS4h5sa/eK8ObKLLJCPUTeIlW1xyaZsf9EZkIDvF77yz2Ndd0OmALJi5rKqmcVYOg+FzaXRv1qc5O+uWPYS/TaQcD7U+6P/si2dIYHoXlndNERqKaLLhFb+eGc0+jLaKyy1EP4SznX/QV2ZOdrjIq7EjfdQ8RLKMkjgePxV0PS1pXQiNgSsbCtbmI26h3TFhSBXE5etZ0Vvabab1INE8Shx8Z9drptVsJgO2UK3kJ7PVlvv8rUdUZCpegGh5g5qmkZXId9YJZg3yMgd1AFkbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790691972; c=relaxed/relaxed;
	bh=8DMiTrHEuHAfAfHczM3479xqIi6gNKMUHt0Q9Yhupb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS+zHw/826gt3zT2nuAhsc4bvb3VPx8BNEatWU2IHoPqIDHKIt8eEeLZvEZPgfK7TmAeohSZqbHrckubFphe67MLpflB0i7HixaYvigw0EBLGw4/ufZ44qZHZtKsiIeaFGm5mLry6OzcklUH1vC0Zu3ictFm+E52loEfUbHRPcZoBPowbfntjjLjQzWokU+kseZoCP9vUwlpHZrcCHI0F6zkQYJ9IhVAgZSPqlNQn0WbdAgPYLf4RwHBJlWOh/wsj9k4YHA1MFk2GFlBKgKjHiFNqZ8YVqWn58HsqLtr4nDU4/2DEb+AYdBf8O508/GIjc6fMrnxOJAB/ujqWul7Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ErCl8NV5; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ErCl8NV5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvL835tmSz30Vy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:26:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8DMiTrHEuHAfAfHczM3479xqIi6gNKMUHt0Q9Yhupb0=; b=ErCl8NV51ZUSe5AJcfBmq4kN8P
	2TLVoAo84HDsopf6r7NEQlOe3C7Ftiy7oukl5U6W+9fgjL5LUeJHnCopcsfjOkQjv/jDlVCv/glIf
	zzwEMZsQV+VhHepotwgXSgbQmidrYM8GJVI6NcTln5piQvcQB87+OFq8Kve0FvVHAp61r4RGLqyiS
	NrHJS9JuMKRMVwiHaSJ0rgKKVkmp05nkJ6E30/FzcBdxkybvkpPlgh4bLNChB0Bo4b05rSMhBb9nH
	PTjWHeBqf4Ed0IsZeNByfu/OkyrsspUCx93ZO5w3XL4pWaTC9LyhBdNR5c6+nDd5hplWza8tCb8F9
	HTPRZVbQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBYmN-0000000E8Bs-340X;
	Tue, 29 Sep 2026 14:25:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 48ABF3006DD; Tue, 29 Sep 2026 16:25:59 +0200 (CEST)
Date: Tue, 29 Sep 2026 16:25:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com,
	alexandre.chartre@oracle.com, alexghiti@rivosinc.com,
	aliceryhl@google.com, ardb@kernel.org, bp@alien8.de,
	chleroy@kernel.org, elver@google.com, ihor.solodrai@linux.dev,
	jpoimboe@kernel.org, kees@kernel.org, legion@kernel.org,
	lossin@kernel.org, maddy@linux.ibm.com, masahiroy@kernel.org,
	mpe@ellerman.id.au, nathan@kernel.org, npiggin@gmail.com,
	nsc@kernel.org, ojeda@kernel.org, pmladek@suse.com,
	rostedt@goodmis.org, tamird@kernel.org,
	thomas.weissschuh@linutronix.de, thuth@redhat.com,
	yuxuan.zuo@outlook.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v2 4/6] objtool/powerpc: Skip jump destination analysis
 and unnanotated intra-function call warnings for --ftr-fixup
Message-ID: <20260929142559.GC88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
 <20260929055138.43489-5-shivangu@linux.ibm.com>
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
In-Reply-To: <20260929055138.43489-5-shivangu@linux.ibm.com>

On Tue, Sep 29, 2026 at 11:21:35AM +0530, Shivang Upadhyay wrote:
> From: Sathvika Vasireddy <sv@linux.ibm.com>
> 
> Objtool is throwing unannotated intra-function call warnings
> when run on vmlinux with --ftr-fixup option.
> 
> One such example:
> 
> vmlinux: warning: objtool: .text+0x3d94:
>                         unannotated intra-function call
> 
> .text + 0x3d94 = c000000000008000 + 3d94 = c0000000000081d4
> 
> c0000000000081d4: 45 24 02 48  bl c00000000002a618
> <system_reset_exception+0x8>
> 
> c00000000002a610 <system_reset_exception>:
> c00000000002a610:       0e 01 4c 3c     addis   r2,r12,270
>                         c00000000002a610: R_PPC64_REL16_HA    .TOC.
> c00000000002a614:       f0 6c 42 38     addi    r2,r2,27888
>                         c00000000002a614: R_PPC64_REL16_LO    .TOC.+0x4
> c00000000002a618:       a6 02 08 7c     mflr    r0
> 
> This is happening because we should be looking for destination
> symbols that are at absolute offsets instead of relative offsets.

Again, confused. We run objtool on objects, this is pre-linking, there
are no absolute offsets.

