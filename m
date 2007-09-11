Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9402BDDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Sep 2007 22:49:22 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IV5B8-0004yF-Fb
	for linuxppc-embedded@ozlabs.org; Tue, 11 Sep 2007 05:49:18 -0700
Message-ID: <12613692.post@talk.nabble.com>
Date: Tue, 11 Sep 2007 05:49:18 -0700 (PDT)
From: WITTROCK <jwittrock@maginst.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interrupt-problem mpc5200
In-Reply-To: <20070910090305.GG11807@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20070910090305.GG11807@sfrouter>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,

Is it possible that this call failed?
intr = ioremap(MPC52xx_MBAR+MPC52xx_INTR_OFFSET, MPC52xx_INTR_SIZE); 

Maybe intr is invalid at this point?
out_be32(&intr->ctrl, intr_ctrl);       // ERROR!


Regards,
WITTROCK


S. Fricke wrote:
> 
> Hello all.
> 
> What are the steps to configure an MPC500B-Board to react on an IRQ (2)?
> 
> I have written a test-driver with this code-snippets, but the prozessor
> hangs when loading the driver.
> 
> my __init-function looks like:
> 
> static int __init mod_init( void ) 
> {
>     volatile static struct mpc52xx_intr __iomem *intr;
>     u32 intr_ctrl;
> 
>     // ...
> 
>     printk( "intmod.ko: interrupt init ");
>     if (request_irq(MPC52xx_IRQ2, intmod_isr, IRQF_SHARED , "intmod",
>                 INTMOD_IRQ_BOARD) == -EBUSY)
>         printk("KO\n");
>     else
>         printk("OK\n");
> 
>     intr = ioremap(MPC52xx_MBAR+MPC52xx_INTR_OFFSET, MPC52xx_INTR_SIZE);
> 
>     // read - modify - write
>     intr_ctrl = in_be32(&intr->ctrl);
>     intr_ctrl &= 0xfff3ffff;
>     intr_ctrl |= 0x00080200;
>     out_be32(&intr->ctrl, intr_ctrl);       // ERROR!
> 
>     if(intr) iounmap(intr);
> 
>     // ...
> }
> 
> On the Line, marked with "ERROR!" the prozessor hangs and the kernel drops
> out.
> 
> TIA: Silvio
> 
> 
> Mit freundlichen Gruessen
> Silvio Fricke
> 
> -- 
> -- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com
> --
>    Diplom-Informatiker (FH)
>    Linux-Entwicklung                       JABBER:      fricke@jabber.org
> ----------------------------------------------------------------------------
> 
> 
>  
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/Interrupt-problem-mpc5200-tf4413834.html#a12613692
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
