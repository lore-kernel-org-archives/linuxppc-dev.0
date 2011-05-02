Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F26BC1007D1
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2011 21:50:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1QGre2-0005v3-Ma
	for linuxppc-dev@ozlabs.org; Mon, 02 May 2011 04:50:30 -0700
Message-ID: <31522823.post@talk.nabble.com>
Date: Mon, 2 May 2011 04:50:30 -0700 (PDT)
From: linuxppc-dev <eftakhar.chowdhury@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Read/write BCSR registers of PPC460EX
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I am trying to read the BCSR register of my PPC460ex board.But when I load
the module, then I get the "Machine Check Error".

I am not sure if I missed out something.

I would really appreciate it if somebody could help me on this.

I have posted the source code below, as well as the complete message.

Thanks,
efti

Source code
------------

#include <linux/init.h> // to use module_init and module_exit
#include <linux/module.h>// macros for modules
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/errno.h>
#include <asm/io.h>

static unsigned int reg1 = 1; // test data
static unsigned int reg2 = 2; // test data
static unsigned int reg3 = 3; // test data
static unsigned int *virtual_base = 0; // remapped address
static unsigned long mem_addr = 0xC0000000;// IP base address
static unsigned long mem_size = 0x10000; // 64KB

int io_driver_init(void)
{
	int i;
	if(check_mem_region(mem_addr,mem_size))
	{
		printk("simp_mult: memory already in use\n");
		return -EBUSY;
	}
	// request memory for the device
	request_mem_region(mem_addr,mem_size,"simp_mult");
	// remap
	virtual_base = ioremap(mem_addr,mem_size);
	printk("ioremap: Virtual Address %08x\n",(unsigned int)virtual_base);	
	if( virtual_base==0 )
	{
		printk("ioremap failed\n");
		return -EBUSY ;
	}
	else
	{
	
	 unsigned int value;
	 value = in_be32(virtual_base);
	 printk("Data to Read : %08x\n",value);
		
		return 0; // indicate a success
	}
}

void io_driver_exit(void)
{
	printk("Release Memory Region...\n") ;
	iounmap(virtual_base) ;
	release_mem_region(mem_addr,mem_size) ;
}

module_init(io_driver_init);
module_exit(io_driver_exit);



-- 
View this message in context: http://old.nabble.com/Read-write-BCSR-registers-of-PPC460EX-tp31522823p31522823.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
