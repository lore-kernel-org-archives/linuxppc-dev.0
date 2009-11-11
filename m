Return-Path: <Bo.Liu@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5F244B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 13:11:18 +1100 (EST)
Message-ID: <4AFA1C46.8040609@windriver.com>
Date: Wed, 11 Nov 2009 10:07:02 +0800
From: Tonyliu <Bo.Liu@windriver.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Interrupts not Firing on PPC405EX
References: <BB99A6BA28709744BF22A68E6D7EB51F0331030DBB@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0331030DBB@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: Bo.Liu@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan Haws wrote:
> All,
>
> I am having some troubles getting interrupts to fire from my kernel module.  I have connected the ISR with a call to request_irq() and have configured my device to generate interrupts.   However, my ISR is called once when I connect the interrupt for the first time.  After that it never is called again.  It seems like that interrupt is getting stuck disabled, but that does not make sense as to why.
>
> The device is on the PCIE0 bus and works just fine in another OS (namely Vxworks - that is the driver I am working on porting to Linux).
>
> Here is how I am connecting the ISR and the ISR itself.  Am I doing something stupid?
>
> Thanks for the help!
>
> Jonathan
>
> PS - Our hardware is a custom spun PPC405EX board based on the AMCC Kilauea board and uses the kilauea.dts with no modifications.
>
> A quick note - I realize that I am not checking if I was the one to interrupt the CPU.  I am not worried about that right now - especially since I know there is nothing else that will interrupt the CPU on this IRQ right now anyway - it never fires.
>
>
> int fpga_open(struct inode *inode, struct file *filp)
> {
> 	int err = 0;
>
> 	/* Make sure we have successfully probed the device */
> 	if (NULL == fpga_drv.pcidev)
> 	{
> 		return -ENODEV;
> 	}
>
> 	/* Only one process at a time can have access to the FPGA */
> 	if (0 != atomic_read(&fpga_drv.openCount))
> 	{
> 		atomic_inc(&fpga_drv.openCount);
> 		printk(KERN_WARNING "FPGA: Could not open device: already open. \n");
> 		return -EBUSY;
> 	}
>
> 	/* If not already in use, state that we are */
> 	atomic_inc(&fpga_drv.openCount);
>
> 	/* Store a pointer to the PCI device structure */
> 	filp->private_data = fpga_drv.pcidev;
>
> 	/* Attach ISR to IRQ */
> 	if (request_irq(fpga_drv.pcidev->irq, &fpga_isr, IRQF_SHARED,
> 			FPGA_MODULE_NAME, fpga_drv.pcidev))
> 	{
> 		printk( KERN_ERR "FPGA: Unable to connect FPGA ISR (%d)!\n",
> 				fpga_drv.pcidev->irq);
> 		return -EPERM;
> 	}
>
> 	return 0;
> }
>
> /* Interrupt Service Routine */
> irqreturn_t fpga_isr(int irq, void *dev_id)
> {
> 	uint32_t status = 0;
>
> 	status = fpga_drv.cfg_ptr[FPGA_INTER_STATUS];
>   
> 	printk(KERN_NOTICE "FPGA: Interrupt fired! (%#08x)\n", status);
> 	if (status & FPGA_INTERRUPT_SPI)
> 	{
> 		rt_sem_v(&fpga_drv.sarSem);
> 	}
>   
Your ISR registry and handling is fine. you mentioned that the IRQ only 
be trigged once.
Are you sure that nothing is needed to reenable the HW IRQ generation 
such as clear status bit ...
Is the algorithm in linux same with it in Vxworks?

Tony
> 	/* Return HANDLED */
> 	return (IRQ_HANDLED);}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>   


-- 
Tony Liu | Liu Bo
-------------------------------------------------------------
WIND RIVER | China Development Center
Tel: 86-10-8477-8542 ext: 8542 |  Fax: 86-10-64790367
(M): 86-136-7117-3612
Address: 15/F, Wangjing TowerB, Chaoyang District, Beijing, P.R.China
