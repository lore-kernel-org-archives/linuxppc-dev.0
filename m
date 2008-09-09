Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 9E962DDF47
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 09:36:26 +1000 (EST)
Subject: PPC460EX - Machine check in kernel mode - when accessing I/O in
	user space
From: Henry Bausley <hbausley@deltatau.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Tue, 09 Sep 2008 16:34:07 -0700
Message-Id: <1221003247.5414.20.camel@lt-linuxhenry>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to give user space application access to I/O.   Previously I
used 2.6.14 with RT Linux and made a kernel device driver with a mmap
routine on a 440EP.

I am converting to a PPC460Ex with 2.6.26-2 with Xenomai the same code
results in a Machine Check in Kernel mode when I attempt to use the code
in user space.


The io memory is in the device tree and with ioremap and I can read and
write to it in kernel mode with

of_address_to_resource(np,0,&res)
piom = (unsigned *) ioremap( res.start, RTL_SHIOM_SIZE);
 


In addition I tried  

	void *map_base, * virtAddr;
	off_t target = ((unsigned int)addr) & ~MAP_MASK;
	int fd;

	if ((fd = open("/dev/mem", O_RDWR | O_SYNC)) == -1) {
		printf("/dev/mem could not be opened.\n");
		exit(1);
	}

	/* Map one page */
	map_base = mmap((void *)target, length, PROT_READ | PROT_WRITE,
			MAP_SHARED, fd, target);
	if (map_base == (void *) -1) {
		printf("Memory map failed for address 0x%lx\n", addr);
		exit(1);
	}


In my own driver I did the following for my mmap but it gives an error
as well.

//---------------------------------------
// map a pointer back for user mode usage
//----------------------------------------
static int ubus_mmap(struct file * filp, void * pvoidvma)
{
  int ret;
  struct vm_area_struct * vma = (struct vm_area_struct *)pvoidvma;

  vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
  ret = remap_pfn_range(vma,
                        vma->vm_start,
                        UBUS_BASE_ADDRESS >> PAGE_SHIFT,
                        vma->vm_end-vma->vm_start,
                        vma->vm_page_prot);
  if(ret != 0)
  {
    return -EAGAIN;
  }
  return 0;
}
