Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 842C8DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:15:39 +1000 (EST)
Message-ID: <49EEE18C.5000805@windriver.com>
Date: Wed, 22 Apr 2009 17:21:16 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Nicolas Lavocat <nicolas.lavocat@fr.thalesgroup.com>
Subject: Re: freeze when reading a PCI bridge register
References: <49EECF8D.9000808@fr.thalesgroup.com>
In-Reply-To: <49EECF8D.9000808@fr.thalesgroup.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas Lavocat wrote:
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
> 
> 
> Therefore, when I do the same thing under Linux, the system crash when I
> try to read the second register...
> Linux is frozen, and there is no error message.
> Under Linux, I made an ioremap before use the registers and access to
> these registers thanks to  functions  "in_be32" and "out_be32".
> I tried with different endianness to avoid an error of this type.
> 
> If I understand, the main difference between u-boot and Linux (about
> registers access) is the activation of the MMU.
> So I thought that  problem could come from it. I think the problem could
> came from the configuration of DBAT and IBATS registers of the MMU, but
> I didn't found any information about the MMU configuration under Linux.
> So after this novel, I have some questions:
> 
> -Is the MMU configuration generic under Linux?
> -Does somebody think that the problem doesn't come from MMU?
> -How does work ioremap? Is it a fully software function, or does it
> speaks to MMU to get the effective address from physical address?
> -Does somebody have an idea, or a documentation about MMU configuration
> under linux?
> -Do you think that my MMU is under the control of an evil spirit? ^^
> 
> thank you for your help
> 

Looks you want to re-configure the PCI bridge again?

If so you really should do the private fixup function via some kernel API,
DECLARE_PCI_FIXUP_XXXX. It's not reasonable to re-configure PCI bridge after PCI
sub-system initial process is completed by kernel.

Best Regards
Tiejun

> Nicolas Lavocat
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
