Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43832C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890DC208E7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 13:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890DC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BCX66bcHzDrj0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 00:11:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BCRL5tb8zDrh6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 00:06:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43BCRL1sXVz9s0t; Sat,  8 Dec 2018 00:06:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2b038cbc5fcf12a7ee1cc9bfd5da1e46dacdee87
X-Patchwork-Hint: ignore
In-Reply-To: <1542990611-17149-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries/cpuidle: Fix preempt warning
Message-Id: <43BCRL1sXVz9s0t@ozlabs.org>
Date: Sat,  8 Dec 2018 00:06:53 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-11-23 at 16:30:11 UTC, Breno Leitao wrote:
> When booting a pseries kernel with PREEMPT enabled, it dumps the following
> warning:
> 
>    BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>    caller is pseries_processor_idle_init+0x5c/0x22c
>    CPU: 13 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc3-00090-g12201a0128bc-dirty #828
>    Call Trace:
>    [c000000429437ab0] [c0000000009c8878] dump_stack+0xec/0x164 (unreliable)
>    [c000000429437b00] [c0000000005f2f24] check_preemption_disabled+0x154/0x160
>    [c000000429437b90] [c000000000cab8e8] pseries_processor_idle_init+0x5c/0x22c
>    [c000000429437c10] [c000000000010ed4] do_one_initcall+0x64/0x300
>    [c000000429437ce0] [c000000000c54500] kernel_init_freeable+0x3f0/0x500
>    [c000000429437db0] [c0000000000112dc] kernel_init+0x2c/0x160
>    [c000000429437e20] [c00000000000c1d0] ret_from_kernel_thread+0x5c/0x6c
> 
> This happens because the code calls get_lppaca() which calls get_paca() and
> it checks if preemption is disabled through check_preemption_disabled().
> 
> Preemption should be disabled because the per CPU variable may make no
> sense if there is a preemption (and a CPU switch) after it reads the per
> CPU data and when it is used.
> 
> At this device driver specifically, it is not a problem, because this code
> just need to have access to one lppaca struct, and it does not matter if it
> is the current per CPU lppaca struct or not (i.e. when there is a
> preemption and a CPU migration).
> 
> That said, the most appropriated fix seems to be related to avoiding the
> debug_smp_processor_id() call at get_paca(), instead of calling
> preempt_disable() before get_paca().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2b038cbc5fcf12a7ee1cc9bfd5da1e

cheers
