Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88849C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:15:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3641E20823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3641E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Rzd6WBWzDqVn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:15:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RN46qJbzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RN42QRWz9sBK; Fri, 22 Feb 2019 20:47:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RN34yW3z9sDr; Fri, 22 Feb 2019 20:47:47 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: aa7150ba378650d0e9d84b8e4d805946965a5926
X-Patchwork-Hint: ignore
In-Reply-To: <20190207024935.30456-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/44x: Force PCI on for CURRITUCK
Message-Id: <445RN34yW3z9sDr@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:47 +1100 (AEDT)
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
Cc: bhelgaas@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-02-07 at 02:49:35 UTC, Michael Ellerman wrote:
> The recent rework of PCI kconfig symbols exposed an existing bug in
> the CURRITUCK kconfig logic.
> 
> It selects PPC4xx_PCI_EXPRESS which depends on PCI, but PCI is user
> selectable and might be disabled, leading to a warning:
> 
>   WARNING: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS
>     Depends on [n]: PCI [=n] && 4xx [=y]
>     Selected by [y]:
>     - CURRITUCK [=y] && PPC_47x [=y]
> 
> Prior to commit eb01d42a7778 ("PCI: consolidate PCI config entry in
> drivers/pci") PCI was enabled by default for currituck_defconfig so we
> didn't see the warning. The bad logic was still there, it just
> required someone disabling PCI in their .config to hit it.
> 
> Fix it by forcing PCI on for CURRITUCK, which seems was always the
> expectation anyway.
> 
> Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/aa7150ba378650d0e9d84b8e4d805946

cheers
