Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1754DDF51
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 07:44:57 +1000 (EST)
Subject: Re: PS3 early lock-up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
References: <Pine.LNX.4.64.0808041640220.31424@vixen.sonytel.be>
Content-Type: text/plain
Date: Tue, 05 Aug 2008 07:44:47 +1000
Message-Id: <1217886287.24157.87.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-04 at 17:48 +0200, Geert Uytterhoeven wrote:
> On PS3, recent kernels lock up in the very early stage (i.e. before mere
> mortals get to see a working console). The kernel crashes with
> 
> | kernel BUG at linux/arch/powerpc/platforms/ps3/htab.c:141!
> 
> Bisecting shows this happens since:
> 
> | commit a1f242ff460e4b50a045fa237c3c56cce9eabf83
> | Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> | Date:   Wed Jul 23 21:27:08 2008 -0700
> | 
> |     powerpc ioremap_prot
> |     
> |     This adds ioremap_prot and pte_pgprot() so that one can extract protection
> |     bits from a PTE and use them to ioremap_prot() (in order to support ptrace
> |     of VM_IO | VM_PFNMAP as per Rik's patch).
> |     
> |     This moves a couple of flag checks around in the ioremap implementations
> |     of arch/powerpc.  There's a side effect of allowing non-cacheable and
> |     non-guarded mappings on ppc32 which before would always have _PAGE_GUARDED
> |     set whenever _PAGE_NO_CACHE is.
> |     
> |     (standard ioremap will still set _PAGE_GUARDED, but ioremap_prot will be
> |     capable of setting such a non guarded mapping).
>   
> Inside ps3_hpte_insert(), lv1_write_htab_entry() fails with error code 5
> (LV1_ACCESS_VIOLATION) when adding the PS3 hotplug memory.
> 
> debug_dump_hpte() prints for the offending hpte:
> 
> | pa     = 500001000000h
> | lpar   = 500001000000h
> | va     = adc7d4c2d0000000h
> | group  = 6168h
> | bitmap = 0h
> | hpte.v = adc7d4c2d011h
> | hpte.r = 500001000115h
>                       ^
> | psize  = 0h
> | slot   = 6168h
> 
> After manually reverting the offending commit, the system boots again. The only
> change is:
> 
> | pa     = 500001000000h
> | lpar   = 500001000000h
> | va     = adc7d4c2d0000000h
> | group  = 6168h
> | bitmap = 0h
> | hpte.v = adc7d4c2d011h
> | hpte.r = 500001000117h
>                       ^
> | psize  = 0h
> | slot   = 6168h
> 
> Note that when adding the initial (non-hotplug) memory, hpte.r always ends in
> `194', both before and after reverting the offending commit.
> 
> ps3_hpte_insert() seems to be called during system initialization with the
> following values of rflags:
>   - first call: 0x190
>   - initial memory: 0x194 (455 times)
>   - hotplug memory:
>       o crash: 0x115
>       o OK: 0x117
> 
> Do you have an idea of what's really going on?

Weird... Both look incorrect. In fact, it's a bit scary...

The one with the 7 at the end means that user space as RO access to
the segment (oops !) and supervisor too. The one with the 5 means
RO for user and RW for supervisor.

That is unless your HV is munging them in strange ways... I don't
know why LV1 is refusing a combination though.

As for the flags, it depends what htab_bolt_mapping() is called
with.

Do you have a backtrace ? I'm a bit lots in the mem hotswap code
trying to figure out where the mapping comes from..

Ben.
