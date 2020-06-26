Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE543C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 04:52:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55CF020768
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 04:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CF020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tPdH2rftzDqtK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:52:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tPTV2lZnzDqkK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 14:45:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49tPTT4081z9sT8; Fri, 26 Jun 2020 14:45:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20200617003835.48831-1-aik@ozlabs.ru>
References: <20200617003835.48831-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel v2] powerpc/powernv/ioda: Return correct error if
 TCE level allocation failed
Message-Id: <159314672700.1150869.1484657945979576951.b4-ty@ellerman.id.au>
Date: Fri, 26 Jun 2020 14:45:49 +1000 (AEST)
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

On Wed, 17 Jun 2020 10:38:35 +1000, Alexey Kardashevskiy wrote:
> The iommu_table_ops::xchg_no_kill() callback updates TCE. It is quite
> possible that not entire table is allocated if it is huge and multilevel
> so xchg may also allocate subtables. If failed, it returns H_HARDWARE
> for failed allocation and H_TOO_HARD if it needs it but cannot do because
> the alloc parameter is "false" (set when called with MMU=off to force
> retry with MMU=on).
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/ioda: Return correct error if TCE level allocation failed
      https://git.kernel.org/powerpc/c/5f202c1a1d429bee3ddab647711f181c72d157da

cheers
