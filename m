Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F029BC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:50:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5486207F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5486207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h1366mpGzDr1N
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:50:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFx5skNzDqRs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFq4bG8z9sVK; Tue,  9 Jun 2020 15:29:35 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200406030745.24595-2-oohall@gmail.com>
References: <20200406030745.24595-1-oohall@gmail.com>
 <20200406030745.24595-2-oohall@gmail.com>
Subject: Re: [PATCH 1/7] powerpc/powernv/npu: Clean up compound table group
 initialisation
Message-Id: <159168033539.1381411.9877327525599662112.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:35 +1000 (AEST)
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
Cc: aik@ozlabs.ru
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 6 Apr 2020 13:07:39 +1000, Oliver O'Halloran wrote:
> Re-work the control flow a bit so what's going on is a little clearer.
> This also ensures the table_group is only initialised once in the P9
> case. This shouldn't be a functional change since all the GPU PCI
> devices should have the same table_group configuration, but it does
> look strange.

Applied to powerpc/next.

[1/7] powerpc/powernv/npu: Clean up compound table group initialisation
      https://git.kernel.org/powerpc/c/6984856865b55c9c1ee0814c30296119cd8ba511
[2/7] powerpc/powernv/iov: Don't add VFs to iommu group during PE config
      https://git.kernel.org/powerpc/c/6cff91b2b97b1b40a52971c9b1e99980dd49fd54
[3/7] powerpc/powernv/pci: Register iommu group at PE DMA setup
      https://git.kernel.org/powerpc/c/9b9408c55935ecc3b1c27b3eeb5a507394113cbb
[4/7] powerpc/powernv/pci: Add device to iommu group during dma_dev_setup()
      https://git.kernel.org/powerpc/c/84d8cc076723058cc294f4360db6ff7758c25b74
[5/7] powerpc/powernv/pci: Delete old iommu recursive iommu setup
      https://git.kernel.org/powerpc/c/f39b8b10fcc5d4617d2be5f2910e017a55444b43
[6/7] powerpc/powernv/pci: Move tce size parsing to pci-ioda-tce.c
      https://git.kernel.org/powerpc/c/96e2006a9dbc02cb1c103521405d457438a2e260
[7/7] powerpc/powernv/npu: Move IOMMU group setup into npu-dma.c
      https://git.kernel.org/powerpc/c/03b7bf341c18ff19129cc2825b62bb0e212463f1

cheers
