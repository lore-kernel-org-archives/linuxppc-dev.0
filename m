Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0842ECA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 17:55:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB592087F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 17:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB592087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473GMv6NF8zF4cm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 04:55:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473GKT4YYszF4Wx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 04:53:47 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4E59F68C7B; Wed, 30 Oct 2019 18:53:41 +0100 (CET)
Date: Wed, 30 Oct 2019 18:53:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH 00/11] powerpv/powernv: Restore
 pnv_npu_try_dma_set_bypass()
Message-ID: <20191030175341.GA19166@lst.de>
References: <1572454800-17976-1-git-send-email-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572454800-17976-1-git-send-email-arbab@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Paul Mackerras <paulus@samba.org>, Alistair Popple <alistair@popple.id.au>,
 Oliver O'Halloran <oohall@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 30, 2019 at 11:59:49AM -0500, Reza Arbab wrote:
> With recent kernels, TCE tables for NPU devices are no longer being
> configured. That task was performed by pnv_npu_try_dma_set_bypass(), a
> function that got swept away in recent overhauling of dma code.
> 
> Patches 1-4 here bring the lost function back and reintegrate it with
> the updated generic iommu bypass infrastructure.
> 
> Patch 5 fixes a regression in behavior when a requested dma mask can not
> be fulfilled.
> 
> Patches 6-8 are cleanup. I put these later in the set because they
> aren't bisectable until after the restored code is wired back in.
> 
> Patches 9-11 refactor pnv_pci_ioda_iommu_bypass_supported(). It seems
> wrong for a boolean *_supported() function to have side effects. They
> reintroduce a pci controller based dma_set_mask() hook. If that's
> undesirable, these last three patches can be dropped.

How do you even use this code?  Nothing in the kernel even calls
dma_set_mask for NPU devices, as we only suport vfio pass through.
