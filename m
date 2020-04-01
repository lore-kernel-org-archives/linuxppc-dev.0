Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6CFC43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:32:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1944E2073B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 13:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1944E2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48snDl59WRzDr8R
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 00:32:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48smMl57f4zDr24
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 23:53:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48smMl3sfDz9sTT; Wed,  1 Apr 2020 23:53:22 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b1a504a6500df50e83b701b7946b34fce27ad8a3
In-Reply-To: <20200306150143.5551-2-clg@kaod.org>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc/xive: Use XIVE_BAD_IRQ instead of zero to
 catch non configured IPIs
Message-Id: <48smMl3sfDz9sTT@ozlabs.org>
Date: Wed,  1 Apr 2020 23:53:22 +1100 (AEDT)
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>,
 stable@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-03-06 at 15:01:40 UTC, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= wrote:
> When a CPU is brought up, an IPI number is allocated and recorded
> under the XIVE CPU structure. Invalid IPI numbers are tracked with
> interrupt number 0x0.
> 
> On the PowerNV platform, the interrupt number space starts at 0x10 and
> this works fine. However, on the sPAPR platform, it is possible to
> allocate the interrupt number 0x0 and this raises an issue when CPU 0
> is unplugged. The XIVE spapr driver tracks allocated interrupt numbers
> in a bitmask and it is not correctly updated when interrupt number 0x0
> is freed. It stays allocated and it is then impossible to reallocate.
> 
> Fix by using the XIVE_BAD_IRQ value instead of zero on both platforms.
> 
> Reported-by: David Gibson <david@gibson.dropbear.id.au>
> Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
> Cc: stable@vger.kernel.org # v4.14+
> Signed-off-by: Cédric Le Goater <clg@kaod.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b1a504a6500df50e83b701b7946b34fce27ad8a3

cheers
