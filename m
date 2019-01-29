Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97AEC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951222175B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="Vt1Np9Vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951222175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pqb95JnPzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 02:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p02-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5302::12; helo=mo6-p02-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="Vt1Np9Vt"; 
 dkim-atps=neutral
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5302::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pqWy2xZZzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 02:03:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1548774232;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=54BYA5R8WWU/JT6uen3I6PSN41rOBysT9ibhJ3C66mE=;
 b=Vt1Np9VtM5wxkjy7yZ2uypJGwc9M2twe4XSlbqj241uuGAqJwpJIJ2jVa5za5Uwl5m
 K02z/W1atUrGi6t+rZNQBBXJ0BuW+kQGfesSxeuynBHjAIz/GaXiF3+Bguo8EE/2YQXM
 yJWnJaVlQnpXGcNIIEOjo4NfNBYk9WvWe68bs6nAUuFcrJrqWnS28pIQqMtBnDw8HdyO
 Z5XjcdIFtmvofgmH5Pn6dj+VsOFwf9FSXSe72KPI0YpVi4HFvKqeWg7mk6z20RCLF61Z
 bnWCcEiyhQrFK81cFZ6YpO0b/9YznqjQln8B++WcHBNxbzhHpjsT7Si7Ar3TW50eLhFz
 5Aiw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkMj7d8MwbIAsOkSwoB8cVrNHNchA=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:31f7:8c35:dc40:528c]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv0TF3XAMu
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 29 Jan 2019 16:03:33 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
Message-ID: <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
Date: Tue, 29 Jan 2019 16:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
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

I compiled kernels for the X5000 and X1000 from your new branch 
'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi 
Ethernet works!

Cheers,
Christian


On 28 January 2019 at 5:52PM, Christian Zigotzky wrote:
> Thanks a lot! I will test it tomorrow.
>
> — Christian
>
> Sent from my iPhone
>
>> On 28. Jan 2019, at 17:22, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Mon, Jan 28, 2019 at 08:04:22AM +0100, Christoph Hellwig wrote:
>>>> On Sun, Jan 27, 2019 at 02:13:09PM +0100, Christian Zigotzky wrote:
>>>> Christoph,
>>>>
>>>> What shall I do next?
>>> I'll need to figure out what went wrong with the new zone selection
>>> on powerpc and give you another branch to test.
>> Can you try the new powerpc-dma.6-debug.2 branch:
>>
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.6-debug.2
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug.2
>

