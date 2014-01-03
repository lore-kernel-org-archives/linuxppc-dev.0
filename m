Return-Path: <jjhiblot@traphandler.com>
Received: from mo3.mail-out.ovh.net (13.mo3.mail-out.ovh.net [188.165.33.202])
 by ozlabs.org (Postfix) with ESMTP id 5164F2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 03:34:54 +1100 (EST)
Received: from mail628.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo3.mail-out.ovh.net (Postfix) with SMTP id D85C9FFAA37
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 16:57:20 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id v10so15577007pde.28
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jan 2014 07:57:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140103150416.GA7132@katana>
References: <1387552376-12986-1-git-send-email-jjhiblot@traphandler.com>
 <1387552376-12986-3-git-send-email-jjhiblot@traphandler.com>
 <20140103150416.GA7132@katana>
Date: Fri, 3 Jan 2014 16:57:17 +0100
Message-ID: <CACh+v5OJoGSZZjbDfeKSnPQ7BHHx6zhdp06=YcMWWfu03FVS+Q@mail.gmail.com>
Subject: Re: [PATCH v3 REPOST 2/4] i2c: i2c-ibm-iic: perform the transfer in
 the interrupt handler
From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To: Wolfram Sang <wsa@the-dreams.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>,
 linuxppc-dev@lists.ozlabs.org, jean-jacques hiblot <jjhiblot@traphandler.com>,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014/1/3 Wolfram Sang <wsa@the-dreams.de>:
>
> Hi,
>
> thanks for the submission!
You're welcome :) Thanks for reviewing this.

>
>> --- a/drivers/i2c/busses/i2c-ibm_iic.c
>> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
>> @@ -58,6 +58,8 @@ static bool iic_force_fast;
>>  module_param(iic_force_fast, bool, 0);
>>  MODULE_PARM_DESC(iic_force_fast, "Force fast mode (400 kHz)");
>>
>> +#define FIFO_FLUSH_TIMEOUT 100
>
> 100 what? The unit is missing.

The actual value of this timeout isn't very important. This is used
only to avoid a never ending loop in case the hardware goes into a
really bad state.

>
>> @@ -167,8 +170,8 @@ static void iic_dev_init(struct ibm_iic_private* dev)
>>       /* Clear control register */
>>       out_8(&iic->cntl, 0);
>>
>> -     /* Enable interrupts if possible */
>> -     iic_interrupt_mode(dev, dev->irq >= 0);
>> +     /* Start with each individual interrupt masked*/
>
> Space at the end of comment missing
ok
>
>>  static irqreturn_t iic_handler(int irq, void *dev_id)
>>  {
>> -     struct ibm_iic_private* dev = (struct ibm_iic_private*)dev_id;
>> -     struct iic_regs __iomem *iic = dev->vaddr;
>> -
>> -     DBG2(dev, "irq handler, STS = 0x%02x, EXTSTS = 0x%02x\n",
>> -          in_8(&iic->sts), in_8(&iic->extsts));
>> -
>> -     /* Acknowledge IRQ and wakeup iic_wait_for_tc */
>> -     out_8(&iic->sts, STS_IRQA | STS_SCMP);
>> -     wake_up_interruptible(&dev->wq);
>> -
>> +     struct ibm_iic_private *dev = (struct ibm_iic_private *) dev_id;
>> +     iic_xfer_bytes(dev);
>
> Is iic_xfer_bytes later used when polling, too? Otherwise it could be
> simply inserted here.
Yes it'll be used for polling (implemented in a later patch)
>
>
>> +     if ((status & STS_ERR) ||
>> +         (ext_status & (EXTSTS_LA | EXTSTS_ICT | EXTSTS_XFRA))) {
>> +             DBG(dev, "status 0x%x\n", status);
>> +             DBG(dev, "extended status 0x%x\n", ext_status);
>> +             if (status & STS_ERR)
>> +                     ERR(dev, "Error detected\n");
>> +             if (ext_status & EXTSTS_LA)
>> +                     DBG(dev, "Lost arbitration\n");
>> +             if (ext_status & EXTSTS_ICT)
>> +                     ERR(dev, "Incomplete transfer\n");
>> +             if (ext_status & EXTSTS_XFRA)
>> +                     ERR(dev, "Transfer aborted\n");
>> +
>> +             dev->status = -EIO;
>
> You could consider returning different fault codes for the different
> states. See Documentation/i2c/fault-codes for a guide.
I'll have a look at it.

>
>> +     if (dev->msgs == NULL) {
>> +             DBG(dev, "spurious !!!!!\n");
>> +             dev->status = -EINVAL;
>> +             return dev->status;
>> +     }
>
> Does that really happen?
Not in my test cases (going through i2c dev). But it could if the data
passed to i2c_transfer is malformed.
Should I remove this ?

>
> And it introduces a build warning:
>
> drivers/i2c/busses/i2c-ibm_iic.c:410:12: warning: 'iic_wait_for_tc' defined but not used [-Wunused-function]
>
I posted this some time ago, but I believe I kept this in to help git
produce a diff readable by a human.
It's removed in a later patch

Jean-Jacques
