Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB576C32767
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 05:25:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77486215A4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 05:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77486215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47rkVq6hXBzDqBM
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 16:25:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47rkSB6lVyzDq9G
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2020 16:23:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 47rkSB2h9Wz9sQp; Mon,  6 Jan 2020 16:23:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47rkSB1FVLz9sR1; Mon,  6 Jan 2020 16:23:21 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 91a063c956084fb21cf2523bce6892514e3f1799
In-Reply-To: <20191221121337.4894-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Mark get_slice_psize() & slice_addr_is_low()
 as notrace
Message-Id: <47rkSB1FVLz9sR1@ozlabs.org>
Date: Mon,  6 Jan 2020 16:23:21 +1100 (AEDT)
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-12-21 at 12:13:37 UTC, Michael Ellerman wrote:
> These slice routines are called from the SLB miss handler, which can
> lead to warnings from the IRQ code, because we have not reconciled the
> IRQ state properly:
> 
>   WARNING: CPU: 72 PID: 30150 at arch/powerpc/kernel/irq.c:258 arch_local_irq_restore.part.0+0xcc/0x100
>   Modules linked in:
>   CPU: 72 PID: 30150 Comm: ftracetest Not tainted 5.5.0-rc2-gcc9x-g7e0165b2f1a9 #1
>   NIP:  c00000000001d83c LR: c00000000029ab90 CTR: c00000000026cf90
>   REGS: c0000007eee3b960 TRAP: 0700   Not tainted  (5.5.0-rc2-gcc9x-g7e0165b2f1a9)
>   MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 22242844  XER: 20000000
>   CFAR: c00000000001d780 IRQMASK: 0
>   ...
>   NIP arch_local_irq_restore.part.0+0xcc/0x100
>   LR  trace_graph_entry+0x270/0x340
>   Call Trace:
>     trace_graph_entry+0x254/0x340 (unreliable)
>     function_graph_enter+0xe4/0x1a0
>     prepare_ftrace_return+0xa0/0x130
>     ftrace_graph_caller+0x44/0x94	# (get_slice_psize())
>     slb_allocate_user+0x7c/0x100
>     do_slb_fault+0xf8/0x300
>     instruction_access_slb_common+0x140/0x180
> 
> Fixes: 48e7b7695745 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/91a063c956084fb21cf2523bce6892514e3f1799

cheers
