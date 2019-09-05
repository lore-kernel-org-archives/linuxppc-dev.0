Return-Path: <SRS0=2H2D=XA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C141C3A5A5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 12:11:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E6221848
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 12:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E6221848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46PKKr41FyzDr5N
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2019 22:11:28 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46PKCC6D1fzDqgS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2019 22:05:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46PKCC0HSGz9sP7; Thu,  5 Sep 2019 22:05:42 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a8318c13e79badb92bc6640704a64cc022a6eb97
In-Reply-To: <20190904045529.23002-2-gromero@linux.vnet.ibm.com>
To: gromero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mikey@neuling.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v2 2/3] powerpc/tm: Fix restoring FP/VMX facility
 incorrectly on interrupts
Message-Id: <46PKCC0HSGz9sP7@ozlabs.org>
Date: Thu,  5 Sep 2019 22:05:42 +1000 (AEST)
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
Cc: cyrilbur@gmail.com, gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-09-04 at 04:55:28 UTC, gromero wrote:
> From: Gustavo Romero <gromero@linux.ibm.com>
> 
> When in userspace and MSR FP=0 the hardware FP state is unrelated to
> the current process. This is extended for transactions where if tbegin
> is run with FP=0, the hardware checkpoint FP state will also be
> unrelated to the current process. Due to this, we need to ensure this
> hardware checkpoint is updated with the correct state before we enable
> FP for this process.
...
> 
> This fixes CVE-2019-15031.
> 
> Fixes: a7771176b439 ("powerpc: Don't enable FP/Altivec if not checkpointed")
> Cc: stable@vger.kernel.org # 4.15+
> Signed-off-by: Gustavo Romero <gromero@linux.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a8318c13e79badb92bc6640704a64cc022a6eb97

cheers
