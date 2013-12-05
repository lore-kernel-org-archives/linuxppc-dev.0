Return-Path: <Bharat.Bhushan@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 463712C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 22:15:02 +1100 (EST)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: Andrea Arcangeli <aarcange@redhat.com>, Alexander Graf <agraf@suse.de>
Subject: RE: Error in frreing hugepages with preemption enabled
Date: Thu, 5 Dec 2013 11:14:54 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0724F0F4@039-SN2MPN1-012.039d.mgd.msft.net>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D07238568@039-SN2MPN1-012.039d.mgd.msft.net>
 <EDB02D3B-6B03-4CCB-95C8-FDF2F2932E1D@suse.de>
 <20131203222121.GB18764@redhat.com>
In-Reply-To: <20131203222121.GB18764@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Andrea Arcangeli [mailto:aarcange@redhat.com]
> Sent: Wednesday, December 04, 2013 3:51 AM
> To: Alexander Graf
> Cc: Bhushan Bharat-R65777; linuxppc-dev@lists.ozlabs.org; kvm-
> ppc@vger.kernel.org; kvm@vger.kernel.org; Wood Scott-B07421; Ben Herrensc=
hmidt
> Subject: Re: Error in frreing hugepages with preemption enabled
>=20
> Hi everyone,
>=20
> On Fri, Nov 29, 2013 at 12:13:03PM +0100, Alexander Graf wrote:
> >
> > On 29.11.2013, at 05:38, Bharat Bhushan <Bharat.Bhushan@freescale.com> =
wrote:
> >
> > > Hi Alex,
> > >
> > > I am running KVM guest with host kernel having CONFIG_PREEMPT enabled=
. With
> allocated pages things seems to work fine but I uses hugepages for guest =
I see
> below prints when "quit" from qemu.
> > >
> > > (qemu) QEMU waiting for connection on: telnet:0.0.0.0:4444,server
> > > qemu-system-ppc64: pci_add_option_rom: failed to find romfile "efi-
> virtio.rom"
> > > q
> > > debug_smp_processor_id: 15 callbacks suppressed
> > > BUG: using smp_processor_id() in preemptible [00000000] code:
> > > qemu-system-ppc/2504 caller is .free_hugepd_range+0xb0/0x21c
> > > CPU: 1 PID: 2504 Comm: qemu-system-ppc Not tainted
> > > 3.12.0-rc3-07733-gabf4907 #175 Call Trace:
> > > [c0000000fb433400] [c000000000007d38] .show_stack+0x7c/0x1cc
> > > (unreliable) [c0000000fb4334d0] [c0000000005e8ce0]
> > > .dump_stack+0x9c/0xf4 [c0000000fb433560] [c0000000002de5ec]
> > > .debug_smp_processor_id+0x108/0x11c
> > > [c0000000fb4335f0] [c000000000025e10] .free_hugepd_range+0xb0/0x21c
> > > [c0000000fb433680] [c0000000000265bc]
> > > .hugetlb_free_pgd_range+0x2c8/0x3b0
> > > [c0000000fb4337a0] [c0000000000e428c] .free_pgtables+0x14c/0x158
> > > [c0000000fb433840] [c0000000000ef320] .exit_mmap+0xec/0x194
> > > [c0000000fb433960] [c00000000004d780] .mmput+0x64/0x124
> > > [c0000000fb4339e0] [c000000000051f40] .do_exit+0x29c/0x9c8
> > > [c0000000fb433ae0] [c0000000000527c8] .do_group_exit+0x50/0xc4
> > > [c0000000fb433b70] [c0000000000606a0]
> > > .get_signal_to_deliver+0x21c/0x5d8
> > > [c0000000fb433c70] [c000000000009b08] .do_signal+0x54/0x278
> > > [c0000000fb433db0] [c000000000009e50] .do_notify_resume+0x64/0x78
> > > [c0000000fb433e30] [c000000000000b44]
> > > .ret_from_except_lite+0x70/0x74
> > >
> > >
> > > This mean that free_hugepd_range() must be called with preemption ena=
bled.
> >
> > with preemption disabled.
> >
> > > I tried below change and this seems to work fine (I am not having
> > > expertise in this area so not sure this is correct way)
> >
> > Not sure - the scope looks odd to me. Let's ask Andrea - I'm sure he kn=
ows
> what to do :).
>=20
> :) So I had a look at the top of this function (0xb0) in the upstream ker=
nel and
> no smp_processor_id() call is apparent, is this stock git or a ppc tree? =
The
> first few calls seem not to call it but I may have overlooked something. =
It's
> just quicker if somebody with vmlinux finds the location of it.
>=20
> static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int
> pdshift,
> 			      unsigned long start, unsigned long end,
> 			      unsigned long floor, unsigned long ceiling) {
> 	pte_t *hugepte =3D hugepd_page(*hpdp);
> 	int i;
>=20
> 	unsigned long pdmask =3D ~((1UL << pdshift) - 1);
> 	unsigned int num_hugepd =3D 1;
>=20
> #ifdef CONFIG_PPC_FSL_BOOK3E
> 	/* Note: On fsl the hpdp may be the first of several */
> 	num_hugepd =3D (1 << (hugepd_shift(*hpdp) - pdshift)); #else
> 	unsigned int shift =3D hugepd_shift(*hpdp); #endif
>=20
> 	start &=3D pdmask;
> 	if (start < floor)
> 		return;
> 	if (ceiling) {
> 		ceiling &=3D pdmask;
> 		if (! ceiling)
> 			return;
> 	}
> 	if (end - 1 > ceiling - 1)
> 		return;
>=20
> 	for (i =3D 0; i < num_hugepd; i++, hpdp++)
> 		hpdp->pd =3D 0;
>=20
> 	tlb->need_flush =3D 1;
>=20
> #ifdef CONFIG_PPC_FSL_BOOK3E
> 	hugepd_free(tlb, hugepte);
> #else
> 	pgtable_free_tlb(tlb, hugepte, pdshift - shift); #endif }
>=20
> Generally smp_processor_id should never be used, exactly to avoid problem=
s like
> above with preempion enabled in .config.
>=20
> Instead it should be replaced with a get_cpu()/put_cpu() pair that is exa=
ctly
> meant to fix bugs like this and define proper critical sections around th=
e per-
> cpu variables.
>=20
> #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
> #define put_cpu()		preempt_enable()
>=20
> After you find where that smp_processor_id() is located, you should simpl=
y
> replace it with a get_cpu() and then you should insert a put_cpu immediat=
ely
> after the "cpu" info is not used anymore. That will define a proper and s=
trict
> critical section around the use of the per-cpu variables.
>=20
> With a ppc vmlinux it should be immediate to find the location of
> smp_processor_id but I don't have the ppc vmlinux here.

Thanks Andrea for the details description. It is really helpful

I will look into this.

Thanks
-Bharat

>=20
> Thanks!
> Andrea
>=20
> >
> >
> > Alex
> >
> > >
> > > diff --git a/arch/powerpc/mm/hugetlbpage.c
> > > b/arch/powerpc/mm/hugetlbpage.c index d67db4b..6bf8459 100644
> > > --- a/arch/powerpc/mm/hugetlbpage.c
> > > +++ b/arch/powerpc/mm/hugetlbpage.c
> > > @@ -563,8 +563,10 @@ static void hugetlb_free_pmd_range(struct mmu_ga=
ther
> *tlb, pud_t *pud,
> > >                 */
> > >                next =3D addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
> > > #endif
> > > +               preempt_disable();
> > >                free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
> > >                                  addr, next, floor, ceiling);
> > > +               preempt_enable();
> > >        } while (addr =3D next, addr !=3D end);
> > >
> > >        start &=3D PUD_MASK;
> > >
> > >
> > > Thanks
> > > -Bharat
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe kvm-ppc"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> >
