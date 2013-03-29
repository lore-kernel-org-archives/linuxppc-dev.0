Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D90F2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 03:34:10 +1100 (EST)
Date: Fri, 29 Mar 2013 11:33:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <412C8208B4A0464FA894C5F0C278CD5D01C18FD6@039-SN1MPN1-003.039d.mgd.msft.net>
 <1363365292.10440.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C2EBEA@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C2EBEA@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Fri Mar 29 03:03:51 2013)
Message-ID: <1364574839.13310.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 David Laight <David.Laight@ACULAB.COM>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2013 03:03:51 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, March 16, 2013 12:35 AM
> > To: Jia Hongtao-B38951
> > Cc: Wood Scott-B07421; David Laight; linuxppc-dev@lists.ozlabs.org;
> > Stuart Yoder
> > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > On 03/14/2013 09:47:58 PM, Jia Hongtao-B38951 wrote:
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Thursday, March 14, 2013 12:38 AM
> > > > To: David Laight
> > > > Cc: Jia Hongtao-B38951; Wood Scott-B07421;
> > > linuxppc-dev@lists.ozlabs.org;
> > > > Stuart Yoder
> > > > Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler =20
> to
> > > fix
> > > > PCIe erratum on mpc85xx
> > > >
> > > > On 03/13/2013 04:40:40 AM, David Laight wrote:
> > > > > > Hmm, seems there's no probe_user_address() -- for userspace =20
> we
> > > > > > basically want the same thing minus the KERNEL_DS.  See
> > > > > > arch/powerpc/perf/callchain.c for an example.
> > > > >
> > > > > Isn't that just copy_from_user() ?
> > > >
> > > > Plus pagefault_disable/enable().
> > > >
> > > > -Scott
> > >
> > > pagefault_disable() is identical to preempt_disable(). So I think =20
> this
> > > could not avoid other cpu to swap out the instruction we want to =20
> read
> > > back.
> > > probe_kernel_address() also have the same issue.
> >
> > That's not the point -- the point is to let the page fault handler =20
> know
> > that it should go directly to bad_page_fault().  Do not pass
> > handle_mm_fault().  Do not collect a page from disk.
> >
> > Granted, we're already in atomic context which will have that effect
> > due to being in the machine check handler, but it's better to be
> > explicit about it and not depend on how pagefault_diasble() is
> > implemented.
> >
> > -Scott
>=20
>=20
> Based on the comments I updated the machine check handler.
>=20
> Changes from last version:
> * Check MSR_GS state
> * Check if the instruction is LD
> * Handle the user space issue
>=20
> The updated machine check handler is as following:
>=20
> int fsl_pci_mcheck_exception(struct pt_regs *regs)
> {
>         unsigned int op, rd;
>         u32 inst;
>         int ret;
>         phys_addr_t addr =3D 0;
>=20
>         /* Let KVM/QEMU deal with the exception */
>         if (regs->msr & MSR_GS)
>                 return 0;
>=20
> #ifdef CONFIG_PHYS_64BIT
>         addr =3D mfspr(SPRN_MCARU);
>         addr <<=3D 32;
> #endif
>         addr +=3D mfspr(SPRN_MCAR);
>=20
>         if (is_in_pci_mem_space(addr)) {
>                 if (user_mode(regs)) {
>                         pagefault_disable();
>                         ret =3D copy_from_user(&(inst), (u32 __user =20
> *)regs->nip, sizeof(inst));
>                         pagefault_enable();

You could use get_user() instead of copy_from_user().

>                 } else {
>                         ret =3D probe_kernel_address(regs->nip, inst);
>                 }
>=20
>                 op =3D get_op(inst);
>                 /* Check if the instruction is LD */
>                 if (!ret && (op =3D=3D 111010)) {
>                         rd =3D get_rt(inst);
>                         regs->gpr[rd] =3D 0xffffffff;
>                 }
>=20
>                 regs->nip +=3D 4;
>                 return 1;
>         }
>=20
>         return 0;
> }
>=20
> BTW, I'm still not sure how to deal with LD instruction with update.

You would need to do the update yourself.  Or just say that's a case =20
you don't handle, and return 0.

Again, please check for the size of the load operation.

-Scott=
