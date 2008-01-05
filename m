Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 37BDFDDE36
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:30:55 +1100 (EST)
Message-ID: <477FCCDE.3030404@pikatech.com>
Date: Sat, 05 Jan 2008 13:30:54 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
References: <477EF225.4070505@pikatech.com> <200801051224.52693.arnd@arndb.de>
In-Reply-To: <200801051224.52693.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Saturday 05 January 2008, Sean MacLennan wrote:
>   
>> I converted the i2c-ibm_iic driver from an ocp driver to an of_platform 
>> driver. Since this driver is in the kernel.org kernel, should I rename 
>> it and keep the old one around? I notice this was done with the emac 
>> network driver.
>>     
>
> The interesting question is whether there are any functional users in
> arch/ppc left for the original driver. If all platforms that used
> to use i2c-ibm_iic are broken already, you can can go ahead with
> the conversion. Otherwise, there are two options:
>
> 1. duplicate the driver like you suggested
> 2. make the same driver both a ocp and of_platform, depending on
> the configuration options.
>
> Since most of the driver is untouched by your patch, I'd lean to
> the second option, but of course, that is more work for you.
>   
Given Stefan subsequent post, I'll go with the second option.
> Your patch otherwise looks good, but I have a few comments on
> details:
>
>   
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -241,7 +241,6 @@ config I2C_PIIX4
>>  
>>  config I2C_IBM_IIC
>>         tristate "IBM PPC 4xx on-chip I2C interface"
>> -       depends on IBM_OCP
>>         help
>>           Say Y here if you want to use IIC peripheral found on 
>>           embedded IBM PPC 4xx based systems. 
>>     
>
> In any way, this one now needs to depend on PPC_MERGE now, you
> could even make it depend on PPC_4xx, but it's often better to
> allow building the driver when you can, even if it doesn't make
> sense on your hardware. This gives a better compile coverage.
>
>   
>> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
>> index 9b43ff7..838006f 100644
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -3,6 +3,10 @@
>>   *
>>   * Support for the IIC peripheral on IBM PPC 4xx
>>   *
>> + * Copyright (c) 2008 PIKA Technologies
>> + * Sean MacLennan <smaclennan@pikatech.com>
>> + *  Converted to an of_platform_driver.
>> + *
>>     
>
> Changelogs in the file itself are discouraged. In this case, it's just
> one line, so it's not really harmful.
>
> I think the convention is for copyrights to be in chronological order,
> so you should put the copyright below Eugene's.
>   
Ok, I will change it. To be honest, I didn't think it was enough of a 
change to actually be worth a copyright, but PIKA is a little touchy 
about copyrights right now and I wanted to point out I *only* did the 
port. I will remove the changelog and move the copyright notice.
>   
>>   * Copyright (c) 2003, 2004 Zultys Technologies.
>>   * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
>>   *
>>     
>
>
>   
>> +       dev->idx = index++;
>> +
>> +       dev_set_drvdata(&ofdev->dev, dev);
>> +
>> +       if((addrp = of_get_address(np, 0, NULL, NULL)) == NULL ||
>> +          (addr = of_translate_address(np, addrp)) == OF_BAD_ADDR) {
>> +               printk(KERN_CRIT "ibm-iic%d: Unable to get iic address\n",
>> +                          dev->idx);
>>                 ret = -EBUSY;
>>                 goto fail1;
>>         }
>>  
>> -       if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
>> +       if (!(dev->vaddr = ioremap(addr, sizeof(struct iic_regs)))){
>>                 printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
>>                         dev->idx);
>>                 ret = -ENXIO;
>> -               goto fail2;
>> +               goto fail1;
>>         }
>>     
>
> Use of_iomap here to save a few lines.
>
>   
Cool, I didn't notice that function.
>>         init_waitqueue_head(&dev->wq);
>>  
>> -       dev->irq = iic_force_poll ? -1 : ocp->def->irq;
>> -       if (dev->irq >= 0){
>> +       if(iic_force_poll)
>> +               dev->irq = -1;
>> +       else if((dev->irq = irq_of_parse_and_map(np, 0)) == NO_IRQ) {
>> +               printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
>> +               dev->irq = -1;
>> +       }
>> +
>> +       if (dev->irq >= 0) {
>>                 /* Disable interrupts until we finish initialization,
>>                    assumes level-sensitive IRQ setup...
>>                  */
>>     
>
> This was in the original driver, but I think it's wrong anyway:
> irq == 0 could be valid, so you shouldn't compare against that
> in general. Use NO_IRQ as a symbolic way to express an invalid
> IRQ (yes, I'm aware that NO_IRQ is currently defined to 0).
>   
Ok.
>   
>> @@ -711,23 +722,30 @@ static int __devinit iic_probe(struct ocp_device *ocp){
>>         
>>         if (dev->irq < 0)
>>                 printk(KERN_WARNING "ibm-iic%d: using polling mode\n", 
>> -                       dev->idx);
>> +                          dev->idx);
>>                 
>>         /* Board specific settings */
>> -       dev->fast_mode = iic_force_fast ? 1 : (iic_data ? iic_data->fast_mode : 0);
>> +       dev->fast_mode = iic_force_fast ? 1 : 0;
>>     
>
> If there is a good reason to specify fast or slow mode per board, you may want
> to make that a property in the device node.
>
>   
Ok. I really don't know, none of the board ports I looked at used fast mode.
>> +
>> +static struct of_device_id ibm_iic_match[] =
>>  {
>> -       { .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_IIC },
>> -       { .vendor = OCP_VENDOR_INVALID }
>> +       { .type = "i2c", .compatible = "ibm,iic", },
>> +       {}
>>  };
>>     
>
> This is probably not specific enough. I'm rather sure that someone at IBM
> has implemented an i2c chip that this driver doesn't support. Maybe
>
> 	.compatible = "ibm,405-iic"
>
> or similar would be a better thing to check for.
>
> 	Arnd <><
>   

Ok, I will look into this.

Cheers,
    Sean
