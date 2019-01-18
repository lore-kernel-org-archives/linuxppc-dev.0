Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C5C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 12:50:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03BA20883
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 12:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="f0LMnMO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03BA20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h14Y0GQXzDr2c
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 23:50:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::1; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="f0LMnMO1"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h1146yZmzDr1F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 23:47:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547815619;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=/KNuk+o0Zcjhlf4x1+HgyJfyMNJ50AuvjDBDfL5yNu4=;
 b=f0LMnMO1Bhc8IecCwgRj8fm8M9ZgooCVMS0r+gMKre7psjki7S+Hv3lD+HnXlmvZOU
 RhkS2oNACA+zKvboJXfp42IHkQ6hTC7uU29jsfJnTopYT/Cy4K1GJ3jjQhEAXsAl5v6V
 0m6jnN70Sm4fcGHkX/MHZ5by6jYAtDUy0VxpZHqQWW9hbmd+tf6qmS+CkgKcHnG8LbwH
 7nKB4SrC2xnqrdXxYTbAKTQQRrVmYIVC9qKsvIGF2g6EO4bSv1llZ31qbXowQc4eEjlz
 qV31BkaCLRuUjtXGVlXszKxKAWEWid+bMksyhE9nZDnUqSKKI4W50GpvOgc+yXTqL+Ni
 haJg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkO3W1t7/x3Ry2nhljiBv4wW5sxWQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1cca:8712:d929:bc6d]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0ICkl9br
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Fri, 18 Jan 2019 13:46:47 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de>
 <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de>
 <20190115133558.GA29225@lst.de>
 <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
 <20190115151732.GA2325@lst.de>
 <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
 <20190118083539.GA30479@lst.de>
 <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
 <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
 <20190118121810.GA13327@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
Date: Fri, 18 Jan 2019 13:46:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118121810.GA13327@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sorry, it's not possible to patch 
'257002094bc5935dd63207a380d9698ab81f0775' with your patch. I also tried 
it manually but without any success.

-- Christian

On 18 January 2019 at 1:18PM, Christoph Hellwig wrote:
> On Fri, Jan 18, 2019 at 01:07:54PM +0100, Christian Zigotzky wrote:
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout 257002094bc5935dd63207a380d9698ab81f0775
>>
>>
>> I get the following error message with your patch:
> Hmm.  Did I attached the wrong patch?  Here is the one I want and just
> applied to that revision:
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 355d16acee6d..e46c9b64ec0d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -118,8 +118,11 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   			page = NULL;
>   		}
>   	}
> -	if (!page)
> +	if (!page) {
>   		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
> +		if (!page)
> +			pr_warn("failed to allocate memory with gfp 0x%x\n", gfp);
> +	}
>   
>   	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>   		__free_pages(page, page_order);
> @@ -139,6 +142,10 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
>   		}
>   	}
>   
> +	if (!page) {
> +		pr_warn("failed to allocate DMA memory!\n");
> +		dump_stack();
> +	}
>   	return page;
>   }
>   
>

