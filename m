Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B5C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:35:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743B52086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743B52086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433zDH4P5SzDqjZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433yws61yhzDqdl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 20:22:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 433yws366jz9s9G; Tue, 27 Nov 2018 20:22:21 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5249497a7bb6334fcc128588d6a7e1e21786515a
In-Reply-To: <1540996702-27161-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,1/3] selftests/powerpc: Allocate base registers
Message-Id: <433yws366jz9s9G@ozlabs.org>
Date: Tue, 27 Nov 2018 20:22:21 +1100 (AEDT)
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

On Wed, 2018-10-31 at 14:38:20 UTC, Breno Leitao wrote:
> Some ptrace selftests are passing input operands using a constraint that
> can allocate any register for the operand, and using these registers on
> load/store operations.
> 
> If the register allocated by the compiler happens to be zero (r0), it might
> cause an invalid memory address access, since load and store operations
> consider the content of 0x0 address if the base register is r0, instead of
> the content of the r0 register. For example:
> 
> 	r1 := 0xdeadbeef
> 	r0 := 0xdeadbeef
> 
> 	ld r2, 0(1) /* will load into r2 the content of r1 address */
> 	ld r2, 0(0) /* will load into r2 the content of 0x0 */
> 
> In order to avoid this possible problem, the inline assembly constraint
> should be aware that these registers will be used as a base register, thus,
> r0 should not be allocated.
> 
> Other than that, this patch removes inline assembly operands that are not
> used by the tests.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5249497a7bb6334fcc128588d6a7e1

cheers
