Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id C82C068ACE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 10:03:17 +1100 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id 94D5AA4011
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 00:03:14 +0100 (CET)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH resend, example] PPC-4xx DMA scatter/gather (to user memory)
Date: Thu, 9 Feb 2006 00:03:13 +0100
References: <68997D3094017740BB875EB2A425A6EA02C1C11D@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <68997D3094017740BB875EB2A425A6EA02C1C11D@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200602090003.13940.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On onsdag 08 februari 2006 21.53, Buhler, Greg wrote:
> Does anyone have any example code they could provide me that shows
> correct usage of the Linux 2.6.x PPC-4xx scatter/gather DMA
> functionality? None of the mainline kernel tree sources or module
> sources seem to use this functionality.

These patches are for 2.4, and scatter/gather works with them
(transfering big images directly to user memory) and using all
channels for multiple purposes...
We have sent two messages to this list about issues in this part of the 
kernel. But lets start with example code using the patches.
(part of this could be moved into generic case)
Disclaimer: I have not worked with this code for over a half year
(home with my son)...

#define DRIVER_DMA_IRQ_BASE xyz
#define DRIVER_DMA_TO_IRQ(dma)         (DRIVER_DMA_IRQ_BASE + (dma))
#define DRIVER_IRQ_TO_DMA(irq)         ((irq) - DRIVER_DMA_IRQ_BASE)

/*
 *  DMA read
 */
#include <asm/ppc4xx_dma.h>
#include <asm/io.h>
static volatile int driver_dma_status[MAX_PPC4xx_DMA_CHANNELS];

int driver_report_dma_error(const char *call, int ret)
{
    switch (ret)
    {
	case DMA_STATUS_GOOD:
//	    printk(KERN_DEBUG "driver: %s STATUS_GOOD\n", call);
	    break;
	case DMA_STATUS_BAD_CHANNEL:
	    printk(KERN_DEBUG "driver: %s STATUS_BAD_CHANNEL\n", call);
	    break;
	case DMA_STATUS_BAD_HANDLE:
	    printk(KERN_DEBUG "driver: %s STATUS_BAD_HANDLE", call);
	    break;
	case DMA_STATUS_BAD_MODE:
	    printk(KERN_DEBUG "driver: %s STATUS_BAD_MODE", call);
	    break;
	case DMA_STATUS_NULL_POINTER:
	    printk(KERN_DEBUG "driver: %s STATUS_NULL_POINTER", call);
	    break;
	case DMA_STATUS_OUT_OF_MEMORY:
	    printk(KERN_DEBUG "driver: %s STATUS_OUT_OF_MEMORY", call);
	    break;
	case DMA_STATUS_SGL_LIST_EMPTY:
	    printk(KERN_DEBUG "driver: %s STATUS_SGL_LIST_EMPTY", call);
	    break;
	case DMA_STATUS_GENERAL_ERROR:
	    printk(KERN_DEBUG "driver: %s STATUS_GENERAL_ERROR", call);
	    break;
	case DMA_STATUS_CHANNEL_NOTFREE:   
	    printk(KERN_DEBUG "driver: %s STATUS_CHANNEL_NOTFREE", call);
	    break;
	default:
	    printk(KERN_DEBUG "driver: %s STATUS(0x%x)", call, ret);
	    break;
     }

    return ret;
}

#ifdef DEBUG_DMA
#define DBG_DMA(call) driver_report_dma_error(#call, call)
#else
#define DBG_DMA(call) call
#endif

/* Forward declaration */
static void driver_dma_irq_handler(int irq, void *dev_id, struct pt_regs 
*regs);

// Returns DMA_STATUS
static unsigned driver_init_peripheral_dma(int dmanr, int write)
{
	unsigned ret;

	if (dmanr < 0 || dmanr >= MAX_PPC4xx_DMA_CHANNELS)
		return DMA_STATUS_BAD_CHANNEL;

#ifdef DEBUG
	int dma_irq = DRIVER_DMA_TO_IRQ(dmanr);
	printk(KERN_INFO "driver: using DMA %d (and IRQ %d) for %s\n", dmanr, 
dma_irq, write?"write":"read");
#endif
	{
		ppc_dma_ch_t p_init = {0,};
		// default polarity?
		p_init.buffer_enable = 1;
		p_init.pl = EXTERNAL_PERIPHERAL;
		p_init.pwidth = PW_32;
		if(write) p_init.sai = 1; // source address increment on
		else p_init.dai = 1;      // destination address increment on
		// no setup cycles
		// no peripheral wait/hold cycles
		p_init.cp = PRIORITY_LOW;
		p_init.pf = 2; // memory (source) read prefetch
		p_init.int_enable = 1;
		p_init.etd_output = 0; // shall be 0. but if p_init.tce_enable is 1 this 
must be 1. but it makes no dif
#ifdef DEBUG_DMA_IRQ_EVERY_PAGE
		p_init.tce_enable = 1; // test only, should be off...
#endif
		// shift, control - will be initiated
		// mode, addr, ce - only in singel dma transfers

		ret = DBG_DMA(ppc4xx_init_dma_channel(dmanr, &p_init));
	}
	
	return ret;
}

struct driver_device
{
	sgl_handle_t dmalist;
};


// buf is pointer in user memory space
// size is size!
// dmanr is dmanr!
// write=1, transfer from user memory to device
// write=0, transfer from device to user memory
// Note: kiobufs does not exist in 2.6 but this code can be ported with less
// overhead...
static ssize_t driver_io_dma(char *buf, size_t size, int dmanr, int 
write) //add parameter [int max_time_ms] for transfer
{
	ssize_t ret;
	size_t remains;
	struct driver_device device = {0,};
	struct kiobuf *kp = NULL;
	int i, res;

	ret = -EAGAIN; // retry should work...
	int dma_irq = DRIVER_DMA_TO_IRQ(dmanr);
	int transmode;

	unsigned long flags;
	time_to("io_dma begin");
	
	spin_lock_irqsave(&driver_dma_lock, flags);

	if ((ret = request_irq(dma_irq, driver_dma_irq_handler, SA_SHIRQ, "driver", 
&device))) {
		printk(KERN_ERR "driver: request_irq(%d) IRQ for DMA(%d) failed.\n", 
dma_irq, dmanr);
		spin_unlock_irqrestore(&driver_dma_lock, flags);
		return ret;
	}
	
	// Note: Interrupt here gave OOPS - cause dmalist was uninitialized and 
handler uses it.

	if (DBG_DMA(request_dma(dmanr, "driver")) != DMA_STATUS_GOOD) // TODO: 
driver_misc_device.name?
		goto out_irqrestore;

	// Clean spurious pending interrupts
#ifdef DEBUG_DMA
	{
		int dma_status = ppc4xx_get_dma_status();
		printk(KERN_DEBUG "driver: dma_status when enabling DMA(%d) was 0x%08x, 
requesting %d bytes\n", dmanr, dma_status, size);
	}
#endif
	driver_dma_status[dmanr] = DMA_STATUS_DMA_BUSY; /* changed by interrupt 
handler */

	// the ppc manual states no dma will start if they for some reason are set...
	unsigned int status_bits[] = {DMA_CS0 | DMA_TS0 | DMA_CH0_ERR,
		DMA_CS1 | DMA_TS1 | DMA_CH1_ERR,
		DMA_CS2 | DMA_TS2 | DMA_CH2_ERR,
		DMA_CS3 | DMA_TS3 | DMA_CH3_ERR};
	mtdcr(DCRN_DMASR, status_bits[dmanr]);
	spin_unlock_irqrestore(&driver_dma_lock, flags);
	/* Interrupts should not happen here... nothing running... status cleared... 
*/
	
	//ppc4xx_disable_dma(dmanr); // should be disabled already...

	ret = -EAGAIN; // retry should work...
	if(write) transmode = DMA_MODE_WRITE;
	else transmode = DMA_MODE_READ;
	if (DBG_DMA(ppc4xx_alloc_dma_handle(&device.dmalist, transmode, dmanr)) != 
DMA_STATUS_GOOD)
	{
		spin_lock_irqsave(&driver_dma_lock, flags);
		goto out_free_dma; /* reuse return path */
	}

	ret = -EINVAL; // page unlocked?
	
	//setup kiobuf
	res = alloc_kiovec(1, &kp);
	if (res < 0 || kp==NULL)
	{
		printk(KERN_DEBUG "driver readdma: alloc_kiovec failed, res=%d\n", res);
		goto out_free_dma_handle;
	}
	
	res = map_user_kiobuf(write /*rw 1 = to device, 0 = from device*/, kp, 
(unsigned long)buf, size);
	if (res != 0)
	{
		printk(KERN_DEBUG "driver readdma: map_user_kiobuf failed, res=%d\n", res);
		free_kiovec(1, &kp);
		goto out_free_dma_handle;
	}
// NOTE: if I remember correctly this part, lock_kiovec, had to be removed for
// proper function, race when using same partial page from different threads
// (one bit for lock?). But I guess it would be equally dangerous to remove it
// when using swap - most don't...
	res = lock_kiovec(1, &kp, 0);
	if (res != 0)
	{
		printk(KERN_DEBUG "driver readdma: lock_kiovec failed, res=%d\n", res);
		unmap_kiobuf(kp);
		free_kiovec(1, &kp);
		goto out_free_dma_handle;
	}
	//printk(KERN_DEBUG "fill the sg dma list #%d\n", kp->nr_pages);
	remains = size;
	for (i=0; i<kp->nr_pages; i++)
	{
		struct page *pg = kp->maplist[i];
		
		//these two tests has never failed so they are probably not needed
		//as long as map_user_kiobuf() and lock_kiovec() is successful
		if (!VALID_PAGE(pg))
		{
			printk(KERN_DEBUG "driver: Page not valid\n");
			goto out_free_kiobuf;
		}
		if (!PageLocked(pg))
		{
			printk(KERN_DEBUG "driver: Page valid but not locked(0x%x)\n", (unsigned 
int)page_address(pg));
			goto out_free_kiobuf;
		}

		//calculate physical address and length of mem
		phys_addr_t part_start = virt_to_phys(page_address(pg));
		size_t part_len = PAGE_SIZE;
		if (i==0)
		{
			part_start += kp->offset;
			part_len -= kp->offset;
		}
		if (part_len > remains)
			part_len = remains;
	
		if(write)
			(void)DBG_DMA(ppc4xx_add_dma_sgl(device.dmalist, part_start, 
(phys_addr_t)NULL, part_len));
		else
			(void)DBG_DMA(ppc4xx_add_dma_sgl(device.dmalist, (phys_addr_t)NULL, 
part_start, part_len));
		remains -= part_len;
	}
	/* User might have cleaned the destination, make sure it is written to memory 
before DMA starts */
	dma_cache_wback_inv((unsigned long)buf, size); //use for both read and write!

#ifdef DEBUG_DMA
	printk(KERN_DEBUG "dma status 0x%08x\n", ppc4xx_get_dma_status()), 
	printk(KERN_DEBUG "Starting DMA%d!\n", dmanr);
#endif
	time_to("io_dma: go");
	//do dma transfer
	ppc4xx_enable_dma_sgl(device.dmalist);
    
	// this takes time... make sure that driver does not change _status early!
	//printk(KERN_DEBUG "enable_dma_sgl done, dma status 0x%08x\n", 
ppc4xx_get_dma_status());
    
	if ((ret = wait_event_interruptible_timeout(driver_dma_event, 
driver_dma_status[dmanr] != DMA_STATUS_DMA_BUSY, HZ*0.6)) <= 0)
	{
        	unsigned long flags, src_addr, dst_addr;

		spin_lock_irqsave(&driver_dma_lock, flags);
		ppc4xx_disable_dma_sgl(device.dmalist);
		
		printk(KERN_DEBUG "Wait Interrupted (%d), dma status 0x%08x - cancel 
DMA(%d), residue %d\n", ret, ppc4xx_get_dma_status(), dmanr, 
ppc4xx_get_dma_sgl_residue(device.dmalist, &src_addr, &dst_addr));
        	
		ppc4xx_set_sg_addr(dmanr, 0);
		
		// ppc4xx_disable_dma(dmanr); says that channel is not used...
		switch (dmanr) {
		case 0:
			mtdcr(DCRN_DMACR0, mfdcr(DCRN_DMACR0) & ~DMA_CE_ENABLE);
			break;
		case 1:
			mtdcr(DCRN_DMACR1, mfdcr(DCRN_DMACR1) & ~DMA_CE_ENABLE);
			break;
		case 2:
			mtdcr(DCRN_DMACR2, mfdcr(DCRN_DMACR2) & ~DMA_CE_ENABLE);
			break;
		case 3:
			mtdcr(DCRN_DMACR3, mfdcr(DCRN_DMACR3) & ~DMA_CE_ENABLE);
			break;
		default:
			printk("disable_dma: bad channel: %d\n", dmanr);
		}

		spin_unlock_irqrestore(&driver_dma_lock, flags);

		if (ret == 0) // timeout
			ret = -ETIMEDOUT;
		goto out_free_kiobuf;
	}

	time_to("io_dma: wait done");
#ifdef DEBUG_DMA	
	printk(KERN_DEBUG "Wait Done, dma status 0x%08x\n", ppc4xx_get_dma_status());
#endif
	
	// always run with enabled interrupts
	// (void)DBG_DMA(ppc4xx_disable_dma_interrupt(dmanr));

	switch (driver_dma_status[dmanr])
	{
		case DMA_STATUS_TS:
		/* peripheral has transfered all its data, question is how much is that? */
		{
			phys_addr_t src_addr, dst_addr;
			ret = ppc4xx_get_dma_sgl_residue(device.dmalist, &src_addr, &dst_addr);
			ret = size - ret;
			//mark_dirty_kiobuf(kp, ret);
			break;
		}
	
		case DMA_STATUS_CS:
			/* more pheripheral data available than space? or exact match? */
			ret = size;
			//mark_dirty_kiobuf(kp, ret);
			break;
	
		case DMA_STATUS_DMA_ERROR:
			/* error occured during transfer */
			ppc4xx_disable_dma_sgl(device.dmalist); /* to late? */
			printk(KERN_ERR "driver: request dma transfer resulted in error\n");
			ret = -EIO;
			break;
		default:
			ppc4xx_disable_dma_sgl(device.dmalist);
			printk(KERN_ERR "driver: request dma transfer result unhandled 
(dma_status=%d)\n", driver_dma_status[dmanr]);
			ret = -EIO;
			break;
	}

 out_free_kiobuf:

	{
		time_to("io_dma teardown begin");
		//end kiobuf
		unlock_kiovec(1, &kp);
		unmap_kiobuf(kp);
		free_kiovec(1, &kp);
		time_to("io_dma teardown done");
	}
       
 out_free_dma_handle:
	//phys_addr_t tmp;
	//while (ppc4xx_delete_dma_sgl_element(device.dmalist, &tmp, &tmp) == 
DMA_STATUS_GOOD) {};
	//^freed in sgdma ppc4xx_free_dma_handle() now.
	
	/* Disable interrupts - you never know what interrupt handler does with dma 
channel othervice */
	spin_lock_irqsave(&driver_dma_lock, flags);
	ppc4xx_free_dma_handle(device.dmalist);
 out_free_dma:
	free_dma(dmanr);

 out_irqrestore:
	free_irq(dma_irq, &device);
	/* No more interrupts are possible */
	spin_unlock_irqrestore(&driver_dma_lock, flags);
	
#ifdef DEBUG_DMA
	printk(KERN_DEBUG "driver_io_dma returns: %d\n", ret);
#endif
	return ret;
}

volatile int irq_count = 0; //debug variable

static void driver_dma_irq_handler(int irq, void *dev_id, struct pt_regs 
*regs)
{
       	unsigned long flags;

	int dmanr = DRIVER_IRQ_TO_DMA(irq);
	int dma_status = ppc4xx_get_dma_status();
	struct driver_device *pDevice = (struct driver_device *)dev_id;
	
	int flag_err = DMA_CH0_ERR | DMA_CH1_ERR | DMA_CH2_ERR | DMA_CH3_ERR;
	int flag_ts = DMA_TS0 | DMA_TS1 | DMA_TS2 | DMA_TS3;
	int flag_sg = DMA_SG0 | DMA_SG1 | DMA_SG2 | DMA_SG3;
	unsigned int status_bits[] = {DMA_CS0 | DMA_TS0 | DMA_CH0_ERR | DMA_SG0,
		DMA_CS1 | DMA_TS1 | DMA_CH1_ERR | DMA_SG1,
		DMA_CS2 | DMA_TS2 | DMA_CH2_ERR | DMA_SG2,
		DMA_CS3 | DMA_TS3 | DMA_CH3_ERR | DMA_SG3};
        
	if (dmanr < 0 || dmanr >= MAX_PPC4xx_DMA_CHANNELS)
	{
		printk(KERN_DEBUG "driver dma irq handler - dma/irq out of range (%d/%d)\n", 
dmanr, irq);
		return;
	}

       	spin_lock_irqsave(&driver_dma_lock, flags);

	//now works for all dma channels
	dma_status = ppc4xx_get_dma_status();
	dma_status &= status_bits[dmanr];
	
	if (dma_status)
	{
		int done=0;
		irq_count++; //debug variable
#ifdef DEBUG_DMA
		printk(KERN_DEBUG "irq 0x%x #%d\n", dma_status, irq_count);
#endif
		if (dma_status & flag_err) //DMA_CHx_ERR
		{
			printk(KERN_DEBUG "irqhandler - DMA_CH%d_ERR\n", dmanr);
			driver_dma_status[dmanr] = DMA_STATUS_DMA_ERROR;
			//TODO: stop sg dma here, or it will continue with next element when DMA 
SR-flags are cleared
			done=1;
		}
		else if (dma_status & flag_ts) //DMA_TSx
		{
#ifdef DEBUG_DMA
			printk(KERN_DEBUG "irqhandler - DMA_TS%d\n", dmanr);
			printk(KERN_DEBUG "irq#%d 0x%x 0x%08x 0x%08x\n", irq_count, dma_status, 
mfdcr(DCRN_ASG3), mfdcr(DCRN_DMACT3));
#endif
			driver_dma_status[dmanr] = DMA_STATUS_TS;
			done=1;
		}
		else /*if (dma_status & DMA_CSn)*/
		{
			//printk(KERN_DEBUG "irqhandler - DMA_CSx\n");
			
			/* set transfer finnished when no sgdma in progress (but device has more 
data to send) */
			if(!(dma_status & flag_sg)) //we don't need it if all goes well, because we 
allocate a large enough buffer
			{ 
#ifdef DEBUG_DMA
				printk(KERN_DEBUG "irqhandler - DMA_CS%d end of data\n", dmanr);
#endif
				driver_dma_status[dmanr] = DMA_STATUS_CS;
				done = 1;
			}
		}
	
		if (done)
		{
			/* Stop transfer before returning from interrupt handler
			 * or next link will be loaded...
			 */
			if (pDevice->dmalist == 0)
			{
#ifdef DEBUG_DMA
				printk(KERN_DEBUG "irqhandler - spurious interrupt on channel %d 
(status=0x%x)\n", dmanr, dma_status);
#endif
			}
			else
			{ 
				ppc4xx_disable_dma_sgl(pDevice->dmalist);

				wake_up(&driver_dma_event); //_interruptible
			}
		}

		//clear dma statusreg, only clear those we have seen
		//ppc4xx_clr_dma_status(dma); Clear even those not seen... DANGEROUS!!! (Not 
- channel stops)
		mtdcr(DCRN_DMASR, dma_status);
	}
	
	spin_unlock_irqrestore(&driver_dma_lock, flags);
}

We are actually still using the 2.4 tree with our own patches
to make SGDMA work.

Using a different approach...
1. We need more than one page of descriptors, so we allocate one
    at a time. [Doing DMA transfers of hires images directly to user space]
2. Interrupt is handled in a simpler way:
   If interrupts are enabled:
   * always enable error
   * always enable end of transfer interrupts
   * only enable terminal count interrupt on last descriptor

http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019442.html

Linux 2.4.20 (probably 2.6 as well?)
 
Conclusion:
Scatter/gather DMA is not thread safe.
 
Background:
1. We run all four dma channels simultaneously in SG mode on the PPC440EP, 
starting and stopping them in different threads.
2. Also we need to change channel configs between different transfers, i.e. 
run ppc4xx_init_dma_channel() to set read or write mode.

http://ozlabs.org/pipermail/linuxppc-embedded/2005-December/021225.html
