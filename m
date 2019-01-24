Return-Path: <SRS0=rclJ=QA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271AC282C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:45:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B58CE207E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58CE207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lSjw3mKVzDqH4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 14:45:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lSbL5G5ZzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 14:40:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43lSbL46kkz9sBn; Thu, 24 Jan 2019 14:40:14 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a65329aa7d613288626275546074f1aae5a04965
X-Patchwork-Hint: ignore
In-Reply-To: <1546947081-18969-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v4] selftests/powerpc: New TM signal self test
Message-Id: <43lSbL46kkz9sBn@ozlabs.org>
Date: Thu, 24 Jan 2019 14:40:14 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-08 at 11:31:21 UTC, Breno Leitao wrote:
> A new self test that forces MSR[TS] to be set without calling any TM
> instruction. This test also tries to cause a page fault at a signal
> handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
> thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
> when tm_recheckpoint() is called.
> 
> This test is not deterministic, since it is hard to guarantee that the page
> access will cause a page fault. In order to force more page faults at
> signal context, the signal handler and the ucontext are being mapped into a
> MADV_DONTNEED memory chunks.
> 
> Tests have shown that the bug could be exposed with few interactions in a
> buggy kernel. This test is configured to loop 5000x, having a good chance
> to hit the kernel issue in just one run.  This self test takes less than
> two seconds to run.
> 
> This test uses set/getcontext because the kernel will recheckpoint
> zeroed structures, causing the test to segfault, which is undesired because
> the test needs to rerun, so, there is a signal handler for SIGSEGV which
> will restart the test.
> 
> v2: Uses the MADV_DONTNEED memory advice
> v3: Fix memcpy and 32-bits compilation
> v4: Does not define unused macros
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a65329aa7d613288626275546074f1aa

cheers
