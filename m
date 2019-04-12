Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D7FC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:24:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6B22082E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 11:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B22082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gbCM3SxhzDqTY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 21:24:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=8bytes.org
 (client-ip=2a01:238:4383:600:38bc:a715:4b6d:a889; helo=theia.8bytes.org;
 envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=8bytes.org
X-Greylist: delayed 379 seconds by postgrey-1.36 at bilbo;
 Fri, 12 Apr 2019 21:23:18 AEST
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gb9f2HH2zDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 21:23:18 +1000 (AEST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5249D21D; Fri, 12 Apr 2019 13:16:51 +0200 (CEST)
Date: Fri, 12 Apr 2019 13:16:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
Message-ID: <20190412111649.GK4518@8bytes.org>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409125308.18304-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, x86 <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>, John Garry <john.garry@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, Tony Luck <tony.luck@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 09, 2019 at 08:53:03PM +0800, Zhen Lei wrote:
> +static int __init iommu_dma_mode_setup(char *str)
> +{
> +	if (!str)
> +		goto fail;
> +
> +	if (!strncmp(str, "passthrough", 11))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
> +	else if (!strncmp(str, "lazy", 4))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
> +	else if (!strncmp(str, "strict", 6))
> +		iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
> +	else
> +		goto fail;
> +
> +	pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);

Printing a number is not very desriptive or helpful to the user. Please
print the name of the mode instead.


Regards,

	Joerg
