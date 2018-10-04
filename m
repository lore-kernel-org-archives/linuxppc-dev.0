Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7536EC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:34:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18595213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 06:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18595213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qjlg1bfVzF3BM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 16:34:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QjKB4b2XzF39S
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 16:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42QjKB2KHkz9sj9; Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 16d7c69c898531210d13dbd1eb2053759ff0946d
In-Reply-To: <1537461907-32003-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/3] powerpc: Redefine TIF_32BITS thread flag
Message-Id: <42QjKB2KHkz9sj9@ozlabs.org>
Date: Thu,  4 Oct 2018 16:14:37 +1000 (AEST)
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
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-09-20 at 16:45:05 UTC, Breno Leitao wrote:
> Moving TIF_32BIT to use bit 20 instead of 4 in the task flag field.
> 
> This change is making room for an upcoming new task macro
> (_TIF_SYSCALL_EMU) which is preferred to set a bit in the lower 16-bits
> part of the word.
> 
> This upcoming flag macro will take part in a composed macro
> (_TIF_SYSCALL_DOTRACE) which will contain other flags as well, and it is
> preferred that the whole _TIF_SYSCALL_DOTRACE macro only sets the lower 16
> bits of a word, so, it could be handled using immediate operations (as load
> immediate, add immediate, ...) where the immediate operand (SI) is limited
> to 16-bits.
> 
> Another possible solution would be using the LOAD_REG_IMMEDIATE() macro
> to load a full 64-bits word immediate, but it takes 5 operations instead of
> one.
> 
> Having TIF_32BITS being redefined to use an upper bit is not a problem
> since there is only one place in the assembly code where TIF_32BIT is being
> used, and it could be replaced with an operation with right shift (addis),
> since it is used alone, i.e. not being part of a composed macro, which has
> different bits set, and would require LOAD_REG_IMMEDIATE().
> 
> Tested on a 64 bits Big Endian machine running a 32 bits task.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/16d7c69c898531210d13dbd1eb2053

cheers
