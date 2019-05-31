Return-Path: <SRS0=knV+=T7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A94C04AB6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 17:05:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A0B26CC5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 May 2019 17:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A0B26CC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FrRW1kGwzDqc1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Jun 2019 03:05:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 45FrPp34Z2zDqWF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2019 03:03:39 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00600A78;
 Fri, 31 May 2019 10:03:37 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B94C3F59C;
 Fri, 31 May 2019 10:03:32 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
To: Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
 <20190530.150844.1826796344374758568.davem@davemloft.net>
 <20190531163350.GB8708@infradead.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <37406608-df48-c7a0-6975-4b4ad408ba36@arm.com>
Date: Fri, 31 May 2019 18:03:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531163350.GB8708@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
Cc: madalin.bucur@nxp.com, netdev@vger.kernel.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 iommu@lists.linux-foundation.org, camelia.groza@nxp.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 31/05/2019 17:33, Christoph Hellwig wrote:
> On Thu, May 30, 2019 at 03:08:44PM -0700, David Miller wrote:
>> From: laurentiu.tudor@nxp.com
>> Date: Thu, 30 May 2019 17:19:45 +0300
>>
>>> Depends on this pull request:
>>>
>>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/653554.html
>>
>> I'm not sure how you want me to handle this.
> 
> The thing needs to be completely redone as it abuses parts of the
> iommu API in a completely unacceptable way.

`git grep iommu_iova_to_phys drivers/{crypto,gpu,net}`

:(

I guess one alternative is for the offending drivers to maintain their 
own lookup tables of mapped DMA addresses - I think at least some of 
these things allow storing some kind of token in a descriptor, which 
even if it's not big enough for a virtual address might be sufficient 
for an index.

Robin.
