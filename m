Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04ACA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:44:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFD42080F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 12:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFD42080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4737S43YybzF4KM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 23:44:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4736nv34XBzF4BZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 23:14:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4736nt571jz9sPd; Wed, 30 Oct 2019 23:14:26 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4736nr03ZLz9sRM; Wed, 30 Oct 2019 23:14:23 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eb8e20f89093b64f48975c74ccb114e6775cee22
In-Reply-To: <20191024055932.27940-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Mark accumulate_stolen_time() as notrace
Message-Id: <4736nr03ZLz9sRM@ozlabs.org>
Date: Wed, 30 Oct 2019 23:14:23 +1100 (AEDT)
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-10-24 at 05:59:32 UTC, Michael Ellerman wrote:
> accumulate_stolen_time() is called prior to interrupt state being
> reconciled, which can trip the warning in arch_local_irq_restore():
> 
>   WARNING: CPU: 5 PID: 1017 at arch/powerpc/kernel/irq.c:258 .arch_local_irq_restore+0x9c/0x130
>   ...
>   NIP .arch_local_irq_restore+0x9c/0x130
>   LR  .rb_start_commit+0x38/0x80
>   Call Trace:
>     .ring_buffer_lock_reserve+0xe4/0x620
>     .trace_function+0x44/0x210
>     .function_trace_call+0x148/0x170
>     .ftrace_ops_no_ops+0x180/0x1d0
>     ftrace_call+0x4/0x8
>     .accumulate_stolen_time+0x1c/0xb0
>     decrementer_common+0x124/0x160
> 
> For now just mark it as notrace. We may change the ordering to call it
> after interrupt state has been reconciled, but that is a larger
> change.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/eb8e20f89093b64f48975c74ccb114e6775cee22

cheers
