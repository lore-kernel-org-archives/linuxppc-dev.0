Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 13:15:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D343610E5
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 13:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D343610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gd1pL2kLNz306y
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 23:15:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gd1nt5YXsz2yx2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Aug 2021 23:14:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Gd1ns57MRz9sXk; Sun,  1 Aug 2021 23:14:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
In-Reply-To: <20210729060449.292780-1-srikar@linux.vnet.ibm.com>
References: <20210729060449.292780-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Fix regression while building external
 modules
Message-Id: <162782363987.2951535.6223006855030878479.b4-ty@ellerman.id.au>
Date: Sun, 01 Aug 2021 23:13:59 +1000
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
Cc: marc.c.dionne@gmail.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Nicholas Piggin <npiggin@gmail.com>, jforbes@redhat.com, yadayada@in.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 29 Jul 2021 11:34:49 +0530, Srikar Dronamraju wrote:
> With Commit c9f3401313a5 ("powerpc: Always enable queued spinlocks for
> 64s, disable for others") CONFIG_PPC_QUEUED_SPINLOCKS is always
> enabled on ppc64le, external modules that use spinlock APIs are
> failing.
> 
> ERROR: modpost: GPL-incompatible module XXX.ko uses GPL-only symbol
> 'shared_processor'
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries: Fix regression while building external modules
      https://git.kernel.org/powerpc/c/333cf507465fbebb3727f5b53e77538467df312a

cheers
