Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 734F9B6F70
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2011 23:47:00 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id p8RDknXL016449
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2011 19:16:49 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8RDkFjt2420780
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2011 19:16:16 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8RJFGJb028325
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Sep 2011 05:15:46 +1000
Date: Tue, 27 Sep 2011 19:04:30 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
To: linux-ppc dev <linuxppc-dev@ozlabs.org>
Subject: [RFC] CONFIG_RELOCATABLE - __va() , __pa() definitions
Message-ID: <20110927190430.7fb9082e@suzukikp.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
	David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
	Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Scott Wood <scottwood@freescale.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Resending - Missed a few key people on the Cc list + Some more comments]

Hi,

I am working on enabling CONFIG_RELOCATABLE for PPC44x Embedded PowerPC 
boards as a foundation to enable CONFIG_CRASH_DUMP. After a discussion 
on the linux-ppcdev , we decided that we will follow the 'processing 
relocation entries' approach for running the kernel from a different 
address.

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-June/090986.html

 
 On PPC44x we pin the kernel text/data sections using 256M sized TLB 
entries. Since the embedded boards have limited amount of RAM, we cannot
enforce the kernel load address to be aligned to 256M. This prevents us 
from mapping the 'loaded physical address' of the kernel to 'KERNELBASE'
(virtual address of the kernel start). So we are forced to generate 
relocation entries and process them before we start using the virtual 
address(s) at the kernel boot time.

Please note that the KERNELBASE doesn't have to be 256M aligned.

 I have adopted the following method for finding the relocation offset.

 1) Find the physical address of _start (start of kernel text)
 2) Calculate the relocation offset as :

	reloc_offset = (Phy_Addr(_stext) % 256M) - (KERNELBASE % 256M)

And then map ALIGN_DOWN(KERNELBASE,256M) to
ALIGN_DOWN(Phys_Addr(_stext),256M).





			| Phys. Addr	| Virt. Addr	|
PageBoundary(256M)	|-------------------------------|
			|		|		|
			|		|		|
			|		|		|
(Phys. Start)%256M->	|_______________|_ _ _ _ _ _ _ _|<- Act.Kernel 
			|		|       ^	|   Virtual Address
			|		|	|	|
			|		|	|	|
			|		|  reloc_offset	|
			|		|	|	|
			|		|	|	|
			|		|_______v_______|<-(KERNELBASE)%
			|		|		|   256M
			|		|		|
			|		|		|
			|		|		|
			|		|		|
PageBoundary(256M)	|---------------|---------------|
			|		|		|
			|		|		|


So the conversion of the addresses from virtual to physical and vice
versa, needs to take care of the actual kernel virtual address taking
into account of the relocation offset.

Currently __va() & __pa() has been defined as follows :

#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) -
PHYSICAL_START + KERNELBASE)) #define __pa(x) ((unsigned long)(x) +
PHYSICAL_START - KERNELBASE)

Where:

 * PHYSICAL_START (defined to variable, kernstart_addr) which holds 
the physical address where the kernel is loaded. This variable is 
initialized at the boot time.

 * KERNELBASE is the (compiled) kernel virtual start address.

These definitions would hold only if the load address is Page aligned, 
which is not feasible onf PPC44x(as mentioned in the beginning).

So we need new definitions for them in CONFIG_RELOCATABLE case.

Here are the solutions that I could think of :

1) Update kernstart_addr(PHSYICAL_START) to match the Physical address
of KERNELBASE.

 i.e, kernstart_addr = Phys.Addr(_stext) + Reloc Offset

 This may not sound good, however, the kernstart_addr is only used for
 the __va()/__pa() calculation. So we are OK to use that.

2) Redefine __va() & __pa()
i.e,

#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_44x)
#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) -
PHYSICAL_START + (KERNELBASE + RELOC_OFFSET))) #define __pa(x)
((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
#endif

where, RELOC_OFFSET could be 

  a) Either stored in a variable, say relocation_offset (like
  kernstart_addr) at boot time.

		OR

  b) #define RELOC_OFFSET ((PHYSICAL_START & PPC_PIN_SIZE_OFFSET_MASK)
  - \ (KERNELBASE & PPC_PIN_SIZE_OFFSET_MASK))


3) Enforce CONFIG_KERNEL_START (i.e, KERNELBASE) to be PPC_PIN_SIZE(256M 
on PPC44x) aligned.

I am more tempted to adopt 2(a). Could you please let me know your 
suggestions / thoughts / comments.



Thanks
Suzuki
