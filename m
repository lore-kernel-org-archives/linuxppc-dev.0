Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A0ECAAA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 12:11:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPFFb46SRz3dxm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 22:10:59 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPFDY5vDHz2xBl
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2022 22:10:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDY576Zz4xYS;
	Fri,  9 Sep 2022 22:10:05 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
References: <b95f2e3216a574837dd61208444e9515c3423da4.1662132312.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/vdso: link with -z noexecstack
Message-Id: <166272522030.2076816.2756216556441607158.b4-ty@ellerman.id.au>
Date: Fri, 09 Sep 2022 22:07:00 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2 Sep 2022 17:25:24 +0200, Christophe Leroy wrote:
> With recent binutils, the following warning appears:
> 
>   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.2.0/../../../../powerpc64-linux/bin/ld: warning: arch/powerpc/kernel/vdso/getcpu-32.o: missing .note.GNU-stack section implies executable stack
> /opt/gcc-12.2.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/12.2.0/../../../../powerpc64-linux/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> 
> To avoid that, explicitely tell the linker we don't
> want executable stack.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vdso: link with -z noexecstack
      https://git.kernel.org/powerpc/c/1d53c0192b15f42129a3dbbbfa05637bcf781a3e

cheers
