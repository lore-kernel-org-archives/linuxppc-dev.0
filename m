Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B26CE67A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 11:11:34 +1000 (EST)
In-Reply-To: <20050404191718.GA30281@logos.cnet>
References: <20050404191718.GA30281@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <b383dfd14d6dcc895297851a2424f319@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 4 Apr 2005 20:11:20 -0500
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo,

One thing would be useful to comment why we are doing this so if it=20
ends up being a CPU errata we at least know why we are doing this.

- kumar

On Apr 4, 2005, at 2:17 PM, Marcelo Tosatti wrote:

> (need volunteers to test the patch below on 8xx)
>
> Hi,
>
>  I've been investigating the 8xx update_mmu_cache() oops for the last=20=

> weeks, and
> here is what I have gathered.
>
>  Oops: kernel access of bad area, sig: 11 [#1]
>  NIP: C00049E8 LR: C000A5D0 SP: C4F53E10 REGS: c4f53d60 TRAP: 0300=A0=A0=
=A0=20
> Not taintedMSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
>
> DAR: 100113A0, DSISR: C2000000
>  TASK =3D c53f17e0[1224] 'a' THREAD: c4f52000
>  Last syscall: 47
>  GPR00: C783D2A0 C4F53E10 C53F17E0 10050000 00000100 0009F0A0 10050000=20=

> 00000000
>  GPR08: 00075925 C783D2A0 C53F17E0 00000000 00076924 10077178 00000000=20=

> 100B4338
>  GPR16: 100BBDE8 0ED792CE 7FFFF670 00000000 00000000 00000000 00000000=20=

> C4F41100
>  GPR24: 00000000 C4F3CAD4 C783D2A0 1005078C C4EB9140 C53861D0 04F85889=20=

> C034A0A0
>  NIP [c00049e8] __flush_dcache_icache+0x14/0x40
> LR [c000a5d0] update_mmu_cache+0x64/0x98
> Call trace:
>  =A0[c003fa7c] do_no_page+0x2f8/0x370
> =A0[c003fc44] handle_mm_fault+0x88/0x160
> =A0[c0009b58] do_page_fault+0x168/0x394
> =A0[c0002c28] handle_page_fault+0xc/0x80
>
> What is happening here is that update_mmu_cache() calls=20
> __flush_dcache_icache()
>  to sync the d-cache with memory and invalidate any stale i-cache=20
> entries for
>  the address being faulted in.
>
> Problem is that the "dcbst" instruction will, _sometimes_ (the=20
> failure/success rate is about 1/4
>  with my test application) fault as a _write_ operation on the data.
>
>  The address in question is always at the very beginning of the=20
> read-only data section,
> thus the write fault (as can be verified in DSISR: 0x02000000) is=20
> rejected
> because the vma structure is marked as read-only (vma->flags =3D=20
> ~VM_WRITE).
>
> 8xx machines running v2.6 are operating at the moment with a "tlbie()"=20=

> call at
> update_mmu_cache() just before __flush_dcache_icache(), which=20
> worksaround the problem.
>
>  I've been able to watch the "problematic" TLB entry just before=20
> update_mmu_cache().
> Here it is:
>
> SPR=A0 824 : 0x10011f0b=A0=A0=A0 268508939
>  BDI>rds 825
>  SPR=A0 825 : 0x000001e0=A0=A0=A0=A0=A0=A0=A0=A0=A0 480
>  BDI>rds 826
>  SPR=A0 826 : 0x00001f00=A0=A0=A0=A0=A0=A0=A0=A0 7936
>
> As you can see by bit 18 of the D-TLB debugging register MD_RAM1 (SPR=20=

> 826), this entry
>  is marked as invalid, which will invocate DataTLBError in case of an=20=

> access at this point
>  and handle the fault properly in most cases.
>
>  This is expected, and is how the sequence "DataTLBMiss" (no effective=20=

> address in TLB entry) ->
> "DataTLBError" (existant EA but valid bit not set) works on 8xx.
>
> Kumar Gala suggested inspection of memory which holds=20
> __flush_dcache_icache().
> With the BDI I could verify that the instruction sequence is there,=20
> intact.
>
> I'm unable to determine why a "dcbst" fault is incorrectly being=20
> treated as a WRITE operation.
>
>  That seems to be the real problem. Likely to be Yet Another CPU bug?
>
>  I've came up with a workaround which looks acceptable (unlike the=20
> tlbie one).
>
>  Solution is to jump directly from the data tlb miss exception to=20
> DataAccess, which
>  in turn calls do_page_fault() and friends.
>
> This avoids the dcbst's from being called to sync an address with an=20=

> "invalid" TLB entry.
>
>  Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
>
> --- a/arch/ppc/kernel/head_8xx.S.orig=A0=A0 2005-04-04 =
19:43:23.000000000=20
> -0300
>  +++ b/arch/ppc/kernel/head_8xx.S=A0=A0=A0=A0=A0=A0=A0 2005-04-04 =
19:47:40.000000000=20
> -0300
>  @@ -359,9 +359,7 @@
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 . =3D 0x1200
>  =A0DataStoreTLBMiss:
> -#ifdef CONFIG_8xx_CPU6
> =A0=A0=A0=A0=A0=A0=A0 stw=A0=A0=A0=A0 r3, 8(r0)
>  -#endif
>  =A0=A0=A0=A0=A0=A0=A0 DO_8xx_CPU6(0x3f80, r3)
>  =A0=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 M_TW, r10=A0=A0=A0=A0=A0=A0 /* Save =
a couple of working registers=20
> */
>  =A0=A0=A0=A0=A0=A0=A0 mfcr=A0=A0=A0 r10
> @@ -390,6 +388,16 @@
>  =A0=A0=A0=A0=A0=A0=A0 mfspr=A0=A0 r10, MD_TWC=A0=A0=A0=A0 /* ....and =
get the pte address */
>  =A0=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r10, 0(r10)=A0=A0=A0=A0 /* Get =
the pte */
>  =A0
>  +=A0=A0=A0=A0=A0=A0 li=A0=A0=A0=A0=A0 r3, 0
> +=A0=A0=A0=A0=A0=A0 cmpw=A0=A0=A0 r10, r3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /* does the pte contain a valid=20
> address? */
>  +=A0=A0=A0=A0=A0=A0 bne=A0=A0=A0=A0 4f
> +=A0=A0=A0=A0=A0=A0 mfspr=A0=A0 r10, M_TW=A0=A0=A0=A0=A0=A0 /* Restore =
registers */
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11, 0(r0)
>  +=A0=A0=A0=A0=A0=A0 mtcr=A0=A0=A0 r11
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11, 4(r0)
>  +=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r3, 8(r0)
>  +=A0=A0=A0=A0=A0=A0 b DataAccess
>  +4:
>  =A0=A0=A0=A0=A0=A0=A0 /* Insert the Guarded flag into the TWC from =
the Linux PTE.
>  =A0=A0=A0=A0=A0=A0=A0=A0 * It is bit 27 of both the Linux PTE and the =
TWC (at least
>  =A0=A0=A0=A0=A0=A0=A0=A0 * I got that right :-).=A0 It will be better =
when we can put
>  @@ -419,9 +427,7 @@
>  =A0=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11, 0(r0)
>  =A0=A0=A0=A0=A0=A0=A0 mtcr=A0=A0=A0 r11
> =A0=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r11, 4(r0)
>  -#ifdef CONFIG_8xx_CPU6
> =A0=A0=A0=A0=A0=A0=A0 lwz=A0=A0=A0=A0 r3, 8(r0)
>  -#endif
>  =A0=A0=A0=A0=A0=A0=A0 rfi
>  =A0
>  =A0/* This is an instruction TLB error on the MPC8xx.=A0 This could =
be due
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
