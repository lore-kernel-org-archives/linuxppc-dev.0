Return-Path: <pku.leo@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id EEC70DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 20:41:02 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so158755nfd.9
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 03:40:59 -0700 (PDT)
Message-ID: <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
Date: Thu, 25 Sep 2008 18:40:59 +0800
From: "Li Yang" <leoli@freescale.com>
Sender: pku.leo@gmail.com
To: "Wang Jian" <lark@linux.net.cn>
Subject: Re: [PATCH] pata_platform struct resource signness fix
In-Reply-To: <48DB51C3.6040504@linux.net.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
> The alternative fix can be.

This one is better as 0 is defined as 'invalid irq' for all
architectures.  Added linux-ide and Anton to cc.

- Leo

>
> diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
> index 408da30..1f18ad9 100644
> --- a/drivers/ata/pata_of_platform.c
> +++ b/drivers/ata/pata_of_platform.c
> @@ -52,7 +52,7 @@ static int __devinit pata_of_platform_probe(struct
> of_device *ofdev,
>
>        ret = of_irq_to_resource(dn, 0, &irq_res);
>        if (ret == NO_IRQ)
> -               irq_res.start = irq_res.end = -1;
> +               irq_res.start = irq_res.end = 0;
>        else
>                irq_res.flags = 0;
>
> I just didn't spend much time to see which is better.
>
> Wang Jian wrote:
>>
>> Hi,
>>
>> This patch is to pata_platform.c but at this time, it's powerpc specific
>> because it can only be triggerred using openfirmware, so I post the patch
>> here. The patch is against 2.6.26-rc8.
>>
>> The problem is triggerred when ata device is populated using
>> pata_of_platform.c, and no irq is assigned (poll mode, such as CF card).
>>
>> pata_of_platform_probe() parse device tree and
>>
>>        if (ret == NO_IRQ)
>>                        irq_res.start = irq_res.end = -1;
>>
>> Then irq is 0xffffffff, not NULL. Probe will fail coz irq can't be
>> requested.
>>
>>
>> ---
>> (irq_res->start > 0) will be true even when it is (-1). When the device
>> has no irq, irq_res->start is assigned (-1).
>>
>> Signed-off-by: Wang Jian <lark@linux.net.cn>
>> ---
>>  drivers/ata/pata_platform.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>> index 8f65ad6..b12cd0c 100644
>> --- a/drivers/ata/pata_platform.c
>> +++ b/drivers/ata/pata_platform.c
>> @@ -123,7 +123,7 @@ int __devinit __pata_platform_probe(struct device
>> *dev,
>>        /*
>>         * And the IRQ
>>         */
>> -       if (irq_res && irq_res->start > 0) {
>> +       if (irq_res && irq_res->start != -1) {
>>                irq = irq_res->start;
>>                irq_flags = irq_res->flags;
>>        }
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
