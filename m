Return-Path: <SRS0=TRtS=2J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E21C43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 13:57:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7703D218AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 13:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="r0KFI0F2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7703D218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dtjX0b9YzDqtS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Dec 2019 00:57:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo6-p01-ob.smtp.rzone.de (client-ip=2a01:238:20a:202:5301::2;
 helo=mo6-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="r0KFI0F2"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dtft0yPFzDqqD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2019 00:55:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576763695;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=kI2ukjRy7KCFsfSWtfjMgsGPbi2sbVneeGOg1X7LIV8=;
 b=r0KFI0F2jAfR7x3po2hTuzbx9QuE1cnq5Not5BJwqpsvU9jO5Xxx0Za5EL/ql8Qmr2
 sKOte7fMifbOy3poCwGlHOU1Ati1I9EigYmOB+hA6/uH8+lucovEi0VnZJM23Onwbtjd
 ZLMTYiMhPJygQnsAxJSPnZbUv73B6X/adLdZWofYI+jx4CO2Sepqy4IhmDti2+UUKiER
 OZZC2Rhr6GDkMoxhKOguv+6pxJji7+UezRq3kJTNvjyKpE/V8GLDa3L7n9KxElgGgyrI
 2JyI6/fjR+2T8qMEHdu+2c6DhDM6wj77qzT9+68TVs/z9h+U5/OfjazjqlcWxU3HaVvX
 XKxg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPhSIk4IhhIsapUrtwdiemkXf6zUCQ=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:89c0:ebfc:141e:1690:4104:28ad]
 by smtp.strato.de (RZmta 46.1.1 AUTH) with ESMTPSA id 40080evBJDsS14t
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 19 Dec 2019 14:54:28 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Message-ID: <ea5433f6-ef8d-3cd0-0645-dd89c4806dca@xenosoft.de>
Date: Thu, 19 Dec 2019 14:54:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
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
 mad skateman <madskateman@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 "contact@a-eon.com" <contact@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi All,

We still have some issues with PCI cards in our FSL P5020 and P5040 
systems since the DMA mapping updates. [1, 2]

We have to limit the RAM to 3500MB for some problematic PCI cards. 
(kernel boot argument 'mem=3500M')

The problematic DMA mapping code was added with the PowerPC updates 
4.21-1 to the official kernel source code last year. [3]

We have created a bug report. [4]

The old 4.x kernels aren't affected because they use the old DMA code.

Please check the new DMA code again.

Thanks,
Christian

[1] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&p=49486#p49486
[2] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=50#p49099
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d6973327ee84c2f40dd9efd8928d4a1186c96e2
[4] https://bugzilla.kernel.org/show_bug.cgi?id=205201


On 28 November 2018 at 4:55 pm, Christian Zigotzky wrote:
> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
>> Nothing specific yet.
>>
>> I'm a bit worried it might break one of the many old obscure platforms
>> we have that aren't well tested.
>>
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old 
> code works perfect. We must not forget, that we work for the end 
> users. Does the end user have advantages with this new code? Is it 
> faster? The old code works without any problems. I am also worried 
> about this code. How can I test this new DMA mapping code?
>
> Thanks
>
>

