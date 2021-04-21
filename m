Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F04C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:12:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1828361440
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1828361440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQLZb4Mt4z3ddT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:12:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQLVN4Vsmz301g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:09:16 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FQLVN1cWcz9vFl; Wed, 21 Apr 2021 23:09:15 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Leonardo Bras <leobras.c@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <20210420045404.438735-1-leobras.c@gmail.com>
References: <20210420045404.438735-1-leobras.c@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/pseries/iommu: Fix window size for direct
 mapping with pmem
Message-Id: <161901050137.1961279.12627937904577975513.b4-ty@ellerman.id.au>
Date: Wed, 21 Apr 2021 23:08:21 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 20 Apr 2021 01:54:04 -0300, Leonardo Bras wrote:
> As of today, if the DDW is big enough to fit (1 << MAX_PHYSMEM_BITS) it's
> possible to use direct DMA mapping even with pmem region.
> 
> But, if that happens, the window size (len) is set to
> (MAX_PHYSMEM_BITS - page_shift) instead of MAX_PHYSMEM_BITS, causing a
> pagesize times smaller DDW to be created, being insufficient for correct
> usage.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Fix window size for direct mapping with pmem
      https://git.kernel.org/powerpc/c/a9d2f9bb225fd2a764aef57738ab6c7f38d782ae

cheers
