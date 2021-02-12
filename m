Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDCDC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:45:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760A464DDA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 00:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760A464DDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcFCB24W2zDx1L
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 11:45:10 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcDfC44LDzDwnQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 11:20:03 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DcDfB6vBdz9sVy; Fri, 12 Feb 2021 11:20:02 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210208063406.331655-1-npiggin@gmail.com>
References: <20210208063406.331655-1-npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Remove EXSLB interrupt save area
Message-Id: <161308903986.3606979.1147645719599134830.b4-ty@ellerman.id.au>
Date: Fri, 12 Feb 2021 11:20:02 +1100 (AEDT)
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

On Mon, 8 Feb 2021 16:34:06 +1000, Nicholas Piggin wrote:
> SLB faults should not be taken while the PACA save areas are live, all
> memory accesses should be fetches from the kernel text, and access to
> PACA and the current stack, before C code is called or any other
> accesses are made.
> 
> All of these have pinned SLBs so will not take a SLB fault. Therefore
> EXSLB is not be required.

Applied to powerpc/next.

[1/1] powerpc/64s: Remove EXSLB interrupt save area
      https://git.kernel.org/powerpc/c/ac7c5e9b08acdb54ef3525abcad24bdb3ed05551

cheers
