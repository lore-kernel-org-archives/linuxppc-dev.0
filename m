Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7626C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:55:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF512087B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF512087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCS43m1fzDqQk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:55:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBfM25mBzDqDp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:19:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBfL1LfBz9s5c; Mon, 22 Apr 2019 00:19:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c05f57fdc34a3d00c9ee28a35772e9d11b5ce100
X-Patchwork-Hint: ignore
In-Reply-To: <20190407024808.39821-1-cai@lca.pw>
To: Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries/iommu: fix set but not used values
Message-Id: <44nBfL1LfBz9s5c@ozlabs.org>
Date: Mon, 22 Apr 2019 00:19:05 +1000 (AEST)
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, Qian Cai <cai@lca.pw>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 2019-04-07 at 02:48:08 UTC, Qian Cai wrote:
> The commit b7d6bf4fdd47 ("powerpc/pseries/pci: Remove obsolete SW
> invalidate") left 2 variables unused.
> 
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_build_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:108:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>   __be64 *tcep, *tces;
>                  ^~~~
> arch/powerpc/platforms/pseries/iommu.c: In function 'tce_free_pSeries':
> arch/powerpc/platforms/pseries/iommu.c:132:17: warning: variable 'tces'
> set but not used [-Wunused-but-set-variable]
>   __be64 *tcep, *tces;
>                  ^~~~
> 
> Also, the commit 68c0449ea16d ("powerpc/pseries/iommu: Use memory@ nodes
> in max RAM address calculation") set "ranges" in
> ddw_memory_hotplug_max() but never use it.
> 
> arch/powerpc/platforms/pseries/iommu.c: In function
> 'ddw_memory_hotplug_max':
> arch/powerpc/platforms/pseries/iommu.c:948:7: warning: variable 'ranges'
> set but not used [-Wunused-but-set-variable]
>    int ranges, n_mem_addr_cells, n_mem_size_cells, len;
>        ^~~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c05f57fdc34a3d00c9ee28a35772e9d1

cheers
