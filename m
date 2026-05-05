Return-Path: <linuxppc-dev+bounces-20479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17658CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 14:50:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g91db4nHhz308P;
	Wed, 06 May 2026 00:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777992611;
	cv=none; b=MoWX7JnHnB9WTPLIS5O7M9UG5tlde82xctVAMcHPP0AW5q4YTnr0lY6oBNkXXNgoJ2tb1xIMtLb+mIRox3jl2o95tsBkSrCS4AInEMqlQTHKh5Ka1riYWxe4aFgptQxIO3rRE2MUJFkOMNE5pM0yalX1giB3ixazOKjP9rb+iT8KF2FQmaht9BiRtg+M7MWVacO85N5yCk+MXALDJMErbKT0H1MBLorc05IXe6PDUJMWaWTa1w6gnwhzNINq8tKDzGV7lTRa3JdVbBYEC/hMocUwwDpWJoAbwcgFVSpQ+VNfCS9fFTcNVLTdL/7lMPo77B4Q5PoFPYrlb8kAQDfdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777992611; c=relaxed/relaxed;
	bh=MhIH6P4L9AHrtbUCk5z0gOsY/j0PxcVoR9jw1AI5Xkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aONnw6W1I2OwVGcZ00Sz/mNhVTIyOK0RdOrHm1hqqVIDNgcx67IGg+CpObl4f7z0dHbcWEPgcipSuqwbFdS3k7Xo/m1zb6bcdtvBB1DyVQodRwzstqDRwG2QLG4GYXmNNZ1tSfbm6xBmCA46Y/lM5euOS+UW+wyMU5k1HBsEu9b+P+168QHcm8kwtaCkX9jYzOp/kYDvtDYiwUd8zac499N+vSe087FWb/k0WP48ZOblYA7xTceY/twT4JiI+PV6mGsLQZnuY3kRBySKEj7hNWhkTrFNHS0u6cvIg1pArxYIWOCRfgixrci6hGwNFZvX2WBqeb5Es6cHzAZ6Yv75iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OWRI0ab3; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OWRI0ab3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g91dV6dHRz2yjx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 00:50:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MhIH6P4L9AHrtbUCk5z0gOsY/j0PxcVoR9jw1AI5Xkg=; b=OWRI0ab3sH+PmXYQl/+8rjjdTj
	4peTJVZ4lPgPFSxwUZUebGE+gGchVIwHFCAWM+NVUUYa0X5DrAfOvRR0kGEE9gIiJQJXB4yKPOcrP
	M26jeunhYfFt2kxxfDCxMNuTgkEuAuR7vsp6aR2ofat3cpWODaNqyFSJfi/4jJ1j5ZXW34JNjkiKs
	fTkUdeJiJSIds3AnbocGr0q45oEuUpkBYKEQ20Jit62UHSp8cUMtTQGNEdsnxwT34DMPF5ZhAZfG7
	CsEFCOTl5adOzaLxrZE3smVEf+DCsnHtXXLyuJ9Q66Vlg0T6Q1vn/h0f/uVPmhY0Hsu//2zBgYhvt
	xtSisCIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKH5q-0000000DoGA-1dyJ;
	Tue, 05 May 2026 14:49:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E81B300324; Tue, 05 May 2026 16:49:49 +0200 (CEST)
Date: Tue, 5 May 2026 16:49:49 +0200
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
Message-ID: <20260505144949.GO3102924@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260505144539.GX3126523@noisy.programming.kicks-ass.net>

On Tue, May 05, 2026 at 04:45:39PM +0200, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 02:16:23PM +0530, Sathvika Vasireddy wrote:
> >  	switch (opcode) {
> > +	case 16:
> 
> Like case 18 below, this wants a comment describing which instruction
> this is; bclr ?

Also, isn't that typically used for return, suggesting at least
something should have INSN_RETURN on?

> > +		if (ins & 1)
> > +			typ = INSN_OTHER;
> > +		else
> > +			typ = INSN_JUMP_CONDITIONAL;
> > +		imm = ins & 0xfffc;
> > +		if (imm & 0x8000)
> > +			imm -= 0x10000;
> > +		insn->immediate = imm | aa;
> > +		break;
> > +
> >  	case 18: /* b[l][a] */
> >  		if (ins == 0x48000005)	/* bl .+4 */
> >  			typ = INSN_OTHER;

