Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9986EB64DC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 05:37:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvZS62LM9z3d8d
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:37:10 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvZP42YWcz3bXv
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2023 15:34:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZP416rjz4wxm;
	Mon,  3 Jul 2023 15:34:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
References: <57834a703dfa5d6c27c9de0a01329059636e5ab7.1685080579.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kcsan: Properly instrument arch_spin_unlock()
Message-Id: <168836201884.50010.3433894878909493070.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:26:58 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 26 May 2023 07:57:33 +0200, Christophe Leroy wrote:
> The following boottime error is encountered with SMP kernel:
> 
>   kcsan: improperly instrumented type=(0): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(0): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE): spin_unlock(&test_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): arch_spin_unlock(&arch_spinlock)
>   kcsan: improperly instrumented type=(KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND): spin_unlock(&test_spinlock)
>   kcsan: selftest: test_barrier failed
>   kcsan: selftest: 2/3 tests passed
>   Kernel panic - not syncing: selftests failed
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kcsan: Properly instrument arch_spin_unlock()
      https://git.kernel.org/powerpc/c/396f2b0106ff343c61f7ae221dc6ae300f807760

cheers
