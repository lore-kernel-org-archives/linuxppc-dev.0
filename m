From: Gabriel Paubert <paubert@iram.es>
Date: Thu, 27 Nov 2003 18:57:29 +0100
To: tpvk22 <tpvk22@163.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: how to use vme_queue_dmalist
Message-ID: <20031127175729.GA19364@iram.es>
References: <3FC5F059.000018.29086@bj244.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FC5F059.000018.29086@bj244.163.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 27, 2003 at 08:38:49PM +0800, tpvk22 wrote:
>
>   Hi, Gabriel Paubert
>   I used your universe.c and moditied your cm_mem20.c to do dma. But the PPC
> always died after done "vme_queue_dmalist ".Is it caused by error vme attributation?

I don't thonk so. I believe that you have missed the fact
that vme_queue_dmalist is an asynchronous call. You have to wait
for completion in the dma_handler routine.

Actually you can (and often should) allocate dmalist structures in the
module_init routine, but its unlikely that you need to perform DMA
at this point. In any case you need to put the process that triggers the
DMA on a wait list and wait to be awaken by the DMA handler routine
(which is called when the DMA is finished or encounters a bus error).


>   I am new to vme and universe. Hope get your help. Thanks very much!!

Well, in this case it is pretty standard way of triggering DMA
operations: you tell the hardware to do something and switch to
another task in the meantime.

The fact that vme_queue_dmalist is asynchornous is actually a necessary
feature when you consider some of the applications I have in which
the DMA is started in an interrupt routine, in which case you do not
have the right to sleep to wait fpr the end of the DMA.

	Regards,
	Gabriel

>
>
> #include <linux/vme.h>
> #include <linux/module.h>
> #include <linux/init.h>
> #include <linux/fs.h>
> #include <linux/errno.h>
> #include <linux/kernel.h>
> #include <linux/malloc.h>
> #include <linux/proc_fs.h>
> #include <linux/stat.h>
> #include <linux/pci.h>
> #include <linux/time.h>
> #include <linux/delay.h>
> #include <asm/uaccess.h>
> #include <asm/io.h>
> #include <linux/slab.h>
> //#include <mm/page_alloc.c>
>
> #define PAGE_SIZE  1024
> #define CM_MEM20_MAJOR 42
> static int cm_mem20_open(struct inode *, struct file *);
> static int cm_mem20_release(struct inode *, struct file *);
> static int cm_mem20_ioctl(struct inode *, struct file *,
> 		       unsigned int, unsigned long);
>
> static struct file_operations cm_mem20_fops = {
>   	NULL,                /* lseek */
> 	NULL,       	     /* read */
> 	NULL,                /* write */
> 	NULL,                /* readdir */
> 	NULL,                /* poll */
> 	ioctl:cm_mem20_ioctl,
> 	NULL,                /* mmap (might be implemented later) */
> 	open:cm_mem20_open,
> 	NULL,                /* flush */
> 	release:cm_mem20_release,
> 	NULL,                /* fsync */
> 	NULL,                /* fasync */
> 	NULL,                /* check_media_change */
> 	NULL,                /* revalidate */
> 	NULL                 /* lock */
> };
>
> static void dma_handler(struct vme_dma *);
>
> static struct private {
>         struct vme_device device;
> 	struct vme_region memory;
> 	struct vme_dma dmaread, dmawrite;
> 	struct vme_dmavec dmareadvec[2];
> 	//struct vme_dmavec dmareadvec;
> 	//struct vme_dmavec dmawritevec[2];
> 	struct wait_queue * wait;
> } cm_mem20 = {
>   	device:      {fops: &cm_mem20_fops,
> 		      name: "cm_mem20",
> 		      minor: 0},
> 	memory:      {flags: VME_AM_A24(32) |
> 		      VME_USE_PIO | VME_USE_DMA | VME_USE_RMW,
>                          base:  0,
>                          limit: 0xfffff},
> 	dmaread:     {handler: dma_handler,
>                          status : 0,
> 		    timeout: HZ},
> 	dmawrite:    {handler: dma_handler,
>                          status : 0,
> 		    timeout: HZ},
> 	dmareadvec:  {[0 ...1] = {length: PAGE_SIZE,
> 		      flags: VME_DMA(READ, A24(32))}},
> 	wait:        NULL,
> };
>
> static int mem=0;
>
> MODULE_PARM(mem, "i");
>
> static int cm_mem20_open(struct inode * inode, struct file * file)
> {
> 	MOD_INC_USE_COUNT;
> 	return 0;
> }
>
> static int cm_mem20_release(struct inode * inode, struct file * file)
> {
>   	MOD_DEC_USE_COUNT;
> 	return 0;
> }
>
> static void dma_handler(struct vme_dma* dma) {
> 	//wake_up(&cm_mem20.wait);
> }
>
>
> /*static int cm_mem20_ioctl(struct inode * inode, struct file * file,
> 			  unsigned int cmd, unsigned long arg)
> {
> 	int error;
> 	//volatile u_char *dp=cm_mem20.memory.vaddr;
> 	if (_IOC_SIZE(cmd) &&
> 	    !access_ok((_IOC_TYPE(cmd)&_IOC_READ) ? VERIFY_WRITE:VERIFY_READ,
> 		       arg, _IOC_SIZE(cmd))) return -EFAULT;
> 	switch(cmd) {
> 	case CM_MEM20_READP:
> 		error = vme_queue_dmalist(&cm_mem20.dmaread,
> 					  cm_mem20.dmareadvec, 2);
> 		if (error) break;
> //		while(cm_mem20.dmaread.status>0)
> 			//sleep_on(&cm_mem20.wait);
> 		error = cm_mem20.dmaread.status;
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
> 	return error;
> }
> */
> #ifdef MODULE
> void cleanup_module(void) {
> 	struct private *lp = &cm_mem20;
> 	printk("Unloading cm_mem20!\n");
>
> 	vme_unregister_device(&lp->device);
> 	kfree((void *) lp->dmareadvec[0].kvaddr);
>            kfree((void *) lp->dmareadvec[1].kvaddr);
>            lp->dmareadvec[0].kvaddr = 0;
>            lp->dmareadvec[1].kvaddr = 0;
> }
> #endif
>
> #ifdef MODULE
> #define cm_mem20_init init_module
> #endif
>
> int __init cm_mem20_init(void)
> {
> 	int error=0;
> 	struct private * lp = &cm_mem20;
> 	u_long tmp;
>
> 	/* These checks are crude, but the best we could reasonably do is
> 	 * to also check the last bytes of the RAM.
> 	 */
>
>           printk("step 1\n");
>           error = vme_safe_access(VME_READ32, VME_AM_A24(32), mem, &tmp);
> 	if (error) return error;
>
> 	tmp = 0x55aaaa55;
> 	error = vme_safe_access(VME_WRITE32, VME_AM_A24(32), mem, &tmp);
> 	if (error) return error;
>
>            printk("step 2\n");
> 	error = vme_safe_access(VME_READ32, VME_AM_A24(32), mem, &tmp);
> 	if (error) return error;
> 	if (tmp != 0x55aaaa55) return -ENXIO;
>
>         /*lp->dmareadvec[0].vme_addr =
> 	  lp->dmawritevec[0].vme_addr = mem;
> 	  lp->dmareadvec[1].vme_addr =
> 	  lp->dmawritevec[1].vme_addr = mem+PAGE_SIZE;
>         */
> 	do {
>
>            printk("step 3\n");
>            printk("memory.device = %p\n", lp->memory.device);
>            error = vme_register_region(&lp->device, &lp->memory);
>            if (error) {
>                printk ("memory.device = %p, cm_mem20 at kernel virtual     address %p.\n",
>                lp->memory.device, lp->memory.kvaddr);
>             return error;
>        }
> 	printk("memory.device = %p, cm_mem20 at kernel virtual address %p.\n", lp->memory.device, lp->memory.kvaddr);
>
>         printk("step 4\n");
>         //lp->dmareadvec[0].vme_addr = (u_long)lp->memory.kvaddr;
>         lp->dmareadvec[0].vme_addr = 0;
>         //lp->dmareadvec[1].vme_addr = (u_long)lp->memory.kvaddr+PAGE_SIZE;
>         lp->dmareadvec[1].vme_addr = 0+PAGE_SIZE;
>
>         printk("step 5\n");
>         error = vme_alloc_dmalist(&lp->device, &lp->dmaread, 4);
>         if (error) return -2;
>
>    printk("after:dmaread.status = %d,error=%d\n",lp->dmaread.status,error);
>
>        error = -ENOMEM;
>        lp->dmareadvec[0].kvaddr = (u_long) kmalloc(PAGE_SIZE, GFP_ATOMIC);
>        lp->dmareadvec[1].kvaddr = (u_long) kmalloc(PAGE_SIZE, GFP_ATOMIC);
>        if (!lp->dmareadvec[0].kvaddr || !lp->dmareadvec[1].kvaddr)
>        return -4;
>
>        error = vme_queue_dmalist(&lp->dmaread,
>                                           lp->dmareadvec, 2);
>        if (error)
>        {
>           printk("\n vme_queue_dmalist fail\n");
>           return -5;
>        }
>        else{
>           printk("\n vme_queue_dmalist success\n");
>           printk("\n dmavec0.dtbc = %d, dmavec0.laddr = %p,
>                      dmavec0.vaddr = %p",
>                      lp->dmareadvec[0].length,
>                      (virt_to_bus((void *)lp->dmareadvec[0].kvaddr)),
>                      lp->dmareadvec[0].vme_addr );
>           printk("\n dmavec1.dtbc = %d, dmavec1.laddr = %p,
>                      dmavec1.vaddr = %p",
>                      lp->dmareadvec[1].length,
>                      (virt_to_bus((void *)lp->dmareadvec[1].kvaddr)),
>                      lp->dmareadvec[1].vme_addr );
>        }
>        printk("end:dmaread.status = %d\n",lp->dmaread.status);
>        return 0;
>       } while (0);
> #ifdef MODULE
> 	cleanup_module();
> #endif
> 	return error;
> }
>
> the resule is:
> 202:/home/vmetest# insmod cm_mem20.2.o
> step 1
> step 2
> step 3
> cm_mem20 at kernel virtual address f5000000.
> step 4
> step 5
> after:dmaread.status = 2,error=0
>  vme_queue_dmalist success
>  dmavec0.dtbc = 1024, dmavec0.laddr = 0011e400, dmavec0.vaddr =
>  00000000
>  dmavec1.dtbc = 1024, dmavec1.laddr = 0011e800, dmavec1.vaddr =
>  00000400end:dmaread.status = 3
> NIP: C00383C4 XER: 00000000 LR: C00038BC REGS: c1c1fd70 TRAP: 0
> 300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c1c1e000[127] 'insmod' mm->pgd c1ce2000 Last syscall: 14
> 3
> last math c1c1e000
> GPR00: 00000100 C1C1FE20 C1C1E000 00000003 00000008 1002C490 00
> 001478 00000B70
> GPR08: 1002BB88 0000000C C0038384 C011EC00 44242080 1002B1A8 00
> 000000 100BCF10
> GPR16: 00000000 00000000 00000000 00000000 00009032 01C1FE80 00
> 000000 C0003B34
> GPR24: C0003868 10024D58 10024D48 00000000 7FFFECC8 00000008 FF
> FFFFF7 4BF03919
> Call backtrace:
> 00000000 C00038BC 10003F90 100041D8 0FECFF70 00000000
> Kernel panic: kernel access of bad area pc c00383c4 lr c00038bc
>  address 4BF03939 tsk insmod/127
> Rebooting in 180 seconds..
>
>
>
> ========================================================
> ????VIP??????????????????????! ??1??6??????          http://vip.163.com
>
> ???????????????????????? 25??????4?????????????????? http://mail.163.com
>
> ???????????????????? ????????????????????!????????????http://popo.163.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
