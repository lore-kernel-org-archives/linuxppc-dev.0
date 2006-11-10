Return-Path: <cel@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 983FB67EEB
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 09:57:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAAMvFUD013145
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 17:57:15 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAAMvF3m264024
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 15:57:15 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAAMvFTI029768
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 15:57:15 -0700
Subject: Help with an MMIO register read function
From: Carl Love <cel@us.ibm.com>
To: linuxppc-dev@ozlabs.org, cel@us.ibm.com
Content-Type: text/plain
Date: Fri, 10 Nov 2006 14:57:14 -0800
Message-Id: <1163199434.30540.13.camel@dyn9047021226.beaverton.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to print the value of the debug bus signal routing
registers to debug a potential issue in the RTAS call.  There are a
number of MMIO addresses that I need to read and print.  I was given a
little code segment to start with (see the example in the code below).
Based on that I wrote a function to read the 64 bit MMIO registers.  The
issue that I have is the data is almost correct.  Here is the output:

Print the pass through registers
L2_debug_1 addr 0x500858, value = 600000000000000
CIU_DR1 addr 0x500958, value = 4
on_ramp_trace 0x509c98, value = 100000000
MBL Debug addr 0x50a010, value = 80000
SBI_PMCR (MFC0) 0x4003c8, value = 200000000
SBI_PMCR (MFC1) 0x4023c8, value = 200000000
SBI_PMCR (MFC2) 0x4043c8, value = 200000000
SBI_PMCR (MFC3) 0x4063c8, value = 200000000
SBI_PMCR (MFC4) 0x4083c8, value = 200000000
SBI_PMCR (MFC5) 0x40a3c8, value = 200000000
SBI_PMCR (MFC6) 0x40c3c8, value = 200000000
SBI_PMCR (MFC7) 0x40e3c8, value = 200000000

I expect the SBI values to be 0x2000000  not 0x200000000.  The L2 debug
value should be 0x6 not 0x600000000000000.  It seems like the bits are
there but shifted from where I would expect them to be.  Anyone have any
thoughts as to what is wrong? 

               Carl Love

static void dump_mmio_addr()
{
  // need to include io.h
  unsigned long *base;
  unsigned long temp1;
  unsigned offset;
  struct device_node *node;
  void __iomem *tmcu_regs;

  //  Example
  //  node = of_find_node_by_type(NULL, "cpu");
  //  base = (unsigned long *) get_property(node, "bp-base", NULL);
  //  tmcu_regs = ioremap(*base+0x509800, 0xB000);
  //  temp1 = readq(tmcu_regs + 0x0);


  printk("Print the pass through registers\n");

  node = of_find_node_by_type(NULL, "cpu");
  base = (unsigned long *) get_property(node, "bp-base", NULL);

  offset = 0x500858;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("L2_debug_1 addr 0x%x, value = %lx\n", offset, temp1);

  offset = 0x500958;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("CIU_DR1 addr 0x%x, value = %lx\n", offset, temp1);

  offset = 0x509c98;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("on_ramp_trace 0x%x, value = %lx\n", offset, temp1);

  offset = 0x50A010;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("MBL Debug addr 0x%x, value = %lx\n", offset, temp1);

  offset = 0x4003c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC0) 0x%x, value = %lx\n", offset, temp1);


  offset = 0x4023c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC1) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x4043c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC2) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x4063c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC3) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x4083c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC4) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x40A3c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC5) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x40C3c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC6) 0x%x, value = %lx\n", offset, temp1);

  offset = 0x40E3c8;
  tmcu_regs = ioremap(*base+offset, 0xB000);
  temp1 = readq(tmcu_regs + 0x0);
  printk("SBI_PMCR (MFC7) 0x%x, value = %lx\n", offset, temp1);

}
