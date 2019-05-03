Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31AC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:06:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6BB205F4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 07:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6BB205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wNTt5NlhzDqQB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 17:06:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wNK64wLyzDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 16:59:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44wNK649xcz9sD4; Fri,  3 May 2019 16:59:06 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 83e367f9ad18d42a1883ee29f20608a2b93e1071
X-Patchwork-Hint: ignore
In-Reply-To: <1547744514-7276-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] Selftests/powerpc: Add a signal fuzzer selftest
Message-Id: <44wNK649xcz9sD4@ozlabs.org>
Date: Fri,  3 May 2019 16:59:06 +1000 (AEST)
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

On Thu, 2019-01-17 at 17:01:54 UTC, Breno Leitao wrote:
> This is a new selftest that raises SIGUSR1 signals and handles it in a set
> of different ways, trying to create different scenario for testing
> purpose.
> 
> This test works raising a signal and calling sigreturn interleaved with
> TM operations, as starting, suspending and terminating a transaction. The
> test depends on random numbers, and, based on them, it sets different TM
> states.
> 
> Other than that, the test fills out the user context struct that is passed
> to the sigreturn system call with random data, in order to make sure that
> the signal handler syscall can handle different and invalid states
> properly.
> 
> This selftest has command line parameters to control what kind of tests the
> user wants to run, as for example, if a transaction should be started prior
> to signal being raised, or, after the signal being raised and before the
> sigreturn. If no parameter is given, the default is enabling all options.
> 
> This test does not check if the user context is being read and set
> properly by the kernel. Its purpose, at this time, is basically
> guaranteeing that the kernel does not crash on invalid scenarios.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/83e367f9ad18d42a1883ee29f20608a2

cheers
