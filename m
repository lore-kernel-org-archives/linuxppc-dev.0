Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01A5467D5D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jul 2005 04:59:17 +1000 (EST)
Date: Sat, 23 Jul 2005 09:21:26 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>
Message-ID: <20050723122125.GA5846@dmt.cnet>
References: <20050720062859.GA8477@dmt.cnet> <42DEDF9D.3080400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <42DEDF9D.3080400@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: avoid icbi misbehaviour in
	__flush_dcache_icache_phys
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

On Thu, Jul 21, 2005 at 01:34:53AM +0200, Anton W=F6llert wrote:
> Marcelo Tosatti wrote:
> >Can you please test the following which is equivalent to your=20
> >suggest changes, the only difference being the location, contained=20
> >inside flush_dcache_icache_page(). After confirmation that it works
> >we can send up to the kernel maintainers.
>=20
> of course, i can do that :).
>=20
> >We should still try to understand why this is happening, possibly=20
> >matching it to a published CPU errata bug, or inform Freescale
> >otherwise.
>=20
> i think so too. as far as i understand it, the thing with the previous=20
> __flush_dcache_icache&tlbie patch was that __flush_dcache_icache should=
=20
> try to call dcbst on every address on a cache-line-boundary that could=20
> reference the page to give the cpu a hint, so that the next write-acces=
s=20
> to this page will be more effective, right? but while trying to do the=20
> dcbst, the TLB is looked up for the addresses for a faster translation.=
=20
> but here the old TLB-Entry exists, that says invalid Page or something=20
> like that, right? So it should be invalidated before, right?

Actually the dcbst instruction flushes data from cache to main memory.
Quoting MPC860UM.pdf:

Data Cache Block Store (dcbst)

The effective address is computed, translated, and checked for protection
violations as defined in the PowerPC architecture. This instruction is=20
treated as a load with respect to address translation and memory protecti=
on.
If the address hits in the cache and the cache block is in the
unmodified-valid state, no action is taken. If the address hits in the ca=
che
and the cache block is in the modified-valid state, the modified block is=
=20
written back to memory and the cache block is placed in the unmodified-va=
lid
state.

> 	Question, normally the dcbst should cause a TLB-Error-Exception,=20
> 	that than should do reload the TLB-Entry automatically, doesn't this w=
ork=20
> because of the dcb*-errata (btw. where can i found that?).=20

I dont think that this one bug which the TLB invalidate worksaround, name=
ly=20
dcbst misbehaviour with invalid (zeroed) TLB, is covered by Freescale
errata (I'm looking at Errata revision A.2).

> And the __flush_dcache_icache should do a dcbst 4096/16=3D256 times, bu=
t there are=20
> just 64 cache-lines =E0 16Byte (1Kb DCache), so shouldn't be 3/4 of tha=
t=20
> routine redundant? and also, as it seems to me, the whole dcache will b=
e=20
> *flushed* or better dcbst'd trough this routine. is that right?
> please correct me!

See the dcbst description above, the cache line entry is only flushed if
the address hits in cache _and_ is the modified state.

> so, now the __flush_dcache_icache_phys(). this is just called, when the=
=20
> memory-mapping of the vma is not same as the one of that from the=20
> current process. this should be the case with ptrace. couldn't now be=20
> done the same as above? maybe no because the address is the virtual=20
> address as seen from the ptraced process? and so that will *flush* the=20
> pages from the ptraced process (that doesn't exists yet?, because they=20
> were just created for the tracing process?).=20

Since the 8xx cache is physically indexed and tagged, you can flush memor=
y
by either its virtual address or its physical address - virtual accesses=20
need to perform v->p translation with help from the MMU.

On the ptrace case the kernel must do a physical flush because the ptrace=
ing=20
process does not have an equivalent virtual->physical mapping in its own=20
address space. ie. equivalent virtual addresses from the ptracing and=20
ptrace'd processes are obviously not physically equivalent.=20

The change you proposed flushes the page via its kernel virtual map:=20
page_address(page), which is similar to doing a physical flush. Only=20
difference being that on 8xx "icbi" goes nuts when using the physical=20
flush, as you reported.

> so the pte, that was created for the tracing process is used. from that=
,=20
> the physical address is calculated (how is this done, whats the magic=20
> about the pfn-stuff etc, i didn't really understand that :( ).

Actually the page being faulted in by the ptrace'ing process is a page
of the _ptraced_ process, that is, one process is faulting in pages=20
of another process.

> now  __flush_dcache_icache_phys is used, because the [d|i]cache uses ph=
ysical=20
> address tags and so the data-mmu could be turned off to flush these ent=
ries.
> so to understand the things further, i have to understand which=20
> addresses are used with dcbst and icbi. there is=20
> page=3Dpfn_to_page(pte_pfn(pte)) and (page_to_pfn(page) << PAGE_SHIFT).=
=20
> but what are these values or where do they point. any hints to the=20
> pfn&pte stuff? unfortunately i didn't have much time the last days to=20
> understand this more deeply...=20

PFN =3D Page Frame Number. This value is the page identifier by page size=
 units.=20

page_to_pfn(page) << PAGE_SHIFT means:

Get the pfn of the page and multiply it by page size ("<< PAGE_SHIFT").=20

Returns address of page in bytes, not in page units.

> >On 8xx, in the case where a pagefault happens for a process who's not
> >the owner of the vma in question (ptrace for instance), the flush=20
> >operation is performed via the physical address.
> >
> >Unfortunately, that results in a strange, unexplainable "icbi"=20
> >instruction fault, most likely due to a CPU bug (see oops below).
>=20
> where do you know, that "icbi" is the bad?

What instruction resides at __flush_dcache_icache_phys+0x38 ?=20

>From what I could see that is "icbi".
