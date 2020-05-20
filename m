Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:22:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576CA20758
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576CA20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Rr2B31WdzDqQl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 21:22:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RqXP0cVBzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 21:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49RqXL3Y3Gz9sTn; Wed, 20 May 2020 21:00:02 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49RqXK73hHz9sTd; Wed, 20 May 2020 21:00:01 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200428123130.73078-1-mpe@ellerman.id.au>
References: <20200428123130.73078-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Don't initialise init_task->thread.regs
Message-Id: <158997213898.943180.17083666326738032852.b4-ty@ellerman.id.au>
Date: Wed, 20 May 2020 21:00:01 +1000 (AEST)
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
Cc: aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 28 Apr 2020 22:31:30 +1000, Michael Ellerman wrote:
> Aneesh increased the size of struct pt_regs by 16 bytes and started
> seeing this WARN_ON:
> 
>   smp: Bringing up secondary CPUs ...
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 0 at arch/powerpc/kernel/process.c:455 giveup_all+0xb4/0x110
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc2-gcc-8.2.0-1.g8f6a41f-default+ #318
>   NIP:  c00000000001a2b4 LR: c00000000001a29c CTR: c0000000031d0000
>   REGS: c0000000026d3980 TRAP: 0700   Not tainted  (5.7.0-rc2-gcc-8.2.0-1.g8f6a41f-default+)
>   MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 48048224  XER: 00000000
>   CFAR: c000000000019cc8 IRQMASK: 1
>   GPR00: c00000000001a264 c0000000026d3c20 c0000000026d7200 800000000280b033
>   GPR04: 0000000000000001 0000000000000000 0000000000000077 30206d7372203164
>   GPR08: 0000000000002000 0000000002002000 800000000280b033 3230303030303030
>   GPR12: 0000000000008800 c0000000031d0000 0000000000800050 0000000002000066
>   GPR16: 000000000309a1a0 000000000309a4b0 000000000309a2d8 000000000309a890
>   GPR20: 00000000030d0098 c00000000264da40 00000000fd620000 c0000000ff798080
>   GPR24: c00000000264edf0 c0000001007469f0 00000000fd620000 c0000000020e5e90
>   GPR28: c00000000264edf0 c00000000264d200 000000001db60000 c00000000264d200
>   NIP [c00000000001a2b4] giveup_all+0xb4/0x110
>   LR [c00000000001a29c] giveup_all+0x9c/0x110
>   Call Trace:
>   [c0000000026d3c20] [c00000000001a264] giveup_all+0x64/0x110 (unreliable)
>   [c0000000026d3c90] [c00000000001ae34] __switch_to+0x104/0x480
>   [c0000000026d3cf0] [c000000000e0b8a0] __schedule+0x320/0x970
>   [c0000000026d3dd0] [c000000000e0c518] schedule_idle+0x38/0x70
>   [c0000000026d3df0] [c00000000019c7c8] do_idle+0x248/0x3f0
>   [c0000000026d3e70] [c00000000019cbb8] cpu_startup_entry+0x38/0x40
>   [c0000000026d3ea0] [c000000000011bb0] rest_init+0xe0/0xf8
>   [c0000000026d3ed0] [c000000002004820] start_kernel+0x990/0x9e0
>   [c0000000026d3f90] [c00000000000c49c] start_here_common+0x1c/0x400
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Don't initialise init_task->thread.regs
      https://git.kernel.org/powerpc/c/7ffa8b7dc11752827329e4e84a574ea6aaf24716

cheers
