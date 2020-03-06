Return-Path: <SRS0=OxMP=4X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59174C3F2D2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 00:15:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB3C20801
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 00:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB3C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48YSmd2r9KzDqsb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2020 11:14:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48YSj26F80zDqhY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2020 11:11:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48YSj25gZZz9sRR; Fri,  6 Mar 2020 11:11:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48YSj254WTz9sSR; Fri,  6 Mar 2020 11:11:50 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 59bee45b9712c759ea4d3dcc4eff1752f3a66558
In-Reply-To: <20200303235708.26004-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/mm: Fix missing KUAP disable in
 flush_coherent_icache()
Message-Id: <48YSj254WTz9sSR@ozlabs.org>
Date: Fri,  6 Mar 2020 11:11:50 +1100 (AEDT)
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

On Tue, 2020-03-03 at 23:57:08 UTC, Michael Ellerman wrote:
> We received a report of strange kernel faults which turned out to be
> due to a missing KUAP disable in flush_coherent_icache() called
> from flush_icache_range().
> 
> The fault looks like:
> 
>   Kernel attempted to access user page (7fffc30d9c00) - exploit attempt? (uid: 1009)
>   BUG: Unable to handle kernel data access on read at 0x7fffc30d9c00
>   Faulting instruction address: 0xc00000000007232c
>   Oops: Kernel access of bad area, sig: 11 [#1]
>   LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>   CPU: 35 PID: 5886 Comm: sigtramp Not tainted 5.6.0-rc2-gcc-8.2.0-00003-gfc37a1632d40 #79
>   NIP:  c00000000007232c LR: c00000000003b7fc CTR: 0000000000000000
>   REGS: c000001e11093940 TRAP: 0300   Not tainted  (5.6.0-rc2-gcc-8.2.0-00003-gfc37a1632d40)
>   MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28000884  XER: 00000000
>   CFAR: c0000000000722fc DAR: 00007fffc30d9c00 DSISR: 08000000 IRQMASK: 0
>   GPR00: c00000000003b7fc c000001e11093bd0 c0000000023ac200 00007fffc30d9c00
>   GPR04: 00007fffc30d9c18 0000000000000000 c000001e11093bd4 0000000000000000
>   GPR08: 0000000000000000 0000000000000001 0000000000000000 c000001e1104ed80
>   GPR12: 0000000000000000 c000001fff6ab380 c0000000016be2d0 4000000000000000
>   GPR16: c000000000000000 bfffffffffffffff 0000000000000000 0000000000000000
>   GPR20: 00007fffc30d9c00 00007fffc30d8f58 00007fffc30d9c18 00007fffc30d9c20
>   GPR24: 00007fffc30d9c18 0000000000000000 c000001e11093d90 c000001e1104ed80
>   GPR28: c000001e11093e90 0000000000000000 c0000000023d9d18 00007fffc30d9c00
>   NIP flush_icache_range+0x5c/0x80
>   LR  handle_rt_signal64+0x95c/0xc2c
>   Call Trace:
>     0xc000001e11093d90 (unreliable)
>     handle_rt_signal64+0x93c/0xc2c
>     do_notify_resume+0x310/0x430
>     ret_from_except_lite+0x70/0x74
>   Instruction dump:
>   409e002c 7c0802a6 3c62ff31 3863f6a0 f8010080 48195fed 60000000 48fe4c8d
>   60000000 e8010080 7c0803a6 7c0004ac <7c00ffac> 7c0004ac 4c00012c 38210070
> 
> This path through handle_rt_signal64() to setup_trampoline() and
> flush_icache_range() is only triggered by 64-bit processes that have
> unmapped their VDSO, which is rare.
> 
> flush_icache_range() takes a range of addresses to flush. In
> flush_coherent_icache() we implement an optimisation for CPUs where we
> know we don't actually have to flush the whole range, we just need to
> do a single icbi.
> 
> However we still execute the icbi on the user address of the start of
> the range we're flushing. On CPUs that also implement KUAP (Power9)
> that leads to the spurious fault above.
> 
> We should be able to pass any address, including a kernel address, to
> the icbi on these CPUs, which would avoid any interaction with KUAP.
> But I don't want to make that change in a bug fix, just in case it
> surfaces some strange behaviour on some CPU.
> 
> So for now just disable KUAP around the icbi. Note the icbi is treated
> as a load, so we allow read access, not write as you'd expect.
> 
> Fixes: 890274c2dc4c ("powerpc/64s: Implement KUAP for Radix MMU")
> Cc: stable@vger.kernel.org # v5.2+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/59bee45b9712c759ea4d3dcc4eff1752f3a66558

cheers
