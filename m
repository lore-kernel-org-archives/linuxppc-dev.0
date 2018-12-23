Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE1C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:34:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0F821855
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F821855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N3JG6bWWzDqcY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 00:34:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N3893dmczDqVw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:27:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43N3892b7Xz9sDn; Mon, 24 Dec 2018 00:27:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e1c3743e1a20647c53b719dbf28b48f45d23f2cd
X-Patchwork-Hint: ignore
In-Reply-To: <1542828069-29100-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/tm: Set MSR[TS] just prior to recheckpoint
Message-Id: <43N3892b7Xz9sDn@ozlabs.org>
Date: Mon, 24 Dec 2018 00:27:53 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 "v3.9+" <stable@vger.kernel.org>, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-21 at 19:21:09 UTC, Breno Leitao wrote:
> On a signal handler return, the user could set a context with MSR[TS] bits
> set, and these bits would be copied to task regs->msr.
> 
> At restore_tm_sigcontexts(), after current task regs->msr[TS] bits are set,
> several __get_user() are called and then a recheckpoint is executed.
> 
> This is a problem since a page fault (in kernel space) could happen when
> calling __get_user(). If it happens, the process MSR[TS] bits were
> already set, but recheckpoint was not executed, and SPRs are still invalid.
> 
> The page fault can cause the current process to be de-scheduled, with
> MSR[TS] active and without tm_recheckpoint() being called.  More
> importantly, without TEXASR[FS] bit set also.
> 
> Since TEXASR might not have the FS bit set, and when the process is
> scheduled back, it will try to reclaim, which will be aborted because of
> the CPU is not in the suspended state, and, then, recheckpoint. This
> recheckpoint will restore thread->texasr into TEXASR SPR, which might be
> zero, hitting a BUG_ON().
> 
> 	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
> 	cpu 0xb: Vector: 700 (Program Check) at [c00000041f1576d0]
> 	    pc: c000000000054550: restore_gprs+0xb0/0x180
> 	    lr: 0000000000000000
> 	    sp: c00000041f157950
> 	   msr: 8000000100021033
> 	  current = 0xc00000041f143000
> 	  paca    = 0xc00000000fb86300	 softe: 0	 irq_happened: 0x01
> 	    pid   = 1021, comm = kworker/11:1
> 	kernel BUG at /build/linux-sf3Co9/linux-4.9.30/arch/powerpc/kernel/tm.S:434!
> 	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
> 	enter ? for help
> 	[c00000041f157b30] c00000000001bc3c tm_recheckpoint.part.11+0x6c/0xa0
> 	[c00000041f157b70] c00000000001d184 __switch_to+0x1e4/0x4c0
> 	[c00000041f157bd0] c00000000082eeb8 __schedule+0x2f8/0x990
> 	[c00000041f157cb0] c00000000082f598 schedule+0x48/0xc0
> 	[c00000041f157ce0] c0000000000f0d28 worker_thread+0x148/0x610
> 	[c00000041f157d80] c0000000000f96b0 kthread+0x120/0x140
> 	[c00000041f157e30] c00000000000c0e0 ret_from_kernel_thread+0x5c/0x7c
> 
> This patch simply delays the MSR[TS] set, so, if there is any page fault in
> the __get_user() section, it does not have regs->msr[TS] set, since the TM
> structures are still invalid, thus avoiding doing TM operations for
> in-kernel exceptions and possible process reschedule.
> 
> With this patch, the MSR[TS] will only be set just before recheckpointing
> and setting TEXASR[FS] = 1, thus avoiding an interrupt with TM registers in
> invalid state.
> 
> Other than that, if CONFIG_PREEMPT is set, there might be a preemption just
> after setting MSR[TS] and before tm_recheckpoint(), thus, this block must
> be atomic from a preemption perspective, thus, calling
> preempt_disable/enable() on this code.
> 
> It is not possible to move tm_recheckpoint to happen earlier, because it is
> required to get the checkpointed registers from userspace, with
> __get_user(), thus, the only way to avoid this undesired behavior is
> delaying the MSR[TS] set.
> 
> The 32-bits signal handler seems to be safe this current issue, but, it
> might be exposed to the preemption issue, thus, disabling preemption in
> this chunk of code.
> 
> Changes from v2:
>  * Run the critical section with preempt_disable.
> 
> Fixes: 87b4e5393af7 ("powerpc/tm: Fix return of active 64bit signals")
> Cc: stable@vger.kernel.org (v3.9+)
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1c3743e1a20647c53b719dbf28b48

cheers
