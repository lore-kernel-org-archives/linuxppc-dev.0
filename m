Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469DEC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:51:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E602064A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E602064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fRtt0TDHzDqN9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 00:51:34 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fRrx5pyrzDqMx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 00:49:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44fRrx4BVsz9s70; Thu, 11 Apr 2019 00:49:53 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7100e8704b61247649c50551b965e71d168df30b
X-Patchwork-Hint: ignore
In-Reply-To: <20190329074257.14428-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s/radix: Fix radix segment exception handling
Message-Id: <44fRrx4BVsz9s70@ozlabs.org>
Date: Thu, 11 Apr 2019 00:49:53 +1000 (AEST)
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-03-29 at 07:42:57 UTC, Nicholas Piggin wrote:
> Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> broke the radix-mode segment exception handler. In radix mode, this is
> exception is not an SLB miss, rather it signals that the EA is outside
> the range translated by any page table.
> 
> The commit lost the radix feature alternate code patch, which can
> cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!
> 
> The original radix code would send faults to slb_miss_large_addr,
> which would end up faulting due to slb_addr_limit being 0. This patch
> sends radix directly to do_bad_slb_fault, which is a bit clearer.
> 
> Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7100e8704b61247649c50551b965e71d

cheers
