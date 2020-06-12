Return-Path: <SRS0=EtvQ=7Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A61C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 12:45:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B262074B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SbwWGzWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B262074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49k0n96rgdzDqvp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 22:45:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49k0kV6krYzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 22:42:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=SbwWGzWR; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49k0kV0KY5z9sT9;
 Fri, 12 Jun 2020 22:42:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1591965778;
 bh=WsPMUjIBU+8l06+X1fmwD1TZqna6PzkWkngb+a65SR0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=SbwWGzWRtsbqLolo3htmKtmmgbKSiCu1nfcEqMEm7bUpe613skf2/AflksfW5mITI
 XWOoEy60jv4viB9y2p/t23S8ZHm67ZATVy+K3uxMxMYHZWqE4EprOGzZDmOJ6HWoXw
 L8RcaX+gtkUN3cSL7Zkcb8050ihR8jFlq45ngC0xFpPWjilVx70EjfvR1sPmg2iXnq
 z22IdwGFVnSTOJBIHyBPbEml41s3hA8j/NSeL4qz7SLFkN5fR8FCu4HD8+ne8ptGv3
 kya+xYIl8hp3Ag48V99WQ4qQ+IoAVZ38tQ+njWNNdMXzbpSRNBoE3p5HrMotRLvim6
 dwRgzflZn5zug==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/xive: Ignore kmemleak false positives
In-Reply-To: <20200612043303.84894-1-aik@ozlabs.ru>
References: <20200612043303.84894-1-aik@ozlabs.ru>
Date: Fri, 12 Jun 2020 22:43:22 +1000
Message-ID: <87a718fo9h.fsf@mpe.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> xive_native_provision_pages() allocates memory and passes the pointer to
> OPAL so kmemleak cannot find the pointer usage in the kernel memory and
> produces a false positive report (below) (even if the kernel did scan
> OPAL memory, it is unable to deal with __pa() addresses anyway).
>
> This silences the warning.
>
> unreferenced object 0xc000200350c40000 (size 65536):
>   comm "qemu-system-ppc", pid 2725, jiffies 4294946414 (age 70776.530s)
>   hex dump (first 32 bytes):
>     02 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00  ....P...........
>     01 00 08 07 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<0000000081ff046c>] xive_native_alloc_vp_block+0x120/0x250
>     [<00000000d555d524>] kvmppc_xive_compute_vp_id+0x248/0x350 [kvm]
>     [<00000000d69b9c9f>] kvmppc_xive_connect_vcpu+0xc0/0x520 [kvm]
>     [<000000006acbc81c>] kvm_arch_vcpu_ioctl+0x308/0x580 [kvm]
>     [<0000000089c69580>] kvm_vcpu_ioctl+0x19c/0xae0 [kvm]
>     [<00000000902ae91e>] ksys_ioctl+0x184/0x1b0
>     [<00000000f3e68bd7>] sys_ioctl+0x48/0xb0
>     [<0000000001b2c127>] system_call_exception+0x124/0x1f0
>     [<00000000d2b2ee40>] system_call_common+0xe8/0x214
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
> Does kmemleak actually check the OPAL memory?

No it shouldn't.

The memory used by OPAL should all be reserved in the device tree. That
means we never give it to any of the Linux memory allocators, and
therefore kmemleak will never see an allocation from those areas and add
that area to its list of areas to scan.

At least that's my understanding of how kmemleak works.

> Because if it did, we would still have a warning as kmemleak does not
> trace __pa() addresses anyway.

Right.

I think this patch is an OK solution.

It's kind of odd that we donate pages and don't keep track of them. But
they're used by xive until it's reset, and we don't do that until we
kexec, at which point we don't need to know about them anyway.

cheers
