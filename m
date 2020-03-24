Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFD5C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 12:29:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B682070A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 12:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B682070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48mrCj60fxzDqMM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 23:29:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.50.107; helo=6.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo69.mail-out.ovh.net (6.mo69.mail-out.ovh.net
 [46.105.50.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48mr8x6YMTzDqZj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 23:26:54 +1100 (AEDT)
Received: from player691.ha.ovh.net (unknown [10.110.103.225])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 57BB589078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 13:21:01 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 1E5F810D1BF1E;
 Tue, 24 Mar 2020 12:20:40 +0000 (UTC)
Subject: Re: [PATCH v8 04/14] powerpc/vas: Alloc and setup IRQ and trigger
 port address
To: Haren Myneni <haren@linux.ibm.com>
References: <1584598120.9256.15237.camel@hbabu-laptop>
 <1584598473.9256.15248.camel@hbabu-laptop>
 <396db62b-5342-a1b3-eade-a219afd98fc7@kaod.org>
 <bd846a9c-0e21-1d97-0b03-e01c35ff01ae@kaod.org>
 <1584990135.9256.15381.camel@hbabu-laptop>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <475d136f-5b71-6c6c-c206-4a528565e6ff@kaod.org>
Date: Tue, 24 Mar 2020 13:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584990135.9256.15381.camel@hbabu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 18099122480320777209
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrgh
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
Cc: mikey@neuling.org, herbert@gondor.apana.org.au,
 Frederic Barrat <frederic.barrat@fr.ibm.com>, npiggin@gmail.com,
 hch@infradead.org, oohall@gmail.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, ajd@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/23/20 8:02 PM, Haren Myneni wrote:
> On Mon, 2020-03-23 at 10:27 +0100, Cédric Le Goater wrote:
>> On 3/23/20 10:06 AM, Cédric Le Goater wrote:
>>> On 3/19/20 7:14 AM, Haren Myneni wrote:
>>>>
>>>> Alloc IRQ and get trigger port address for each VAS instance. Kernel
>>>> register this IRQ per VAS instance and sets this port for each send
>>>> window. NX interrupts the kernel when it sees page fault.
>>>
>>> I don't understand why this is not done by the OPAL driver for each VAS 
>>> of the system. Is the VAS unit very different from OpenCAPI regarding
>>> the fault ? 
>>
>> I checked the previous patchsets and I see that v3 was more like I expected
>> it: one interrupt for faults allocated by the skiboot driver and exposed  
>> in the DT.
>>
>> What made you change your mind ? 
>>
>> This version is hijacking the lowlevel routines of the XIVE irqchip which
>> is not the best approach. OCXL is doing that because it needs to allocate
>> interrupts for the user space processes using the AFU and we should rework 
>> that part. 
>>
>> However, the translation fault interrupt is allocated by skiboot.
> 
> Sorry my mistake. I should have CC you earlier. 
> 
> Each VAS instance will generate fault interrupt which is per chip. There
> won't be other job completion interrupts. 

That's a very good reason to set everything in the skiboot driver and 
advertise the interrupt number in the DT. The interrupt will be mapped
automatically by OF routines and the driver will only have to install
an interrupt handler. 

> Correct, V3 used allocating interrupts per chip in skiboot and exposed
> in DT. Since XIVE code has similar feature, exploited this approach so
> that we do not need skiboot changes. 

It's not the same. These are the low level (OPAL) interface used by the 
XIVE driver. The exception is the KVM XIVE device which needs a finer
grain. 

C.
