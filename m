Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5313AEB64D9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Jun 2023 16:14:12 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ya+LHoCu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QhnRQ5TCVz3bpq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Jun 2023 02:14:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ya+LHoCu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QhnQS095Xz2yV5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2023 02:13:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TVieQetclBnLRfOuxZVNk52q2nLwdGMxHN974XpGXPQ=; b=ya+LHoCutzqadGlvLhtIBbuiNM
	GruOqlr9jcSVhUYpOGkO4yYJl1t+jgo3J3IcfZELgzr7I9XuyT3HSQEv5jvjZ0SXEiG0KQUrqddcY
	ytcloUNN+WIEJjC2mba35qGuqrFHA5erZZgjqSIHhJb+hVV/nP09pwRtq2xggvBdHAd98em6sfNnx
	2u2ZT3sdsbld8Gsnqaabqox/ua9E2e41l0i3oM5xM/8D5P1RVYNhaWBwMnjITpoGuIuc7La0ntdKc
	qF2Uup7+KsDTMDVOIgF3QPr6bKa5f/+FztR8MMFabdXO5mEfRGfTrRlrTNgTR0gXsoQlwTWpvHmTB
	VQzTyizQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q9pb1-00FOO6-0G;
	Thu, 15 Jun 2023 16:13:15 +0000
Message-ID: <208f3734-4902-ff5c-3410-5b9cd984dad7@infradead.org>
Date: Thu, 15 Jun 2023 09:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
Content-Language: en-US
To: Timothy Pearson <tpearson@raptorengineering.com>
References: <20230602140143.0af52cee@canb.auug.org.au>
 <2d188c87-ef34-3812-7330-a985f756d959@infradead.org>
 <87h6rogjok.fsf@mail.lhotse>
 <586983120.3136676.1685851048873.JavaMail.zimbra@raptorengineeringinc.com>
 <e2b46606-7ebc-c9a4-4f9a-873c0e71da5e@infradead.org>
 <373175504.6295209.1686845130893.JavaMail.zimbra@raptorengineeringinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <373175504.6295209.1686845130893.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 6/15/23 09:05, Timothy Pearson wrote:
> 
> 
> ----- Original Message -----
>> From: "Randy Dunlap" <rdunlap@infradead.org>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "Michael Ellerman" <mpe@ellerman.id.au>
>> Cc: "Stephen Rothwell" <sfr@canb.auug.org.au>, "Linux Next Mailing List" <linux-next@vger.kernel.org>, "linux-kernel"
>> <linux-kernel@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Alexey Kardashevskiy" <aik@ozlabs.ru>
>> Sent: Thursday, June 15, 2023 11:00:08 AM
>> Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
> 
>> Hi Timothy,
>>
>> On 6/3/23 20:57, Timothy Pearson wrote:
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Michael Ellerman" <mpe@ellerman.id.au>
>>>> To: "Randy Dunlap" <rdunlap@infradead.org>, "Stephen Rothwell"
>>>> <sfr@canb.auug.org.au>, "Linux Next Mailing List"
>>>> <linux-next@vger.kernel.org>
>>>> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linuxppc-dev"
>>>> <linuxppc-dev@lists.ozlabs.org>, "Alexey
>>>> Kardashevskiy" <aik@ozlabs.ru>, "Timothy Pearson"
>>>> <tpearson@raptorengineering.com>
>>>> Sent: Saturday, June 3, 2023 7:22:51 PM
>>>> Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
>>>
>>>> Randy Dunlap <rdunlap@infradead.org> writes:
>>>>> On 6/1/23 21:01, Stephen Rothwell wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Changes since 20230601:
>>>>>>
>>>>>
>>>>> On powerpc64, a randconfig failed with:
>>>>>
>>>>> In file included from ../include/linux/list.h:5,
>>>>>                  from ../include/linux/preempt.h:11,
>>>>>                  from ../include/linux/spinlock.h:56,
>>>>>                  from ../include/linux/mmzone.h:8,
>>>>>                  from ../include/linux/gfp.h:7,
>>>>>                  from ../include/linux/slab.h:15,
>>>>>                  from ../arch/powerpc/kernel/iommu.c:15:
>>>>> ../arch/powerpc/kernel/iommu.c: In function
>>>>> 'spapr_tce_setup_phb_iommus_initcall':
>>>>> ../arch/powerpc/kernel/iommu.c:1391:36: error: 'hose_list' undeclared (first use
>>>>> in this function); did you mean 'zonelist'?
>>>>>  1391 |         list_for_each_entry(hose, &hose_list, list_node) {
>>>>>       |                                    ^~~~~~~~~
>>>> ...
>>>>
>>>> hose_list is in pci-common.c which is built when PCI=y.
>>>>
>>>> PSERIES and POWERNV force PCI=y.
>>>>
>>>> But this config has neither:
>>>>
>>>> # CONFIG_PPC_POWERNV is not set
>>>> # CONFIG_PPC_PSERIES is not set
>>>> CONFIG_HAVE_PCI=y
>>>> # CONFIG_PCI is not set
>>>> # CONFIG_COMMON_CLK_RS9_PCIE is not set
>>>>
>>>>
>>>> Probably the spapr_tce code should be wrapped in an #ifdef that is only
>>>> enabled when POWERNV || PSERIES is enabled.
>>>>
>>>> cheers
>>>
>>> Sounds reasonable, I was going to look into this further over the weekend.  I
>>> can put together a patch for Monday if that works?
>>
>> Did you prepare a patch for this? I am still seeing this build error.
>>
>> thanks.
>> --
>> ~Randy
> 
> Yes, it was sent in to the linuxppc-dev list some weeks ago.  Did it not arrive?

I don't know - I'm not subscribed to that list.

It's probably still in the patchworks review cycle
so it hasn't been applied anywhere that gets into linux-next.

thanks.
-- 
~Randy
