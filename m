Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2820C001DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jul 2023 13:00:14 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=r6tVW/Rc;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4zZP3p87z30gr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jul 2023 23:00:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=r6tVW/Rc;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4zYP3jQBz30MD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2023 22:59:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1689685159;
	bh=acJNVov+LEY5vzZF2D/HTZd1dJc8QADqtfbwJQh2Skg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r6tVW/RcSC1U72NGhCYDHUMHKZKIGJOXGCJF/+RE0O2c7z8GdbGwX+kdyMO7zpQ2f
	 /Po1Ds78wdOzXCGnpUIWeq4QT3eK7sHRnw55x/yplEJmP+GKIRuZs+1GGDPJeXrBSG
	 g80rRSEIA7UuDQGJQpYVWVpVXrOwfZ4sj5yzQ3LUbyQv7lJJEsAsfB4efJECmnsW53
	 wYXt+0iaGhrzbSqp9i50Ro0ka6Cr0lq1BxJMSaOwmh5I94RRhd8SmVdI7FsAcHsNG/
	 HBzsk2S/hwigjyGp/tJbp+s+vqjqJJ4a8Dt/TA2tsdr6t1iRqXTBzqPlA90UEtwqZB
	 pEo9BOidgT9PA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4zYM5xYRz4wZt;
	Tue, 18 Jul 2023 22:59:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Ogness <john.ogness@linutronix.de>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <871qh6wcgb.fsf@jogness.linutronix.de>
References: <20230609051002.3342-1-npiggin@gmail.com>
 <871qh6wcgb.fsf@jogness.linutronix.de>
Date: Tue, 18 Jul 2023 22:59:13 +1000
Message-ID: <871qh5jrz2.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

John Ogness <john.ogness@linutronix.de> writes:
> Hi Nicholas,
>
> On 2023-06-09, Nicholas Piggin <npiggin@gmail.com> wrote:
>> Add --orphan-handlin for vdsos, and adjust vdso linker scripts to deal
>> with orphan sections.
>
> I'm reporting that I am getting a linker warning with 6.5-rc2. The
> warning message is:
>
> ld: warning: discarding dynamic section .rela.opd
>
> and bisects to:
>
> 8ad57add77d3 ("powerpc/build: vdso linker warning for orphan sections")
>
> Despite the warning, my ppc64 system seems to run fine. Let me know if
> you need any other information from me.

We already discard .opd and .rela*, so I guess we should also be
discarding .rela.opd.

Can you test with a newer compiler/binutils?

cheers
