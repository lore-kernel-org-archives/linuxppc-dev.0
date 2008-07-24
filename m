Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E1F8EDE019
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jul 2008 18:33:22 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KLwGE-00075V-T2
	for linuxppc-embedded@ozlabs.org; Thu, 24 Jul 2008 01:33:18 -0700
Message-ID: <18627544.post@talk.nabble.com>
Date: Thu, 24 Jul 2008 01:33:18 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
In-Reply-To: <18605418.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <18503022.post@talk.nabble.com> <200807170956.52101.arnd@arndb.de>
	<18522535.post@talk.nabble.com> <48803D3C.5020608@coritel.it>
	<18525063.post@talk.nabble.com> <200807181739.10268.arnd@arndb.de>
	<18582612.post@talk.nabble.com> <200807221131.32556.arnd@arndb.de>
	<4885AC94.7050501@coritel.it> <18587466.post@talk.nabble.com>
	<200807221712.52030.arnd@arndb.de> <18605418.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ...
 
I am uploading the source code which is doing the following :-

1. mapping cpld register using ioremap coping the data to circular buffer
and remapping it to user space .

2. It can also map kernel virtual dma memory to user space if compiled
conditionally .

following is the problem which i am facing ...

1. It is somitimes giving following kernel panic ....

nable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#1]
Modules linked in: fluke_driver tstamp sig_router mvci_spi mvci_sf_pcd
mvci_sci_unidir_s1 mvci_sci_diff mvci_sci_bidir_s
1 mvci_rtmd_s1 mvci_kwiso_s1 mvci_kw1281_s1 mvci_kh_s1 mvci_j1850
mvci_gm_sbc mvci_diagh_s1 g_ether mvci_dcl mvci_can1 f
pga_conf arcotg_udc adc_dac keypad(F) splc501_lcd(F) cpld
CPU: 0
PC is at cascade+0x64/0x8c
LR is at __init_begin+0x3fff8000/0x30
pc : [<c00484ac>]    lr : [<00000000>]    Tainted: GF
sp : c0293ea8  ip : 0040b000  fp : c0293ecc
r10: 8001d9f0  r9 : c0292000  r8 : 00000001
r7 : c0292000  r6 : 0000000c  r5 : c02fa048  r4 : 00000000
r3 : c02fa2f8  r2 : 0000261a  r1 : bf01ab70  r0 : c02fa2f8
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5387F
Table: 8698C000  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc0292250)
Stack: (0xc0293ea8 to 0xc0294000)
3ea0:                   bf01ab70 c02fb440 0000000a 00000000 c02fa048
0000000a
3ec0: c0293efc c0293ed0 c0048810 c0048454 c0293eec c0293ee0 c002a30c
00000001
3ee0: c02f9e44 0000000a 00000002 00000001 c0293f1c c0293f00 c00442a0
c0048794
3f00: c0293f2c 0000001d c0294740 00000000 c0293f2c c0293f20 c00446d4
c0044254
3f20: c0293f4c c0293f30 c00217b0 c0044698 c0293f5c ffffffff 0000ffff
00000001
3f40: c0293fa4 c0293f50 c00209e4 c0021770 00000001 00000001 c0292000
00000000
3f60: c0022068 c0292000 c0298c44 c03121c0 8001da24 4107b364 8001d9f0
c0293fa4
3f80: c0293fa8 c0293f98 c0021d48 c002209c 60000013 ffffffff c0293fbc
c0293fa8
3fa0: c0021d48 c0022074 c02faae0 c02f292c c0293fcc c0293fc0 c00202e0
c0021d24
3fc0: c0293ff4 c0293fd0 c0008848 c00202b4 c00083c4 00000000 00000000
c02f29a8
3fe0: 00000000 00c5387d 00000000 c0293ff8 80008030 c00086e0 00000000
00000000
Backtrace:
[<c0048448>] (cascade+0x0/0x8c) from [<c0048810>]
(run_timer_softirq+0x88/0x1e8)
 r6 = 0000000A  r5 = C02FA048  r4 = 00000000
[<c0048788>] (run_timer_softirq+0x0/0x1e8) from [<c00442a0>]
(__do_softirq+0x58/0xc8)
 r8 = 00000001  r7 = 00000002  r6 = 0000000A  r5 = C02F9E44
 r4 = 00000001
[<c0044248>] (__do_softirq+0x0/0xc8) from [<c00446d4>] (irq_exit+0x48/0x5c)
 r6 = 00000000  r5 = C0294740  r4 = 0000001D
[<c004468c>] (irq_exit+0x0/0x5c) from [<c00217b0>] (asm_do_IRQ+0x4c/0x64)
[<c0021764>] (asm_do_IRQ+0x0/0x64) from [<c00209e4>] (__irq_svc+0x44/0x80)
 r6 = 00000001  r5 = 0000FFFF  r4 = FFFFFFFF
[<c0022068>] (default_idle+0x0/0x3c) from [<c0021d48>] (cpu_idle+0x30/0x5c)
[<c0021d18>] (cpu_idle+0x0/0x5c) from [<c00202e0>] (rest_init+0x38/0x40)
 r5 = C02F292C  r4 = C02FAAE0
[<c00202a8>] (rest_init+0x0/0x40) from [<c0008848>]
(start_kernel+0x174/0x1c0)
[<c00086d4>] (start_kernel+0x0/0x1c0) from [<80008030>] (0x80008030)
Code: e1530005 15822000 ebffffb6 e1a0e004 (e5944000)
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


also when i run it on X86 PC i am able to get the data and no panic where in
on the board it is giving the above error ....

2. I can raed the data using the user application when i run it on X86 PC
where in i cant able to read the data when i run it on the board the data i
was getting was always '/0' filled buffer .


Here is the compilete code .............


/******************************************************************************
* McBSP_Driver.c
*
* Fluke Driver
*
* Description:
*
* Libraries Used:
*
*
* Unit Test Drivers (Binary):
*
*		<fix me >
*
*
* Special Compile Flags
*		Nil
*
* Revision History:
* 	(17/July/2008) Misbah
*    		Created the file
*
* Copyright (C)
*
******************************************************************************/

/******************************************************************************
*						Include Files
*****************************************************************************/

/* Standard linux files includes */
#include<linux/kernel.h>
//#include<linux/config.h>
#include<linux/ioctl.h>
#include<linux/types.h>
#include<linux/module.h>
#include<linux/fs.h>
#include<linux/delay.h>
#include<linux/init.h>
#include<linux/interrupt.h>
#include<linux/version.h>
#include<linux/wait.h>
#include<linux/poll.h>
#include<linux/timer.h>
#include<linux/irq.h>
#include<asm/uaccess.h>
#include<linux/time.h>
#include<asm/io.h>
#include<asm/bitops.h>
#include<linux/mm.h>
//#include<asm/mmzone.h>
#include<linux/bootmem.h>
#include <linux/dma-mapping.h>
#include <linux/vmalloc.h>
#include <asm/pgtable.h>
#include<asm/io.h>
#include<asm/bitops.h>
#include"fluke_driver.h"

static int McBSP_DriverOpen(struct inode *inode,struct file *file);
static int McBSP_DriverInit(void);
static int McBSP_DriverIoctl(struct inode *inode, struct file *file,\
					unsigned int cmd, unsigned long param);
static ssize_t McBSP_DriverWrite(struct file *file,
			const char __user *buf, size_t len,loff_t *offset);
static ssize_t McBSP_DriverRead(struct file *file,char __user *buf,size_t
len,
			loff_t *offset);
static int McBSP_DriverMmap(struct file *file,struct  vm_area_struct *vma);
static void MmapOpen(struct vm_area_struct *vma);
static void MmapClose(struct vm_area_struct *vma);
static void McBSP_DriverExit(void);
static int McBSP_DriverClose(struct inode *inode,struct file *file);
static int WriteBuf(void);
void timer_func(void);

static struct timer_list 		fluke_timer;
static dma_addr_t 				dma_addr;
static char						*buf_ptr;

static struct file_operations fluke_fops =
{
	.owner 		= THIS_MODULE,
	.open 		= McBSP_DriverOpen,
//	.read 		= McBSP_DriverRead,
	.ioctl 		= McBSP_DriverIoctl,
	.mmap		= McBSP_DriverMmap,
//	.write		= McBSP_DriverWrite,
	.release 	= McBSP_DriverClose,
};

/* File operation structure for mmap system call */
static struct vm_operations_struct mmap_op=
{
	.open		=	MmapOpen,
	.close		=	MmapClose,
};

static circularbuffer_S *buf_area = NULL;
static circularbuffer_index_S buf_index_area;
static int device_open_count	  = 0;
static int data_present_status    = 0;

void *ioremap_ptr;
static int phy_addr ;

/* static declaration of wait queue  */
static DECLARE_WAIT_QUEUE_HEAD(wait_queue);

static DECLARE_MUTEX(mutex);

module_init(McBSP_DriverInit);
module_exit(McBSP_DriverExit);

MODULE_AUTHOR("Misbah U K");
MODULE_LICENSE ("GPL");

#define SIMULATION
/****************************************************************************
*
* Description: This function will open fluke device
*
* Input:	File structure pointer and Inode structure pointer.
*			( passed by the kernel )
*
* output:	Returns 0 on Success.
*
***************************************************************************/
static int McBSP_DriverOpen(struct inode *inode,struct file *file)
{
	/* Reintialize file operation structure */
	file->f_op=&fluke_fops;

	printk(KERN_DEBUG" fluke driver open success \n");

	if (device_open_count == 0)
	{
		device_open_count = 1;

		/* Reset the read and write index*/
		buf_index_area.write_index=0;
		buf_index_area.read_index=-1;
		buf_index_area.count_index=0;

		#ifdef SIMULATION
		/* Initialize the Timer */
		init_timer(&fluke_timer);
		fluke_timer.expires = jiffies + (HZ*10);//Timer will Expire after 60 sec
		fluke_timer.data = 0;
		fluke_timer.function = (void *)timer_func;
		add_timer(&fluke_timer);
		#endif
	}

	return 0;
}

/******************************************************************************
 *
 * Description : Interrupt handler function.
 *
 * Input:		 NONE
 *
 * Output:		 NONE
 *

*****************************************************************************/
irqreturn_t DataAcqIntHandler(int irq,void *dev_id, struct pt_regs *regs)
{
	printk(KERN_ALERT" In Interrupt Handler\n");
	/* Data present status is set to wake up the read call */
	data_present_status=1;

	/* Wake up the blocked Select call */
	wake_up_interruptible(&wait_queue);

	#ifndef SIMULATION
	/* Clear the interrupt in the interrupt pending registor */
	cpi->ic_scprrh |=DATA_ACQ_INT_CLEAR;
	#endif

	return IRQ_HANDLED;

}/* End of PpsIntrHandler() */

#ifdef SIMULATION
void timer_func(void)
{

	printk(KERN_ALERT" In the timer function \n");
	/* Data present status is set to wake up the read call */
	data_present_status=1;

	/* Wake up the blocked Read call */
	wake_up_interruptible(&wait_queue);

}

#endif

/***************************************************************************
*
* Description: Register the device and perform Initialization.
*
* Input:		NIL
*
* Output:		Returns 0 on Success and -1 on failure
*
**************************************************************************/
static int __init McBSP_DriverInit(void)
{
	unsigned int virt_addr = 0;
	int mem = 0;

	//buf_area = vmalloc(sizeof(circularbuffer_S));
	//if(!buf_area)
	//{
	//	printk(KERN_ALERT"vmalloc failed \n");
	//	return -1;
	//}

#if 0
	/*
	* Allocate memory for the circular buffer in the DMA coherent area
	* and algin it in the Cache
	*/
	mem = L1_CACHE_ALIGN(sizeof(circularbuffer_S));

	buf_ptr = (char *)dma_alloc_coherent(NULL, mem, &dma_addr,GFP_KERNEL);
	printk(KERN_INFO" buf_ptr = 0x%x \n",(int )buf_ptr);
	if(NULL == buf_ptr )
	{
		printk(KERN_ALERT" Allocation of Memory failure ");
		return -1;
	}

	buf_area = (circularbuffer_S *)(((unsigned int )buf_ptr + PAGE_SIZE - 1) \
			& PAGE_MASK);

	printk(KERN_INFO" buf_area = 0x%x \n",(int )buf_area);

	if(NULL == buf_area)
	{
		printk(KERN_ALERT" Circular buffer memory not allocated \n");
		return -1;
	}

	/* Marking the Pages as reserved */
	for (virt_addr = (unsigned int)buf_area; \
	virt_addr < (unsigned int )buf_area + sizeof(circularbuffer_S);\
	virt_addr += PAGE_SIZE)
	{
		/* Set the pages as reserved */
		SetPageReserved(virt_to_page(virt_addr));
		//mem_map_reserve(virt_to_page(virt_addr));
	}

	phy_addr = virt_to_phys(buf_ptr);
	printk(KERN_INFO"Allocated Memory for Circular Buffer at physical
0x0%x\n",phy_addr);

#else

	buf_area = ioremap(0xB2000000,0x4000); //(0xB2000000,0x4000);
//(7700000,900000);
	if(!buf_area)
	{
		printk(KERN_ALERT"ioremap failed \n");
		return -1;
	}

	printk(" Ioremap mapped to virtual 0x0%x \n",buf_area);
	*((unsigned int *)buf_area) = 0xa5a5a5a5;
	printk(" Ioremap data  0x0%x \n",*((unsigned int *)buf_area + 0));

#endif

	/* Device major number is registered to set the driver entry point */
	if(register_chrdev(MAJOR_NO,MODULE_NAME, &fluke_fops)==0)
	{
		printk(KERN_DEBUG" Fluke driver registeration success \n");

	}
	else
	{
		printk(KERN_ALERT" Fluke driver registeration failed \n");
		return -1;
	}

	/*
	 * Register Data Acq interrupt request with specified irq and install the
	 * handler
	 */
	 if(request_irq(DATA_ACQ_INT,(void *)DataAcqIntHandler, SA_INTERRUPT,
	 						MODULE_NAME, NULL)==0)
	{
		printk(KERN_DEBUG" Data Acq interrupt request returns success \n");
	}
	else
	{
		printk(KERN_DEBUG" Data Acq interrupt request failed \n");
		unregister_chrdev(MAJOR_NO,MODULE_NAME);
		return -1;

	}

	/* Reset the read and write index*/
	buf_index_area.write_index=0;
	buf_index_area.read_index=0;
	buf_index_area.count_index=0;

	return 0;

}

/***************************************************************************
*
* Description: Input/Output entry point for driver.
*
* Input:		Inode pointer, File pointer, command and parameter.
*
* Output:		Returns 0 on success and -1 on failure.
*
**************************************************************************/

static int McBSP_DriverIoctl(struct inode *inode, struct file *file,\
									unsigned int cmd, unsigned long param)
{
	int i;
	daq_t daq_param;

	printk(KERN_DEBUG"In ioctl command \n");

	switch(cmd)
	{
		case START_ACQ_DATA:

			if(copy_from_user(&daq_param,(void *)param,sizeof(daq_param)))
			{

				return -1;
			}

			/* For Simulation we are writing the data */
			if(WriteBuf() < 0)
			{
				printk(" Writing to the memory failure \n");
				return -1;
			}

			/* Wait for the Interrupt to occur */
			wait_event_interruptible( wait_queue, data_present_status !=0);

			printk("Read Index before read %d\n",buf_index_area.read_index);
			data_present_status=0;

			buf_index_area.read_index++;
			buf_index_area.read_index%=NO_FRAMES;

			if(buf_index_area.read_index ==((buf_index_area.write_index +1) %
NO_FRAMES))
			//if(buf_index_area.read_index == buf_index_area.write_index )
			{
				printk("Read failure because read and write index are same\n");
				return -1;
			}

			/* Decrement the count index to indicate the data availibility */
			down(&mutex);
			buf_index_area.count_index--;
			up(&mutex);

			/* copy the circular buffer read index */
			daq_param.circular_index = buf_index_area.read_index;

			/*for(i = 0;i < SIZE_FRAME; i++)
			{
				printk("%c",buf_area->fluke[buf_index_area.read_index].buffer[i]);
			}
			*/
			/* Configure ADC unit for No of samples and period */
			/* < To Dod > */
			#ifdef SIMULATION
			/* Reinitialize the timer and run it again */
			init_timer(&fluke_timer);
			fluke_timer.function=(void *)timer_func;
			fluke_timer.data=0;
			fluke_timer.expires=jiffies + (HZ*10);
			del_timer(&fluke_timer);
			printk(KERN_DEBUG"Timer reinitialize in ioctl \n");
			add_timer(&fluke_timer);

			#endif
			printk("Read Index after read %d\n",buf_index_area.read_index);
			if(copy_to_user((void *)param,&daq_param,sizeof(daq_param)))
			{

				return -1;
			}

			break;
		default:
			return(0);
	}
	return (0);
}

/******************************************************************************
* Description: This function writes data to the device.
*
* Inputs:  NONE
*
* Outputs: Returns No of bytes copied or -1 on failure.
******************************************************************************/
static ssize_t McBSP_DriverWrite(struct file *file,
			const char __user *buf, size_t len,loff_t *offset)
{

	int i,write_index;
	write_index = buf_index_area.write_index;
	if(buf_index_area.read_index ==((buf_index_area.write_index +1) %
NO_FRAMES))
	//if(buf_index_area.read_index == buf_index_area.write_index )
	{
		printk(KERN_ALERT"Not able to write\n");
		return -1;
	}
	printk(KERN_INFO" Before Write index = %d\n",buf_index_area.write_index);
	for(i=0;i<len;i++)
	{
		buf_area->fluke[write_index].buffer[i]=buf[i];
		//memset(buf_area->fluke[write_index].buffer,'A',SIZE_FRAME);
		//for(i = 0;i < SIZE_FRAME; i++)
		//{
		//	printk("%c",buf_area->fluke[write_index].buffer[i]);
		//}
		//printk(" %c",buf_area->fluke[write_index].buffer[i]);
	}
	for(i = 0;i < SIZE_FRAME; i++)
	{
		printk("%c",buf_area->fluke[write_index].buffer[i]);
	}
	//len = copy_from_user(buf_area->fluke[write_index].buffer,buf,len);

	//memcpy_fromio(ioremap_ptr,buf_area->fluke[write_index].buffer,4);

	buf_index_area.count_index++;
	buf_index_area.write_index++;
	buf_index_area.write_index%=3;

	printk(KERN_INFO" After Write index = %d\n",buf_index_area.write_index);

	return len;

}

/******************************************************************************
* Description: This function writes data to the circular buffer.
*
* Inputs:  NONE
*
* Outputs: Returns No of bytes copied or -1 on failure.
******************************************************************************/
static int WriteBuf(void)
{
	int i;

	printk(" write Index is %d \n",buf_index_area.write_index);
	if(buf_index_area.read_index ==((buf_index_area.write_index +1) %
NO_FRAMES))
	//if(buf_index_area.read_index == buf_index_area.write_index )
	{
		printk(KERN_ALERT"Not able to write\n");
		return -1;
	}

	memset(buf_area->fluke[buf_index_area.write_index].buffer,'A',SIZE_FRAME);

	/*for(i = 0;i < SIZE_FRAME; i++)
	{
		printk("%c",buf_index_area.fluke[buf_index_area.write_index].buffer[i]);
	}
	*/
	buf_index_area.count_index++;
	buf_index_area.write_index++;
	buf_index_area.write_index%=3;
	printk(" write Index incremented to %d \n",buf_index_area.write_index);

	return 0;
}


/******************************************************************************
* Description: This function reads data from the shared mmap area.
*
* Inputs:  file structuer,data buffer pointer and length of data.
*
* Outputs: Return no of bytes read or -1 on failure.
*
******************************************************************************/
static ssize_t McBSP_DriverRead(struct file *file,char __user *buf,size_t
len,
			loff_t *offset)
{

	int temp_read_index,i;
	printk(KERN_INFO"Entering %s\n",__FUNCTION__);

	/* Wait till timer Expires */
	wait_event_interruptible( wait_queue, data_present_status !=0);

	data_present_status=0;

	buf_index_area.read_index++;
	buf_index_area.read_index%=NO_FRAMES;

	/* Decrement the count index to indicate the data availibility */
	down(&mutex);
	buf_index_area.count_index--;
	up(&mutex);

	temp_read_index = buf_index_area.read_index;

	printk(KERN_INFO"Exting %s\n",__FUNCTION__);

	printk(KERN_INFO"count_index=%d\n",buf_index_area.count_index);
	printk(KERN_INFO"read_index=%d\n",buf_index_area.read_index);
	/*for(i = 0 ;i < SIZE_FRAME ; i++)
	{
		printk("%c",buf_area->fluke[temp_read_index].buffer[i]);
	}
	*/
	return((temp_read_index));
}

/*****************************************************************************
* Description:This function is used to map the memory area to user
application.
*				There is a circular buffer which is created in the driver.
*			   This region is mmaped to the user application by this function.
*			   This fuction sets the permissions for that area accordingly.
*
* Inputs:file pointer, virtual memory area structure.
*
* Outputs: Returns 0 on success or -1 on failure.
*******************************************************************************/
static int McBSP_DriverMmap(struct file *file,struct  vm_area_struct *vma)
{

	unsigned long start = vma->vm_start;
	unsigned long size = vma->vm_end - vma->vm_start; //0x900000;
	unsigned long phy_add = virt_to_phys(buf_ptr); //0x7700000;
	int ret = 0;

	/* Make the mmaped area noncacheable */
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

	/* Set the Flags to give permissions to Mmaped area */
	vma->vm_flags |=VM_RESERVED;
	vma->vm_flags |=VM_READ;
	vma->vm_flags |=VM_WRITE;
	vma->vm_flags |=VM_IO;
	//vma->vm_flags |=VM_SHARED;
	//vma->vm_flags |=VM_LOCKED;

	printk(KERN_DEBUG"In mmap function\n");

	/* Mmap the kernel buffer to user space */
	if(remap_pfn_range(vma,start,(phy_add >>
PAGE_SHIFT),size,vma->vm_page_prot))
	//if(remap_pfn_range(vma,start,vma->vm_pgoff,size,vma->vm_page_prot))
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

/******************************************************************************
* Description: This function opens mmaped area for the device.
*
* Inputs:  Virtual memory area structure.
*
* Outputs: none
******************************************************************************/
static void MmapOpen(struct vm_area_struct *vma)
{
	printk("Mmaped are is opened \n");

	printk("Virtual= %lx, Physical=%lx \n",vma->vm_start,
		(vma->vm_pgoff << PAGE_SHIFT));
	return;
}

/******************************************************************************
* Description: This function closes mmaped area for the device
*
* Inputs: Virtual Memory structure.
*
* Outputs: Return CASHEL_SUCCESS after closing the device.
******************************************************************************/
static void MmapClose(struct vm_area_struct *vma)
{
	printk(KERN_DEBUG"Mmaped are is closed\n ");
	return;
}

/******************************************************************************
*
* Description	: Unregisters the driver and makes the resources free.
*
* Input		: NIL
*
* Output		: NIL
*
*****************************************************************************/
static void __exit McBSP_DriverExit(void)
{
	unsigned int virt_addr;

#if 0
	/* Clear or Free the pages which are reserverd */
	for (virt_addr=(unsigned int)buf_area; virt_addr < (unsigned int)buf_area
										+ sizeof(circularbuffer_S);
	virt_addr += PAGE_SIZE)
	{
		// clear all pages
		ClearPageReserved(virt_to_page(virt_addr));
	}

	/* Free the mmaped buffer area */
	dma_free_coherent(NULL,L1_CACHE_ALIGN(sizeof(circularbuffer_S)),
												buf_ptr,dma_addr);
#else

	iounmap(buf_area);

#endif

	/* Unregister the device */
	if(unregister_chrdev(MAJOR_NO , MODULE_NAME)==0)
		printk(KERN_DEBUG" device cleanup success\n");
	else
		printk(KERN_ALERT" device cleanup failed \n");

	/* Free IRQ */
	free_irq(DATA_ACQ_INT,NULL);

	//if(buf_area)
	//	vfree(buf_area);

}

/******************************************************************************
* Description: This function closes the device
*
* Inputs:  Inode structure pointer, File structure pointer
*
* Outputs: Return 0 on success and -1 on failure.
******************************************************************************/
static int McBSP_DriverClose(struct inode *inode,struct file *file)
{
	device_open_count--;
	if(device_open_count == 0)
	{
		/* Delete the timer */
		del_timer(&fluke_timer);
	}

	printk(KERN_INFO" device closed %d\n",device_open_count);
	return 0;
}

/******************************************************************************
 *						 File Ends

*****************************************************************************/

#define MODULE_NAME						"fluke_driver"
#define MAJOR_NO							 333
#define NO_FRAMES							 3
#define SIZE_FRAME							 1024*5//(1024*1024*1)/* 3MB */
#define DATA_ACQ_INT						 23 /* To Do <for testing only > */
#define DATA_ACQ_INT_CLEAR					 1 /* To Do <for testing only > */

#define MAGIC_NUM      			'D'

#define START_ACQ_DATA   		_IOWR(MAGIC_NUM, 0,unsigned long)

/* Frame */
typedef struct
{
	char buffer[SIZE_FRAME];

}frame_S;

/* Circular Buffer Structured */
/* Mmaped area Structure */
typedef struct
{

	frame_S  fluke[NO_FRAMES];

}circularbuffer_S;

typedef struct
{
	unsigned int count_index;
	unsigned int read_index;
	unsigned int write_index;
}circularbuffer_index_S;

typedef struct
{
	int test_period_ms;		/*????? send to driver*/
	int req_no_sample;		/*send to driver*/
	int acq_no_of_sample;  /* return by driver*/
	int circular_index;    /* return by driver*/
	int sampling_rate_hz;  /*send to driver*/

}daq_t;


/******************************************************************************
 *						 File Ends

*****************************************************************************/

/******************************************************************************
* McBSP_appl.c
*
* Fluke Driver
*
* Description:
*
* Libraries Used:
*
*
* Unit Test Drivers (Binary):
*
*		<fix me >
*
*
* Special Compile Flags
*		Nil
*
* Revision History:
* 	(17/July/2008) Misbah
*    		Created the file
*
* Copyright (C)
*
******************************************************************************/

/******************************************************************************
*						Include Files
*****************************************************************************/
/* Standard linux files includes */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include "fluke_driver.h"

#define FLUKE_DRIVER		"/dev/fluke"

int main (int argc ,char *argv[])
{
	circularbuffer_S *mmap_ptr;
	int fd = -1,i;
	int size_mmap = sizeof(circularbuffer_S);
	int read_index = -1,ret = -1 ;
	FILE *fp1,*fp2,*fp3;
	char buf[1024];
	char *mmap_data;
	daq_t daq_param;

	/* Initialize the config param */
	daq_param.test_period_ms = 60*1000 ;
	daq_param.acq_no_of_sample = 0;
	daq_param.req_no_sample =0;
	daq_param.sampling_rate_hz = 0;

	mmap_data = (char *)malloc(sizeof(circularbuffer_S));

	/* creat files for frames */
	fp1 = fopen("frame1.txt","w");
	fp2 = fopen("frame2.txt","w");
	fp3 = fopen("frame3.txt","w");

	/* Open the device file */
	fd = open(FLUKE_DRIVER , O_RDWR);
	if (fd == -1)
	{
		printf(" Error in opening fluke device \n");
		return -1;
	}

	/* map the kernel memory to user space */
	mmap_ptr = mmap(NULL,size_mmap,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	printf(" Virtual addr of the pointer is 0x%x \n",(unsigned int)mmap_ptr);

	if(mmap_ptr == NULL )
	{
		printf(" mapped ptr returns NULL from driver n");
		return -1;
	}

	while(1)
	{
		/* Write to driver for testing only */
		memset(buf,'Z',sizeof(buf));
		printf(" Writing to driver \n");
		//write(fd,buf,sizeof(buf));

		/* Block on read to get the circular buffer read index */
		//read_index = read(fd, buf , 1024);
		//printf(" Here is the read for you %s\n",buf);
		if (ioctl(fd , START_ACQ_DATA ,&daq_param) < 0)
		{
			printf(" ioctl failed \n");
			return -1 ;
		}

		read_index = daq_param.circular_index;

		printf(" read index from application %d \n",read_index);

		/* Print the data read */
		//for(i = 0;i <= 1024 ; i++)
			printf(" %s \n",mmap_ptr->fluke[read_index].buffer);

		/* Write the data read fron the driver to the file */
		if(read_index >= 0)
		{
			ret = (SIZE_FRAME) ;

			memcpy(mmap_data, \
				mmap_ptr->fluke[read_index].buffer,SIZE_FRAME);

			if(read_index == 0)
				fwrite(mmap_ptr->fluke[read_index].buffer ,SIZE_FRAME , 1 ,fp1);
			else if(read_index == 1)
				fwrite(mmap_ptr->fluke[read_index].buffer ,SIZE_FRAME , 1 ,fp2);
			else if(read_index == 2)
				fwrite(mmap_ptr->fluke[read_index].buffer ,SIZE_FRAME , 1 ,fp3);
			else
			{
				printf("Not able to write to file as read_index returns %d
\n",read_index );
				return -1;
			}

		}

	}

	if(mmap_data)
		free(mmap_data);
	fclose(fp1);
	fclose(fp2);
	fclose(fp3);

	return 0;
}


/******************************************************************************
 *						 File Ends

*****************************************************************************/



please help me to resolve this issue .......


Thanks in advance ...

---- Misbah <><

Misbah khan wrote:
> 
> 
> If you SDRAM is you main memory, you need vmalloc and remap_vmalloc_range.
> If the SDRAM is not your main memory but some I/O attached buffer, you
> need
> ioremap/of_iomap and remap_pfn_range.
> 
> My SDRAM is the main memory of which 9MB i have to allocate in the driver. 
> 
> If i allocate 9BM using vmalloc and remap to user space how should it
> address to the 9MB 
> SDRAM contigues address which i need to map for user access ? 
> 
> 
> Arnd Bergmann wrote:
>> 
>> On Tuesday 22 July 2008, Misbah khan wrote:
>>> First of all let me thank you for your valuable suggessions ...
>>> 
>>> 1. I wanted to allocate 9MB in kernel and wanted that memory to be
>>> mapped to
>>> the physically continews SDRAM memory. but till now i could not found a
>>> way
>>> to do so ???
>>> 
>>> 2. So i thought to use ioremap to map SDRAM and make it accessible to
>>> user
>>> using mmap technique but there is only one doubt and that is will it be
>>> secure and stable and whether it is a right way of doing ???
>> 
>> As I have told you a few times now, you *either* allocate the memory *or*
>> ioremap it, NOT BOTH!!!
>> 
>> If you SDRAM is you main memory, you need vmalloc and
>> remap_vmalloc_range.
>> If the SDRAM is not your main memory but some I/O attached buffer, you
>> need
>> ioremap/of_iomap and remap_pfn_range.
>> 
>> 	Arnd <><
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>> 
> 
> 

-- 
View this message in context: http://www.nabble.com/how-to-allocate-9MB-of-memory-in-kernel---tp18503022p18627544.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
