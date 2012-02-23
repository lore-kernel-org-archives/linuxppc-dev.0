Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id DB68AB6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2012 13:32:58 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.54])
 by hrndva-qmta03.mail.rr.com with ESMTP
 id <20120223231514521.FGDI28900@hrndva-qmta03.mail.rr.com>
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 23:15:14 +0000
Date: Thu, 23 Feb 2012 17:13:58 -0600
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: How to handle cache when I allocate phys memory?
Message-ID: <20120223231358.GA30865@crust.elkhashab.com>
References: <20111012210816.GA17878@crust.elkhashab.com>
 <1318577991.29415.514.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318577991.29415.514.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I never did get this to work, and now I am back to it again.

On Fri, Oct 14, 2011 at 09:39:51AM +0200, Benjamin Herrenschmidt wrote:
> On Wed, 2011-10-12 at 16:08 -0500, Ayman El-Khashab wrote:
> > I'm using the 460sx (440 core) so no snooping here.  What
> > I've done is reserved the top of memory for my driver.  My
> > driver can read/write the memory and I can mmap it just
> > fine.  The problem is I want to enable caching on the mmap
> > for performance but I don't know / can't figure out how to
> > tell the kernel to sync the cache after it gets dma data
> > from the device or after i put data into it from user space.
> > I know how to do it from regular devices, but not when I've
> > allocated the physical memory myself.  I suppose what I am
> > looking for is something akin to dma_sync_single cpu/device.
> > 
> > In my device driver, I am allocating the memory like this, 
> > in this case the buffer is about 512MB.
> > 
> >  vma->vm_flags |= VM_LOCKED | VM_RESERVED;
> > 
> >  /* map the physical area into one buffer */
> >  rc = remap_pfn_range(vma, vma->vm_start, 
> >                          (PHYS_MEM_ADDR)>>PAGE_SHIFT, 
> >                          len, vma->vm_page_prot);
> > 
> > Is this going to give me the best performance, or is there
> > something more I can do?
> > 
> > Failing that, what is the best way to do this (i need a very
> > large contiguous buffer).  it runs in batch mode, so it
> > DMAs, stops, cpu reads, cpu writes, repeat ...
> 
> Did you try looking at what the dma_* functions do under the hood and
> call it directly (or reproducing it) ?
> 
> Basically it boils down to using dcbf instructions to flush dirty data
> or dcbi to invalidate cache lines.
> 

I've reserved (using mem=) memory at the top of my system.
In my case, its the upper 1GB of 2GB total.  I've got a
small driver that I've written that maps it into user space
using mmap .. that all works fine.  I've also got it caching
and that also works.  The problem is that depending on how I
do things, I can get some cache-coherency issues.  I know in
the user code where to poke things, but I've tried
everything I can think of and *cannot* get flush_dcache_range 
to work for me.

My mapping code in the driver is:

static int my_mmap(struct file *fip, struct
vm_area_struct *vma)
{
  int rc;

  unsigned long len = vma->vm_end - vma->vm_start;

  printk(KERN_DEBUG "mapping %ld bytes\n", len);

 vma->vm_page_prot = pgprot_cached(vma->vm_page_prot);

 kernel_vp = ioremap(PHYS_MEM_ADDR, 1<<20);
 rc = remap_pfn_range(vma, vma->vm_start,
             (PHYS_MEM_ADDR)>>PAGE_SHIFT,
             len, vma->vm_page_prot);

  return (rc < 0 ? rc : 0);
}

I've stripped out some comments but otherwise, this is it.
I've tried both with and without ioremap, both fail in the
same way.  I've changed the vma->vm_page_prot a number of
ways.  In this example, I had knocked the size of ioremap
(and the flush) to 1MB to see if it was a size issue, but
the kernel gives an error as soon as the first dcbf
instruction is executed in the flush loop.

Then I've got an ioctl to flush

   case CACHE_FLUSH:
        {   
            u_int32_t phys_start = phys_mem_addr<<20;
            u_int32_t phys_stop  = (phys_mem_addr +
phys_mem_size)<<20;
            //flush_dcache_range(phys_start, phys_stop-1);
            flush_dcache_range(kernel_vp, kernel_vp +
(1<<20));
        }
        break;

kernel_vp is a virtual pointer from ioremap (only 1MB in
size).  The phys_stop and phys_start is the physical address
range, which I think might be wrong.  It does not work in
either case anyway.  

I'd really like to map 1G, make it cachable and do the flush
and invalidate on demand ... what am I missing?  Here is the
kernel dump

##########Unable to handle kernel paging request for data at
address 0x40000000
##Faulting instruction address: 0xc000c398
##Oops: Kernel access of bad area, sig: 11 [#1]
PowerPC 44x Platform
last sysfs file:
/sys/devices/plb.0/opb.3/4ef600400.i2c/i2c-0/0-0022/gpio/gpio223/value
Modules linked in: tan_mpt2sas tanomem [last unloaded:
tanomem]
NIP: c000c398 LR: f4fd91d4 CTR: 02000000
REGS: ebad7dc0 TRAP: 0300   Not tainted
(2.6.37.6-tanisys-sx2-24099)
MSR: 00029000 <EE,ME,CE>  CR: 48040242  XER: 00000001
DEAR: 40000000, ESR: 00800000
TASK = ebceb0c0[2720] 'testapplication' THREAD: ebad6000
GPR00: 00000400 ebad7e70 ebceb0c0 40000000 02000000 0000001f
28040244 101132b0
GPR08: 0002d000 f4fd9590 ebbda180 c000c37c 00000000 101a47c8
00000003 bfa4d229
GPR16: bfd98f84 1003a5f8 101416c0 101414b0 bfa4baa8 bfa4bb1c
bfa4bd00 00000000
GPR24: 00000000 101a1514 bfa4d69c ebbda180 fffffff7 c0045402
28040244 28040244
NIP [c000c398] invalidate_dcache_range+0x1c/0x30
LR [f4fd91d4] tanomem_ioctl+0xc8/0x200 [tanomem]
Call Trace:
[ebad7e70] [00029000] 0x29000 (unreliable)
[ebad7e90] [c00ac98c] vfs_ioctl+0x40/0x64
[ebad7ea0] [c00acb7c] do_vfs_ioctl+0x88/0x6fc
[ebad7f10] [c00ad230] sys_ioctl+0x40/0x74
[ebad7f40] [c000c7dc] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0x1011ad90
    LR = 0x10021508
Instruction dump:
7c0018ac 38630020 4200fff8 7c0004ac 4e800020 38a0001f
7c632878 7c832050
7c842a14 5484d97f 4d820020 7c8903a6 <7c001bac> 38630020
4200fff8 7c0004ac
# Kernel panic - not syncing: Fatal exception
IRebooting in 5 seconds..dentifyDevice ###############



Thanks,
Ayman
