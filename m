Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF7C49EA6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:41:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D4D6162A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D4D6162A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBr581kfnz3df2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 20:41:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBr2R4Y2Jz3btC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 20:38:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GBr2Q3R6Mz9t0Y; Sat, 26 Jun 2021 20:38:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
References: <5bdc8cbc9a95d0779e27c9ddbf42b40f51f883c0.1624425798.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/kprobes: Fix Oops by passing ppc_inst as a
 pointer to emulate_step() on ppc32
Message-Id: <162470384231.3589875.12558061004579567759.b4-ty@ellerman.id.au>
Date: Sat, 26 Jun 2021 20:37:22 +1000
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

On Wed, 23 Jun 2021 05:23:30 +0000 (UTC), Christophe Leroy wrote:
> Trying to use a kprobe on ppc32 results in the below splat:
>     BUG: Unable to handle kernel data access on read at 0x7c0802a6
>     Faulting instruction address: 0xc002e9f0
>     Oops: Kernel access of bad area, sig: 11 [#1]
>     BE PAGE_SIZE=4K PowerPC 44x Platform
>     Modules linked in:
>     CPU: 0 PID: 89 Comm: sh Not tainted 5.13.0-rc1-01824-g3a81c0495fdb #7
>     NIP:  c002e9f0 LR: c0011858 CTR: 00008a47
>     REGS: c292fd50 TRAP: 0300   Not tainted  (5.13.0-rc1-01824-g3a81c0495fdb)
>     MSR:  00009000 <EE,ME>  CR: 24002002  XER: 20000000
>     DEAR: 7c0802a6 ESR: 00000000
>     <snip>
>     NIP [c002e9f0] emulate_step+0x28/0x324
>     LR [c0011858] optinsn_slot+0x128/0x10000
>     Call Trace:
>      opt_pre_handler+0x7c/0xb4 (unreliable)
>      optinsn_slot+0x128/0x10000
>      ret_from_syscall+0x0/0x28
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kprobes: Fix Oops by passing ppc_inst as a pointer to emulate_step() on ppc32
      https://git.kernel.org/powerpc/c/511eea5e2ccdfdbf3d626bde0314e551f247dd18

cheers
