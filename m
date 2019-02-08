Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434262147C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 09:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="T0CBtLK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434262147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wq5V4zZJzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 20:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::4; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="T0CBtLK6"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wq1w32YLzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 20:02:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549616526;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=fooRh1gZ6IpLFzGD2jk4xEF8/2O5k1pY3XR60x9luIk=;
 b=T0CBtLK62JDm/QinsshQU81AmawHZ9kQHS8Ns7DnudD2yBeXNVa+Fpt7RImXqYsV4G
 8xHmywamEkSxu/fhw189x1JvsjI4a1FKiS3S0FNCxxSjLvx1GvE+tJeMIg+JiBzQ9Tvh
 pRCSgNJUw5OZIwxd8E0Q7AHo/raV6CaP5Xa0MwxDXxQJs/71k4newkeEn4thatVVua6t
 sgrMH29xweqi3/vlfjpkUfjjp1Wl9Q9MC6cXq2YH4f77tomngxVovQQVIAO5tCP+bDc8
 diALlPT8ajzWSdvTeu2gUeJnSLqq4l1o9ZmHhfioAQFbZirzX3iWH5CblkNXQQXrrCm2
 2o4w==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkGj+Y7E+ydJaUNFx8xLfqBQFoUyw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:914e:ec0c:daf0:5a2a]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv1891k4iY
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Fri, 8 Feb 2019 10:01:46 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
Message-ID: <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
Date: Fri, 8 Feb 2019 10:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Christoph,

Your new patch fixes the problems with the P.A. Semi Ethernet! :-)

Thanks,
Christian


On 07 February 2019 at 05:34AM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I also didn’t notice the 32-bit DMA mask in your patch. I have to read your patches and descriptions carefully in the future. I will test your new patch at the weekend.
>
> Thanks,
> Christian
>
> Sent from my iPhone
>
>> On 6. Feb 2019, at 16:16, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Wed, Feb 06, 2019 at 04:15:05PM +0100, Christoph Hellwig wrote:
>>> The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
>>> ("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
>>> remember correctly.  powerpc/dma: use the dma_direct mapping routines
>>> was the one that you said makes the pasemi ethernet stop working.
>>>
>>> Can you post the dmesg from the failing runs?
>> But I just noticed I sent you a wrong patch - the pasemi ethernet
>> should set a 64-bit DMA mask, not 32-bit.  Updated version below,
>> 32-bit would just keep the previous status quo.
>>
>> commit 6c8f88045dee35933337b9ce2ea5371eee37073a
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Mon Feb 4 13:38:22 2019 +0100
>>
>>     pasemi WIP
>>
>> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
>> index 8a31a02c9f47..2d7d1589490a 100644
>> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
>> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
>> @@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         err = -ENODEV;
>>         goto out;
>>     }
>> +    dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
>>
>>     mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
>>     if (!mac->iob_pdev) {


