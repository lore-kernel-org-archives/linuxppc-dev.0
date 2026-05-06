Return-Path: <linuxppc-dev+bounces-20505-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A5CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 08:00:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9SV41Rrkz2xdh;
	Wed, 06 May 2026 18:00:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778054412;
	cv=none; b=DRwQWLpg4tvOLQhWK5PyGwqzmEAMXaO1gWC+wXn1N9Q54WBZOMWBcJozgsJ6XZ2x9mj5/ZMvrv5fbMMYIyC85ISrW0yaaYKvfSyLLr4kgqtmkAPZLGr2QcFIY0d02dMiUGT8cMuQgL4Mg4VWjqDct5QWJBiYQnqbbR0gVHX9H2MLm2b4oZxqa0fbYN8IFWyQv0leAjhLg4MLUiN7tpWj3YtsNF4MZJg/yoisJzoED5qkmk7zyR0US7I7SS7dc/TsU50JYS6JCHM5dwnsMuGEInLF0IS2IC46cJR+H481/8b7XISKT8VVrf3gZBMOFTY2CFdqV0x6FcMGeHUalwIDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778054412; c=relaxed/relaxed;
	bh=Z7e5wfsQXAKmxK97eeb0+Cr3E/r0kMMdycxMwl8zRSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idwMgQ+qfyDg9aBXfndVMc7Bgxsy0riGbWNbIC6ffJgXzQmXhbWE3p8d3+GqDdAaKpJsKI5ZTfYNr3JnGJMevbmhql/gReekB4bBmrIuW3qVX6QkV6KrowdtYaxzqCUWpijL0iT8tjcKzPMwy+7d+hkmzrP9d2UzT2mEWOjkfQtBeBMHNPl3J7LcKL6qNZ01PkQCRpHzbMI6FIXgPNehOuUQkY2dhXbL4I7tv334t3Lj0qvLOE93WPnegFv1mX+q0IabELkOEIBM28dbb2AQiSU22rvU5wuhL4IfS4rGvJ951iHss+BNKE+stqbrWaHv1SffV8VYt1j/2P0xbHo8sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TwqzQxiI; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TwqzQxiI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9STz4y6hz30BC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 18:00:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z7e5wfsQXAKmxK97eeb0+Cr3E/r0kMMdycxMwl8zRSI=; b=TwqzQxiIdy1vK3gzph4t1YyE9J
	sQDQojBiOJiG5kpByBNTBnzK7h1BkmHTdKJ8yELp1413oMExLA49ZVMeJJzA1xElhfJH+plJxa9pu
	zepCRCyYuCgAdAnr1XSUj+0roKu3uJuP+YAkxRKA0uwDyKjnXwOrpGzggjb49yh3FkKpeO1MCi5ry
	Lsdfa/2SzpNlSRmVi9hkVq6P2GwvWONe1eF9XRLS2kj7kAESknbRyIyqRoDRT/KEQSmdrKfQgDHa/
	dfrrllrLxFsUUheHY20ush0gqWymyC5libuMBxnRX1qAf6UmuvaZllkZ33x83REY8MACXjdQd9QG0
	7s6A36gA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKXAV-00000000ukV-225f;
	Wed, 06 May 2026 07:59:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BB847302EC2; Wed, 06 May 2026 09:17:53 +0200 (CEST)
Date: Wed, 6 May 2026 09:17:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org,
	nsc@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, jpoimboe@kernel.org, ojeda@kernel.org,
	masahiroy@kernel.org, lossin@kernel.org, tamird@kernel.org,
	thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
	ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
	aliceryhl@google.com, elver@google.com, kees@kernel.org,
	legion@kernel.org, ardb@kernel.org, yuxuan.zuo@outlook.com,
	alexghiti@rivosinc.com, alexandre.chartre@oracle.com, bp@alien8.de,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/6] objtool/powerpc: Add build-time fixup of
 alternate feature branch targets
Message-ID: <20260506071753.GA3126523@noisy.programming.kicks-ass.net>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505084628.17940-2-sv@linux.ibm.com>
 <20260505144539.GX3126523@noisy.programming.kicks-ass.net>
 <20260505144949.GO3102924@noisy.programming.kicks-ass.net>
 <669fbc9a-a243-43e8-8888-93bfb9d6ee12@kernel.org>
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
In-Reply-To: <669fbc9a-a243-43e8-8888-93bfb9d6ee12@kernel.org>

On Tue, May 05, 2026 at 05:48:32PM +0200, Christophe Leroy (CS GROUP) wrote:

> bclr (which is the return INSN_RETURN) has type 19
> 
> By the way you can have a look at https://patchwork.ozlabs.org/project/linuxppc-dev/patch/bfa8364da047d8610a09458a1cd924a0566aedbb.1736955567.git.christophe.leroy@csgroup.eu/

That is indeed more; isn't bcl something like COND_CALL ? (another one
of them things we don't have).

> That patch has all the objtool decoding. By the way objtool is missing a
> INSN_CONDITIONAL_RETURN, also see https://patchwork.ozlabs.org/project/linuxppc-dev/patch/537e5d8f181b1f1c2b8918f1aefa1dba3f972c03.1736955567.git.christophe.leroy@csgroup.eu/

Right, that is not something x86 has, but I don't see a reason we can't
add that. With return thunks, Clang (and I've heard GCC is also
considering this) does something very close to conditional return.

With return thunks, regular RET instruction is replaced with a JMP, or
rather Jcc in this specific case, to the out of line __x86_return_thunk
symbol. Objtool currently treats that as a conditional sibling/tail
call, which isn't wrong.

Anyway, with that patch, I think validate_insn() wants something like so
added:

	case INSN_COND_RETURN:
		validate_return(func, insn, statep);
		break;

That way we do the return checks, but don't terminate the control flow.
After all, when the condition is taken, we had better have the stack
frame in the same state etc.

