Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E81E62C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 08:41:13 +1000 (EST)
Date: Tue, 2 Jul 2013 17:41:05 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20130702034514.GB26391@pek-khao-d1.corp.ad.wrs.com> (from
 haokexin@gmail.com on Mon Jul  1 22:45:14 2013)
Message-ID: <1372804865.8183.125@snotra>
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

On 07/01/2013 10:45:14 PM, Kevin Hao wrote:
> On Mon, Jul 01, 2013 at 08:00:06PM -0500, Scott Wood wrote:
> > On 06/30/2013 02:35:21 AM, Kevin Hao wrote:
> > >On Thu, Jun 27, 2013 at 09:19:06PM -0500, Scott Wood wrote:
> > >> On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> > >> >diff --git a/arch/powerpc/include/asm/mmu-book3e.h
> > >> >b/arch/powerpc/include/asm/mmu-book3e.h
> > >> >index 936db36..bf422db 100644
> > >> >--- a/arch/powerpc/include/asm/mmu-book3e.h
> > >> >+++ b/arch/powerpc/include/asm/mmu-book3e.h
> > >> >@@ -214,6 +214,11 @@
> > >> > #define TLBILX_T_CLASS2			6
> > >> > #define TLBILX_T_CLASS3			7
> > >> >
> > >> >+#ifdef CONFIG_PPC32
> > >> >+/* The max size that one tlb can map in a 32bit kernel. */
> > >> >+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> > >> >+#endif
> > >>
> > >> That comment is not true for all chips.
> > >
> > >This is not for the hardware limitation.
> >
> > It's not for a general software limitation, either.  We can use 1G
> > mappings for user hugetlb (if the default mmap address is moved out
> > of the way) or for the kernel lowmem mapping (if the address is
> > moved to 0x80000000 instead of 0xc0000000).
> >
> > It's also possible (although unlikely at this point) that someone
> > could make a 32-bit booke chip that cannot handle 256M mappings.
>=20
> Then I have to agree with you. :-)
> Wish I can find a way to drop it.

At least give it a comment that describes how it's actually used.

> > Assuming memstart_addr isn't affected by the crashkernel reservation
> > (if it is, could you point out where?),
>=20
> No. The memstart_addr does be affected. For example, for a boot kernel
> with the command line with "crashkernel=3D32M@64M", the device tree =20
> passed
> the kdump kernel will have a memory node like this:
>     memory {
>             reg =3D <0x0 0x4000000 0x0 0x2000000>;
>             device_type =3D "memory";
>     }
>=20
> Then the memstart_addr will be set to 0x4000000 in the kdump kernel.

OK, so then how does the crash kernel know which regions to dump?  Is =20
that indicated somewhere else in the device tree?

-Scott=
