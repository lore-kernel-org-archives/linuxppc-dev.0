Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08982C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:33:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B903921019
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 15:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="QSvVR549"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B903921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435M3l0K89zDqg4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 02:33:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="QSvVR549";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::2; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="QSvVR549"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435M0r4P1BzDrFY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 02:30:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1543505433;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=JgdgvdTu/o0yT27LCN+jL9f+Mispkq92cGvwyIeIznA=;
 b=QSvVR549X/JI5RQddA5Ce6ANbUVaotMXB94ougoSmAoUKt6RQYZQZQkvc1E7koopWe
 +i/9R60cGc8C4FhJLfsuVG1gCg7eRyAJqxi3jyLsdQQ6ITwJpzjlLL7qiOVZb7CaEzNI
 +YeT280SoGZ09lmmHsDw3V7Go3lc2+db0rZB3SY/vgh3erld1u2ZN7pzJR+mXTThrEFm
 VnHio6E0hwxSxpuulTm4MxdhDakHxzgQt4d1Wv6fyF6RK7cTOBzPY3QXmZvw/AQWdTAQ
 vYOM+KywEgO4YD5QXHO+tjCSzQg2l8m0iRelfg8S7XYRPOKKzn3NeHXH7fZo8ma6/16s
 n+9g==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkJi0VMkvuN7Z4uCrs4n97IXLTUkg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:65d3:91db:4cc8:8cf2]
 by smtp.strato.de (RZmta 44.6 AUTH) with ESMTPSA id 404b20uATFU6CwU
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 29 Nov 2018 16:30:06 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
Message-ID: <35b94e7c-89ca-9e11-e79a-048c5c8c5f03@xenosoft.de>
Date: Thu, 29 Nov 2018 16:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 29 November 2018 at 1:05PM, Christian Zigotzky wrote:
> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> Any comments?  I'd like to at least get the ball moving on the easy
>>> bits.
>> Nothing specific yet.
>>
>> I'm a bit worried it might break one of the many old obscure platforms
>> we have that aren't well tested.
>>
>> There's not much we can do about that, but I'll just try and test it on
>> everything I can find.
>>
>> Is the plan that you take these via the dma-mapping tree or that they go
>> via powerpc?
>>
>> cheers
>>
> Hi All,
>
> I compiled a test kernel from the following Git today.
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4 
>
>
> Command: git clone git://git.infradead.org/users/hch/misc.git -b 
> powerpc-dma.4 a
>
> Unfortunately I get some DMA error messages and the PASEMI ethernet 
> doesn't work anymore.
>
> [  367.627623] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.627631] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.627639] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.627647] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.627655] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.627686] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.628418] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.628505] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.628592] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.629324] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.629417] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.629495] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
> [  367.629589] pci 0000:00:1a.0: dma_direct_map_page: overflow 
> 0x000000026bcb5002+110 of device mask ffffffff bus mask 0
>
> [  430.424732]pasemi_mac: rcmdsta error: 0x04ef3001
>
> I tested this kernel with the Nemo board (CPU: PWRficient PA6T-1682M). 
> The PASEMI ethernet works with the RC4 of kernel 4.20.
>
> Cheers,
> Christian
>
Hi All,

I tested this kernel on my NXP QorIQ P5020 board. U-Boot loads the dtb 
file and the kernel and after that the booting stops. This board works 
with the RC4 of kernel 4.20. Please test this kernel on your NXP and 
PASEMI boards.

Thanks,
Christian

