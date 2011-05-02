Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C58EB6F12
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2011 22:40:07 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4256mfb024076
	for <linuxppc-dev@ozlabs.org>; Sun, 1 May 2011 23:06:48 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p42CdseL333166
	for <linuxppc-dev@ozlabs.org>; Mon, 2 May 2011 06:39:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p42CdRAp015623
	for <linuxppc-dev@ozlabs.org>; Mon, 2 May 2011 06:39:27 -0600
Date: Mon, 2 May 2011 08:40:39 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev <eftakhar.chowdhury@yahoo.com>
Subject: Re: Read/write BCSR registers of PPC460EX
Message-ID: <20110502124039.GB3269@zod.rchland.ibm.com>
References: <31522823.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <31522823.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 02, 2011 at 04:50:30AM -0700, linuxppc-dev wrote:
>
>Hi,
>
>I am trying to read the BCSR register of my PPC460ex board.But when I load
>the module, then I get the "Machine Check Error".
>
>I am not sure if I missed out something.
>
>I would really appreciate it if somebody could help me on this.
>
>I have posted the source code below, as well as the complete message.
>
>Thanks,
>efti
>
>Source code
>------------
>
>#include <linux/init.h> // to use module_init and module_exit
>#include <linux/module.h>// macros for modules
>#include <linux/kernel.h>
>#include <linux/ioport.h>
>#include <linux/errno.h>
>#include <asm/io.h>
>
>static unsigned int reg1 = 1; // test data
>static unsigned int reg2 = 2; // test data
>static unsigned int reg3 = 3; // test data
>static unsigned int *virtual_base = 0; // remapped address
>static unsigned long mem_addr = 0xC0000000;// IP base address

Is this the correct address for the BCSR?  On the 460EX Canyonlands
board, the CPLD/BCSR is at 0xE1000000.

>static unsigned long mem_size = 0x10000; // 64KB
>
>int io_driver_init(void)
>{
>	int i;
>	if(check_mem_region(mem_addr,mem_size))
>	{
>		printk("simp_mult: memory already in use\n");
>		return -EBUSY;
>	}
>	// request memory for the device
>	request_mem_region(mem_addr,mem_size,"simp_mult");
>	// remap
>	virtual_base = ioremap(mem_addr,mem_size);
>	printk("ioremap: Virtual Address %08x\n",(unsigned int)virtual_base);	
>	if( virtual_base==0 )
>	{
>		printk("ioremap failed\n");
>		return -EBUSY ;
>	}
>	else
>	{
>	
>	 unsigned int value;
>	 value = in_be32(virtual_base);
>	 printk("Data to Read : %08x\n",value);
>		
>		return 0; // indicate a success
>	}
>}

Aside from minor things like using unsigned int instead of unsigned
long, the code looks correct.  The thing to check is if you are
ioremapping the right physical address, and making sure you're reading a
proper location.

josh
