Return-Path: <linuxppc-dev+bounces-20501-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63117CD3424
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 07:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9RGB0Tz4z2xdh;
	Wed, 06 May 2026 17:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778051089;
	cv=none; b=AH5EpCensS42ZwfZ1UIILUy6BhfngGo3+ycI539oL0Llf/COYX5wCJ7i7T/J6Lr0OxeaEO0NFmTz7gSt5Fm3nF1AkP3rauJCgCHcb4Rr9rsbiiHK6s7g0Tc/IZGOug2xlPX7MPLQFUqLvRwNTlcgNR0ij+u54kB5JxmXhlC6f48p9smo1ku7yqTIFQfv+5dE1e7YbdRcxttbjyS1xBq04ZxkrnlV9O9ekKdbUQK7I9pwTCPoLQgE0jRVojUbxliriYLaN8s07AtsH33UQkuPrhIByaF6sDj3nUuHepRg7J2ylhGJTz/zCKcKkgq2RoSY2oLv0P/ihcEDxbrvST0BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778051089; c=relaxed/relaxed;
	bh=fMovDlk88JtntvXu/seZ66F90g7SFyxentqAJGuZSZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiVnpACMcFDSThbRN1LeqNVxTYrN+h9wA5m+FgcgOxjhzTHNhamEISi59MOkjj4QqJEoFlytgNa4w9+tpbzz5+aIcBza8CLvYPsxPmeoaf+Z54saw4wEbHPfN+nbXYe7mI9LCedsHwUfUsVfwdPXB7BYwfPouKPgviZUpX3RFjxCl6tQbULsQ200J8CcB25+o0+Klxpbel7JfmTvGqrZCJaQ/gLsLFcvEqfIqYE1VnPDmyG5zLHydtwB+tjjTn0PyihCyhULA6DZz7jlHNrT4gD35anxegs6W7CxrN67X9k+zeQPW2Wak0dnHkhfN3li5Euewmq9h/pKRVK4FtyRYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M+uwskEF; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=M+uwskEF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9RG80gY0z2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 17:04:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fMovDlk88JtntvXu/seZ66F90g7SFyxentqAJGuZSZY=; b=M+uwskEFSiaSfENlDe8KMqTC1m
	z/xTI76HSzdMfAX6DI7dyOyOndAEg5QHoBeIMOaMO9cKEx+A0yexAvUqVMPQ6LaVh1ixCTd3VkwrD
	2ID0X0crB5mrQWMV92h9j81QWloJomAuUhm2dSGngaFraGXKjLCH2dr9F+kDoqaW7XJ8U52yFOxCu
	qqrNUFrWAzJe7t8o8x3wMVBKgaLiLTLb3OjFuEyY0GwYZwE6oFQtkTMdw3mQkLWmIZq5axoigcXa1
	/o9icvzx3RrpaKhSFcUlVqbzDu9pId82D19w37tpX91ULPxcpy2Fqy5qvnWZi8MqfsRV5AgTx0Yy/
	LQDoOjeg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKWEk-00000000jO3-2Yoc;
	Wed, 06 May 2026 07:00:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE881302EC2; Wed, 06 May 2026 09:00:00 +0200 (CEST)
Date: Wed, 6 May 2026 09:00:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org,
	nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, chleroy@kernel.org, jpoimboe@kernel.org,
	ojeda@kernel.org, masahiroy@kernel.org, lossin@kernel.org,
	tamird@kernel.org, thomas.weissschuh@linutronix.de,
	rostedt@goodmis.org, ihor.solodrai@linux.dev, thuth@redhat.com,
	pmladek@suse.com, aliceryhl@google.com, elver@google.com,
	kees@kernel.org, legion@kernel.org, ardb@kernel.org,
	yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
	alexandre.chartre@oracle.com, bp@alien8.de,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of
 alternate feature branch targets
Message-ID: <20260506070000.GZ3126523@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <afoTSvawD4CXCCy1@gate>
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
In-Reply-To: <afoTSvawD4CXCCy1@gate>

On Tue, May 05, 2026 at 10:56:58AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
> > On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
> > >  	switch (opcode) {
> > > +	case 16:
> > 
> > Like case 18 below, this wants a comment describing which instruction
> > this is; bclr ?
> 
> Yes.  It is 19/16, b[c]lr (primary opcode 19, secondary opcode 16).
> 
> Where is it described what INSN_RETURN actually means for objtool?  Not
> in the header file :-(

Yeah, nowhere much I'm afraid, it is very much organic growth that is
firmly rooted in x86.

RETURN, along with sibling/tail CALLs validate things like the stack
frame being in identical state as on function entry and a few other
sanity checks (DF flag not set, no uaccess).

There is also a pile of hacks around the whole return thunk mitigation
thing. But that might be less relevant for other archs.

