Message-ID: <937610FE9B70D511B3E700508B8B65770E53DC@MAIL1>
From: Shie Erlich <shie_e@elbit.co.il>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 64 bit memory access - again ...
Date: Wed, 5 Dec 2001 11:25:16 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> a) what is the recommended way of doing a 64bit access in the linux kernel
?
>
>>I would first try to do it with a cache line burst access.  Put it in
>>copyback mode, zero the line, write the line, flush the line, invalidate
>>the line.

i tried that: first, i mapped the memory region as _PAGE_RW | _PAGE_GUARDED,
making
it cachable and since no _PAGE_WRITETHRU - it is supposed to be set in
writeback mode.
i tried writing to the address i need (a simple long long*) and than to
flush and invalidate
the address using the following function (found in arch/ppc/kernel/misc.S):
<===========================================================================
=========>
_GLOBAL(flush_dcache_range)
       li      r5,CACHE_LINE_SIZE-1
       andc    r3,r3,r5
       subf    r4,r3,r4
       add     r4,r4,r5
       srwi.   r4,r4,LG_CACHE_LINE_SIZE
       beqlr
       mtctr   r4

#if defined(CONFIG_IBM405_REVB) || defined(CONFIG_IBM405_REVC)
1:      mfmsr   r5
        li      r7,0
        ori     r7,r7,MSR_EE
        andc    r7,r5,r7
        mtmsr   r7
        dcbt    0,r3
        dcbf    0,r3
        mtmsr   r5
#else
1:     dcbf    0,r3
#endif
       addi    r3,r3,CACHE_LINE_SIZE
       bdnz    1b
       sync                            /* wait for dcbf's to get to ram */
       blr
<===========================================================================
=========>

the function accepts 2 parameters: start address and stop address. i tried
calling it
as flush_dcache_range(MY_ADDRESS, MY_ADDRESS + 8) - to flush the 64 bit i
need.
this did not work, and obviously, i'm doing something really wrong here.
any clues ???



>> b) if the fpu is the way to go, what do i need to do so that the kernel
does
>> not trap my floating point access ?
>
>You can't trap and emulate, that defeats the purpose.  The biggest
challenge
>when using floating point in the kernel is context switching the FPU.
>I would probably force the kernel to always context switch the FPU (as
>it does on SMP) so you would always have a clean context to use in
>the kernel.  I would then disable interrupts (to avoid other FPU context
>problems), enable the FPU, perform the access, ensure the context is
>reloaded for the switched-in thread, disable the FPU, enable interrupts.

the FPU solution does work, however (and thanks for the pointers) - but if
my
function saves the fpu registers and restores them, do i really need to
force
the kernel to context switch the fpu ?


		thanks for your help.
			shie erlich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
