Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788DEC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:26:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8432184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8432184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496cB1kxkzDq6W
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:26:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496VY60RtzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496VY4sRKz9s6w; Thu, 28 Feb 2019 20:21:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5330367fa300742a97e20e953b1f77f48392faae
X-Patchwork-Hint: ignore
In-Reply-To: <20190226043935.14053-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2, 1/2] powerpc/hugetlb: Handle mmap_min_addr correctly in
 get_unmapped_area callback
Message-Id: <4496VY4sRKz9s6w@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:09 +1100 (AEDT)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-02-26 at 04:39:34 UTC, "Aneesh Kumar K.V" wrote:
> After we ALIGN up the address we need to make sure we didn't overflow
> and resulted in zero address. In that case, we need to make sure that
> the returned address is greater than mmap_min_addr.
> 
> This fixes selftest va_128TBswitch --run-hugetlb reporting failures when
> run as non root user for
> 
> mmap(-1, MAP_HUGETLB)
> 
> The bug is that a non-root user requesting address -1 will be given address 0
> which will then fail, whereas they should have been given something else that
> would have succeeded.
> 
> We also avoid the first mmap(-1, MAP_HUGETLB) returning NULL address as mmap address
> with this change. So we think this is not a security issue, because it only affects
> whether we choose an address below mmap_min_addr, not whether we
> actually allow that address to be mapped. ie. there are existing capability
> checks to prevent a user mapping below mmap_min_addr and those will still be
> honoured even without this fix.
> 
> Fixes: 484837601d4d ("powerpc/mm: Add radix support for hugetlb")
> Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5330367fa300742a97e20e953b1f77f4

cheers
