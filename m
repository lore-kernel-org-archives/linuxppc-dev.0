Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ECDA52C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 11:00:21 +1000 (EST)
Date: Mon, 1 Jul 2013 20:00:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130630073521.GC32268@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Sun Jun 30 02:35:21 2013)
Message-ID: <1372726806.8183.105@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2013 02:35:21 AM, Kevin Hao wrote:
> On Thu, Jun 27, 2013 at 09:19:06PM -0500, Scott Wood wrote:
> > On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> > >diff --git a/arch/powerpc/include/asm/mmu-book3e.h
> > >b/arch/powerpc/include/asm/mmu-book3e.h
> > >index 936db36..bf422db 100644
> > >--- a/arch/powerpc/include/asm/mmu-book3e.h
> > >+++ b/arch/powerpc/include/asm/mmu-book3e.h
> > >@@ -214,6 +214,11 @@
> > > #define TLBILX_T_CLASS2			6
> > > #define TLBILX_T_CLASS3			7
> > >
> > >+#ifdef CONFIG_PPC32
> > >+/* The max size that one tlb can map in a 32bit kernel. */
> > >+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> > >+#endif
> >
> > That comment is not true for all chips.
>=20
> This is not for the hardware limitation.

It's not for a general software limitation, either.  We can use 1G =20
mappings for user hugetlb (if the default mmap address is moved out of =20
the way) or for the kernel lowmem mapping (if the address is moved to =20
0x80000000 instead of 0xc0000000).

It's also possible (although unlikely at this point) that someone could =20
make a 32-bit booke chip that cannot handle 256M mappings.

> > Pardon my ignorance about how kdump/kexec works, but I'm a bit
> > confused by exactly what the situation is with crashkernel.  How do
> > we know that we are the crash kernel, and that we should limit our
> > RAM usage to that area?
>=20
> The kexec tool will parse the command line of the boot kernel and get
> the reserved memory info (such as start address, size) and then pass
> these informations to the kdump kernel via device tree.

Does this alter memstart_addr or just mark the region as reserved?

> > >+	while (1) {
> > >+		cam_sz =3D calc_cam_sz(ram, virt, phys);
> > >+		if (cam_sz + phys > PHYSICAL_START + _end - _stext)
> > >+			break;
> > >+		ram =3D 1 << (ilog2(ram) + 1);
> > >+	}
> >
> > The ram that was passed in is as much as you have.  Don't map more.
> >
> > What happens if (e.g.) memstart_addr is 512M, with a size of 512M,
> > and the kernel starts at 768M?  Increasing the size will never get
> > you a mapping that covers kernstart, because calc_cam_sz will never
> > return more than 256M.
>=20
> Yes, the current code still can't handle this case. We always assume
> that the kernel is in the memory region which can be covered by the
> first tlb entry.

Assuming memstart_addr isn't affected by the crashkernel reservation =20
(if it is, could you point out where?), you'd then have a problem with =20
the crashkernel area going anywhere above 256M.

-Scott=
