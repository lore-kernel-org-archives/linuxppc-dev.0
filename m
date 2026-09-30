Return-Path: <linuxppc-dev+bounces-28548-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F56FCA5FC1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 09:48:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvqxW4QJWz2yqT;
	Wed, 30 Sep 2026 19:48:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790761727;
	cv=none; b=JO4gHa62MKt7bk6b5497xAl4ApOrp3CiW0MeDn0qbPGtW9pg23RMuDZ4z/m/oFBavubruOWnFP1agXRgkp4GbuVaAKmaBU2PdMPLhjoMyq59HxjehMGHib//UlX5h1Y+b2Z1FIO7ZxYAgsosPoGragy5SSCeGbFEXxG2r3Cga1TRpVCzbUABZCWs9hSixJriNeLm/3Z2kMCSqc/r+y+VcAxf3EApwFTp78D9fmk4RM+YRP2XO4LX80oV5qDU/02ID8p5X+WU3s1O8Mn3aptViGIbUOp/2d+cK36fXn7boWitGStg6mZtBf+EzepKjF5lcWhUYo53a9abeWczAJbrag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790761727; c=relaxed/relaxed;
	bh=Qf3VAn39dgRaRdsnEtqKy7usItPghgcMfYhUb8awYLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnLlwhiWd0mlVjD5cG6iigfN7RMVG1OdO3fzxxLFerun0rGJtpB9UVd1XkCOFw0+bVpSlQ1bCfiOUWebuqdsHsmuVDH/UiR9PU/xYOGj1Pn83uNZFQl47jghBd6ELQaiBx/D3Oih9Z3vzTXvqhFPtUjdhPua4vIjcP4B7RRV3AhgBEsZVrGcZgAr/yuxDCbriTeAkcGaoX1obNKzTlYb8Sj2uAyBqkW01rPqMOLz+ci21p8ESBmYx6d02Uc5Ir1P8506Wwvnf5YA2x4RsAILkd3gS7xO0qbAR/Qm88gTfoCCTg33CO16aIm0q09gwkZ/M5y7fKDFPZzjVIOZvzO9gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SlrBsAqQ; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=SlrBsAqQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvqxT6nxlz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 19:48:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qf3VAn39dgRaRdsnEtqKy7usItPghgcMfYhUb8awYLI=; b=SlrBsAqQWwyEqJOj8k57wrfsmE
	W/az/jxjJOKA1vAbNvgun8uxZRuN+Oa3yhPaIfoIW3iJi9RoIIYK5WS6XPmel+xyXt7pjV6Sdg0jk
	9HX+r0QmhC6HQrFuH9G97M8+YtFN3X1dUgc6noQ3BWoMUpZMAumAxeFZ96s5t+lplEPja/WYyfgLg
	ZA870BoToTSNFBAxgGkyDthoCI+ZrmemGR3KzCynra+htMcCcPnJcOyPxiX8LR6RLacHxVB4Xo5FE
	lcztF8oJnJvQtxrSja6sZVc5hgsW62om7FsWmpqqUQKQo6gO900twJSZGlVOwsbLGAQ+MsZ/IvDBn
	SjjdB/5w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqvS-0000000C2Wb-3R8f;
	Wed, 30 Sep 2026 09:48:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 370D8300673; Wed, 30 Sep 2026 11:48:34 +0200 (CEST)
Date: Wed, 30 Sep 2026 11:48:34 +0200
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
Subject: Re: [PATCH v2 2/6] objtool: Set ELF_F_LAYOUT flag to preserve
 vmlinux segment layout
Message-ID: <20260930094834.GK88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
 <20260929055138.43489-3-shivangu@linux.ibm.com>
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
In-Reply-To: <20260929055138.43489-3-shivangu@linux.ibm.com>

On Tue, Sep 29, 2026 at 11:21:33AM +0530, Shivang Upadhyay wrote:
> From: Sathvika Vasireddy <sv@linux.ibm.com>
> 
> When objtool writes changes back to vmlinux with --ftr-fixup --link,
> libelf recalculates the file layout and inserts padding between
> sections. This corrupts the ELF segment structure, causing kexec to
> fail with:
> 
>     ELF Note corrupted !
>     Cannot determine the file type of vmlinux
> 
> This happens because libelf's default behavior assumes it can freely
> rearrange section offsets when writing, which breaks the carefully
> constructed vmlinux layout produced by the linker.
> 
> Set ELF_F_LAYOUT after elf_begin() to instruct libelf that the
> application is responsible for the file layout. This prevents libelf
> from inserting padding or repositioning sections while still allowing
> data modifications to be written back.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  tools/objtool/elf.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index a791f4ea6ec1..55c20a993f5d 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -1239,6 +1239,9 @@ struct elf *elf_open_read(const char *name, int flags)
>  		goto err;
>  	}
>  
> +	if (opts.ftr_fixup)
> +		elf_flagelf(elf->elf, ELF_C_SET, ELF_F_LAYOUT);

So per the previous email; you need this because this is a post-link
pass. As such, anything that has absolute sections would need this. So
should this be conditional on that, rather than ftr?

