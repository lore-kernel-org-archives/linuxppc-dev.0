Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0CC432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:11:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4571206DC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 10:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4571206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DHM233JczF1nS
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 21:11:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFy82DBqzF5sc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:08:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47DFy74wbhz9sSX; Thu, 14 Nov 2019 20:08:15 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1ca3dec2b2dff9d286ce6cd64108bda0e98f9710
In-Reply-To: <20191031063100.3864-1-clg@kaod.org>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/xive: Prevent page fault issues in the machine
 crash handler
Message-Id: <47DFy74wbhz9sSX@ozlabs.org>
Date: Thu, 14 Nov 2019 20:08:15 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-10-31 at 06:31:00 UTC, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= wrote:
> When the machine crash handler is invoked, all interrupts are masked
> but interrupts which have not been started yet do not have an ESB page
> mapped in the Linux address space. This crashes the 'crash kexec'
> sequence on sPAPR guests.
> 
> To fix, force the mapping of the ESB page when an interrupt is being
> mapped in the Linux IRQ number space. This is done by setting the
> initial state of the interrupt to OFF which is not necessarily the
> case on PowerNV.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ca3dec2b2dff9d286ce6cd64108bda0e98f9710

cheers
