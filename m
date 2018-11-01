Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D466C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:51:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F1D2081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 12:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F1D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m4pD665xzF3KK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 23:51:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m4hr1FX5zF3Ln
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 23:46:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42m4hr04qlzB4XQ; Thu,  1 Nov 2018 23:46:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a95ecac5cb2fc8a8ee606991384d33ee121df00c
In-Reply-To: <20181023080456.2558-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Joel Stanley <joel@jms.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: selftests/powerpc: Relax L1d miss targets for rfi_flush test
Message-Id: <42m4hr04qlzB4XQ@ozlabs.org>
Date: Thu,  1 Nov 2018 23:46:51 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-23 at 08:04:56 UTC, "Naveen N. Rao" wrote:
> When running the rfi_flush test, if the system is loaded, we see two
> issues:
> 1. The L1d misses when rfi_flush is disabled increase significantly due
> to other workloads interfering with the cache.
> 2. The L1d misses when rfi_flush is enabled sometimes goes slightly
> below the expected number of misses.
> 
> To address these, let's relax the expected number of L1d misses:
> 1. When rfi_flush is disabled, we allow upto half the expected number of
> the misses for when rfi_flush is enabled.
> 2. When rfi_flush is enabled, we allow ~1% lower number of cache misses.
> 
> Reported-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Tested-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a95ecac5cb2fc8a8ee606991384d33

cheers
