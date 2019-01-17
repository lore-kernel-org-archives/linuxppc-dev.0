Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254E4C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:30:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67D0205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67D0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43g4jb5r7BzDqkp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:30:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43g4f92TDvzDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43g4f90vdwz9sCX; Thu, 17 Jan 2019 11:27:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43g4f90795z9sCh; Thu, 17 Jan 2019 11:27:28 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fcf5036f09694d09d946c0455f329894a6482a4d
X-Patchwork-Hint: ignore
In-Reply-To: <20190114003255.22005-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/4xx/ocm: Fix fix for phys_addr_t printf warnings
Message-Id: <43g4f90795z9sCh@ozlabs.org>
Date: Thu, 17 Jan 2019 11:27:28 +1100 (AEDT)
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
Cc: chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-01-14 at 00:32:55 UTC, Michael Ellerman wrote:
> My recent commit to fix the printf warnings in ocm.c got the format
> specifier wrong, because I copied it from the documentation without
> realising the square brackets are not meant as literals.
> 
> This results in the address being suffixed with a literal "[p]".
> 
> Actually tested this time:
> 
>   # cat info /sys/kernel/debug/ppc4xx_ocm
>   PhysAddr     : 0x0000000400040000
>   ...
>   NC.PhysAddr  : 0x0000000400040000
>   ...
>   C.PhysAddr   : 0x0000000000000000
> 
> Fixes: 52b88fa1e8c7 ("powerpc/4xx/ocm: Fix phys_addr_t printf warnings")
> Reported-by: Christian Lamparter <chunkeey@gmail.com>
> Tested-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/fcf5036f09694d09d946c0455f329894

cheers
