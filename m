Message-ID: <1DF71FB881F4D311A6B700C04FA06A1AC437B4@orca.desanasystems.com>
From: "Marti, Felix" <fmarti@desanasystems.com>
To: "'Troy Benjegerdes'" <hozer@drgw.net>,
	Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: using the little endian bit 4xx mmu
Date: Thu, 23 Aug 2001 11:28:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I hacked it in a few hours:
in arch/ppc/kernel/head_4xx.S

in the DTLBMissHandler
START_EXCEPTION(0x1100, DTLBMiss)

check if we want to set the bit (_PAGE_ENDIAN is defined to be 0x800)

<nl>        andi.   r22, r21, _PAGE_ENDIAN  /* Perfom endian swap on this
page */
<nl>        bne     endian_tlb_load
OAOA
/*
<nl> * mapping with endian (e) storage attribute set, see ch. 3.5.3
<nl> * in the PPC405GP User's Manual.
<nl> * (this is kind of temporary, until the SCF does the swapping
<nl> * for us) --fmarti
<nl> */
endian_tlb_load:
<nl>        li      r22, 0x0c00
<nl>        andc    r21, r21, r22           /* Make sure 20, 21 are zero */
<nl>        ori     r21, r21, 0x02e0        /* TLB LO ready to go */
<nl>
<nl>        tlbsx.  r23, 0, r20
<nl>        beq     match_exists
<nl>
<nl>        /* load the next available TLB index.
<nl>         */
<nl>        lis     r22, tlb_4xx_index@h
<nl>        ori     r22, r22, tlb_4xx_index@l
<nl>        tophys(r22, r22)
<nl>        lwz     r23, 0(r22)
<nl>        addi    r23, r23, 1
<nl>        andi.   r23, r23, (PPC4XX_TLB_SIZE-1)
<nl>        stw     r23, 0(r22)
<nl>
match_exists:
<nl>        tlbwe   r21, r23, TLB_DATA              /* Load TLB LO */
<nl>
<nl>        /* Create EPN.  This is the faulting address plus a static
<nl>         * set of bits.  These are size, valid, E, U0, and ensure
<nl>         * bits 20 and 21 are zero.
<nl>         */
<nl>        li      r22, 0x00e0                     /* Set Size=4kB, V=1,
E=1 */
<nl>        rlwimi  r20, r22, 0, 20, 31
<nl>        tlbwe   r20, r23, TLB_TAG               /* Load TLB HI */
<nl>
<nl>        /* Done...restore registers and get out of here.
<nl>         */
<nl>        mfspr   r22, SPRG6
<nl>        mfspr   r21, SPRG7
<nl>        mtspr   SPRN_PID, r22
<nl>        mtcr    r21
<nl>        mfspr   r23, SPRG5
<nl>        mfspr   r22, SPRG4
<nl>        mfspr   r21, SPRG1
<nl>        mfspr   r20, SPRG0
<nl>        rfi

it could be done nicer (less code), but I needed it fast and it is only a
temporary solution for me.


-----Original Message-----
From: Troy Benjegerdes [mailto:hozer@drgw.net]
Sent: Thursday, August 23, 2001 10:53 AM
To: Ralph Blach
Cc: Linix PPC Emmbedded
Subject: Re: using the little endian bit 4xx mmu



On Thu, Aug 23, 2001 at 01:39:15PM -0400, Ralph Blach wrote:
>
> Is there any hope of getting an ioremap little endian in the 4xx code
> so the tlb would use little endian bit in the tlb?

Do you have an implementation or a patch that does this?

I think we'd be happy to look at it if someone comes up with a nice, clean
implementation.

Most of the developers seem too busy with other problems to work on
something that might take a lot of work, but only works on a small subset
of PPC chips.

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Shulz


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
