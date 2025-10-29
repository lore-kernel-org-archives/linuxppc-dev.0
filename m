Return-Path: <linuxppc-dev+bounces-13509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99A8CCF9EB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Oct 2025 10:24:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cxNdm200Wz3c1T;
	Wed, 29 Oct 2025 21:24:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761733468;
	cv=none; b=TlBFRUxTZTfbmDV+KZktA0Fv0KiGaWkAAZT29L0zreClJhVRjIeNnrUdJL4AWNoeapODGkAZyH4IcCp3+lAqUhMyyvqmFtHKRSxpXwy/7aKY1Mg+aP1afXmt/7VXXPPQd+EwrUtZUUt3erL4qUFcxCgu3Q4wOQV4K+KaE5LyGYT9FAX+PourqQbBBKDp/C6Ug8CALo70Z1rg5abC4cXV1CzK12+I+LtCtl91KLoRw4F/BYYjwbyU7T6jlEmoJ2YNDqw9WniN44yk7A4O+W7SDm9umWr2wbD7oOkLama3cMxnpvS6NSqh/zYV5s67vtA/S5UFWOvDzvVUtK4oH7SOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761733468; c=relaxed/relaxed;
	bh=FTMUdLNlqjqoXX4P14LI/1ejbYO2CftFuA0qjvbF9f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9k3QwovoBtvQT0clQubpdcFRpDXKJXEZg/dRirAZiybq0ZjGokh7j5CAF3YDojLdxQEFn8y3T0SAe1OVrcj4M1b6IS6Y8JZY+Q9QsI74q/YX7GTqW7B4m/jqZcHwGP+2/Xm3b5sfFGjHGYmQIG3EgLg+6vWJscq44P7v6yeYx1JDvFk99O1Y+UgM12T9i+pWXqMcV66M8EuEYvQz1t9kSprqQ6UjJTZQRfUlFNrrmB0XUHIVrExpMVzt10LvFxA4SGpxf++cZEmjcIDwC6rbK2V+fLJe+sU7akDWH6p+T9VgTF9XAvRuz92tjTYL+I1+Cn6FxCV2Jc4CuDuV3tdnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fpc+lgyc; dkim-atps=neutral; spf=temperror (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.helo=casper.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=fpc+lgyc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.helo=casper.infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cxNdX3wDSz3c1J
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2025 21:23:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FTMUdLNlqjqoXX4P14LI/1ejbYO2CftFuA0qjvbF9f8=; b=fpc+lgycW1wcwUiZs6b4NjJePP
	iuaV9Xq7hNjiBnfjYwG7NBZlPjgZxOgGNDi8UoDFQ2xMc4q8YBYtO20x88uTqSr2tN5PTAcwTu+qG
	jRsNMYi3FjF+scS+TRjZ8raKrmJm9irXvKLA2qzlz3kQZOfHDnKWt3nYjxtU3QoTlJ9FFjc5NRt5i
	BJ0qtaYnNMLstn6zkZGJcqLrpPOfRpgOQIVchARnPISVBUlcFFYLLVx72Xb5bgAV7fHs8ehlsNrWf
	TG363xC52UimSsVO9P073iBgZndCyJUrWJNmVTw2mNHVCVo6NnZx0KzUujHtGahy82tqBVkLDkuet
	cNiQyKCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3L1-00000007Ffr-18tN;
	Wed, 29 Oct 2025 10:23:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 034AB300323; Wed, 29 Oct 2025 11:23:32 +0100 (CET)
Date: Wed, 29 Oct 2025 11:23:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [patch V5 00/12] uaccess: Provide and use scopes for user access
Message-ID: <20251029102331.GG988547@noisy.programming.kicks-ass.net>
References: <20251027083700.573016505@linutronix.de>
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
In-Reply-To: <20251027083700.573016505@linutronix.de>

On Mon, Oct 27, 2025 at 09:43:40AM +0100, Thomas Gleixner wrote:
> Thomas Gleixner (12):
>       ARM: uaccess: Implement missing __get_user_asm_dword()
>       uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
>       x86/uaccess: Use unsafe wrappers for ASM GOTO
>       powerpc/uaccess: Use unsafe wrappers for ASM GOTO
>       riscv/uaccess: Use unsafe wrappers for ASM GOTO
>       s390/uaccess: Use unsafe wrappers for ASM GOTO
>       uaccess: Provide scoped user access regions
>       uaccess: Provide put/get_user_inline()
>       futex: Convert to get/put_user_inline()
>       x86/futex: Convert to scoped user access
>       select: Convert to scoped user access

Applied to tip/core/rseq along with the first set of rseq patches. The
core-scoped-uaccess tag should denote just this series.

