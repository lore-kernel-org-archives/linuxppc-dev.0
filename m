Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A78C04FFE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2024 13:49:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZGjC2zvcz78Zf
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2024 23:49:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZGXW6C72z3cVv
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2024 23:42:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VZGXS5NX9z4xKZ;
	Wed,  8 May 2024 23:42:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20240503075619.394467-1-mpe@ellerman.id.au>
References: <20240503075619.394467-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc/io: Avoid clang null pointer arithmetic warnings
Message-Id: <171517558549.165093.14013162517942082900.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 23:39:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: nathan@kernel.org, naresh.kamboju@linaro.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 03 May 2024 17:56:18 +1000, Michael Ellerman wrote:
> With -Wextra clang warns about pointer arithmetic using a null pointer.
> When building with CONFIG_PCI=n, that triggers a warning in the IO
> accessors, eg:
> 
>   In file included from linux/arch/powerpc/include/asm/io.h:672:
>   linux/arch/powerpc/include/asm/io-defs.h:23:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>      23 | DEF_PCI_AC_RET(inb, u8, (unsigned long port), (port), pio, port)
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   linux/arch/powerpc/include/asm/io.h:591:53: note: expanded from macro '__do_inb'
>     591 | #define __do_inb(port)          readb((PCI_IO_ADDR)_IO_BASE + port);
>         |                                       ~~~~~~~~~~~~~~~~~~~~~ ^
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/io: Avoid clang null pointer arithmetic warnings
      https://git.kernel.org/powerpc/c/03c0f2c2b2220fc9cf8785cd7b61d3e71e24a366
[2/2] powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n
      https://git.kernel.org/powerpc/c/be140f1732b523947425aaafbe2e37b41b622d96

cheers
