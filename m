Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC5C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:07:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943B420693
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943B420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCjz5Ng4zDqHv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:07:19 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfX1nWmzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBfW4Hbdz9sB3; Mon, 22 Apr 2019 00:19:15 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfV60dTz9sNF; Mon, 22 Apr 2019 00:19:14 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a3f3072db6cad40895c585dce65e36aab997f042
X-Patchwork-Hint: ignore
In-Reply-To: <20190418065125.2687-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v6,01/10] powerpc/powernv/idle: Restore IAMR after idle
Message-Id: <44nBfV60dTz9sNF@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:14 +1000 (AEST)
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

On Thu, 2019-04-18 at 06:51:16 UTC, Michael Ellerman wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute
> userspace without faulting.
> 
> This is necessary when returning from any stop state that modifies
> user state, as well as hypervisor state.
> 
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
> 
>   $ echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
> 
> which won't fault, then boot the kernel with powersave=off, where it
> will fault. Applying this patch will fix this.
> 
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user space")
> Cc: stable@vger.kernel.org # v4.10+
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Reviewed-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/a3f3072db6cad40895c585dce65e36aa

cheers
