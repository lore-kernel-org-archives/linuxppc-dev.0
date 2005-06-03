Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-sd.sony.com (mail8.fw-sd.sony.com [160.33.66.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5945679F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 02:30:43 +1000 (EST)
Message-ID: <42A085AD.3070005@am.sony.com>
Date: Fri, 03 Jun 2005 09:30:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <429F8F86.1040308@am.sony.com>
	<134a0b6339320a60ba2a868931a3aed4@freescale.com>
In-Reply-To: <134a0b6339320a60ba2a868931a3aed4@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Fix PPC440 pagetable attributes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jun 2, 2005, at 6:00 PM, Geoff Levand wrote:
> 
> 
>>This patch fixes a bug in the PPC440 pagetable attributes that breaks
>>swap support.  It also adds some notes on the PPC440 attribute fields.
>>
>>  *
>>  * Note that these bits preclude future use of a page size
>>  * less than 4KB.
>>+ *
>>+ *
>>+ * PPC 440 core has following TLB attribute fields;
>>+ *
>>+ *   TLB1:
>>+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 
>>31
>>+ *   RPN.................................  -  -  -  -  -  - 
>>ERPN.......
>>+ *
>>+ *   TLB2:
>>+ *   0  1  2  3  4  ... 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 
>>31
>>+ *   -  -  -  -  -    - U0 U1 U2 U3 W  I  M  G  E   - UX UW UR SX SW 
>>SR
>>+ *
>>+ * There are some constrains and options, to decide mapping software 
>>bits
>>+ * into TLB entry.
>>+ *
>>+ *   - PRESENT *must* be in the bottom three bits because swap cache
>>+ *     entries use the top 29 bits for TLB2.
>>+ *
>>+ *   - FILE *must* be in the bottom three bits because swap cache
>>+ *     entries use the top 29 bits for TLB2.
>>+ *
>>+ *   - CACHE COHERENT bit (M) has no effect on PPC440 core, because it
>>+ *     doesn't support SMP. So we can use this as software bit, like
>>+ *     DIRTY.
>>+ *
>>+ * PPC Book-E Linux implementation uses PPC HW PTE bit field 
>>definition,
>>+ * even it doesn't have HW PTE. 0-11th LSB of PTE stand for memory
>>+ * protection-related function. (See PTE structure in 
>>include/asm-ppc/mmu.h)
>>+ * Definition of _PAGE_XXX in "include/asm-ppc/pagetable.h" stands for
>>+ * above bits. Note that those bits values are CPU dependent, not
>>+ * architecture.
>>+ *
> 
> I disagree with this comment.  PPC Book-E PTE format has nothing to do 
> with PPC HW PTE format.
> 

OK, is this more agreeable?

* With the PPC Book-E Linux implementation, 0-11th LSB of PTE stand for memory 
* protection-related function. (See PTE structure in include/asm-ppc/mmu.h) 
* Definition of _PAGE_XXX here stands for above bits. Note that those bits 
* values are CPU dependent, not architecture.

If not, could you be more specific.

-Geoff
