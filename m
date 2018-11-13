Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99AC43610
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 12:22:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6B7208E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 12:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6B7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vRZw5fSFzF3Mb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 23:22:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vRRv4YlLzF3L9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42vRRs12jfz9sBZ; Tue, 13 Nov 2018 23:16:09 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42vRRr3c9Gz9sCQ; Tue, 13 Nov 2018 23:16:06 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c8b00bb742dd036388f37d019dbb9db177f3e66c
In-Reply-To: <20181101052105.17973-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm/64s: Fix preempt warning in slb_allocate_kernel()
Message-Id: <42vRRr3c9Gz9sCQ@ozlabs.org>
Date: Tue, 13 Nov 2018 23:16:06 +1100 (AEDT)
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

On Thu, 2018-11-01 at 05:21:05 UTC, Michael Ellerman wrote:
> With preempt enabled we see warnings in do_slb_fault():
> 
>   BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u33:0/98
>   futex hash table entries: 4096 (order: 3, 524288 bytes)
>   caller is do_slb_fault+0x204/0x230
>   CPU: 5 PID: 98 Comm: kworker/u33:0 Not tainted 4.19.0-rc3-gcc-7.3.1-00022-g1936f094e164 #138
>   Call Trace:
>     dump_stack+0xb4/0x104 (unreliable)
>     check_preemption_disabled+0x148/0x150
>     do_slb_fault+0x204/0x230
>     data_access_slb_common+0x138/0x180
> 
> This is caused by the get_paca() in slb_allocate_kernel(), which
> includes a call to debug_smp_processor_id().
> 
> slb_allocate_kernel() can only be called from do_slb_fault(), and in
> that path interrupts are hard disabled and so we can't be preempted,
> but we can't update the preempt flags (in thread_info) because that
> could cause an SLB fault.
> 
> So just use local_paca which is safe and doesn't cause the warning.
> 
> Fixes: 48e7b7695745 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/c8b00bb742dd036388f37d019dbb9d

cheers
