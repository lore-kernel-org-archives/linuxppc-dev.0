Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF37C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Apr 2022 12:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KmRwT0gX3z3cJs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Apr 2022 22:17:13 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KmRvC6mY5z2yY7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2022 22:16:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KmRv86fN0z4yST;
 Sun, 24 Apr 2022 22:16:04 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220420141657.771442-1-mpe@ellerman.id.au>
References: <20220420141657.771442-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/time: Always set decrementer in timer_interrupt()
Message-Id: <165080251887.1540533.9539225847343635534.b4-ty@ellerman.id.au>
Date: Sun, 24 Apr 2022 22:15:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: miguel.ojeda.sandonis@gmail.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 Apr 2022 00:16:57 +1000, Michael Ellerman wrote:
> This is a partial revert of commit 0faf20a1ad16 ("powerpc/64s/interrupt:
> Don't enable MSR[EE] in irq handlers unless perf is in use").
> 
> Prior to that commit, we always set the decrementer in
> timer_interrupt(), to clear the timer interrupt. Otherwise we could end
> up continuously taking timer interrupts.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/time: Always set decrementer in timer_interrupt()
      https://git.kernel.org/powerpc/c/d2b9be1f4af5cabed1ee5bb341f887f64b1c1669

cheers
