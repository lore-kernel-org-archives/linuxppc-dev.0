Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC296C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 02:53:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262E960C3F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 02:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 262E960C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpbFC4TWxz3cGc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:53:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=nQOfwUs5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=nQOfwUs5; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GpbDT33FWz2yRS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 12:52:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GpbDQ3bDgz9sSs;
 Tue, 17 Aug 2021 12:52:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629168759;
 bh=ZcLwqPNyFGgNGXWnp5QzLIMHYBfTDJ+axVOzNxoaC5A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nQOfwUs5Wk2yPKh4WpMNbc/e9yesGDDoEodhWaw3Pu5zHC3cLqIz5clYdnwTi270C
 OzQgs4FX71P7pDD6pmS0tSZyeOOr+9324FVMwwtfe4CeJkIKqhw3wPmcW0O+4UNJOi
 r8x5ZdZyGKUzxZdCCqJxv6v26BQJr874T9u/4ep8A9WjwSGtrp418zsFth0VR43taG
 GKysHrk88bnssfosAEBIlnnDJSQi9hu8Jgpg54EMqPuB9cWipYV6aicYKWekkAKWNQ
 HxBcyV8Z829/D1pI3r7IdZw/JOIrm4ALLSoV5FM4CcfuX0ydCjFOiMVy1YlmwMQ8Hi
 lWTSb5EX1qWvg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: Fix undefined static key
In-Reply-To: <20210816082403.2293846-3-joel@jms.id.au>
References: <20210816082403.2293846-1-joel@jms.id.au>
 <20210816082403.2293846-3-joel@jms.id.au>
Date: Tue, 17 Aug 2021 12:52:37 +1000
Message-ID: <877dgkhjey.fsf@mpe.ellerman.id.au>
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:
> When CONFIG_PPC_BARRIER_NOSPEC=n, security.c is not built leading to a
> missing definition of uaccess_flush_key.
>
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.kallsyms1
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/align.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/signal_64.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/process.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/traps.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/hw_breakpoint_constraints.o:(.toc+0x0): undefined reference to `uaccess_flush_key'
> powerpc64le-linux-gnu-ld: arch/powerpc/kernel/ptrace/ptrace.o:(.toc+0x0): more undefined references to `uaccess_flush_key' follow
> make[1]: *** [Makefile:1176: vmlinux] Error 1
>
> Hack one in to fix the build.

Yeah sorry that is a bit of a hack :)

I think the root cause here is that we don't have a CONFIG for "want
security workaround stuff", because so far we haven't had a CPU that
wants to turn that all off.

The generic code uses CONFIG_GENERIC_CPU_VULNERABILITIES, so I guess we
should follow that example and add PPC_CPU_VULNERABILITIES.

Then we'd use that to disable all the security.c stuff, and
PPC_BARRIER_NOSPEC would depend on it also.

Then we could allow configuring that off for Microwatt, or possibly for
all platforms if people want to do that.

cheers
