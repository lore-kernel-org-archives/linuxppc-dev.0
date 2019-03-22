Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8676C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C592054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C592054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QjY803cjzDqV6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 23:25:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QjSj6TyfzDqTR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 23:21:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44QjSh4zGhz9sV2; Fri, 22 Mar 2019 23:21:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8bc086899816214fbc6047c9c7e15fcab49552bf
X-Patchwork-Hint: ignore
In-Reply-To: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
Message-Id: <44QjSh4zGhz9sV2@ozlabs.org>
Date: Fri, 22 Mar 2019 23:21:40 +1100 (AEDT)
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

On Sun, 2019-03-17 at 01:17:56 UTC, Ben Hutchings wrote:
> MAX_PHYSMEM_BITS only needs to be defined if CONFIG_SPARSEMEM is
> enabled, and that was the case before commit 4ffe713b7587
> ("powerpc/mm: Increase the max addressable memory to 2PB").
> 
> On 32-bit systems, where CONFIG_SPARSEMEM is not enabled, we now
> define it as 46.  That is larger than the real number of physical
> address bits, and breaks calculations in zsmalloc:
> 
>     mm/zsmalloc.c:130:49: warning: right shift count is negative [-Wshift-count-negative]
>       MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
>                                                      ^~
>     ...
>     mm/zsmalloc.c:253:21: error: variably modified 'size_class' at file scope
>       struct size_class *size_class[ZS_SIZE_CLASSES];
>                          ^~~~~~~~~~
> 
> Fixes: 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2PB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8bc086899816214fbc6047c9c7e15fca

cheers
