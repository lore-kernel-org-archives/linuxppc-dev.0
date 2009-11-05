Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 6B0F8B7BAE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Nov 2009 07:38:07 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 5 Nov 2009 13:37:58 -0700
Subject: Interrupts not Firing on PPC405EX
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0331030DBB@midas.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All,

I am having some troubles getting interrupts to fire from my kernel module.=
  I have connected the ISR with a call to request_irq() and have configured=
 my device to generate interrupts.   However, my ISR is called once when I =
connect the interrupt for the first time.  After that it never is called ag=
ain.  It seems like that interrupt is getting stuck disabled, but that does=
 not make sense as to why.

The device is on the PCIE0 bus and works just fine in another OS (namely Vx=
works - that is the driver I am working on porting to Linux).

Here is how I am connecting the ISR and the ISR itself.  Am I doing somethi=
ng stupid?

Thanks for the help!

Jonathan

PS - Our hardware is a custom spun PPC405EX board based on the AMCC Kilauea=
 board and uses the kilauea.dts with no modifications.

A quick note - I realize that I am not checking if I was the one to interru=
pt the CPU.  I am not worried about that right now - especially since I kno=
w there is nothing else that will interrupt the CPU on this IRQ right now a=
nyway - it never fires.


int fpga_open(struct inode *inode, struct file *filp)
{
	int err =3D 0;

	/* Make sure we have successfully probed the device */
	if (NULL =3D=3D fpga_drv.pcidev)
	{
		return -ENODEV;
	}

	/* Only one process at a time can have access to the FPGA */
	if (0 !=3D atomic_read(&fpga_drv.openCount))
	{
		atomic_inc(&fpga_drv.openCount);
		printk(KERN_WARNING "FPGA: Could not open device: already open. \n");
		return -EBUSY;
	}

	/* If not already in use, state that we are */
	atomic_inc(&fpga_drv.openCount);

	/* Store a pointer to the PCI device structure */
	filp->private_data =3D fpga_drv.pcidev;

	/* Attach ISR to IRQ */
	if (request_irq(fpga_drv.pcidev->irq, &fpga_isr, IRQF_SHARED,
			FPGA_MODULE_NAME, fpga_drv.pcidev))
	{
		printk( KERN_ERR "FPGA: Unable to connect FPGA ISR (%d)!\n",
				fpga_drv.pcidev->irq);
		return -EPERM;
	}

	return 0;
}

/* Interrupt Service Routine */
irqreturn_t fpga_isr(int irq, void *dev_id)
{
	uint32_t status =3D 0;

	status =3D fpga_drv.cfg_ptr[FPGA_INTER_STATUS];
	printk(KERN_NOTICE "FPGA: Interrupt fired! (%#08x)\n", status);
	if (status & FPGA_INTERRUPT_SPI)
	{
		rt_sem_v(&fpga_drv.sarSem);
	}

	/* Return HANDLED */
	return (IRQ_HANDLED);}
