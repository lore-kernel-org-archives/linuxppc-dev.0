Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id F2FBEDDED6
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 21:29:55 +1000 (EST)
Date: Wed, 22 Apr 2009 13:03:27 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Nicolas Lavocat <nicolas.lavocat@fr.thalesgroup.com>
Subject: Re: freeze when reading a PCI bridge register
Message-ID: <20090422110327.GA9997@iram.es>
References: <49EECF8D.9000808@fr.thalesgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49EECF8D.9000808@fr.thalesgroup.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 10:04:29AM +0200, Nicolas Lavocat wrote:
> Hi everybody!
>
> I' am trying to configure a PCI bridge on a private board, with a  
> powerpc . In a first time, I tried to get informations about PCI  
> devices, in order to be sure  that  my read  and write methods work (  
> using 2 configuration registers, like on an x86 architecture.) . 2  
> configuration registers  are used, for example we  write  an encoded  
> address (it is a request to a PCI device) in the first and the answer of  
> the PCI device can be read in the second register (it is a configuration  
> cycle)
> Firstly, I did it by JTAG: it works. Then, under uboot, it is ok.

JTAG is probably a completely different hardware path, so it
does not really count. uboot testing is ok.
>
> For example, the code used under u-boot:
>
> volatile u32* addr;
> u32 vendor_device_ID;
>
> puts("PCI1 reading PCI VENDOR and DEVICE ID\n");
> addr=CFG_ADDR_PCI1;
> *addr=0x80007800;
>
> addr= CFG_DATA_PCI1;
> vendor_device_ID= *addr;
> printf("PCI1: PCI1_VENDOR_DEVICE_ID= %08x  \n" ,vendor_device_ID);

2 possibilities:
- your I/O is not marked uncacheable (should be with ioremap)
- the PPC is reordering and issuing the read before the write,
  you should use accessors. A simple test is inserting
  an asm volatile("eieio") before the read.

About your other mails, please avoid HTML mail.

	Gabriel
