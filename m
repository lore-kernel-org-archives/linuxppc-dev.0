Return-Path: <SRS0=4FME=QK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64911C169C4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 16:51:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962F821773
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 16:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="q+k3zJAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962F821773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43sxg95n3ZzDqHF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 03:51:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::3; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="q+k3zJAw"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43sxdG1BYwzDqDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 03:49:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549212555;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=B6q2ei1aHR9lzl0hOvwoWBIVmVDE9nFvmFewblIeLYs=;
 b=q+k3zJAwT+iOJ0eUSHjBsX1gX/TwmrIdOVHLMBKMyCWTFy3zd506ce1opOd32TRP+Q
 exRuhMKXv5K1wyslFDn4QoQOv2GZfDN8BMknedtrjEcifhF94j7q0zl3cTzAcuuP24W6
 MT8tnPjDscqdl5Pth8l8QdvVpnR4qSWdGSXjmBpLh/uGnN42pWn8SU/NItWb6DbBnBYw
 Nt9rDXeKFF1W0DOktwEiyDNRPqJ3kjv1qcV5KSWejTNyGW+gS0CAdcKeIbFUmy6X58Pz
 Qz1ctu1E+2DwHX8I/5RK8SBpzX2pyeOEiBmmG2P5u0O+4etVZ1UQBPMHwv/Hak9dp65C
 3n9w==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7CkH3W0cWmG9fyXgS4bddBxLVsnYjg=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:8c9a:b0b5:e3d3:9527]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv13Gn2cCf
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Sun, 3 Feb 2019 17:49:02 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
 <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
Message-ID: <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
Date: Sun, 3 Feb 2019 17:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
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

OK, next step: b50f42f0fe12965ead395c76bcb6a14f00cdf65b (powerpc/dma: 
use the dma_direct mapping routines)

git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a

git checkout b50f42f0fe12965ead395c76bcb6a14f00cdf65b

Results: The X1000 and X5000 boot but unfortunately the P.A. Semi 
Ethernet doesn't work.

-- Christian


On 01 February 2019 at 5:54PM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I will try it at the weekend.
>
> Thanks,
> Christian
>
> Sent from my iPhone
>
>> On 1. Feb 2019, at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Thu, Jan 31, 2019 at 01:48:26PM +0100, Christian Zigotzky wrote:
>>> Hi Christoph,
>>>
>>> I compiled kernels for the X5000 and X1000 from your branch 'powerpc-dma.6'
>>> today.
>>>
>>> Gitweb:
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6
>>>
>>> git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.6 a
>>>
>>> The X1000 and X5000 boot but unfortunately the P.A. Semi Ethernet doesn't
>>> work.
>> Oh.  Can you try with just the next one and then two patches applied
>> over the working setup?  That is first:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/b50f42f0fe12965ead395c76bcb6a14f00cdf65b
>>
>> then also with:
>>
>> http://git.infradead.org/users/hch/misc.git/commitdiff/21fe52470a483afbb1726741118abef8602dde4d


