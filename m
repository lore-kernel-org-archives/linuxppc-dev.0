Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCFDC04A68
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Jul 2022 12:03:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LtC931Z2kz3dqy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Jul 2022 22:03:19 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LtC8d755bz3bbQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2022 22:02:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtC8d6PpMz4x1V;
	Wed, 27 Jul 2022 22:02:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220718134418.354114-1-mpe@ellerman.id.au>
References: <87cze3docs.fsf@mpe.ellerman.id.au> <20220718134418.354114-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Disable stack variable initialisation for prom_init
Message-Id: <165892333889.2650300.15415941186820004901.b4-ty@ellerman.id.au>
Date: Wed, 27 Jul 2022 22:02:18 +1000
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

On Mon, 18 Jul 2022 23:44:18 +1000, Michael Ellerman wrote:
> With GCC 12 allmodconfig prom_init fails to build:
> 
>   Error: External symbol 'memset' referenced from prom_init.c
>   make[2]: *** [arch/powerpc/kernel/Makefile:204: arch/powerpc/kernel/prom_init_check] Error 1
> 
> The allmodconfig build enables KASAN, so all calls to memset in
> prom_init should be converted to __memset by the #ifdefs in
> asm/string.h, because prom_init must use the non-KASAN instrumented
> versions.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Disable stack variable initialisation for prom_init
      https://git.kernel.org/powerpc/c/be640317a1d0b9cf42fedb2debc2887a7cfa38de

cheers
