Return-Path: <SRS0=Si2p=DV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A26C433E7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 00:15:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFFE20776
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nS9Y29JA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFFE20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C9tGF4NwxzDqpC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2020 11:15:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9tDS5ZZqzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2020 11:13:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=nS9Y29JA; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4C9tDS1d3yz9sVS;
 Wed, 14 Oct 2020 11:13:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1602634408;
 bh=kWr8uHYNyFOfUWg35FUMahaQ83JjMGcRXGempu9ybD0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nS9Y29JAUsw49i0j0VMBbrzXc3gOqyL1ZeUmGeO5zhOjwIByt6IodOdoXGlbKqs2G
 scFUqq6SMzlbhsiWYpTNgOgYn820EgQY0HllZDzowDwnAqDrmdkQ0r+8C9xU1pFyx9
 HvbXe2cChgNGNBUzqQ1lPlFeFFkX1enc4rJm9Hqq6r0y0QpwFSqBiq2j5o9gV/ZEuM
 NE79wWEmndltYlJpzHNiZls7BKRoepoyXcc9Cb9VptwfoAyZM4xM8QqqDImcnTJ8QZ
 iIqHh73wQCqdWsJ+MeUKagjqQubrihj1LazMNftkDEfNa3CyIEtWwuK1t5Js7fIgBC
 CZzy+b7yHQi5Q==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc: Fix user data corruption with P9N DD2.1 VSX
 CI load workaround emulation
In-Reply-To: <20201013043741.743413-1-mikey@neuling.org>
References: <20201013043741.743413-1-mikey@neuling.org>
Date: Wed, 14 Oct 2020 11:13:24 +1100
Message-ID: <87pn5lzmu3.fsf@mpe.ellerman.id.au>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Neuling <mikey@neuling.org> writes:
> __get_user_atomic_128_aligned() stores to kaddr using stvx which is a
> VMX store instruction, hence kaddr must be 16 byte aligned otherwise
> the store won't occur as expected.
>
> Unfortunately when we call __get_user_atomic_128_aligned() in
> p9_hmi_special_emu(), the buffer we pass as kaddr (ie. vbuf) isn't
> guaranteed to be 16B aligned. This means that the write to vbuf in
> __get_user_atomic_128_aligned() has the bottom bits of the address
> truncated. This results in other local variables being
> overwritten. Also vbuf will not contain the correct data which results
> in the userspace emulation being wrong and hence user data corruption.
>
> In the past we've been mostly lucky as vbuf has ended up aligned but
> this is fragile and isn't always true. CONFIG_STACKPROTECTOR in
> particular can change the stack arrangement enough that our luck runs
> out.

Actually I'm yet to find a kernel with CONFIG_STACKPROTECTOR=n that is
vulnerable to the bug.

Turning on STACKPROTECTOR changes the order GCC allocates locals on the
stack, from bottom-up to top-down. That in conjunction with the 8 byte
stack canary means we end up with 8 bytes of space below the locals,
which misaligns vbuf.

But obviously other things can change the stack layout too, so no
guarantees that CONFIG_STACKPROTECTOR=n makes it safe.

cheers
