Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064B3C4332F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:58:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfSR45Y0z3hSM
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:58:47 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1p4kYZz3dsn
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:39:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1p3dQGz4xHg;
	Wed,  5 Oct 2022 00:39:10 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220909142457.278032-1-npiggin@gmail.com>
References: <20220909142457.278032-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/time: avoid programming DEC at the start of the timer interrupt
Message-Id: <166488989423.779920.11698546566177035809.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:24:54 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 10 Sep 2022 00:24:57 +1000, Nicholas Piggin wrote:
> Setting DEC to maximum at the start of the timer interrupt is not
> necessary and can be avoided for performance when MSR[EE] is not
> enabled during the handler as explained in commit 0faf20a1ad16
> ("powerpc/64s/interrupt: Don't enable MSR[EE] in irq handlers unless
> perf is in use"), where this change was first attempted.
> 
> The idea is that the timer interrupt runs with MSR[EE]=0, and at the end
> of the interrupt DEC is programmed to the next timer interval, so there
> is no need to clear the decrementer exception before then.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/time: avoid programming DEC at the start of the timer interrupt
      https://git.kernel.org/powerpc/c/c84550203b3173511e8cdbe94bc2e33175ba1d72

cheers
