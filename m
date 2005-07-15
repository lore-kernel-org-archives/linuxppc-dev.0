Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFDE267C64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jul 2005 03:42:59 +1000 (EST)
Received: from [127.0.0.1] (helo=dmt.cnet)
	by parcelfarce.linux.theplanet.co.uk with esmtp (Exim 4.43)
	id 1Duw8Z-0003ba-I7
	for linuxppc-embedded@ozlabs.org; Tue, 19 Jul 2005 18:44:53 +0100
Date: Fri, 15 Jul 2005 02:03:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>
Message-ID: <20050715050312.GA6585@dmt.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<faba7798050714012370af5e74@mail.gmail.com>
	<20050714202715.GS19321@oops.ghostprotocols.net>
	<20050714111941.GC5179@dmt.cnet>
	<faba779805071502425552aefc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <faba779805071502425552aefc@mail.gmail.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ptrace on linux 2.6.12 causes oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Anton,

On Fri, Jul 15, 2005 at 11:42:27AM +0200, Anton W=F6llert wrote:
> >=20
> > Yep, just that now its the ptraceing process which is faulting in the=
=20
> > page,
> > instead of the (ptraced) process itself.
> >=20
> > So Anton, can you move the _tlbie() call up to
> >=20
> > && !test_bit(PG_arch_1, &page->flags)) {
> > <---------- HERE
> > if (vma->vm_mm =3D=3D current->active_mm)
> > __flush_dcache_icache((void *) address);
> > else
> > flush_dcache_icache_page(page);
> > set_bit(PG_arch_1, &page->flags);
> >=20
> > So that it covers both cases instead of just (vma->vm_mm =3D=3D=20
> > current->active_mm) ?
> >=20
> > Its safe to do it because the address space ID is ignored by tlbie=20
> > accordingly
> > to the manual page:
> >=20
> > The ASID value in the entry is ignored for the purpose of
> > matching an invalidate address, thus multiple entries can be invalida=
ted
> > if they have the same effective address and different ASID values.
>=20
>=20
>=20
> Well, unfortunately, that doesn't work :(.=20

Oh doh, on the case where the process faulting in the page is not the own=
er of the
vma (which is the case with ptrace here), the flushing is done via the ph=
ysical address.

So its expected that the _tlbie() on the process virtual address will not=
 change=20
a thing, since flush_dcache_icache_page() is working on the physical addr=
ess.

> If i'm right, the=20
> __flush_dcache_icache((void *) address) should avoid that the cache say=
s=20
> faulting address again.
> The flush_dcache_icache_page(page) should flush the cache, where stands=
,=20
> page not mapped. but the flush_dcache_icache_page(page) oopses on my sy=
stem.=20
> but instead of this call, the call __flush_dcache_icache(page_address(p=
age))=20
> works. for me, that also makes more sence.=20

Well, you end up flushing the page through its kernel virtual address map=
ping (returned
by page_address()).=20

It will be necessary for the kernel virtual map to be faulted in the TLB,=
 which is=20
certainly slower than doing the direct physical address flush (requires u=
pdating=20
the MSR twice (+isync) to turn the MMU on/off).

But other than that I see no problem with your suggestion really, as to w=
orkaround the=20
oops.

Still, we should try to understand what is going on...

> and also, the flush_dcache_icache_page(page) calls the flush_dcache_ica=
che_phys, which=20
> turns off the data virtual address mapping. i found that a bit strange.=
 any=20
> comments?=20

It seems that the instruction at "__flush_dcache_icache_phys+0x38" is icb=
i - can you send=20
the disassembly of __flush_dcache_icache_phys? =20

We should figure out what is causing the oops.=20

What is causing DAR to be set to "00000010"? ie why the hell is it trying=
 to access=20
the 00000010 address.

Oops: kernel access of bad area, sig: 11 [#2]
NIP: C000543C LR: C000B060 SP: C0F35DF0 REGS: c0f35d40 TRAP: 0300 Not tai=
nted
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
DAR: 00000010, DSISR: C2000000
TASK =3D c0ea8430[761] 'gdbserver' THREAD: c0f34000
Last syscall: 26
GPR00: 00009022 C0F35DF0 C0EA8430 00F59000 00000100 FFFFFFFF 00F58000
00000001
GPR08: C021DAEF C0270000 00009032 C0270000 22044024 10025428 01000800
00000001
GPR16: 007FFF3F 00000001 00000000 7FBC6AC0 00F61022 00000001 C0839300
C01E0000
GPR24: 00CD0889 C082F568 3000AC18 C02A7A00 C0EA15C8 00F588A9 C02ACB00
C02ACB00
NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
LR [c000b060] flush_dcache_icache_page+0x20/0x30
