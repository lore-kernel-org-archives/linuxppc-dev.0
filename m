Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0E5C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 04:34:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67DEC214DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 04:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67DEC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JCZF28lhzDqp7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 14:34:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46JCM436SCzDqqJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 14:24:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46JCM41vrKz9sNm; Wed, 28 Aug 2019 14:24:48 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9d535e200f09ce347afc38c81ec7f2901187e5f0
In-Reply-To: <20190814205211.24840-1-gromero@linux.ibm.com>
To: Gustavo Romero <gromero@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/selftests: Fix and enhance TM signal context tests
Message-Id: <46JCM41vrKz9sNm@ozlabs.org>
Date: Wed, 28 Aug 2019 14:24:48 +1000 (AEST)
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
Cc: mikey@neuling.org, Gustavo Romero <gromero@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-08-14 at 20:52:11 UTC, Gustavo Romero wrote:
> Currently TM signal context tests for GPR, FPR, VMX, and VSX registers
> print wrong register numbers (wrongly starting from register 0 instead of
> the first register in the non-volatile subset). Besides it the output when
> a mismatch happens is poor giving not much information about which context
> and which register mismatches, because it prints both contexts at the same
> time and not a comparison between the value that mismatches and the value
> expected and, moreover, it stops printing on the first mismatch, but it's
> important to know if there are other mismatches happening beyond the first
> one.
> 
> For instance, this is the current output when a mismatch happens:
> 
> test: tm_signal_context_chk_gpr
> tags: git_version:v5.2-8249-g02e970fae465-dirty
> Failed on 0 GPR 1 or 18446744073709551615
> failure: tm_signal_context_chk_gpr
> 
> test: tm_signal_context_chk_fpu
> tags: git_version:v5.2-8248-g09c289e3ef80
> Failed on 0 FP -1 or -1
> failure: tm_signal_context_chk_fpu
> 
> test: tm_signal_context_chk_vmx
> tags: git_version:v5.2-8248-g09c289e3ef80
> Failed on 0 vmx 0xfffffffffffffffefffffffdfffffffc vs 0xfffffffffffffffefffffffdfffffffc
> failure: tm_signal_context_chk_vmx
> 
> test: tm_signal_context_chk_vsx
> tags: git_version:v5.2-8248-g09c289e3ef80
> Failed on 0 vsx 0xfffffffffefffffffdfffffffcffffff vs 0xfffffffffefffffffdfffffffcffffff
> failure: tm_signal_context_chk_vsx
> 
> This commit fixes the register numbers printed and enhances the error
> output by providing a full list of mismatching registers separated by the
> context (non-speculative or speculative context), for example:
> 
> test: tm_signal_context_chk_gpr
> tags: git_version:v5.2-8249-g02e970fae465-dirty
> GPR14 (1st context) == 1 instead of -1 (expected)
> GPR15 (1st context) == 2 instead of -2 (expected)
> GPR14 (2nd context) == 0 instead of 18446744073709551615 (expected)
> GPR15 (2nd context) == 0 instead of 18446744073709551614 (expected)
> failure: tm_signal_context_chk_gpr
> 
> test: tm_signal_context_chk_fpu
> tags: git_version:v5.2-8249-g02e970fae465-dirty
> FPR14 (1st context) == -1 instead of 1 (expected)
> FPR15 (1st context) == -2 instead of 2 (expected)
> failure: tm_signal_context_chk_fpu
> 
> test: tm_signal_context_chk_vmx
> tags: git_version:v5.2-8249-g02e970fae465-dirty
> VMX20 (1st context) == 0xfffffffffffffffefffffffdfffffffc instead of 0x00000001000000020000000300000004 (expected)
> VMX21 (1st context) == 0xfffffffbfffffffafffffff9fffffff8 instead of 0x00000005000000060000000700000008 (expected)
> failure: tm_signal_context_chk_vmx
> 
> test: tm_signal_context_chk_vsx
> tags: git_version:v5.2-8249-g02e970fae465-dirty
> VSX20 (1st context) == 0xfffffffffefffffffdfffffffcffffff instead of 0x00000001000000020000000300000004 (expected)
> VSX21 (1st context) == 0xfbfffffffafffffff9fffffff8ffffff instead of 0x00000005000000060000000700000008 (expected)
> failure: tm_signal_context_chk_vsx
> 
> Finally, this commit adds comments to the tests in the hope that it will
> help people not so familiar with TM understand the tests.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d535e200f09ce347afc38c81ec7f2901187e5f0

cheers
