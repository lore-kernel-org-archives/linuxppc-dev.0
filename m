Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 15:33:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F63620868
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 15:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="dmZU4VOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F63620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435z1S4B9pzDr9C
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 02:33:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="dmZU4VOu";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::4; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="dmZU4VOu"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435yxs1Q9XzDrQx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 02:30:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543591805;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=vx/O4RzewWVBbqwppz8CMgGXMMYyYUTfLOLIKfSFWz4=;
 b=dmZU4VOuM67kvcrDJ9UEIpT7P87k8HgoJrowAP6XC774o7vUt+0BmH7ftepsObrUou
 UDA6L7yKA9Xtke8Ou8C82OuEBdO/hRbINXR6BeSKpYz2Pb7O21LwFALNMA7K5XIte/s0
 XVQJtyp0WEsQwuIH36LKoWooAop22A6y2j8D7vLdFO0caQkR4uNn47zZ7lABpWBSWVKb
 91IoEp4M+gdFd5FG7IdVU171yA95xXUBvVsDHGhY9XYYZt3yuAbJRgR9Nz+YVamBe/DB
 nqisTHvaWXq0Fn80GYN4StY9YNJJAlNuo2o+OvOpC76ayvLW8oizeNkMfjFktV5kEju/
 ApuQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkOhtXRWqPjJ5MV2zvh/ExgOBPpsw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:1876:2ea1:f7b3:289d]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uAUFTeIEo
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Fri, 30 Nov 2018 16:29:40 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
Date: Fri, 30 Nov 2018 16:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181130131056.GA5211@lst.de>
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

Hello Christoph,

Thanks for your reply.

On 30 November 2018 at 2:10PM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 01:23:20PM +0100, Christian Zigotzky wrote:
>> Yes, of course. I patched your Git kernel and after that I compiled it
>> again. U-Boot loads the kernel and the dtb file. Then the kernel starts but
>> it doesn't find any hard disks (partitions).
> Interesting.  Does it find the storage controller (what kind of
> storage does it use?).
It seems not. I don't see any infos about hard disks in the kernel ring 
buffer. The two serial ATA (SATA 2.0) controllers are integrated in the 
P5020 SoC and the hard disks are connected via SerDes lanes (PCIe) to 
the SoC. LANE 16 = SATA 0 and LANE 17 = SATA 1.
> For the PASEMI board can you test the attached patch?  Also are you
> using Compact Flash cards on that system?
Yes, we are using Compact Flash cards. The slot is wired to the CPU 
local bus. It works with your kernel. :-)

Where is the attached patch?

I downloaded the version 5 of your Git kernel and compiled it today. 
Unfortunately the PASEMI ethernet doesn't work.

Error message: pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

@All
Could you please also test Christoph's kernel on your PASEMI and NXP boards? Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian

