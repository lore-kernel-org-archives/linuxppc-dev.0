Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 460922C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 11:49:22 +1100 (EST)
Message-ID: <1388796549.11795.100.camel@snotra.buserror.net>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 3 Jan 2014 18:49:09 -0600
In-Reply-To: <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
 <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-20 at 15:43 +0800, Kevin Hao wrote:
> On Wed, Dec 18, 2013 at 05:48:25PM -0600, Scott Wood wrote:
> > On Wed, Aug 07, 2013 at 09:18:31AM +0800, Kevin Hao wrote:
> > > This is based on the codes in the head_44x.S. The difference is that
> > > the init tlb size we used is 64M. With this patch we can only load the
> > > kernel at address between memstart_addr ~ memstart_addr + 64M. We will
> > > fix this restriction in the following patches.
> > 
> > Which following patch fixes the restriction?  With all seven patches
> > applied, I was still only successful booting within 64M of memstart_addr.
> 
> There is bug in this patch series when booting above the 64M. It seems
> that I missed to test this previously. Sorry for that. With the following
> change I can boot the kernel at 0x5000000.

I tried v4 and it still doesn't work for me over 64M (without increasing
the start of memory).  I pulled the following out of the log buffer when
booting at 0x5000000 (after cleaning up the binary goo -- is that
something new?):

Unable to handle kernel paging request for data at address 0xbffe4008
Faulting instruction address: 0xc16ee934
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=8
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.0-rc1-00065-g422752a #12
task: c18f2340 ti: c192c000 task.ti: c192c000
NIP: c16ee934 LR: c16d1860 CTR: c100e96c
REGS: c192dee0 TRAP: 0300   Not tainted  (3.13.0-rc1-00065-g422752a)
MSR: 00021002 <CE,ME>  CR: 42044022  XER: 20000000
DEAR: bffe4008 ESR: 00000000 
GPR00: c16d1860 c192df90 c18f2340 c16eec58 00000000 00000000 05000000 00000000 
GPR08: 00000000 bffe4000 00000000 bc000000 00000000 0570ad40 ffffffff 7ffb0aec 
GPR16: 00000000 00000000 7fe4dd70 00000000 7fe4ddb0 00000000 c192c000 00000007 
GPR24: 00000000 c1940000 c16eec58 00000000 ffffffff 03fe4000 00000000 c18f0000
NIP [c16ee934] of_scan_flat_dt+0x28/0x148
LR [c16d1860] early_get_first_memblock_info+0x38/0x84
Call Trace:
[c192dfc0] [c16d1860] early_get_first_memblock_info+0x38/0x84
[c192dfd0] [c16d4888] relocate_init+0x98/0x160
[c192dff0] [c100045c] set_ivor+0x144/0x190
Instruction dump:
7c0803a6 4e800020 9421ffd0 7c0802a6 bee1000c 3f20c194 8139a45c 7c7a1b78
90010034 7c9b2378 3b80ffff 3ae00007 <83e90008> 3b00fff8 7fe9fa14 48000008
---[ end trace 41ed10ed80b8d831 ]---
Kernel panic - not syncing: Attempted to kill the idle task!


> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
> index 048d716ae706..ce0c7d7db6c3 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -171,11 +171,10 @@ unsigned long calc_cam_sz(unsigned long ram, unsigned long virt,
>  	return 1UL << camsize;
>  }
>  
> -unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
> +static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long virt,
> +					unsigned long ram, int max_cam_idx)
>  {
>  	int i;
> -	unsigned long virt = PAGE_OFFSET;
> -	phys_addr_t phys = memstart_addr;
>  	unsigned long amount_mapped = 0;
>  
>  	/* Calculate CAM values */
> @@ -195,6 +194,14 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
>  	return amount_mapped;
>  }
>  
> +unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
> +{
> +	unsigned long virt = PAGE_OFFSET;
> +	phys_addr_t phys = memstart_addr;
> +
> +	return map_mem_in_cams_addr(phys, virt, ram, max_cam_idx);
> +}
> +
>  #ifdef CONFIG_PPC32
>  
>  #if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >= NUM_TLBCAMS)
> @@ -289,7 +296,11 @@ notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
>  		is_second_reloc = 1;
>  		n = switch_to_as1();
>  		/* map a 64M area for the second relocation */
> -		map_mem_in_cams(0x4000000UL, CONFIG_LOWMEM_CAM_NUM);
> +		if (memstart_addr > start)
> +			map_mem_in_cams(0x4000000, CONFIG_LOWMEM_CAM_NUM);
> +		else
> +			map_mem_in_cams_addr(start, PAGE_OFFSET - offset,
> +					0x4000000, CONFIG_LOWMEM_CAM_NUM);
>  		restore_to_as0(n, offset, __va(dt_ptr));
>  		/* We should never reach here */
>  		panic("Relocation error");
> 

I'm having a hard time following the logic here.  What is PAGE_OFFSET -
offset supposed to be?  Why would we map anything belowe PAGE_OFFSET?

-Scott
