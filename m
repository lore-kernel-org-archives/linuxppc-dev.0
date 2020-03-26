Return-Path: <SRS0=iuvT=5L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65833C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:28:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB342070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB342070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48p45P2xftzDqrs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2020 23:28:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48p3cY55JwzDqsR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2020 23:06:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48p3cX5fl5z9sSK; Thu, 26 Mar 2020 23:06:36 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48p3cX2lj3z9sRN; Thu, 26 Mar 2020 23:06:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a0968a025c04702427a4aee2c618f451a5098cd8
In-Reply-To: <20200304110402.6038-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Add a test of sigreturn vs VDSO
Message-Id: <48p3cX2lj3z9sRN@ozlabs.org>
Date: Thu, 26 Mar 2020 23:06:35 +1100 (AEDT)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-03-04 at 11:04:02 UTC, Michael Ellerman wrote:
> There's two different paths through the sigreturn code, depending on
> whether the VDSO is mapped or not. We recently discovered a bug in the
> unmapped case, because it's not commonly used these days.
> 
> So add a test that sends itself a signal, then moves the VDSO, takes
> another signal and finally unmaps the VDSO before sending itself
> another signal. That tests the standard signal path, the code that
> handles the VDSO being moved, and also the signal path in the case
> where the VDSO is unmapped.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/a0968a025c04702427a4aee2c618f451a5098cd8

cheers
