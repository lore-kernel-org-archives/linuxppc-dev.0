Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id F3C8F2BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Oct 2004 22:18:52 +1000 (EST)
Message-ID: <004301c4bc1f$69fccdc0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "soar.wu" <soar.wu@utstar.com>
References: <PCEFKKAFFIJFPILJEMCHAEAPCGAA.soar.wu@utstar.com>
Date: Wed, 27 Oct 2004 08:20:26 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Yes, the 'HPI' - are connected to a T.I. DSP, 6416 type.
>
> About the HPI problem progress.
> now we have the following resolve method:
>
> 1, If we use a temp variable to store the read out data, then store the
data to SDRAM, it is OK, there is no hop.
>      tmpReadRst = READ_UL_HPI_REG(UL_HPIDA_ADDR);
>     *p_cur = tmpReadRst;
>      p_cur++;
>
> 2, If we donot modify the source codes, but we use the optimization O3 to
compile the source codes, it is OK.
> *p_cur = READ_UL_HPI_REG(UL_HPIDA_ADDR);
> p_cur++;
>
> 3, If we add a sync instruction to the source  codes, it is OK.
> *p_cur = READ_UL_HPI_REG(UL_HPIDA_ADDR);
>             __asm__("  eieio; sync");
> p_cur++;
>
> 4, If we modify the BSP, update the memory operation option,
> from :
> PHYS_MEM_DESC sysPhysMemDesc [] =
> {
> ...
>     /*all the other small chip*/
>     {
>     (void *) 0x50000000,
>     (void *) 0x50000000,
>     0x08000000,
>     VM_STATE_MASK_VALID | VM_STATE_MASK_WRITABLE |
VM_STATE_MASK_CACHEABLE,
>     VM_STATE_VALID      | VM_STATE_WRITABLE      | VM_STATE_CACHEABLE_NOT
>     },
> ...
> to:
> PHYS_MEM_DESC sysPhysMemDesc [] =
> {
> ...
>     /*all the other small chip*/
>     {
>     (void *) 0x50000000,
>     (void *) 0x50000000,
>     0x08000000,
>     VM_STATE_MASK_VALID | VM_STATE_MASK_WRITABLE | VM_STATE_MASK_CACHEABLE
| VM_STATE_MASK_GUARDED,
>     VM_STATE_VALID      | VM_STATE_WRITABLE      | VM_STATE_CACHEABLE_NOT
| VM_STATE_GUARDED
>     },
> ...
>
> We added the option VM_STATE_VM_MASK_GUARDED and VM_STATE_GUARDED,
> still use the old source codes:
> *p_cur = READ_UL_HPI_REG(UL_HPIDA_ADDR);
> p_cur++;
>
> Now We find there is no hop. It is OK
>
>
> 5, If we use the memory which is allocated by function cacheDmaMalloc(),
> the hop still exist, but the number of  hop is little than when we use
malloc().
>
> Do you tell me the reason??
>

sysPhysMemDesc? This is VxWorks, not linux, right?  Well, the same general
points can be made, but this list is not the right one for VxWorks issues.

1) Even though the 8260 is cache-coherent you should make sure the MMU is
set up so the HPI space is non-cached.
2) In C code make sure the HPI space is declared as 'volatile' so the
compiler doesn't optimize out references to the address.
3) Remember that the HPI interface on the DSP is DMA driven and goes through
a FIFO, so that writes to DSP memory have a delay before they actually
appear in DSP memory.  And don't forget to look at cache issues on the DSP
side.  Your problem may actually be on the DSP side and your various fixes
are just introducing enough delay for things to complete on the DSP side.

Good luck,
Mark Chambers
