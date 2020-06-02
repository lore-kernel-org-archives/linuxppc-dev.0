Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2638C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4EB206A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4EB206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bgcC4kGzzDqXJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:30:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bgVd0qqhzDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 15:25:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49bgVc0ql9z9sSg; Tue,  2 Jun 2020 15:25:43 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2f26ed1764b42a8c40d9c48441c73a70d805decf
In-Reply-To: <20200529061446.2773-1-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64/syscall: Disable sanitisers for C syscall
 entry/exit code
Message-Id: <49bgVc0ql9z9sSg@ozlabs.org>
Date: Tue,  2 Jun 2020 15:25:43 +1000 (AEST)
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
Cc: ajd@linux.ibm.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-05-29 at 06:14:46 UTC, Daniel Axtens wrote:
> syzkaller is picking up a bunch of crashes that look like this:
> 
> Unrecoverable exception 380 at c00000000037ed60 (msr=8000000000001031)
> Oops: Unrecoverable exception, sig: 6 [#1]
> LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
> Modules linked in:
> CPU: 0 PID: 874 Comm: syz-executor.0 Not tainted 5.7.0-rc7-syzkaller-00016-gb0c3ba31be3e #0
> NIP:  c00000000037ed60 LR: c00000000004bac8 CTR: c000000000030990
> REGS: c0000000555a7230 TRAP: 0380   Not tainted  (5.7.0-rc7-syzkaller-00016-gb0c3ba31be3e)
> MSR:  8000000000001031 <SF,ME,IR,DR,LE>  CR: 48222882  XER: 20000000
> CFAR: c00000000004bac4 IRQMASK: 0
> GPR00: c00000000004bb68 c0000000555a74c0 c0000000024b3500 0000000000000005
> GPR04: 0000000000000000 0000000000000000 c00000000004bb88 c008000000910000
> GPR08: 00000000000b0000 c00000000004bac8 0000000000016000 c000000002503500
> GPR12: c000000000030990 c000000003190000 00000000106a5898 00000000106a0000
> GPR16: 00000000106a5890 c000000007a92000 c000000008180e00 c000000007a8f700
> GPR20: c000000007a904b0 0000000010110000 c00000000259d318 5deadbeef0000100
> GPR24: 5deadbeef0000122 c000000078422700 c000000009ee88b8 c000000078422778
> GPR28: 0000000000000001 800000000280b033 0000000000000000 c0000000555a75a0
> NIP [c00000000037ed60] __sanitizer_cov_trace_pc+0x40/0x50
> LR [c00000000004bac8] interrupt_exit_kernel_prepare+0x118/0x310
> Call Trace:
> [c0000000555a74c0] [c00000000004bb68] interrupt_exit_kernel_prepare+0x1b8/0x310 (unreliable)
> [c0000000555a7530] [c00000000000f9a8] interrupt_return+0x118/0x1c0
> --- interrupt: 900 at __sanitizer_cov_trace_pc+0x0/0x50
> ...<random previous call chain>...
> 
> That looks like the KCOV helper accessing memory that's not safe to
> access in the interrupt handling context.
> 
> Do not instrument the new syscall entry/exit code with KCOV, GCOV or
> UBSAN.
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Fixes: 68b34588e202 ("powerpc/64/sycall: Implement syscall entry/exit logic in C")
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2f26ed1764b42a8c40d9c48441c73a70d805decf

cheers
