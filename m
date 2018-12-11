Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7BFC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:33:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1AD2081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 14:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="p7rCvgEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1AD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dj8s0R7jzDqc1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 01:33:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="p7rCvgEa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::6; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="p7rCvgEa"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dj4J6X9DzDqVM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 01:29:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544538539;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=rItOzgUuqEpwZEzn16FSVomGzsINWRwfpv8bF8hO+zA=;
 b=p7rCvgEaZTNfD6Wn/ZygD/j66L83DjYDChjx1gFam2pdBZsFDhoVwW6yKQumBj2JMD
 Zqq3hwqz3NZlqMT8vml3k9WGSRbxjeEK9VjEeuf3tPmwWVGjBKm8Rm4LqQiILk/HcuW/
 Z1jfdwMJLyWnY7jFbQdZ3CJzbFmMG20P6ONCTRj8r7Fz6ALvLdxVShCJFy43mQw/3FMM
 e8nDRXcJV+swl7ck0PzSgaHV9yFZ9wj/LQat4gO4Bkbor6r3csnzhA1Yjo95w517jSQZ
 rYBXWBLRN0SY7QOv+MEfKJ9H4fGYCOZr73DUaisxJtF99LA+eB2UmJU1rxMmmoce0RpO
 zA1g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkMh8jk++v0p07AockVEYHf+vz0MA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:39b6:b99f:5436:fbce]
 by smtp.strato.de (RZmta 44.7 AUTH) with ESMTPSA id j074b8uBBESl2bZ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 11 Dec 2018 15:28:47 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
 <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
 <c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
 <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
Message-ID: <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
Date: Tue, 11 Dec 2018 15:28:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
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

Next step: 977706f9755d2d697aa6f45b4f9f0e07516efeda (powerpc/dma: remove 
dma_nommu_mmap_coherent)

Result: The P5020 board boots and the PASEMI onboard ethernet works.

-- Christian


On 10 December 2018 at 4:54PM, Christian Zigotzky wrote:
> Next step: 64ecd2c160bbef31465c4d34efc0f076a2aad4df (powerpc/dma: use 
> phys_to_dma instead of get_dma_offset)
>
> The P5020 board boots and the PASEMI onboard ethernet works.
>
> -- Christian
>
>
> On 09 December 2018 at 7:26PM, Christian Zigotzky wrote:
>> Next step: c1bfcad4b0cf38ce5b00f7ad880d3a13484c123a (dma-mapping, 
>> powerpc: simplify the arch dma_set_mask override)
>>
>> Result: No problems with the PASEMI onboard ethernet and with booting 
>> the X5000 (P5020 board).
>>
>> -- Christian
>>
>>
>> On 09 December 2018 at 3:20PM, Christian Zigotzky wrote:
>>> Next step: 602307b034734ce77a05da4b99333a2eaf6b6482 
>>> (powerpc/fsl_pci: simplify fsl_pci_dma_set_mask)
>>>
>>> git checkout 602307b034734ce77a05da4b99333a2eaf6b6482
>>>
>>> The PASEMI onboard ethernet works and the X5000 boots.
>>>
>>> -- Christian
>>>
>>>
>>> On 08 December 2018 at 2:47PM, Christian Zigotzky wrote:
>>>> Next step: e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615 (powerpc/dma: 
>>>> fix an off-by-one in dma_capable)
>>>>
>>>> git checkout e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615
>>>>
>>>> The PASEMI onboard ethernet also works with this commit and the 
>>>> X5000 boots without any problems.
>>>>
>>>> -- Christian
>>>>
>>>>
>>>> On 08 December 2018 at 11:29AM, Christian Zigotzky wrote:
>>>>> Next step: 7ebc44c535f6bd726d553756d38b137acc718443 (powerpc/dma: 
>>>>> remove max_direct_dma_addr)
>>>>>
>>>>> git checkout 7ebc44c535f6bd726d553756d38b137acc718443
>>>>>
>>>>> OK, the PASEMI onboard ethernet works and the P5020 board boots.
>>>>>
>>>>> -- Christian
>>>>>
>>>>>
>>>>> On 07 December 2018 at 7:33PM, Christian Zigotzky wrote:
>>>>>> Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: 
>>>>>> move pci_dma_dev_setup_swiotlb to fsl_pci.c)
>>>>>>
>>>>>> git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d
>>>>>>
>>>>>> Result: The PASEMI onboard ethernet works and the P5020 board boots.
>>>>>>
>>>>>> — Christian
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>
>

