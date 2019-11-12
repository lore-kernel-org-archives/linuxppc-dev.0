Return-Path: <SRS0=XoDG=ZE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15001C43331
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 13:09:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C350F2084E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Nov 2019 13:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C350F2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47C7Nt0RMZzF38Y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=87.98.165.38; helo=6.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 599 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Nov 2019 00:05:18 AEDT
Received: from 6.mo2.mail-out.ovh.net (6.mo2.mail-out.ovh.net [87.98.165.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47C7JZ3g0WzF56D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2019 00:05:15 +1100 (AEDT)
Received: from player774.ha.ovh.net (unknown [10.109.143.24])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 363F71B4DED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2019 13:48:18 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id 06558BFF7DCC;
 Tue, 12 Nov 2019 12:48:14 +0000 (UTC)
Subject: Re: [PATCH] powerpc/xive: Prevent page fault issues in the machine
 crash handler
To: Michael Ellerman <mpe@ellerman.id.au>
References: <20191031063100.3864-1-clg@kaod.org>
 <871rud2riv.fsf@mpe.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <96933f3e-d3a6-0763-869e-f5172e5b38af@kaod.org>
Date: Tue, 12 Nov 2019 13:48:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <871rud2riv.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12254857536652282813
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddvledggeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghenucevlhhushhtvghrufhiiigvpedt
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
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kurz <groug@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/11/2019 13:44, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
>> When the machine crash handler is invoked, all interrupts are masked
>> but interrupts which have not been started yet do not have an ESB page
>> mapped in the Linux address space. This crashes the 'crash kexec'
>> sequence on sPAPR guests.
> 
> This sounds like it needs a Fixes/stable tag?

yes.

> I used these:
> 
>   Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
>   Cc: stable@vger.kernel.org # v4.12+
>
> Please tell me if you think that's wrong.

Looks OK to me. 

Thanks,

C. 


 
> cheers
> 
> 
>> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
>> index df832b09e3e9..f5fadbd2533a 100644
>> --- a/arch/powerpc/sysdev/xive/common.c
>> +++ b/arch/powerpc/sysdev/xive/common.c
>> @@ -1035,6 +1035,15 @@ static int xive_irq_alloc_data(unsigned int virq, irq_hw_number_t hw)
>>  	xd->target = XIVE_INVALID_TARGET;
>>  	irq_set_handler_data(virq, xd);
>>  
>> +	/*
>> +	 * Turn OFF by default the interrupt being mapped. A side
>> +	 * effect of this check is the mapping the ESB page of the
>> +	 * interrupt in the Linux address space. This prevents page
>> +	 * fault issues in the crash handler which masks all
>> +	 * interrupts.
>> +	 */
>> +	xive_esb_read(xd, XIVE_ESB_SET_PQ_01);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.21.0

