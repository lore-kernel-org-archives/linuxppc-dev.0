Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4C7EDE25A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 01:33:43 +1000 (EST)
Message-ID: <48DBAF4F.3020003@linux.net.cn>
Date: Thu, 25 Sep 2008 23:33:35 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
	<2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
In-Reply-To: <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Li Yang wrote:
> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>> The alternative fix can be.
> 
> This one is better as 0 is defined as 'invalid irq' for all
> architectures.  Added linux-ide and Anton to cc.

However, this is not very true. Just git grep "#define NO_IRQ" and see. It
seems that the NO_IRQ is in transition from (-1) to (0).

I happened to code the same 2 patches as Anton Vorontsov <avorontsov@ru.mvista.com>
had done without knowing his earlier work. I think he was also confused by (-1)
and (0).

> 
> - Leo
> 
>> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
>> index 408da30..1f18ad9 100644
>> --- a/drivers/ata/pata_of_platform.c
>> +++ b/drivers/ata/pata_of_platform.c
>> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct
>> of_device *ofdev,
>>
>>        ret = of_irq_to_resource(dn, 0, &irq_res);
>>        if (ret == NO_IRQ)
>> -               irq_res.start = irq_res.end = -1;
>> +               irq_res.start = irq_res.end = 0;
>>        else
>>                irq_res.flags = 0;
>>
>> I just didn't spend much time to see which is better.
>>
>> Wang Jian wrote:
>>> Hi,
>>>
>>> This patch is to pata_platform.c but at this time, it's powerpc specific
>>> because it can only be triggerred using openfirmware, so I post the patch
>>> here. The patch is against 2.6.26-rc8.
>>>
>>> The problem is triggerred when ata device is populated using
>>> pata_of_platform.c, and no irq is assigned (poll mode, such as CF card).
>>>
>>> pata_of_platform_probe() parse device tree and
>>>
>>>        if (ret == NO_IRQ)
>>>                        irq_res.start = irq_res.end = -1;
>>>
>>> Then irq is 0xffffffff, not NULL. Probe will fail coz irq can't be
>>> requested.
>>>
>>>
>>> ---
>>> (irq_res->start > 0) will be true even when it is (-1). When the device
>>> has no irq, irq_res->start is assigned (-1).
>>>
>>> Signed-off-by: Wang Jian <lark@linux.net.cn>
>>> ---
>>>  drivers/ata/pata_platform.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>>> index 8f65ad6..b12cd0c 100644
>>> --- a/drivers/ata/pata_platform.c
>>> +++ b/drivers/ata/pata_platform.c
>>> @@ -123,7 +123,7 @@ int __devinit __pata_platform_probe(struct device
>>> *dev,
>>>        /*
>>>         * And the IRQ
>>>         */
>>> -       if (irq_res && irq_res->start > 0) {
>>> +       if (irq_res && irq_res->start != -1) {
>>>                irq = irq_res->start;
>>>                irq_flags = irq_res->flags;
>>>        }
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
> 
> 
