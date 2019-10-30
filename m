Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F7DCA9EC7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 17:58:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29FD208E3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 17:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29FD208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473GQJ1DkBzF4dP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 04:58:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473GMG4HYLzF4cc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 04:55:22 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D34F968C7B; Wed, 30 Oct 2019 18:55:18 +0100 (CET)
Date: Wed, 30 Oct 2019 18:55:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH 11/11] powerpc/powernv: Add pnv_pci_ioda_dma_set_mask()
Message-ID: <20191030175518.GB19166@lst.de>
References: <1572454800-17976-1-git-send-email-arbab@linux.ibm.com>
 <1572454800-17976-12-git-send-email-arbab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572454800-17976-12-git-send-email-arbab@linux.ibm.com>
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

On Wed, Oct 30, 2019 at 12:00:00PM -0500, Reza Arbab wrote:
> Change pnv_pci_ioda_iommu_bypass_supported() to have no side effects, by
> separating the part of the function that determines if bypass is
> supported from the part that actually attempts to configure it.
> 
> Move the latter to a controller-specific dma_set_mask() callback.

Nak, the dma_set_mask overrides are going away.  But as said in the
reply to the cover letter I don't even see how you could end up calling
this code.
