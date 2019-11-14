Return-Path: <SRS0=fdF7=ZG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0140C432C3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:39:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8BD20709
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 09:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8BD20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DGdh5rl2zF7bf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 20:39:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFxm2DfPzF5JP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 20:07:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47DFxh45YSz9sRd; Thu, 14 Nov 2019 20:07:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: de84ffc3ccbeec3678f95a3d898fc188efa0d9c5
In-Reply-To: <43817cb6e6631b0828b9a6e266f60d1f8ca8eb22.1571288375.git.sbobroff@linux.ibm.com>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc/eeh: differentiate duplicate detection message
Message-Id: <47DFxh45YSz9sRd@ozlabs.org>
Date: Thu, 14 Nov 2019 20:07:52 +1100 (AEDT)
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

On Thu, 2019-10-17 at 04:59:37 UTC, Sam Bobroff wrote:
> Currently when an EEH error is detected, the system log receives the
> same (or almost the same) message twice:
> 
> EEH: PHB#0 failure detected, location: N/A
> EEH: PHB#0 failure detected, location: N/A
> or
> EEH: eeh_dev_check_failure: Frozen PHB#0-PE#0 detected
> EEH: Frozen PHB#0-PE#0 detected
> 
> This looks like a bug, but in fact the messages are from different
> functions and mean slightly different things.  So keep both but change
> one of the messages slightly, so that it's clear they are different:
> 
> EEH: PHB#0 failure detected, location: N/A
> EEH: Recovering PHB#0, location: N/A
> or
> EEH: eeh_dev_check_failure: Frozen PHB#0-PE#0 detected
> EEH: Recovering PHB#0-PE#0
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de84ffc3ccbeec3678f95a3d898fc188efa0d9c5

cheers
