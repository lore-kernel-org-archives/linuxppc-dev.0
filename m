Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17397C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:46:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A777B205C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A777B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQqq2yshzF3Cb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:45:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPrB5tbVzF2Dx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YPrB3G7gzB2xk; Mon, 15 Oct 2018 15:01:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPrB1H6nz9sj2; Mon, 15 Oct 2018 15:01:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 002af9391bfbe84f8e491bb10bd9c6001a6becee
In-Reply-To: <20181013105646.5147-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: Split user/kernel definitions of struct pt_regs
Message-Id: <42YPrB1H6nz9sj2@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:13 +1100 (AEDT)
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

On Sat, 2018-10-13 at 10:56:44 UTC, Michael Ellerman wrote:
> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
> That means the layout of the structure is ABI, ie. we can't change it.
> 
> That would be fine if it was only used to describe the user-visible
> register state of a process, but it's also the struct we use in the
> kernel to describe the registers saved in an interrupt frame.
> 
> We'd like more flexibility in the content (and possibly layout) of the
> kernel version of the struct, but currently that's not possible.
> 
> So split the definition into a user-visible definition which remains
> unchanged, and a kernel internal one.
> 
> At the moment they're still identical, and we check that at build
> time. That's because we have code (in ptrace etc.) that assumes that
> they are the same. We will fix that code in future patches, and then
> we can break the strict symmetry between the two structs.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/002af9391bfbe84f8e491bb10bd9c6

cheers
