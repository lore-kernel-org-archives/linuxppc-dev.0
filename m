Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 40809B70BC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2011 18:11:51 +1100 (EST)
Subject: RE: Request_irq fails for IRQ2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: smitha.vanga@wipro.com
In-Reply-To: <40631E9A2581F14BA60888C87A76A1FE0147A1@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE0147A1@HYD-MKD-MBX4.wipro.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 09:11:43 +0200
Message-ID: <1318144303.29415.364.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-10-04 at 13:55 +0000, smitha.vanga@wipro.com wrote:
> 
> Hi Scoot,
> 
> When I try to use a atomic varaible in my ISR  I see a kernel crash .
> with mesage BUG: scheduling while atomic:
> 
> 
> 
> Below is the code :
> My ISR
> 
> irqreturn_t cpld_irq_handler(int irq, void * dev_id, struct pt_regs
> *regs)
> 
> {
> 
> wake_up(&cpld_intr_wait);
> 
> atomic_inc(&cpld_intr_data); /* incrementing this will indicate the
> poll() that the interrupt is occured */
> 
> return 0;
> 
> }

This is of course completely racy, you should do the increment -before-
you wake up. I suppose you aren't SMP at the moment but even then, if
you ever switch for example to threaded interrupts or use RT it will
potentially break.
> 
> DRIVER_INIT
> static int __init gpio_init(void)
> {
>         int ret = 0;
>         int virq;
> 
>        
>     atomic_set(&cpld_intr_data, 0);                     /* initialize
> the Interrupt indicator */
>     init_waitqueue_head(&cpld_intr_wait);               /* Initialize
> the wait queue */
> 
>     virq = irq_create_mapping(NULL, CPLD1_INTERRUPT);

See comments earlier about using the device-tree here.
>               
>    if ((ret = request_irq(virq,cpld_irq_handler, 0, GPIO_CHAR_PATH,
> NULL))!=0)
>    {
>       printk(KERN_ERR "gpio_init: Could not grab IRQ line for CPLD ret
> = %d\n",ret);
>           goto err1;
>    }
>   
>  
>         if((s_nGPIOMajor = register_chrdev(MPC8247_DEVICE_MAJOR_NUM,
> GPIO_CHAR_PATH, &gpio_fops))<0)
>         {
>                 GPIO_DBG2("GPIO_DRIVER  : unable to get major %d\n",
> s_nGPIOMajor);
>                 return s_nGPIOMajor;
>                
>         }else{
>                 GPIO_DBG2("GPIO_DRIVER  : major = %x\n", s_nGPIOMajor
> );
>         }

coding style FAIL

>         return 0;
>     
> } 

I don't see anything that does your scheduling while atomic here,
probably a bug in your poll implementation but it's not here.

Oh and stop sending that crap:

> Regards,
> Smitha
> 
> Please do not print this email unless it is absolutely necessary. 
> 
> The information contained in this electronic message and any
> attachments to this message are intended for the exclusive use of the
> addressee(s) and may contain proprietary, confidential or privileged
> information. If you are not the intended recipient, you should not
> disseminate, distribute or copy this e-mail. Please notify the sender
> immediately and destroy all copies of this message and any
> attachments. 
> 
> WARNING: Computer viruses can be transmitted via email. The recipient
> should check this email and any attachments for the presence of
> viruses. The company accepts no liability for any damage caused by any
> virus transmitted by this email. 

It's a complete nonsense on a public mailing list

Ben.
