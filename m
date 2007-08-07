Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id 3DA0CDDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 19:07:08 +1000 (EST)
Date: Tue, 07 Aug 2007 12:06:46 +0300
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Scott Wood" <scottwood@freescale.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
Message-ID: <op.twol4cixnhx3hy@phoenix>
In-Reply-To: <F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Except from some macros arch/powerpc/include/asm/io.h / mpc8260_pci9.h, I  
can seem to find anywhere the code regarding PCI Erratum 9. The defined  
macros(in io.h) for read/write are sufficient as a workaround for PCI9?  
Who does DMA and register initialization for this (it used to be done in  
arch/ppc/syslib/m8260_pci_erratum9.c in arc/ppc). Maybe u-boot or the  
bootwrapper?

Another question regarding resource allocation: when  
alloc_resource(pci_32.c), called from pcibios_allocate_resources(), during  
pcibios init, attempts to allocate resources using request_resource(), the  
request fails. This seems to happen because the previously scanned PCI  
devices request resources in the form, e.g. 00000- 0000f (i.e. starting  
 from zero), and this should be mapped somewhere else in cpu mem space. My  
question (in order to find my bug) is, who performs this mapping, from PCI  
space to CPU space, the kernel (and if yes, where?) or the host bridge (in  
which case, I've probably failed to configure it properly).

Thank you

On Sat, 04 Aug 2007 19:39:58 +0300, Kumar Gala <galak@kernel.crashing.org>  
wrote:

>
> On Aug 3, 2007, at 3:10 PM, Scott Wood wrote:
>
>> On Fri, Aug 03, 2007 at 05:58:56PM +0300, Alexandros Kostopoulos wrote:
>>> Hi all,
>>> in the old arch/ppc tree, there was a function called  
>>> pq2ads_setup_pci()
>>> that set up PCI regs for 8272xx, in m82xx_pci.c. I was wandering, where
>>> are these registers configured now in arch/powerpc? I can't seem to  
>>> find
>>> these code now.
>>
>> It's done by the firmware or the bootwrapper.
>
>>> Also, I can see that now bus 0, dev 0 (which I think represents the  
>>> host
>>> bridge, right?) is now excluded using pq2_pci_exclude_device, but it
>>> wasn't in older code. Why is that?
>>
>> The older code probably either excluded all host bridges by class, or
>> just lived with the error message that gets printed on boot.
>
> This will change in 2.6.24.  I've fixed the reason we excluded the host  
> bridges on Freescale host bridges.
>
> - k
