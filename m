Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A35F3DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 00:06:15 +1000 (EST)
Message-Id: <88C63CCF-7ED6-486F-8E95-FABD6CEE92E0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Status of patches (ppc32 mm init clean and 85xx kernel reloc)
Date: Tue, 8 Apr 2008 09:06:08 -0500
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here's my take on the current status of the patchset:

[POWERPC] bootwrapper: Allow specifying of image physical offset

reworked to look at PHDR (needs linker script update patch).  Still  
open question on how best to do that (objdump, readelf, C program,  
suggestions)

[POWERPC] Remove Kconfig option BOOT_LOAD

should be acceptable.

[POWERPC] Provide access to arch/powerpc include path on ppc64

should be acceptable (desired by others).

[POWERPC] Remove and replace uses of PPC_MEMSTART with memstart_addr

You had some questions about _stext and the PAGE_OFFSET vs  
KERNELBASE.  Not sure if you are satisfied with the answers.

[POWERPC] Introduce lowmem_end_addr to distiguish from total_lowmem

No comments.  Should be straight forward.

[POWERPC] 85xx: Cleanup TLB initialization

Only effects 85xx and I don't have issues with it :)

[POWERPC] Use lowmem_end_addr to limit lmb allocations on ppc32

No comments.  Straight forward patch.

[POWERPC] Rename __initial_memory_limit to __initial_memory_limit_addr

No comments.  Straight forward patch.

[POWERPC] Clean up some linker and symbol usage

No comments.  Straight forward patch.

[POWERPC] Move phys_addr_t definition into asm/types.h

I had an open question if the Kconfig for PHYS_64BIT should get set on  
PPC64 as well (has not effect).

I reworked the asm/types.h bits to look like:
+#if defined(CONFIG_PPC64) || defined(CONFIG_PHYS_64BIT)
+typedef __u64 phys_addr_t;
+#else
+typedef __u32 phys_addr_t;
+#endif

[POWERPC] 85xx: Add support for relocatble kernel (and booting at non- 
zero

Should probably get a bit more review.

[POWERPC] Update linker script to properly set physical addresses

You felt LOAD_OFFSET should be (CONFIG_PAGE_OFFSET -  
CONFIG_PHYSICAL_START).  I disagreed.  We need to resolve.

I think we should be able to quickly resolve and get into powerpc-next  
all but the '85xx: Add support for relocatable kernel' and  
'bootwrapper: Allow specifying of image..' patches.  If we can close  
on the phys_addr_t and linker script patches that would be great.

thanks

- k
