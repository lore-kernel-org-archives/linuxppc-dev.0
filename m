Return-Path: <SRS0=xcTM=U5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CCC5B57E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:57:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A6520449
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 08:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A6520449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45c4Bp0Sb6zDr6c
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Jun 2019 18:57:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45c3ly0B7rzDqLc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2019 18:37:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45c3lx4g6Kz9sNt; Sun, 30 Jun 2019 18:37:33 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 869537709ebf1dc865e75c3fc97b23f8acf37c16
X-Patchwork-Hint: ignore
In-Reply-To: <20190620014651.7645-2-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 2/3] KVM: PPC: Book3S HV: Signed extend decrementer value
 if not using large decr
Message-Id: <45c3lx4g6Kz9sNt@ozlabs.org>
Date: Sun, 30 Jun 2019 18:37:33 +1000 (AEST)
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
Cc: clg@kaod.org, kvm-ppc@vger.kernel.org, sjitindarsingh@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-06-20 at 01:46:50 UTC, Suraj Jitindar Singh wrote:
> On POWER9 the decrementer can operate in large decrementer mode where
> the decrementer is 56 bits and signed extended to 64 bits. When not
> operating in this mode the decrementer behaves as a 32 bit decrementer
> which is NOT signed extended (as on POWER8).
> 
> Currently when reading a guest decrementer value we don't take into
> account whether the large decrementer is enabled or not, and this means
> the value will be incorrect when the guest is not using the large
> decrementer. Fix this by sign extending the value read when the guest
> isn't using the large decrementer.
> 
> Fixes: 95a6432ce903 "KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests"
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/869537709ebf1dc865e75c3fc97b23f8acf37c16

cheers
