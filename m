Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D2C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:46:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DEA20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="g1zsoNT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DEA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zMpQ2MSFzDqPb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 23:46:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::7; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="g1zsoNT2"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zMl856H6zDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:43:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1549975389;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=eKLC3wnjS0ITavNG6BmsDxnHT4lHbHcc+BrIvQ3BRho=;
 b=g1zsoNT2G5b4LIEbwkswlPSgdvZFKkd1fZNxaXSCRfVwYy1hgyZnlT87T84PvSt/qC
 Z1qPpkZadXLyFcW7zWlEVPPsZIEYyzLpKnlCrVwI6tx4Jnu0fHIfqiMYOlsouftdcEDJ
 3QkCyxSfbWaOao/mc58Vt1KIlUPdOrqKOK22c9IyUh8avAvBtdAIp/BCIK9apdEOVnua
 VpiVwaFCIxkfrkfH5b7Nz11CzCdHANPpVGHMe2EsOfcK4OE7bUuhiSIaYDLcUlxzzZuM
 ci800/fpteox5q1F0h8cqowIZ9aOXccXPUSTaqt6qGNBsv4ZQ5aMrg5NutkHXXG0aNz/
 dYXw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7ClcioYo/H7zE+E9pbb1CjeE951P"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:c4b:ac82:e1cc:51e0]
 by smtp.strato.de (RZmta 44.9 AUTH) with ESMTPSA id t0203dv1CCguPCQ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Tue, 12 Feb 2019 13:42:56 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
To: Christoph Hellwig <hch@lst.de>
References: <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
 <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
 <20190208091818.GA23491@lst.de>
 <4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
 <20190211073804.GA15841@lst.de>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
Date: Tue, 12 Feb 2019 13:42:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211073804.GA15841@lst.de>
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

On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>> I tested the whole series today. The kernels boot and the P.A. Semi
>> Ethernet works! :-) Thanks a lot!
>>
>> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the
>> kernel crashes.
> This looks like a patch I fixed in mainline a while ago, but which
> the powerpc tree didn't have yet.
>
> I've cherry picked this commit
> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>
> and added it to the powerpc-dma.6 tree, please retry with that one.
>
Hello Christoph,

Have you added it to the powerpc-dma.6 tree yet? The last commit was 4 
days ago.

Thanks,
Christian

