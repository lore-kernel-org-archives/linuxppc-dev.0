Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391FCC5B57E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:41:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7762070D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7762070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45c3r23QPNzDqHd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 18:41:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45c3lh5fG3zDqLc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2019 18:37:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45c3lh4zYrz9sCJ; Sun, 30 Jun 2019 18:37:20 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 348ea30f51fc63ce3c7fd7dba6043e8e3ee0ef34
X-Patchwork-Hint: ignore
In-Reply-To: <20190528232801.7413-1-nathanl@linux.ibm.com>
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: avoid blocking in irq when queuing
 hotplug events
Message-Id: <45c3lh4zYrz9sCJ@ozlabs.org>
Date: Sun, 30 Jun 2019 18:37:20 +1000 (AEST)
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

On Tue, 2019-05-28 at 23:28:01 UTC, Nathan Lynch wrote:
> A couple of bugs in queue_hotplug_event():
> 
> 1. Unchecked kmalloc result which could lead to an oops.
> 2. Use of GFP_KERNEL allocations in interrupt context (this code's
>    only caller is ras_hotplug_interrupt()).
> 
> Use kmemdup to avoid open-coding the allocation+copy and check for
> failure; use GFP_ATOMIC for both allocations.
> 
> Ultimately it probably would be better to avoid or reduce allocations
> in this path if possible.
> 
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/348ea30f51fc63ce3c7fd7dba6043e8e3ee0ef34

cheers
