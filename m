Return-Path: <clemens@ladisch.de>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1EB08B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 23:26:24 +1000 (EST)
Message-ID: <4FEDAAC6.2050202@ladisch.de>
Date: Fri, 29 Jun 2012 15:16:54 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
 <4FED8D03.10507@ladisch.de>
 <00a501cd55f7$323946f0$96abd4d0$%szyprowski@samsung.com>
In-Reply-To: <00a501cd55f7$323946f0$96abd4d0$%szyprowski@samsung.com>
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org,
 'Russell King - ARM Linux' <linux@arm.linux.org.uk>,
 'Arnd Bergmann' <arnd@arndb.de>,
 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
 'Subash Patel' <subash.ramaswamy@linaro.org>, linux-kernel@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
 'Kyungmin Park' <kyungmin.park@samsung.com>, linuxppc-dev@lists.ozlabs.org,
 'Sumit Semwal' <sumit.semwal@linaro.org>, linux-arm-kernel@lists.infradead.org,
 'David Gibson' <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marek Szyprowski wrote:
> On Friday, June 29, 2012 1:10 PM Clemens Ladisch wrote:
>> Marek Szyprowski wrote:
>>> +++ b/drivers/base/dma-mapping.c
>>> ...
>>> +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>>> +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
>>> +{
>>> +	int ret = -ENXIO;
>>> +	...
>>> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
>>> +		return ret;
>>
>> This will return -ENXIO if dma_mmap_from_coherent() succeeds.
>
> Thanks for spotting this!

Sorry, I was wrong; ret is actually set by dma_mmap_from_coherent's
output parameter.  (That function's documentation appears to be
incomplete.)


Regards,
Clemens
