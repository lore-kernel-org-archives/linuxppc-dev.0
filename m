Return-Path: <SRS0=uerg=HM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F355C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:35:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C72A64E77
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Feb 2021 14:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C72A64E77
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DbMjn3KhrzDvbf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 01:35:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DbKYR09ZPzDshk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2021 23:57:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DbKYP3q8lz9sWT; Wed, 10 Feb 2021 23:57:45 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
In-Reply-To: <20200902013657.1753830-1-oohall@gmail.com>
References: <20200902013657.1753830-1-oohall@gmail.com>
Subject: Re: [PATCH v2] powerpc/powernv/pci: Drop pnv_phb->initialized
Message-Id: <161296170666.3178259.2592113861832242190.b4-ty@ellerman.id.au>
Date: Wed, 10 Feb 2021 23:57:45 +1100 (AEDT)
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

On Wed, 2 Sep 2020 11:36:57 +1000, Oliver O'Halloran wrote:
> The pnv_phb->initialized flag is an odd beast. It was added back in 2012 in
> commit db1266c85261 ("powerpc/powernv: Skip check on PE if necessary") to
> allow devices to be enabled even if the device had not yet been assigned to
> a PE. Allowing the device to be enabled before the PE is configured may
> cause spurious EEH events since none of the IOMMU context has been setup.
> 
> I'm not entirely sure why this was ever necessary. My best guess is that it
> was an workaround for a bug or some other undesireable behaviour from the
> PCI core. Either way, it's unnecessary now since as of commit dc3d8f85bb57
> ("powerpc/powernv/pci: Re-work bus PE configuration") we can guarantee that
> the PE will be configured before the PCI core will allow drivers to bind to
> the device.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/powernv/pci: Drop pnv_phb->initialized
      https://git.kernel.org/powerpc/c/24b4c6b1a7fc79fe8142d50cb439944b81b659ff

cheers
