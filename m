Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd1Yw6ClBzF17Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 15:00:36 +1100 (AEDT)
In-Reply-To: <20180207012002.4452-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s/radix: kernel boot-time NULL pointer protection using
 a guard-PID
Message-Id: <3zd1Yv1dVGz9t32@ozlabs.org>
Date: Fri,  9 Feb 2018 15:00:34 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-02-07 at 01:20:02 UTC, Nicholas Piggin wrote:
> This change restores and formalises the behaviour that access to NULL or
> other user addresses by the kernel during boot should fault rather than
> succeed and modify memory. This was inadvertently broken when fixing
> another bug, because it was previously not well defined and only worked
> by chance.
> 
> powerpc/64s/radix uses high address bits to select an address space
> "quadrant", which determines which PID and LPID are used to translate
> the rest of the address (effective PID, effective LPID). The kernel
> mapping at 0xC... selects quadrant 3, which uses PID=0 and LPID=0. So
> the kernel page tables are installed in the PID 0 process table entry.
> 
> An address at 0x0... selects quadrant 0, which uses PID=PIDR for
> translating the rest of the address (that is, it uses the value of the
> PIDR register as the effective PID). If PIDR=0, then the translation is
> performed with the PID 0 process table entry page tables. This is the
> kernel mapping, so we effectively get another copy of the kernel address
> space at 0. A NULL pointer access will access physical memory address 0.
> 
> To prevent duplicating the kernel address space in quadrant 0, this
> patch allocates a guard PID containing no translations, and initializes
> PIDR with this during boot, before the MMU is switched on.  Any kernel
> access to quadrant 0 will use this guard PID for translation and find no
> valid mappings, and therefore fault.
> 
> After boot, this PID will be switchd away to user context PIDs, but
> those contain user mappings (and usually NULL pointer protection) rather
> than kernel mapping, which is much safer (and by design). It may be in
> future this is tightened further, which the guard PID could be used for.
> 
> Commit 371b8044 ("powerpc/64s: Initialize ISAv3 MMU registers before
> setting partition table"), introduced this problem because it zeroes
> PIDR at boot. However previously the value was inherited from firmware
> or kexec, which is not robust and can be zero (e.g., mambo).
> 
> Fixes: 371b8044 ("powerpc/64s: Initialize ISAv3 MMU registers before setting partition table")
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Tested-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/eeb715c3e995fbdda0cc05e61216c6

Added:
  Cc: stable@vger.kernel.org # v4.15+

cheers
