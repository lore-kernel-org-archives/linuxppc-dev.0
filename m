Return-Path: <blackfin.kang@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 59805DDE08
	for <linuxppc-embedded@ozlabs.org.>;
	Wed, 11 Jul 2007 20:21:10 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id d26so329438and
	for <linuxppc-embedded@ozlabs.org.>;
	Wed, 11 Jul 2007 03:21:08 -0700 (PDT)
Message-ID: <a7f827420707110321scea22beg9505286e00ba79b2@mail.gmail.com>
Date: Wed, 11 Jul 2007 18:21:08 +0800
From: "kang shuo" <blackfin.kang@gmail.com>
To: galak@kernel.crashing.org
Subject: ask two question about e500 implementation in
	arch/ppc/kernel/head_fsl_booke.S
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,galak:
              I have two question about e500 part of linux kernel. I
can not get reponse from maillist . So I sent the questions to you
directly.

1. in  arch/ppc/kernel/head_fsl_booke.S
 603         FIND_PTE
 604         andi.   r13, r11, _PAGE_PRESENT /* Is the page present? */
 605         beq     2f                      /* Bail if not present */

That seems _PAGE_PRESENT should be set before enter DataTLBError
exception handler(Or the following finish_tlb_load function will not
execute), but  in __ioremap function of e500 implementation,
_PAGE_PRESENT bit is not set for an io address map.Why?

2. still in   arch/ppc/kernel/head_fsl_booke.S
 791 #ifdef CONFIG_E200
 792         /* Round robin TLB1 entries assignment */
 793         mfspr   r12, SPRN_MAS0
 794
 795         /* Extract TLB1CFG(NENTRY) */
 796         mfspr   r11, SPRN_TLB1CFG
 797         andi.   r11, r11, 0xfff
 798
 799         /* Extract MAS0(NV) */
 800         andi.   r13, r12, 0xfff
 801         addi    r13, r13, 1
 802         cmpw    0, r13, r11
 803         addi    r12, r12, 1
 804
 805         /* check if we need to wrap */
 806         blt     7f
 807
 808         /* wrap back to first free tlbcam entry */
 809         lis     r13, tlbcam_index@ha
 810         lwz     r13, tlbcam_index@l(r13)
 811         rlwimi  r12, r13, 0, 20, 31
 812 7:
 813         mtspr   SPRN_MAS0,r12
 814 #endif /* CONFIG_E200 */
 815
 816         tlbwe

That seems original tlb entry will be overwritten in the above code
for e500? Why , I thought a free tlb entry should be select and fill
for e500. Just like CONFIG_E200.


-- Thanks
-- Michael.Kang
