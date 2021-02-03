Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28377C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:52:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE4464E29
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 11:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE4464E29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW0RF1jJ8zDxWG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 22:52:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW0916ngzzDwtn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW08y6TrGz9sX5; Wed,  3 Feb 2021 22:40:02 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, Qian Cai <cai@lca.pw>
In-Reply-To: <20200510051559.1959-1-cai@lca.pw>
References: <20200510051559.1959-1-cai@lca.pw>
Subject: Re: [PATCH] powerpc/mm/book3s64/iommu: fix some RCU-list locks
Message-Id: <161235200882.1516112.5579154052220245435.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:02 +1100 (AEDT)
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
Cc: aik@ozlabs.ru, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 10 May 2020 01:15:59 -0400, Qian Cai wrote:
> It is safe to traverse mm->context.iommu_group_mem_list with either
> mem_list_mutex or the RCU read lock held. Silence a few RCU-list false
> positive warnings and fix a few missing RCU read locks.
> 
>  arch/powerpc/mm/book3s64/iommu_api.c:330 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm/book3s64/iommu: fix some RCU-list locks
      https://git.kernel.org/powerpc/c/b5952f8125ae512420d5fc569adce591bea73bf5

cheers
