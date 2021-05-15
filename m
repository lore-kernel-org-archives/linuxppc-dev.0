Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C9C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 22:48:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A7661283
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 22:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A7661283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FjLCt0DqYz3db6
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 May 2021 08:48:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4FjL8Y16qnz302K
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 May 2021 08:45:49 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FjL8X6DLYz9ssP; Sun, 16 May 2021 08:45:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210503111708.758261-1-npiggin@gmail.com>
References: <20210503111708.758261-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Make NMI record implicitly soft-masked code
 as irqs disabled
Message-Id: <162111863488.1890426.15623689321545527511.b4-ty@ellerman.id.au>
Date: Sun, 16 May 2021 08:43:54 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Cédric Le Goater <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 3 May 2021 21:17:08 +1000, Nicholas Piggin wrote:
> scv support introduced the notion of code that implicitly soft-masks
> irqs due to the instruction addresses. This is required because scv
> enters the kernel with MSR[EE]=1.
> 
> If a NMI (including soft-NMI) interrupt hits when we are implicitly
> soft-masked then its regs->softe does not reflect this because it is
> derived from the explicit soft mask state (paca->irq_soft_mask). This
> makes arch_irq_disabled_regs(regs) return false.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Make NMI record implicitly soft-masked code as irqs disabled
      https://git.kernel.org/powerpc/c/4ec5feec1ad029bdf7d49bc50ccc0c195eeabe93

cheers
