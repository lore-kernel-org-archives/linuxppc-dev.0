MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16617.59368.202493.36547@cargo.ozlabs.ibm.com>
Date: Tue, 6 Jul 2004 09:44:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [more info - please help!] MPC7455 DMA buffer strangeness 
In-Reply-To: <40E97EB5.2040008@fh-landshut.de>
References: <40E97EB5.2040008@fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oliver Korpilla writes:

> I checked my Page Table Entries (PTEs) for the MPC7455 and MPC8240 after the
> remap_page_range() took place.
>
> Except for the RPN part (the physical address of the page) the PTEs match,
> ending with the last 11 Bits (flags as in arch/ppc/mm/pgtable.h):
>
> Kernel space: 0x581
> User   space: 0x72D
>
> (for user space this does mean - from least significant to most significant:
> Page present: 	no,
> Hashed PTE: 	yes,

No, you have _PAGE_PRESENT set and _PAGE_HASHPTE clear there (which
looks correct).

> How are these Linux PTEs mapped to the MMU PTEs (64 bit wide descriptors)?
>
> The "Programming Environments Manual For 32-Bit Implementations of the PowerPC
> Architecture", the MPC603e and MPC7450 reference manuals depict a completely
> different format, so how and where are these converted? (Hopefully not in
> assembler! ;) )

Yes, in assembler. :)  For the 74xx, it's done by create_hpte() in
arch/ppc/mm/hashtables.S, and for the 603 (and the 8240) it's done by
DataLoadTLBMiss or DataStoreTLBMiss in arch/ppc/kernel/head.S.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
