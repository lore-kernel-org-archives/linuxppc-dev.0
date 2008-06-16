Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id 9E126DDF03
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 03:13:15 +1000 (EST)
Date: Mon, 16 Jun 2008 10:13:12 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Using DMA interrupt on MPC8313
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2FCBCE91-8B77-4E78-A7F9-D4128980814F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <101441.49932.qm@web83508.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Here's my code.  There are a few other things that happen but they are inconsequential to this
problem.  I'm sure that the request_irq call is right, especially since it works if the fsldma
drivers are builtin to the kernel.  Also, the irq number 71 comes from the reference manual for
them MPC8313.  It is the internal interrupt for the DMA.  I'll do some more testing in a little
while to try to determine the cause of the error in request_irq.

	int result = 0;
	unsigned int firstminor = 0;
	dev_t dev;
	
	printk(KERN_ALERT "Hello World Driver!  Hi Ron2!\n");


	result |= alloc_chrdev_region(&dev, firstminor, 1, kModuleName);


	if(result < 0){

		printk("simpc: alloc_chrdev_region failed %u\n", result);

		return result;

	}

	mpc_major = MAJOR(dev);
	mpc_minor = MINOR(dev);


	printk(KERN_ALERT kModuleName " MAJOR NUM = %d\n",mpc_major);

	pdx.devno = MKDEV(mpc_major, mpc_minor);

	cdev_init(&pdx.cdev, &mpc_fops);
	pdx.cdev.owner = THIS_MODULE;
	pdx.cdev.ops = &mpc_fops;
	result = cdev_add(&pdx.cdev, pdx.devno, 1);

	if(result)
		printk(KERN_ALERT kModuleName "-init_module: Error %d adding pdx.cdev", result);

		
	printk(KERN_ALERT kModuleName "-SIMPC_open: Entering\n");

	pdx.irq = 71;



	printk(KERN_ALERT kModuleName "-SIMPC_open: IRQ = %d\n", pdx.irq);



	if (pdx.irq == 0){

		printk(kModuleName "-SIMPC_open: WARNING-cannot get IRQ\n");
		return 0;
	}


	if (request_irq(pdx.irq, SIMPC_isr, IRQF_SHARED, kModuleName, &pdx)){

		printk(kModuleName "-SIMPC_open: ERROR-Interrupt Request failed.\n"

			"    pdx.irq = %d, SIMPC_isr = 0x%x\n", 

			pdx.irq, (int)SIMPC_isr);



		pdx.irq = 0;

	}

	else

		printk(kModuleName "-SIMPC_open: found IRQ %d\n", pdx.irq);

--- Kumar Gala <galak@kernel.crashing.org> wrote:

> What does your code actually look like.  In your driver how are you  
> getting the IRQ value that you pass to request_irq?
> 
> - k
> 
> On Jun 13, 2008, at 6:52 PM, Ron Madrid wrote:
> 
> > I don't know why request_irq is succeeding when the fsldma and  
> > dmaengine drivers are installed.
> > I'm using the same dts in both cases.
> >
> > Ron
> > --- Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> >> That's a bit odd.  How is your driver getting the IRQ its requesting?
> >> Are you using the same .dts in both cases?
> >>
> >> - k
> >>
> >> On Jun 13, 2008, at 2:02 PM, Ron Madrid wrote:
> >>
> >>> So after I've built the kernel to include the dmaengine and fsldma
> >>> drivers, my driver is allowed
> >>> to register its ISR via request_irq.  However, if these drivers are
> >>> not installed then request_irq
> >>> fails in my driver.  So it seems that there is some other
> >>> initialization happening before
> >>> request_irq is being called in fsldma and subsequently my driver.
> >>> Does anyone know what this is?
> >>>
> >>> Ron
> >>> --- Kumar Gala <galak@kernel.crashing.org> wrote:
> >>>
> >>>> The dmaengine provides a generic set of APIs w/a FSL dma  
> >>>> backend.  It
> >>>> might be the case that your need of dma doesnt fit into the current
> >>>> set of APIs.
> >>>>
> >>>> - k
> >>>>
> >>>> On Jun 12, 2008, at 3:04 PM, Ron Madrid wrote:
> >>>>
> >>>>> Well in that case wouldn't I need to use the fsldma driver?  Or is
> >>>>> dmaengine a generic dma driver?
> >>>>>
> >>>>> Ron
> >>>>> --- Kumar Gala <galak@kernel.crashing.org> wrote:
> >>>>>
> >>>>>>
> >>>>>> On Jun 12, 2008, at 2:35 PM, Ron Madrid wrote:
> >>>>>>
> >>>>>>> I'm trying to write a driver that would make use of the DMA on  
> >>>>>>> the
> >>>>>>> MPC8313.  I'm attempting to
> >>>>>>> register the interrupt with request_irq but it is not  
> >>>>>>> passing.  Is
> >>>>>>> there something that I need to
> >>>>>>> do before I call request_irq, maybe in the dts or somewhere  
> >>>>>>> else?
> >>>>>>
> >>>>>>
> >>>>>> any reason you aren't using the dmaengine driver?
> >>>>>>
> >>>>>> - k
> >>>>>>
> >>>>
> >>>>
> >>
> >>
> 
> 
