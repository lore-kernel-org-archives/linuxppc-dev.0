Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4C4AB6F95
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 09:03:39 +1000 (EST)
Subject: Re: [RFC] CONFIG_RELOCATABLE : __va() & __pa() definitions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Suzuki Poulose <suzuki@in.ibm.com>
In-Reply-To: <20110927175433.0c300384@suzukikp.in.ibm.com>
References: <20110927175433.0c300384@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Sep 2011 09:03:16 +1000
Message-ID: <1317250996.29415.125.camel@pasglop>
Mime-Version: 1.0
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-09-27 at 17:54 +0530, Suzuki Poulose wrote:
> Hi,
> 
> I am working on enabling CONFIG_RELOCATABLE for PPC44x Embedded PowerPC 
> boards as a foundation to enable CONFIG_CRASH_DUMP. After a discussion 
> on the linux-ppcdev we decided that we will follow the 'processing 
> relocation entries' approach for running the kernel from a different 
> address.

I think the best approach is to not touch KERNELBASE and PAGE_OFFSET,
and just process relocations, that way __va() and __pa() are unoutched
and plenty of other stuff won't break.

Ben.
> 
>  On PPC44x we pin the kernel text/data sections using 256M sized TLB 
> entries. Since the embedded boards have limited amount of RAM, we cannot
> enforce the kernel load address to be aligned to 256M. This prevents us 
> from mapping the 'loaded physical address' of the kernel to 'KERNELBASE'
> (virtual address of the kernel start). So we are forced to generate 
> relocation entries and process them before we start using the virtual 
> address(s) at the kernel boot time.
> 
> Please note that the KERNELBASE doesn't have to be 256M aligned.
> 
> 
>  I have adopted the following method for finding the relocation offset.
> 
>  1) Find the physical address of _start (start of kernel text)
>  2) Calculate the relocation offset as :
> 
> 	reloc_offset = (Phy_Addr(_stext) % 256M) - (KERNELBASE % 256M)
> 
> And then map ALIGN_DOWN(KERNELBASE,256M) to ALIGN_DOWN(Phys_Addr(_stext),256M).
> 
> 
> 
> 
> 
> 			| Phys. Addr	| Virt. Addr	|
> PageBoundary (256M)	|-------------------------------|
> 			|		|		|
> 			|		|		|
> 			|		|		|
> (Phys. Start)%256M->	|_______________|_ _ _ _ _ _ _ _|<- Act. Kernel
> 			|		|       ^	| Virtual Address
> 			|		|	|	|
> 			|		|	|	|
> 			|		|  reloc_offset	|
> 			|		|	|	|
> 			|		|	|	|
> 			|		|_______v_______|<-(KERNELBASE)%
> 			|		|		|   256M
> 			|		|		|
> 			|		|		|
> 			|		|		|
> 			|		|		|
> PageBoundary (256M)	|---------------|---------------|
> 			|		|		|
> 			|		|		|
> 
> 
> So the conversion of the addresses from virtual to physical and vice versa,
> needs to take care of the actual kernel virtual address taking into account
> of the relocation offset.
> 
> Currently __va() & __pa() has been defined as follows :
> 
> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + KERNELBASE))
> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
> 
> Where:
> 
>  * PHYSICAL_START (defined to variable, kernstart_addr) which holds 
> the physical address where the kernel is loaded. This variable is 
> initialized at the boot time.
> 
>  * KERNELBASE is the (compiled) kernel virtual start address.
> 
> These definitions would hold only if the load address is Page aligned, 
> which is not feasible onf PPC44x(as mentioned in the beginning).
> 
> So we need new definitions for them in CONFIG_RELOCATABLE case.
> 
> Here are the solutions that I could think of :
> 
> 1) Update kernstart_addr(PHSYICAL_START) to match the Physical address of
> KERNELBASE.
> 
>  i.e, kernstart_addr = Phys.Addr(_stext) + Reloc Offset
> 
>  This may not sound good, however, the kernstart_addr is only used for the
> __va()/__pa() calculation. So we are OK to use that.
> 
> 2) Redefine __va() & __pa()
> i.e,
> 
> #if defined(CONFIG_RELOCATABLE) && defined(CONFIG_44x)
> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
> #endif
> 
> where, RELOC_OFFSET could be 
> 
>   a) Either stored in a variable, say relocation_offset (like kernstart_addr)
>      at boot time.
> 
> 		OR
> 
>   b) #define RELOC_OFFSET ((PHYSICAL_START & PPC_PIN_SIZE_OFFSET_MASK) - \
>                       (KERNELBASE & PPC_PIN_SIZE_OFFSET_MASK))
> 
> 
> I am more tempted to adopt 2(a). Could you please let me know your 
> suggestions / thoughts / comments.
> 
> 	OR
> 
> Do should we support CONFIG_RELOCATABLE & CONFIG_KERNEL_START in the same time ?
> 
> 
> Thanks
> Suzuki
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
