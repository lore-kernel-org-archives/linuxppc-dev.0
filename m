Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6126C10F14
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 15:22:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E911520656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 15:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E911520656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k8JB34PgzDqNQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 01:22:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k8GF43ZxzDq9l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 01:21:08 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E670680D;
 Tue, 16 Apr 2019 08:21:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E3B23F59C;
 Tue, 16 Apr 2019 08:21:02 -0700 (PDT)
Date: Tue, 16 Apr 2019 16:21:00 +0100
From: Will Deacon <will.deacon@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
Message-ID: <20190416152100.GB4187@fuggles.cambridge.arm.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
 <010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
 <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
 Sebastian Ott <sebott@linux.ibm.com>, linux-doc <linux-doc@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 John Garry <john.garry@huawei.com>, Borislav Petkov <bp@alien8.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 02:11:31PM +0100, Robin Murphy wrote:
> On 12/04/2019 11:26, John Garry wrote:
> > On 09/04/2019 13:53, Zhen Lei wrote:
> > > +static int __init iommu_dma_mode_setup(char *str)
> > > +{
> > > +    if (!str)
> > > +        goto fail;
> > > +
> > > +    if (!strncmp(str, "passthrough", 11))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
> > > +    else if (!strncmp(str, "lazy", 4))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
> > > +    else if (!strncmp(str, "strict", 6))
> > > +        iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
> > > +    else
> > > +        goto fail;
> > > +
> > > +    pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
> > 
> > What happens if the cmdline option iommu.dma_mode is passed multiple
> > times? We get mutliple - possibily conflicting - prints, right?
> 
> Indeed; we ended up removing such prints for the existing options here,
> specifically because multiple messages seemed more likely to be confusing
> than useful.
> 
> > And do we need to have backwards compatibility, such that the setting
> > for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless
> > of order?
> 
> As above I think it would be preferable to just keep using the existing
> options anyway. The current behaviour works out as:
> 
> iommu.passthrough |      Y	|	  N
> iommu.strict	  |      x	|    Y         N
> ------------------|-------------|---------|--------
> MODE		  | PASSTHROUGH | STRICT  |  LAZY
> 
> which seems intuitive enough that a specific dma_mode option doesn't add
> much value, and would more likely just overcomplicate things for users as
> well as our implementation.

Agreed. We can't remove the existing options, and they do the job perfectly
well so I don't see the need to add more options on top.

Will
