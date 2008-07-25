Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 18CBFDE0FF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jul 2008 18:43:37 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KMIti-0006uq-Fe
	for linuxppc-embedded@ozlabs.org; Fri, 25 Jul 2008 01:43:34 -0700
Message-ID: <18647614.post@talk.nabble.com>
Date: Fri, 25 Jul 2008 01:43:34 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <200807241131.12669.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com> <200807221131.32556.arnd@arndb.de>
	<4885AC94.7050501@coritel.it> <18587466.post@talk.nabble.com>
	<200807221712.52030.arnd@arndb.de>
	<18605418.post@talk.nabble.com> <18627544.post@talk.nabble.com>
	<200807241131.12669.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> printk(KERN_INFO"Allocated Memory for Circular Buffer at physical 
> 0x0%x\n",phy_addr); 
> 
> #else 
> 
> buf_area = ioremap(0xB2000000,0x4000); //(0xB2000000,0x4000); 
> //(7700000,900000); 
> if(!buf_area) 
> { 
> printk(KERN_ALERT"ioremap failed \n"); 
> return -1; 
> } ...[show rest of quote]
Don't hardcode the numbers here, you should get the values from the 
device tree, and use of_iomap(). 

I am really unaware of how can we get this physical address from the device
tree which you have mentioned can you please explain this to me ???

Suppose there is one situation in which i have to map ram of the address
0x800000 to 9MB will it be good if i do this to map to user space 

static int McBSP_DriverMmap(struct file *file,struct  vm_area_struct *vma)
{

	unsigned long start = vma->vm_start ;
	unsigned long size = 0x900000 ;
	unsigned long phy_add = 0x800000;
	int ret = 0;

	/* Make the mmaped area noncacheable */
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

	/* Set the Flags to give permissions to Mmaped area */
	vma->vm_flags |=VM_RESERVED;
	vma->vm_flags |=VM_READ;
	vma->vm_flags |=VM_WRITE;
	
	printk(KERN_DEBUG"In mmap function\n");

	/* Mmap the kernel buffer to user space */
	if(remap_pfn_range(vma,start,(phy_add >>
PAGE_SHIFT),size,vma->vm_page_prot))
	{
		printk(KERN_ALERT"remap_pfn_range failed\n");
		goto mmap_exit;

   	}

   	printk(KERN_ALERT"phy addr 0x%08X mmapped to virt addr 0x%08X, size =
0x%08X\n",
		(unsigned int)phy_add, (unsigned int)start, (unsigned int)size);

	/* Initialize the file operation structure of Mmaped area */
	vma->vm_ops=&mmap_op;

	/* Open the Mmaped area */
	MmapOpen(vma);

	mmap_exit:
	   	return ret;
}

suppose the same mapping i have to do using nopage method then shall i
specify the RAM physical address and sixe in the same manner ???


There is one more concern that i have now is that i am writing a pattern
(say 0xa5a5a5a5) to cpld by building the page using remap_pfn_range but when
i try to read it its showing the pattern as a5a5a5a50000000a5a5a5a50000000
like with zeros in between is it a non aligned page problem.

----- Misbah <><

Arnd Bergmann wrote:
> 
> On Thursday 24 July 2008, Misbah khan wrote:
>> 
>> Hi all ...
>>  
>> I am uploading the source code which is doing the following :-
>> 
>> 1. mapping cpld register using ioremap coping the data to circular buffer
>> and remapping it to user space .
>> 
>> 2. It can also map kernel virtual dma memory to user space if compiled
>> conditionally .
>> 
>> following is the problem which i am facing ...
>> 
>> 1. It is somitimes giving following kernel panic ....
>> 
>> nable to handle kernel NULL pointer dereference at virtual address
>> 00000000
>> pgd = c0004000
>> [00000000] *pgd=00000000
>> Internal error: Oops: 17 [#1]
>> Modules linked in: fluke_driver tstamp sig_router mvci_spi mvci_sf_pcd
>> mvci_sci_unidir_s1 mvci_sci_diff mvci_sci_bidir_s
>> 1 mvci_rtmd_s1 mvci_kwiso_s1 mvci_kw1281_s1 mvci_kh_s1 mvci_j1850
>> mvci_gm_sbc mvci_diagh_s1 g_ether mvci_dcl mvci_can1 f
>> pga_conf arcotg_udc adc_dac keypad(F) splc501_lcd(F) cpld
>> CPU: 0
>> PC is at cascade+0x64/0x8c
>> LR is at __init_begin+0x3fff8000/0x30
>> pc : [<c00484ac>]    lr : [<00000000>]    Tainted: GF
>> sp : c0293ea8  ip : 0040b000  fp : c0293ecc
>> r10: 8001d9f0  r9 : c0292000  r8 : 00000001
>> r7 : c0292000  r6 : 0000000c  r5 : c02fa048  r4 : 00000000
>> r3 : c02fa2f8  r2 : 0000261a  r1 : bf01ab70  r0 : c02fa2f8
>> Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
>> Control: C5387F
>> Table: 8698C000  DAC: 00000017
>> Process swapper (pid: 0, stack limit = 0xc0292250)
>> Stack: (0xc0293ea8 to 0xc0294000)
>> 3ea0:                   bf01ab70 c02fb440 0000000a 00000000 c02fa048
>> 0000000a
>> 3ec0: c0293efc c0293ed0 c0048810 c0048454 c0293eec c0293ee0 c002a30c
>> 00000001
>> 3ee0: c02f9e44 0000000a 00000002 00000001 c0293f1c c0293f00 c00442a0
>> c0048794
>> 3f00: c0293f2c 0000001d c0294740 00000000 c0293f2c c0293f20 c00446d4
>> c0044254
>> 3f20: c0293f4c c0293f30 c00217b0 c0044698 c0293f5c ffffffff 0000ffff
>> 00000001
>> 3f40: c0293fa4 c0293f50 c00209e4 c0021770 00000001 00000001 c0292000
>> 00000000
>> 3f60: c0022068 c0292000 c0298c44 c03121c0 8001da24 4107b364 8001d9f0
>> c0293fa4
>> 3f80: c0293fa8 c0293f98 c0021d48 c002209c 60000013 ffffffff c0293fbc
>> c0293fa8
>> 3fa0: c0021d48 c0022074 c02faae0 c02f292c c0293fcc c0293fc0 c00202e0
>> c0021d24
>> 3fc0: c0293ff4 c0293fd0 c0008848 c00202b4 c00083c4 00000000 00000000
>> c02f29a8
>> 3fe0: 00000000 00c5387d 00000000 c0293ff8 80008030 c00086e0 00000000
>> 00000000
>> Backtrace:
>> [<c0048448>] (cascade+0x0/0x8c) from [<c0048810>]
>> (run_timer_softirq+0x88/0x1e8)
>>  r6 = 0000000A  r5 = C02FA048  r4 = 00000000
>> [<c0048788>] (run_timer_softirq+0x0/0x1e8) from [<c00442a0>]
>> (__do_softirq+0x58/0xc8)
>>  r8 = 00000001  r7 = 00000002  r6 = 0000000A  r5 = C02F9E44
>>  r4 = 00000001
>> [<c0044248>] (__do_softirq+0x0/0xc8) from [<c00446d4>]
>> (irq_exit+0x48/0x5c)
>>  r6 = 00000000  r5 = C0294740  r4 = 0000001D
>> [<c004468c>] (irq_exit+0x0/0x5c) from [<c00217b0>] (asm_do_IRQ+0x4c/0x64)
>> [<c0021764>] (asm_do_IRQ+0x0/0x64) from [<c00209e4>]
>> (__irq_svc+0x44/0x80)
>>  r6 = 00000001  r5 = 0000FFFF  r4 = FFFFFFFF
>> [<c0022068>] (default_idle+0x0/0x3c) from [<c0021d48>]
>> (cpu_idle+0x30/0x5c)
>> [<c0021d18>] (cpu_idle+0x0/0x5c) from [<c00202e0>] (rest_init+0x38/0x40)
>>  r5 = C02F292C  r4 = C02FAAE0
>> [<c00202a8>] (rest_init+0x0/0x40) from [<c0008848>]
>> (start_kernel+0x174/0x1c0)
>> [<c00086d4>] (start_kernel+0x0/0x1c0) from [<80008030>] (0x80008030)
>> Code: e1530005 15822000 ebffffb6 e1a0e004 (e5944000)
>>  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
>> 
>> 
>> also when i run it on X86 PC i am able to get the data and no panic where
>> in
>> on the board it is giving the above error ....
>> 
>> 2. I can raed the data using the user application when i run it on X86 PC
>> where in i cant able to read the data when i run it on the board the data
>> i
>> was getting was always '/0' filled buffer .
>> 
>> 
>> Here is the compilete code .............
>> 
>> 
>> static int McBSP_DriverOpen(struct inode *inode,struct file *file)
>> {
>> 	/* Reintialize file operation structure */
>> 	file->f_op=&fluke_fops;
>> 
> 
> this is already set.
> 
>> 	printk(KERN_DEBUG" fluke driver open success \n");
>> 
>> 	if (device_open_count == 0)
>> 	{
>> 		device_open_count = 1;
>> 
>> 		/* Reset the read and write index*/
>> 		buf_index_area.write_index=0;
>> 		buf_index_area.read_index=-1;
>> 		buf_index_area.count_index=0;
>> 
>> 		#ifdef SIMULATION
>> 		/* Initialize the Timer */
>> 		init_timer(&fluke_timer);
>> 		fluke_timer.expires = jiffies + (HZ*10);//Timer will Expire after 60
>> sec
>> 		fluke_timer.data = 0;
>> 		fluke_timer.function = (void *)timer_func;
>> 		add_timer(&fluke_timer);
>> 		#endif
>> 	}
>> 
>> 	return 0;
>> }
> 
> Using the count in this way is racy, best write the code so
> that it can allow multiple opens.
> 
>> irqreturn_t DataAcqIntHandler(int irq,void *dev_id, struct pt_regs *regs)
>> {
>> 	printk(KERN_ALERT" In Interrupt Handler\n");
>> 	/* Data present status is set to wake up the read call */
>> 	data_present_status=1;
>> 
>> 	/* Wake up the blocked Select call */
>> 	wake_up_interruptible(&wait_queue);
>> 
>> 	#ifndef SIMULATION
>> 	/* Clear the interrupt in the interrupt pending registor */
>> 	cpi->ic_scprrh |=DATA_ACQ_INT_CLEAR;
>> 	#endif
>> 
>> 	return IRQ_HANDLED;
>> 
>> }/* End of PpsIntrHandler() */
> 
> The interrupt handler should be able to deal with shared interrupts,
> and needs to check if the interrupt came from this device, returning
> IRQ_NONE otherwise.
> 
>> static int __init McBSP_DriverInit(void)
>> {
>> 	unsigned int virt_addr = 0;
>> 	int mem = 0;
>> 
>> 	//buf_area = vmalloc(sizeof(circularbuffer_S));
>> 	//if(!buf_area)
>> 	//{
>> 	//	printk(KERN_ALERT"vmalloc failed \n");
>> 	//	return -1;
>> 	//}
>> 
>> #if 0
>> 	/*
>> 	* Allocate memory for the circular buffer in the DMA coherent area
>> 	* and algin it in the Cache
>> 	*/
>> 	mem = L1_CACHE_ALIGN(sizeof(circularbuffer_S));
>> 
>> 	buf_ptr = (char *)dma_alloc_coherent(NULL, mem, &dma_addr,GFP_KERNEL);
> 
> no need for the cast.
> 
>> 	printk(KERN_INFO" buf_ptr = 0x%x \n",(int )buf_ptr);
>> 	if(NULL == buf_ptr )
>> 	{
>> 		printk(KERN_ALERT" Allocation of Memory failure ");
>> 		return -1;
>> 	}
>> 
>> 	buf_area = (circularbuffer_S *)(((unsigned int )buf_ptr + PAGE_SIZE - 1)
>> \
>> 			& PAGE_MASK);
>> 
>> 	printk(KERN_INFO" buf_area = 0x%x \n",(int )buf_area);
>> 
>> 	if(NULL == buf_area)
>> 	{
>> 		printk(KERN_ALERT" Circular buffer memory not allocated \n");
>> 		return -1;
>> 	}
>> 
>> 	/* Marking the Pages as reserved */
>> 	for (virt_addr = (unsigned int)buf_area; \
>> 	virt_addr < (unsigned int )buf_area + sizeof(circularbuffer_S);\
>> 	virt_addr += PAGE_SIZE)
>> 	{
>> 		/* Set the pages as reserved */
>> 		SetPageReserved(virt_to_page(virt_addr));
>> 		//mem_map_reserve(virt_to_page(virt_addr));
>> 	}
> 
> no need for SetPageReserved, it already is marked as in use through
> the allocation.
> 
>> 	phy_addr = virt_to_phys(buf_ptr);
> 
> You can't use virt_to_phys to get the dma address. You also don't need
> that
> because you already have it in dma_addr.
> 
> 
>> 	printk(KERN_INFO"Allocated Memory for Circular Buffer at physical
>> 0x0%x\n",phy_addr);
>> 
>> #else
>> 
>> 	buf_area = ioremap(0xB2000000,0x4000); //(0xB2000000,0x4000);
>> //(7700000,900000);
>> 	if(!buf_area)
>> 	{
>> 		printk(KERN_ALERT"ioremap failed \n");
>> 		return -1;
>> 	}
> 
> Don't hardcode the numbers here, you should get the values from the
> device tree, and use of_iomap().
>  
>> 	printk(" Ioremap mapped to virtual 0x0%x \n",buf_area);
>> 	*((unsigned int *)buf_area) = 0xa5a5a5a5;
>> 	printk(" Ioremap data  0x0%x \n",*((unsigned int *)buf_area + 0));
>> 
>> #endif
>> 
>> 	/* Device major number is registered to set the driver entry point */
>> 	if(register_chrdev(MAJOR_NO,MODULE_NAME, &fluke_fops)==0)
>> 	{
>> 		printk(KERN_DEBUG" Fluke driver registeration success \n");
>> 
>> 	}
>> 	else
>> 	{
>> 		printk(KERN_ALERT" Fluke driver registeration failed \n");
>> 		return -1;
>> 	}
> 
> Since it's just one device, it's easier to use a misc_device.
>  
>> 	/*
>> 	 * Register Data Acq interrupt request with specified irq and install
>> the
>> 	 * handler
>> 	 */
>> 	 if(request_irq(DATA_ACQ_INT,(void *)DataAcqIntHandler, SA_INTERRUPT,
>> 	 						MODULE_NAME, NULL)==0)
>> 	{
>> 		printk(KERN_DEBUG" Data Acq interrupt request returns success \n");
>> 	}
>> 	else
>> 	{
>> 		printk(KERN_DEBUG" Data Acq interrupt request failed \n");
>> 		unregister_chrdev(MAJOR_NO,MODULE_NAME);
>> 		return -1;
>> 
>> 	}
> 
> hardcoding interrupt numbers is broken, interrupt numbers are relative to
> one interrupt controller. Use irq_of_parse_and_map.
> 
>> static int McBSP_DriverIoctl(struct inode *inode, struct file *file,\
>> 									unsigned int cmd, unsigned long param)
>> {
>> 	int i;
>> 	daq_t daq_param;
>> 
>> 	printk(KERN_DEBUG"In ioctl command \n");
>> 
>> 	switch(cmd)
>> 	{
>> 		case START_ACQ_DATA:
>> 
>> 			if(copy_from_user(&daq_param,(void *)param,sizeof(daq_param)))
>> 			{
>> 
>> 				return -1;
>> 			}
>> 
>> 			/* For Simulation we are writing the data */
>> 			if(WriteBuf() < 0)
>> 			{
>> 				printk(" Writing to the memory failure \n");
>> 				return -1;
>> 			}
>> 
>> 			/* Wait for the Interrupt to occur */
>> 			wait_event_interruptible( wait_queue, data_present_status !=0);
>> 
>> 			printk("Read Index before read %d\n",buf_index_area.read_index);
>> 			data_present_status=0;
> 
> Racy, you could have multiple threads doing this ioctl.
> Moreover, you should not block in an ioctl but rather
> implement a poll() function for waiting.
> 
>> 			buf_index_area.read_index++;
>> 			buf_index_area.read_index%=NO_FRAMES;
>> 
>> 			if(buf_index_area.read_index ==((buf_index_area.write_index +1) %
>> NO_FRAMES))
>> 			//if(buf_index_area.read_index == buf_index_area.write_index )
>> 			{
>> 				printk("Read failure because read and write index are same\n");
>> 				return -1;
>> 			}
>> 
>> 			/* Decrement the count index to indicate the data availibility */
>> 			down(&mutex);
>> 			buf_index_area.count_index--;
>> 			up(&mutex);
> 
> New drivers should not use semaphores (up/down) in places where they can
> use real
> mutexes (mutex_lock/mutex_unlock).
> 
>> static int McBSP_DriverMmap(struct file *file,struct  vm_area_struct
>> *vma)
>> {
>> 
>> 	unsigned long start = vma->vm_start;
>> 	unsigned long size = vma->vm_end - vma->vm_start; //0x900000;
>> 	unsigned long phy_add = virt_to_phys(buf_ptr); //0x7700000;
> 
> virt_to_phys doesn't work on vmalloc memory.
> 
> 
>> 	int ret = 0;
>> 
>> 	/* Make the mmaped area noncacheable */
>> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> 
>> 	/* Set the Flags to give permissions to Mmaped area */
>> 	vma->vm_flags |=VM_RESERVED;
>> 	vma->vm_flags |=VM_READ;
>> 	vma->vm_flags |=VM_WRITE;
>> 	vma->vm_flags |=VM_IO;
>> 	//vma->vm_flags |=VM_SHARED;
>> 	//vma->vm_flags |=VM_LOCKED;
> 
> For memory, you typically want to set vm_page_prot to use non-guarded
> mapping,
> so that user space accesses are faster.
> 
> Not sure if VM_IO is right for vmalloc.
> 
> 	Arnd <><
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18647614.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
