Return-Path: <SRS0=fxYp=XU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19992C432C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 11:20:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8C7214D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 11:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8C7214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46dbFW1xkTzDqVl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 21:20:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dZwP71CtzDqdf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 21:05:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46dZwP4hpLz9sPl; Wed, 25 Sep 2019 21:05:25 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1211ee61b4a8e60d6dc77211cdcf01906915bfba
In-Reply-To: <20190920130523.20441-2-ldufour@linux.ibm.com>
To: Laurent Dufour <ldufour@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] powperc/mm: read TLB Block Invalidate
 Characteristics
Message-Id: <46dZwP4hpLz9sPl@ozlabs.org>
Date: Wed, 25 Sep 2019 21:05:25 +1000 (AEST)
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

On Fri, 2019-09-20 at 13:05:22 UTC, Laurent Dufour wrote:
> The PAPR document specifies the TLB Block Invalidate Characteristics which
> tells for each pair of segment base page size, actual page size, the size
> of the block the hcall H_BLOCK_REMOVE supports.
> 
> These characteristics are loaded at boot time in a new table hblkr_size.
> The table is separate from the mmu_psize_def because this is specific to
> the pseries platform.
> 
> A new init function, pseries_lpar_read_hblkrm_characteristics() is added to
> read the characteristics. It is called from pSeries_setup_arch().
> 
> Fixes: ba2dd8a26baa ("powerpc/pseries/mm: call H_BLOCK_REMOVE")
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1211ee61b4a8e60d6dc77211cdcf01906915bfba

cheers
