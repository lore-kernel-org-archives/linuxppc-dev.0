Return-Path: <SRS0=ax18=7C=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7826AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:19:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3449207D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 11:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3449207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Rqy93thvzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2020 21:18:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49RqXP0CWqzDqf3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2020 21:00:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49RqXK70CMz9sV9; Wed, 20 May 2020 21:00:01 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49RqXJ5jNmz9sV6; Wed, 20 May 2020 21:00:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200423060038.3308530-1-mpe@ellerman.id.au>
References: <20200423060038.3308530-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] drivers/macintosh: Fix memleak in windfarm_pm112 driver
Message-Id: <158997214040.943180.7832790296838075092.b4-ty@ellerman.id.au>
Date: Wed, 20 May 2020 21:00:00 +1000 (AEST)
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
Cc: erhard_f@mailbox.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 23 Apr 2020 16:00:38 +1000, Michael Ellerman wrote:
> create_cpu_loop() calls smu_sat_get_sdb_partition() which does
> kmalloc() and returns the allocated buffer. In fact it's called twice,
> and neither buffer is freed.
> 
> This results in a memory leak as reported by Erhard:
>   unreferenced object 0xc00000047081f840 (size 32):
>     comm "kwindfarm", pid 203, jiffies 4294880630 (age 5552.877s)
>     hex dump (first 32 bytes):
>       c8 06 02 7f ff 02 ff 01 fb bf 00 41 00 20 00 00  ...........A. ..
>       00 07 89 37 00 a0 00 00 00 00 00 00 00 00 00 00  ...7............
>     backtrace:
>       [<0000000083f0a65c>] .smu_sat_get_sdb_partition+0xc4/0x2d0 [windfarm_smu_sat]
>       [<000000003010fcb7>] .pm112_wf_notify+0x104c/0x13bc [windfarm_pm112]
>       [<00000000b958b2dd>] .notifier_call_chain+0xa8/0x180
>       [<0000000070490868>] .blocking_notifier_call_chain+0x64/0x90
>       [<00000000131d8149>] .wf_thread_func+0x114/0x1a0
>       [<000000000d54838d>] .kthread+0x13c/0x190
>       [<00000000669b72bc>] .ret_from_kernel_thread+0x58/0x64
>   unreferenced object 0xc0000004737089f0 (size 16):
>     comm "kwindfarm", pid 203, jiffies 4294880879 (age 5552.050s)
>     hex dump (first 16 bytes):
>       c4 04 01 7f 22 11 e0 e6 ff 55 7b 12 ec 11 00 00  ...."....U{.....
>     backtrace:
>       [<0000000083f0a65c>] .smu_sat_get_sdb_partition+0xc4/0x2d0 [windfarm_smu_sat]
>       [<00000000b94ef7e1>] .pm112_wf_notify+0x1294/0x13bc [windfarm_pm112]
>       [<00000000b958b2dd>] .notifier_call_chain+0xa8/0x180
>       [<0000000070490868>] .blocking_notifier_call_chain+0x64/0x90
>       [<00000000131d8149>] .wf_thread_func+0x114/0x1a0
>       [<000000000d54838d>] .kthread+0x13c/0x190
>       [<00000000669b72bc>] .ret_from_kernel_thread+0x58/0x64
> 
> [...]

Applied to powerpc/next.

[1/1] drivers/macintosh: Fix memleak in windfarm_pm112 driver
      https://git.kernel.org/powerpc/c/93900337b9ac2f4eca427eff6d187be2dc3b5551

cheers
