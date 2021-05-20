Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B31BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 14:55:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DFB61073
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 14:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DFB61073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmCV03Xhzz3bsW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 00:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kaod.org (client-ip=46.105.48.137; helo=9.mo51.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
X-Greylist: delayed 6612 seconds by postgrey-1.36 at boromir;
 Fri, 21 May 2021 00:55:28 AEST
Received: from 9.mo51.mail-out.ovh.net (9.mo51.mail-out.ovh.net
 [46.105.48.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmCTX4plJz2xfr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 00:55:26 +1000 (AEST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.192])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 1A76629D677;
 Thu, 20 May 2021 14:27:11 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.10; Thu, 20 May
 2021 14:27:11 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00519fae841-2a46-42a8-9273-0eeeffdc5bf7,
 2C87984337330801490BFDABE922B5CE11A7A10A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 176.145.65.252
Subject: Re: [PATCH 31/31] genirq: Improve "hwirq" output in /proc and /sys/
To: Thomas Gleixner <tglx@linutronix.de>, <linuxppc-dev@lists.ozlabs.org>
References: <20210430080407.4030767-1-clg@kaod.org>
 <20210430080407.4030767-32-clg@kaod.org>
 <87mtsx2g7l.ffs@nanos.tec.linutronix.de>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <14b71a4b-fac6-a1c0-1707-436c86b9b6ec@kaod.org>
Date: Thu, 20 May 2021 14:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87mtsx2g7l.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: fa3c8968-2b80-4b8b-beaf-2916292170ad
X-Ovh-Tracer-Id: 6169650017286458333
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdejuddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggv
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 5/14/21 10:49 PM, Thomas Gleixner wrote:
> On Fri, Apr 30 2021 at 10:04, Cédric Le Goater wrote:
>> The HW IRQ numbers generated by the PCI MSI layer can be quite large
>> on a pSeries machine when running under the IBM Hypervisor and they
>> appear as negative. Use '%u' to show them correctly.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  kernel/irq/irqdesc.c | 2 +-
>>  kernel/irq/proc.c    | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index cc1a09406c6e..85054eb2ae51 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -188,7 +188,7 @@ static ssize_t hwirq_show(struct kobject *kobj,
>>  
>>  	raw_spin_lock_irq(&desc->lock);
>>  	if (desc->irq_data.domain)
>> -		ret = sprintf(buf, "%d\n", (int)desc->irq_data.hwirq);
>> +		ret = sprintf(buf, "%u\n", (int)desc->irq_data.hwirq);
> 
> Which makes the (int) cast pointless, right?

Well, hwirq is a long. Would you prefer a "%lu" for both ?

Thanks,

C.

> 
>>  	raw_spin_unlock_irq(&desc->lock);
>>  
>>  	return ret;
>> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
>> index 98138788cb04..e2392f05da04 100644
>> --- a/kernel/irq/proc.c
>> +++ b/kernel/irq/proc.c
>> @@ -513,7 +513,7 @@ int show_interrupts(struct seq_file *p, void *v)
>>  		seq_printf(p, " %8s", "None");
>>  	}
>>  	if (desc->irq_data.domain)
>> -		seq_printf(p, " %*d", prec, (int) desc->irq_data.hwirq);
>> +		seq_printf(p, " %*u", prec, (int)desc->irq_data.hwirq);
> 
> ditto.
> 
> Thanks,
> 
>         tglx
> 

