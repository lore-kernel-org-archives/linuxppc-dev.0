Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B113CC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 02:02:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276C120879
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 02:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276C120879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ctwT5GSVzDqKT
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 12:02:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=guohanjun@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
X-Greylist: delayed 919 seconds by postgrey-1.36 at bilbo;
 Mon, 08 Apr 2019 11:31:02 AEST
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ctD61TwkzDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 11:30:59 +1000 (AEST)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9C74596D1F36357E5063;
 Mon,  8 Apr 2019 09:15:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 09:15:09 +0800
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
To: Zhen Lei <thunder.leizhen@huawei.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, John Garry <john.garry@huawei.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc
 <linux-doc@vger.kernel.org>, Sebastian Ott <sebott@linux.ibm.com>, "Gerald
 Schaefer" <gerald.schaefer@de.ibm.com>, Martin Schwidefsky
 <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck
 <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, David Woodhouse
 <dwmw2@infradead.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
 linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
Date: Mon, 8 Apr 2019 09:14:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190407124147.13576-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 08 Apr 2019 12:01:05 +1000
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

Hi Zhen,

On 2019/4/7 20:41, Zhen Lei wrote:
> As Robin Murphy's suggestion:
> "It's also not necessarily obvious to the user how this interacts with
> IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
> would be better to refactor the whole lot into a single selection of something
> like IOMMU_DEFAULT_MODE anyway."
> 
> In this version, I tried to normalize the IOMMU dma mode boot options for all
> ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
> lazy(mapping but defer the IOTLB invalidation), strict. But currently each
> ARCHs defined their private boot options, different with each other. For
> example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
> X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.
> 
> 
> Zhen Lei (6):
>   iommu: use iommu.dma_mode to replace iommu.passthrough and
>     iommu.strict
>   iommu: keep dma mode build options consistent with cmdline options
>   iommu: add iommu_default_dma_mode_get() helper
>   s390/pci: use common boot option iommu.dma_mode
>   powernv/iommu: use common boot option iommu.dma_mode
>   x86/iommu: use common boot option iommu.dma_mode

This will break systems using boot options as now, and I think
this is unacceptable. If you want to do so, just introduce iommu.dma_mode
on top of those iommu boot options with dma mode boot options unchanged,
and iommu.dma_mode is for all archs but compatible with them.

Thanks
Hanjun

