Return-Path: <linuxppc-dev+bounces-28547-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD0CA5FB1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 09:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvqsP0zSzz2yqT;
	Wed, 30 Sep 2026 19:45:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790761513;
	cv=none; b=FQXSVUSDqFSQu4J2R6mQzJFSAe0IOznWhP1h9ymBuJz2NcTudvLLNtTNaNsnD49R5Avqea1jnstIeRRsShzjUy6lQpX0KcIxW0RbSTwpJbEqia+6DcwR72Hvosu4I1J+e8jLIBKiCAsz7UrGRuNXhurKoJ3RBRmZpRCeUN8HFzxXlyJaguX/vaoIjZ+LkdIKyJHSxdplera7FndBij+cSoS8KQai7bTa8gsxRQUDs6KEs6kJoryOxB8gyf5MKCUj19KDwVOYtPXwzQyA3cepQ6FAhJ9HtXswhZc6swh193CUASUc2MsdxhTe2XeTpfzO/tAiSWkmlxcR9F1zfRLB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790761513; c=relaxed/relaxed;
	bh=kQnAjdSHeRkjSr7bpX0at2Vuq6X479LMq6z2xTCyJ1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koCC99GJPGJOpM1vVEuPnmLVMBd7i6wUJOCvOJpAiOC28sTf5iHP1Bx8BDRi1YUces3VhcWhzBnZVkPmWcLSPN8I6HCLNuwzYCt8l91t/AwPPfkI1x4yD7nCgFVPwG3aTYMrjQeLl2GT25c9RRLdz2X9kgSJ4z2Ob90a2xWdhkTrpNSF00WJ51RTlyYkjsSCJgQEgzZTyb6bYRpm9OTyvwd0ZoawZgHODYDtBIydnvnXlI8zH7IItVUSHimOiIVlb7s5bOtrI0tYJJ7re9x7n4j3F8GgkQvfwEJ/YJKZUzCJ7P+Q+BkHBlGZ3Gh6ldWu1tv3uph4tPoDgFGriKq69g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=enO/gx+K; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=enO/gx+K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvqsL6HP1z2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 19:45:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=kQnAjdSHeRkjSr7bpX0at2Vuq6X479LMq6z2xTCyJ1U=; b=enO/gx+KmlVqfaKwTwKn9iE3po
	/V4F1+HU1KoV4WEzOffjkFVz/bDu+4ZmTHIkGUaR9efMG4qOtCehY8gAO0HrRQnsTeFjtCcZWvnQ4
	tt2UNiA76cAVUGQT6BX30T2ei2Cdd6oVMmuAWMAv+dwz2hoMTRNjtmFQbEz9lWJ38EJYIa0AJcFq6
	ncuC/B/ZfvqhE/6GK0+7X0WMg3gHmc44Cng2A7BoMMwCok7/vyP7vMcagL6gPhg55O/lg+rYh38WE
	B9X6ZgXKJRABKOA7mVrrZOadAqk0p+lCXXHAZswCx5ForxEml9Y65yvAT12aaUjA32esHNZbj32yx
	bqkcI3/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqrr-0000000BxnO-48eL;
	Wed, 30 Sep 2026 09:44:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBF61300673; Wed, 30 Sep 2026 11:44:49 +0200 (CEST)
Date: Wed, 30 Sep 2026 11:44:49 +0200
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
Message-ID: <20260930094449.GJ88198@noisy.programming.kicks-ass.net>
References: <20260929055138.43489-1-shivangu@linux.ibm.com>
 <20260929055138.43489-5-shivangu@linux.ibm.com>
 <20260929142559.GC88198@noisy.programming.kicks-ass.net>
 <05e06ab0d9fc8810fc50e888e9e0f55b2ec9b77f.camel@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05e06ab0d9fc8810fc50e888e9e0f55b2ec9b77f.camel@linux.ibm.com>

On Wed, Sep 30, 2026 at 11:43:10AM +0530, Shivang Upadhyay wrote:
> On Tue, 2026-09-29 at 16:25 +0200, Peter Zijlstra wrote:
> > > c00000000002a610 <system_reset_exception>:
> > > c00000000002a610:       0e 01 4c 3c     addis   r2,r12,270
> > >                          c00000000002a610: R_PPC64_REL16_HA   
> > > .TOC.
> > > c00000000002a614:       f0 6c 42 38     addi    r2,r2,27888
> > >                          c00000000002a614: R_PPC64_REL16_LO   
> > > .TOC.+0x4
> > > c00000000002a618:       a6 02 08 7c     mflr    r0
> > > 
> > > This is happening because we should be looking for destination
> > > symbols that are at absolute offsets instead of relative offsets.
> > 
> > Again, confused. We run objtool on objects, this is pre-linking,
> > there
> > are no absolute offsets.
> Hi Peter,
> 
> This is the special requirement of patching jump assembly instructions
> that we need to know where the jump is performed from/to. As per 5/6
> objtool is run post link on vmlinux. If handling post-link information
> is outside the scope of objtool, please let me know.

I think we can make it work; but this wasn't immediately obvious. Also
I'm still struggling to understand what exactly you're doing -- I'm not
well versed in the PPC details and have no idea what this ftr thing
really is and your patches don't really explain anything much at all.

(Gemini is suggesting this is all somewhat similar to the x86 RIP
relative fixup we do for alternatives, but your case is more 'fun').

Anyway, I would much rather objtool learns how to deal with absolute
sections rather than making things depend on a 'random' ftr option. That
is, if we need conditional code, have it be because the secion has
non-zero address, not because ftr option or somesuch.

But noting that, can't we simply change:

  decode_instructions()
    hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset));

to take sh_addr into account? I mean, when unlinked, it'll be 0 so
nothing changes, but when already linked, it'll get you the absolute
value and then you don't need that fixup later on, or am I missing some
details?

So from where I'm at, please:

 - teach objtool about absolute sections, not ftr specials

 - expand changelog to actually explain what these ftr things are and
   how they work and what the actual problem is we're solving, so we
   don't need to employ LLMs to understand patches and all that :-)

Does that sound reasonable?


