Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7762C282CE
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:54:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E73F20870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 09:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E73F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d5Nc5MzkzDqFH
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 19:54:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d5Lq5dKRzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 19:52:35 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 633868A0D550D054A9A4;
 Mon,  8 Apr 2019 17:52:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 17:51:59 +0800
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
To: Thomas Gleixner <tglx@linutronix.de>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
 <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
 <5CAABD03.9000301@huawei.com>
 <alpine.DEB.2.21.1904080829490.1840@nanos.tec.linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CAB19BC.2040804@huawei.com>
Date: Mon, 8 Apr 2019 17:51:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904080829490.1840@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
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
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Joerg
 Roedel <joro@8bytes.org>, x86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 John Garry <john.garry@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Borislav Petkov <bp@alien8.de>,
 Gerald
 Schaefer <gerald.schaefer@de.ibm.com>, Tony Luck <tony.luck@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Robin
 Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/4/8 14:32, Thomas Gleixner wrote:
> On Mon, 8 Apr 2019, Leizhen (ThunderTown) wrote:
>>>
>>> This will break systems using boot options as now, and I think
>>> this is unacceptable. If you want to do so, just introduce iommu.dma_mode
>>> on top of those iommu boot options with dma mode boot options unchanged,
>>> and iommu.dma_mode is for all archs but compatible with them.
>>
>> I just changed the boot options name, but keep the function no change. I added
>> all related maintainers/supporters in the "to=" list, maybe we can disuss this.
> 
> Changing the name _IS_ the problem. Think about unattended updates.
> 
>> Should I add some "obsoleted" warnings for old options and keep them for a while?
> 
> No, just keep the old options around for backwards compatibilty sake. We
> just do not add new arch specific options in the future. New options need
> to use the generic iommu.dma_mode name space.

OK, thanks for your advise.


> 
> Thanks,
> 
> 	tglx
> 
> .
> 

-- 
Thanks!
BestRegards

