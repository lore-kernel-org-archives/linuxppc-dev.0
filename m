Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFBEC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:51:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687C420851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 17:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="JEzlKgzD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687C420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43G1Sv0ZwkzDr0w
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 04:51:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="JEzlKgzD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (helo) smtp.helo=mo6-p01-ob.smtp.rzone.de
 (client-ip=2a01:238:20a:202:5301::3; helo=mo6-p01-ob.smtp.rzone.de;
 envelope-from=chzigotzky@xenosoft.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="JEzlKgzD"; 
 dkim-atps=neutral
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43G1Q11w3WzDqn5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 04:48:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1544723332;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Of7oTw5jTTkuJTzXvQHcn/Fc5ay4FOtgQImzS9tWHto=;
 b=JEzlKgzD74b5cQiehWte2PxFixStAb1UQceO0ux7pbb/b0puGAopZQiM4Npr/1LYHw
 hEIKawjLAoqq7NDDovIQKVbvOAWmpie6qAW7HcUJPQY6wh1kuYUXUylg44IGsDfPP5b9
 4xatI9k62kSSNT7u6DgCJfjA8hFSssYhG/3xagGSHFrMbeua8OWQH/+p1sVqQldfRyav
 jcHSkK6eyEwxiatlpD9RxJb7KA7h3zFbi8rqgrMspXH/80oKu/yG0882UtTiWbd2tI6c
 mOWPWJNNcsqpEB9y9uIquQPHPdL/KIciw+EjKKoph8CYUZyTABsF61FkuedRAbXFZaO7
 fq8Q==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5G5MdirQj0WG7ClajjwgokhuvHTHIj4bTSStuhrtbw=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a02:8109:a400:162c:e00d:b70a:c44f:a515]
 by smtp.strato.de (RZmta 44.8 AUTH) with ESMTPSA id e03c1euBDHmc3YM
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate);
 Thu, 13 Dec 2018 18:48:38 +0100 (CET)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Christoph Hellwig <hch@lst.de>
References: <1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
 <6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
 <4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
 <82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
 <20181212141556.GA4801@lst.de>
 <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
 <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
 <20181213091021.GA2106@lst.de>
 <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de>
 <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de>
 <20181213112511.GA4574@lst.de>
 <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
Message-ID: <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de>
Date: Thu, 13 Dec 2018 18:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de>
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

On 13 December 2018 at 2:34PM, Christian Zigotzky wrote:
> On 13 December 2018 at 12:25PM, Christoph Hellwig wrote:
>> On Thu, Dec 13, 2018 at 12:19:26PM +0100, Christian Zigotzky wrote:
>>> I tried it again but I get the following error message:
>>>
>>> MODPOST vmlinux.o
>>> arch/powerpc/kernel/dma-iommu.o: In function 
>>> `.dma_iommu_get_required_mask':
>>> (.text+0x274): undefined reference to `.dma_direct_get_required_mask'
>>> make: *** [vmlinux] Error 1
>> Sorry, you need this one liner before all the patches posted last time:
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index d8819e3a1eb1..7e78c2798f2f 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -154,6 +154,7 @@ config PPC
>>       select CLONE_BACKWARDS
>>       select DCACHE_WORD_ACCESS        if PPC64 && CPU_LITTLE_ENDIAN
>>       select DYNAMIC_FTRACE            if FUNCTION_TRACER
>> +    select DMA_DIRECT_OPS
>>       select EDAC_ATOMIC_SCRUB
>>       select EDAC_SUPPORT
>>       select GENERIC_ATOMIC64            if PPC32
>>
> Thanks. Result: PASEMI onboard ethernet works and the X5000 (P5020 
> board) boots with the patch '0001-get_required_mask.patch'.
>
> -- Christian
>
>
Next patch: '0002-swiotlb-dma_supported.patch' for the last good commit 
(977706f9755d2d697aa6f45b4f9f0e07516efeda).

The PASEMI onboard ethernet works and the X5000 (P5020 board) boots.

-- Christian

