Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A9C7112A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:47:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7AC20842
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7AC20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQt03Xq9zF39J
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:47:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPrC3NC8zF35x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YPrB5Y38z9sjH; Mon, 15 Oct 2018 15:01:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPrB3CMKzB2xZ; Mon, 15 Oct 2018 15:01:14 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 48e7b76957457f9a6f086ca2bbe49ec1ffd75f84
In-Reply-To: <20181013131836.26764-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/6] powerpc/64s/hash: Convert SLB miss handlers to C
Message-Id: <42YPrB3CMKzB2xZ@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:14 +1100 (AEDT)
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
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2018-10-13 at 13:18:31 UTC, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> This patch moves SLB miss handlers completely to C, using the standard
> exception handler macros to set up the stack and branch to C.
> 
> This can be done because the segment containing the kernel stack is
> always bolted, so accessing it with relocation on will not cause an
> SLB exception.
> 
> Arbitrary kernel memory must not be accessed when handling kernel
> space SLB misses, so care should be taken there. However user SLB
> misses can access any kernel memory, which can be used to move some
> fields out of the paca (in later patches).
> 
> User SLB misses could quite easily reconcile IRQs and set up a first
> class kernel environment and exit via ret_from_except, however that
> doesn't seem to be necessary at the moment, so we only do that if a
> bad fault is encountered.
> 
> [ Credit to Aneesh for bug fixes, error checks, and improvements to
>   bad address handling, etc ]
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Disallow tracing for all of slb.c for now.]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/48e7b76957457f9a6f086ca2bbe49e

cheers
