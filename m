Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D5EC43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:13:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB2D2073E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB2D2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p3mx6BKmzDqrs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 23:13:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p3cK6d3YzDqch
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 23:06:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48p3cK08fPz9sRN; Thu, 26 Mar 2020 23:06:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 0f8f554e5244f56f496b4ce30ada1126fe290345
In-Reply-To: <20200211033831.11165-3-gustavold@linux.ibm.com>
To: Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] selftests/powerpc: Don't rely on segfault to rerun
 the test
Message-Id: <48p3cK08fPz9sRN@ozlabs.org>
Date: Thu, 26 Mar 2020 23:06:24 +1100 (AEDT)
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
Cc: mikey@neuling.org, gromero@linux.ibm.com,
 Gustavo Luiz Duarte <gustavold@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-02-11 at 03:38:31 UTC, Gustavo Luiz Duarte wrote:
> The test case tm-signal-context-force-tm expects a segfault to happen on
> returning from signal handler, and then does a setcontext() to run the test
> again. However, the test doesn't always segfault, causing the test to run a
> single time.
> 
> This patch fixes the test by putting it within a loop and jumping, via
> setcontext, just prior to the loop in case it segfaults. This way we get the
> desired behavior (run the test COUNT_MAX times) regardless if it segfaults or
> not. This also reduces the use of setcontext for control flow logic, keeping it
> only in the segfault handler.
> 
> Also, since 'count' is changed within the signal handler, it is declared as
> volatile to prevent any compiler optimization getting confused with
> asynchronous changes.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f8f554e5244f56f496b4ce30ada1126fe290345

cheers
