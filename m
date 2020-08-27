Return-Path: <SRS0=o3hI=CF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F87AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF5720786
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5720786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BcZpS2yL4zDq9H
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 17:57:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BcZYn2GtBzDqKw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BcZYn1Q2Mz9sTg; Thu, 27 Aug 2020 17:46:53 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BcZYn0TBxz9sTm; Thu, 27 Aug 2020 17:46:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200825093424.3967813-1-mpe@ellerman.id.au>
References: <20200825093424.3967813-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix crash in load_fp_state() due to
 fpexc_mode
Message-Id: <159851436125.52163.1623382874897078794.b4-ty@ellerman.id.au>
Date: Thu, 27 Aug 2020 17:46:52 +1000 (AEST)
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
Cc: miltonm@us.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 25 Aug 2020 19:34:24 +1000, Michael Ellerman wrote:
> The recent commit 01eb01877f33 ("powerpc/64s: Fix restore_math
> unnecessarily changing MSR") changed some of the handling of floating
> point/vector restore.
> 
> In particular it caused current->thread.fpexc_mode to be copied into
> the current MSR (via msr_check_and_set()), rather than just into
> regs->msr (which is moved into MSR on return to userspace).
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Fix crash in load_fp_state() due to fpexc_mode
      https://git.kernel.org/powerpc/c/b91eb5182405b01a8aeb42e9b5207831767e97ee

cheers
