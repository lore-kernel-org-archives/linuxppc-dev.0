Return-Path: <linuxppc-dev+bounces-20478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A95FF8855
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 14:46:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g91Xt4vHcz2xfB;
	Wed, 06 May 2026 00:46:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777992366;
	cv=none; b=mzp2znDjMfe/Eq9xLB9vTkCoLJRVFqCRQX/520lebE3rqkn5SbTMG/ofKSfGzHCUBAnCtekyBv2STnLNrqA/qr6u3iFkR0oHyJgvd47zbIrhPANc9U2rCz+rVxcmWlBFpsZ0h595taIEvSCPBsSGPeeFVQvkWpMosHPQZb66GZ1AyD308HJNIdGqcTxOh8sxXomgDCoYmKHtIzkjLjzeWbyfXcRkp6F9uth/biJBRTUqVEKz/wlhj01pGGrFLm7Nf2MGz2MuSYlidHjiPhAJpyTYXUbpC/qBr0kWTXFzHMgH7TDexH6J4dNp0ZsdJEXBTu3/sflbMGAkDJ4B80NQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777992366; c=relaxed/relaxed;
	bh=+Q2PUT5mBmE0pVC/l1oOM2DQsGiXTZuOEOmovRml4Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj3Rybyk2KywD+TG7/WR5VRKtZnPdgFN3rLPuQBYmAhjAgzbrbJVcM8Idrw5Mw/QGZ4ai/6MNNncoeGO7WQ5CRRMWrqoyJ0SvtDwgOyR50SxJ0gq4j3OAU35K7CA+Q054dkPclnnjDRqm7wbLAIh8T7PO3806scRldAes8fMLpuz6lIAjsAMvtVBBoHcAvjOBOFLvpqZOomkp0dUMFGjQii0NbGl2IxUVcGNJdQapA9TpA2ScR3G2juGhSOT0NJ3iYgtfR7gJBdCFOEagMeWZ31tdjariVYK8q13xzkGZRhUcRTcFwOsyFC8ymS7IorQ0dhV3AAvl/0s9+cktqJJEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nzIRH6M3; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nzIRH6M3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g91Xn4l0Pz2xSF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 00:45:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Q2PUT5mBmE0pVC/l1oOM2DQsGiXTZuOEOmovRml4Y8=; b=nzIRH6M37lgz1ZVmXp68geh4pF
	HweTOzWYHMGbSTaB82tWfde6xqgb5U4oYODE3yHXQPAMu6AuRykvqnNmI0DMDovXhSBvYN5Or8pR1
	H9zEFlWakIvD9n7lH+oi/US5Byb1Z7Jivufc+GKIq6I2lHJ6qydbHUtlJdV4PG6xgMFcw0D5ruuvI
	8BnaJIqJKCD0UwnEL515mLrIR6zRMat90UlyrZHQuUJ+IJbYPqm8MVHUSVZ6R78knB1NvSxmFprDL
	pbctvHYCwMFob8LUG961TRvlOR8VWiMyuR9ycisNpsNGJCO1BqG9KEHi2s96dNq9G50FIwTQlV77S
	hj9jJqGg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKH1n-00000002um9-3cwc;
	Tue, 05 May 2026 14:45:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38D403001AC; Tue, 05 May 2026 16:45:39 +0200 (CEST)
Date: Tue, 5 May 2026 16:45:39 +0200
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
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of
 alternate feature branch targets
Message-ID: <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
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
In-Reply-To: <20260505084628.17940-2-sv@linux.ibm.com>

On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
>  	switch (opcode) {
> +	case 16:

Like case 18 below, this wants a comment describing which instruction
this is; bclr ?

> +		if (ins & 1)
> +			typ = INSN_OTHER;
> +		else
> +			typ = INSN_JUMP_CONDITIONAL;
> +		imm = ins & 0xfffc;
> +		if (imm & 0x8000)
> +			imm -= 0x10000;
> +		insn->immediate = imm | aa;
> +		break;
> +
>  	case 18: /* b[l][a] */
>  		if (ins == 0x48000005)	/* bl .+4 */
>  			typ = INSN_OTHER;

