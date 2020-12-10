Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCFCC433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:13:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E24F23C81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 12:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E24F23C81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsCVR1dMMzDqjv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 23:13:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsBXP35mrzDqc4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 22:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CsBXP1jR2z9sWm; Thu, 10 Dec 2020 22:29:40 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1606185640-1720-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1606185640-1720-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/perf: Fix crash with is_sier_available when
 pmu is not set
Message-Id: <160756604692.1313423.3777572085113094181.b4-ty@ellerman.id.au>
Date: Thu, 10 Dec 2020 22:29:40 +1100 (AEDT)
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
Cc: sachinp@linux.vnet.ibm.com, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 23 Nov 2020 21:40:40 -0500, Athira Rajeev wrote:
> On systems without any specific PMU driver support registered, running
> 'perf record' with —intr-regs  will crash ( perf record -I <workload> ).
> 
> The relevant portion from crash logs and Call Trace:
> 
> Unable to handle kernel paging request for data at address 0x00000068
> Faulting instruction address: 0xc00000000013eb18
> Oops: Kernel access of bad area, sig: 11 [#1]
> CPU: 2 PID: 13435 Comm: kill Kdump: loaded Not tainted 4.18.0-193.el8.ppc64le #1
> NIP:  c00000000013eb18 LR: c000000000139f2c CTR: c000000000393d80
> REGS: c0000004a07ab4f0 TRAP: 0300   Not tainted  (4.18.0-193.el8.ppc64le)
> NIP [c00000000013eb18] is_sier_available+0x18/0x30
> LR [c000000000139f2c] perf_reg_value+0x6c/0xb0
> Call Trace:
> [c0000004a07ab770] [c0000004a07ab7c8] 0xc0000004a07ab7c8 (unreliable)
> [c0000004a07ab7a0] [c0000000003aa77c] perf_output_sample+0x60c/0xac0
> [c0000004a07ab840] [c0000000003ab3f0] perf_event_output_forward+0x70/0xb0
> [c0000004a07ab8c0] [c00000000039e208] __perf_event_overflow+0x88/0x1a0
> [c0000004a07ab910] [c00000000039e42c] perf_swevent_hrtimer+0x10c/0x1d0
> [c0000004a07abc50] [c000000000228b9c] __hrtimer_run_queues+0x17c/0x480
> [c0000004a07abcf0] [c00000000022aaf4] hrtimer_interrupt+0x144/0x520
> [c0000004a07abdd0] [c00000000002a864] timer_interrupt+0x104/0x2f0
> [c0000004a07abe30] [c0000000000091c4] decrementer_common+0x114/0x120
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Fix crash with is_sier_available when pmu is not set
      https://git.kernel.org/powerpc/c/f75e7d73bdf73f07b0701a6d21c111ef5d9021dd

cheers
