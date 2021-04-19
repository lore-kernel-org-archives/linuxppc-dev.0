Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28931C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:04:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7000610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7000610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtW23TjJz3cZK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:04:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtVK4PSRz30FD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVK2KxVz9vFw; Mon, 19 Apr 2021 14:04:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, linux@roeck-us.net
In-Reply-To: <aad2cb1801a3cc99bc27081022925b9fc18a0dfb.1618159169.git.christophe.leroy@csgroup.eu>
References: <aad2cb1801a3cc99bc27081022925b9fc18a0dfb.1618159169.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal32: Fix build failure with CONFIG_SPE
Message-Id: <161880479652.1398509.9868352965277693855.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:56 +1000
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 11 Apr 2021 16:39:53 +0000 (UTC), Christophe Leroy wrote:
> Add missing fault exit label in unsafe_copy_from_user() in order to
> avoid following build failure with CONFIG_SPE
> 
>   CC      arch/powerpc/kernel/signal_32.o
> arch/powerpc/kernel/signal_32.c: In function 'restore_user_regs':
> arch/powerpc/kernel/signal_32.c:565:36: error: macro "unsafe_copy_from_user" requires 4 arguments, but only 3 given
>   565 |           ELF_NEVRREG * sizeof(u32));
>       |                                    ^
> In file included from ./include/linux/uaccess.h:11,
>                  from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:33,
>                  from ./include/linux/huge_mm.h:8,
>                  from ./include/linux/mm.h:707,
>                  from arch/powerpc/kernel/signal_32.c:17:
> ./arch/powerpc/include/asm/uaccess.h:428: note: macro "unsafe_copy_from_user" defined here
>   428 | #define unsafe_copy_from_user(d, s, l, e) \
>       |
> arch/powerpc/kernel/signal_32.c:564:3: error: 'unsafe_copy_from_user' undeclared (first use in this function); did you mean 'raw_copy_from_user'?
>   564 |   unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
>       |   ^~~~~~~~~~~~~~~~~~~~~
>       |   raw_copy_from_user
> arch/powerpc/kernel/signal_32.c:564:3: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [arch/powerpc/kernel/signal_32.o] Error 1

Applied to powerpc/next.

[1/1] powerpc/signal32: Fix build failure with CONFIG_SPE
      https://git.kernel.org/powerpc/c/af072b1a9d4d9edc24da84a071b0671e147026cb

cheers
