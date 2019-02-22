Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:16:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5FA20823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5FA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445S1N4nKSzDqWm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:16:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RN569LvzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RN526G6z9sBK; Fri, 22 Feb 2019 20:47:49 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RN50fkXz9sBF; Fri, 22 Feb 2019 20:47:48 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: bba436309d579f306419e0bffe8a28a5935cb17a
X-Patchwork-Hint: ignore
In-Reply-To: <20190208123416.1051-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Make PPC_64K_PAGES depend on only 44x or PPC_BOOK3S_64
Message-Id: <445RN50fkXz9sBF@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:48 +1100 (AEDT)
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
Cc: oss@buserror.net, aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-08 at 12:34:16 UTC, Michael Ellerman wrote:
> In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
> 64Kpage size from 64bit booke") we dropped the 64K page size support
> from the 64-bit nohash (Book3E) code.
> 
> But we didn't update the dependencies of the PPC_64K_PAGES option,
> meaning a randconfig can still trigger this code and cause a build
> breakage, eg:
>   arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error "Page size not supported"
>   arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error Unsupported page size
> 
> So remove PPC_BOOK3E_64 from the dependencies. This also means we
> don't need to worry about PPC_FSL_BOOK3E, because that was just trying
> to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/bba436309d579f306419e0bffe8a28a5

cheers
