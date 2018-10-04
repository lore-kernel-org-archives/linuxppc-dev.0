Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FBC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:50:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1782098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1782098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qk6w1pspzF3Jr
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:50:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjKJ69h6zF38J
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjKH73vwz9sj3; Thu,  4 Oct 2018 16:14:42 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c3ff2a5193fa61b1b284cfb1d79628814ed0e95a
In-Reply-To: <8e81b0647fea15e533a73ad4e9063c059fdfc6df.1537987712.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v5,1/2] powerpc/32: add stack protector support
Message-Id: <42QjKH73vwz9sj3@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:42 +1000 (AEST)
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

On Thu, 2018-09-27 at 07:05:53 UTC, Christophe Leroy wrote:
> This functionality was tentatively added in the past
> (commit 6533b7c16ee5 ("powerpc: Initial stack protector
> (-fstack-protector) support")) but had to be reverted
> (commit f2574030b0e3 ("powerpc: Revert the initial stack
> protector support") because of GCC implementing it differently
> whether it had been built with libc support or not.
> 
> Now, GCC offers the possibility to manually set the
> stack-protector mode (global or tls) regardless of libc support.
> 
> This time, the patch selects HAVE_STACKPROTECTOR only if
> -mstack-protector-guard=tls is supported by GCC.
> 
> On PPC32, as register r2 points to current task_struct at
> all time, the stack_canary located inside task_struct can be
> used directly by using the following GCC options:
> -mstack-protector-guard=tls
> -mstack-protector-guard-reg=r2
> -mstack-protector-guard-offset=offsetof(struct task_struct, stack_canary))
> 
> The protector is disabled for prom_init and bootx_init as
> it is too early to handle it properly.
> 
>  $ echo CORRUPT_STACK > /sys/kernel/debug/provoke-crash/DIRECT
> [  134.943666] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lkdtm_CORRUPT_STACK+0x64/0x64
> [  134.943666]
> [  134.955414] CPU: 0 PID: 283 Comm: sh Not tainted 4.18.0-s3k-dev-12143-ga3272be41209 #835
> [  134.963380] Call Trace:
> [  134.965860] [c6615d60] [c001f76c] panic+0x118/0x260 (unreliable)
> [  134.971775] [c6615dc0] [c001f654] panic+0x0/0x260
> [  134.976435] [c6615dd0] [c032c368] lkdtm_CORRUPT_STACK_STRONG+0x0/0x64
> [  134.982769] [c6615e00] [ffffffff] 0xffffffff
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3ff2a5193fa61b1b284cfb1d79628

cheers
