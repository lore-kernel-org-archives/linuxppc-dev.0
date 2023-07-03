Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FB5EB64DC
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 05:24:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvZ990slRz3c0X
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:24:13 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvZ8723Dhz2yHs
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2023 15:23:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ870q3Lz4wqZ;
	Mon,  3 Jul 2023 15:23:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Gaurav Batra <gbatra@linux.vnet.ibm.com>
In-Reply-To: <20230504175913.83844-1-gbatra@linux.vnet.ibm.com>
References: <20230504175913.83844-1-gbatra@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs
Message-Id: <168836167609.46386.4988989425263088348.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:21:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, gjoyce@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 04 May 2023 12:59:13 -0500, Gaurav Batra wrote:
> When DMA window is backed by 2MB TCEs, the DMA address for the mapped
> page should be the offset of the page relative to the 2MB TCE. The code
> was incorrectly setting the DMA address to the beginning of the TCE
> range.
> 
> Mellanox driver is reporting timeout trying to ENABLE_HCA for an SR-IOV
> ethernet port, when DMA window is backed by 2MB TCEs.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/iommu: DMA address offset is incorrectly calculated with 2MB TCEs
      https://git.kernel.org/powerpc/c/096339ab84f36beae0b1db25e0ce63fb3873e8b2

cheers
