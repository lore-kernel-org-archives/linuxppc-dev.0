Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADD1C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 18:17:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D609120836
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="GprycP0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D609120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cScX2Gv5zDr3l
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 05:17:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::7; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="GprycP0/"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cSZh6K31zDqvs
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 05:15:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1547316919;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=tDQUzQaf1uzOW0DjVmQndXv8Oqpitvt6CNmZOymKz/U=;
 b=GprycP0/V4Dfv2U+QWkXOvOb/a9rpWhPCdbYFuiADN8s8VdNKbi9rO5ZDUxLVHJO8l
 HBMvLvpmPHNvKqk5jb4nZYCr3YktjMKy2vYzX71MgCIdgemLpd0/5zYHrHvICr0HCNUp
 MaefAZ7l5iW0fbLxLVBixKqtUSpM8lprp/SVNwdQ9SbdXJstjGuLGEZ/p4CWOmdLbPRW
 A+bR4Rg/TtmKynMHGHInwnBrmPwUMwDmWt82wta3Y6xKkMsN6lP6bkyciPaTs2yp/vFf
 LYgxy1e5Lg1QPgRQpcBxcYBDmJZaF0h7t+Kd6lcIVhsRvbhiHhVUWO8PfLt2WWVx2C+/
 0Eww==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7Claix48Lc7WSXlYG1+kJ2hq5wjkeA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:e5f2:6660:f2b8:db4f]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0CIEseqA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sat, 12 Jan 2019 19:14:54 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
 <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
 <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de>
 <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
 <20190103073622.GA24323@lst.de>
 <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
Message-ID: <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de>
Date: Sat, 12 Jan 2019 19:14:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de>
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

Next step: 4558b6e1ddf3dcf5a86d6a5d16c2ac1600c7df39 (swiotlb: remove 
swiotlb_dma_supported)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout 4558b6e1ddf3dcf5a86d6a5d16c2ac1600c7df39

Output:

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

   git checkout -b <new-branch-name>

HEAD is now at 4558b6e... swiotlb: remove swiotlb_dma_supported

----

Link to the Git: 
http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6

Results: PASEMI onboard ethernet (X1000) works and the X5000 (P5020 
board) boots. I also successfully tested sound, hardware 3D 
acceleration, Bluetooth, network, booting with a label etc. The uImages 
work also in a virtual e5500 quad-core QEMU machine.

-- Christian


On 11 January 2019 at 03:10AM, Christian Zigotzky wrote:
> Next step: 891dcc1072f1fa27a83da920d88daff6ca08fc02 (powerpc/dma: 
> remove dma_nommu_dma_supported)
>
> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>
> git checkout 891dcc1072f1fa27a83da920d88daff6ca08fc02
>
> Output:
>
> Note: checking out '891dcc1072f1fa27a83da920d88daff6ca08fc02'.
>
> You are in 'detached HEAD' state. You can look around, make experimental
> changes and commit them, and you can discard any commits you make in this
> state without impacting any branches by performing another checkout.
>
> If you want to create a new branch to retain commits you create, you may
> do so (now or later) by using -b with the checkout command again. 
> Example:
>
> git checkout -b <new-branch-name>
>
> HEAD is now at 891dcc1... powerpc/dma: remove dma_nommu_dma_supported
>
> ---
>
> Link to the Git: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>
> Results: PASEMI onboard ethernet works and the X5000 (P5020 board) 
> boots. I also successfully tested sound, hardware 3D acceleration, 
> Bluetooth, network, booting with a label etc. The uImages work also in 
> a virtual e5500 quad-core QEMU machine.
>
> -- Christian
>
>
> On 09 January 2019 at 10:31AM, Christian Zigotzky wrote:
>> Next step: a64e18ba191ba9102fb174f27d707485ffd9389c (powerpc/dma: 
>> remove dma_nommu_get_required_mask)
>>
>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>
>> git checkout a64e18ba191ba9102fb174f27d707485ffd9389c
>>
>> Link to the Git: 
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>
>> Results: PASEMI onboard ethernet works and the X5000 (P5020 board) 
>> boots. I also successfully tested sound, hardware 3D acceleration, 
>> Bluetooth, network, booting with a label etc. The uImages work also 
>> in a virtual e5500 quad-core QEMU machine.
>>
>> -- Christian
>>
>>
>> On 05 January 2019 at 5:03PM, Christian Zigotzky wrote:
>>> Next step: c446404b041130fbd9d1772d184f24715cf2362f (powerpc/dma: 
>>> remove dma_nommu_mmap_coherent)
>>>
>>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>>
>>> git checkout c446404b041130fbd9d1772d184f24715cf2362f
>>>
>>> Output:
>>>
>>> Note: checking out 'c446404b041130fbd9d1772d184f24715cf2362f'.
>>>
>>> You are in 'detached HEAD' state. You can look around, make 
>>> experimental
>>> changes and commit them, and you can discard any commits you make in 
>>> this
>>> state without impacting any branches by performing another checkout.
>>>
>>> If you want to create a new branch to retain commits you create, you 
>>> may
>>> do so (now or later) by using -b with the checkout command again. 
>>> Example:
>>>
>>>   git checkout -b <new-branch-name>
>>>
>>> HEAD is now at c446404... powerpc/dma: remove dma_nommu_mmap_coherent
>>>
>>> -----
>>>
>>> Link to the Git: 
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>>
>>> Result: PASEMI onboard ethernet works and the X5000 (P5020 board) 
>>> boots.
>>>
>>> -- Christian
>>>
>>
>>
>
>

