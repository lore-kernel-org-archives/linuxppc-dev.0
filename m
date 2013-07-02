Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7E4B2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 13:45:26 +1000 (EST)
Received: by mail-pa0-f48.google.com with SMTP id kp12so5744294pab.21
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jul 2013 20:45:24 -0700 (PDT)
Date: Tue, 2 Jul 2013 11:45:14 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Message-ID: <20130702034514.GB26391@pek-khao-d1.corp.ad.wrs.com>
References: <20130630073521.GC32268@pek-khao-d1.corp.ad.wrs.com>
 <1372726806.8183.105@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
In-Reply-To: <1372726806.8183.105@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2013 at 08:00:06PM -0500, Scott Wood wrote:
> On 06/30/2013 02:35:21 AM, Kevin Hao wrote:
> >On Thu, Jun 27, 2013 at 09:19:06PM -0500, Scott Wood wrote:
> >> On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> >> >diff --git a/arch/powerpc/include/asm/mmu-book3e.h
> >> >b/arch/powerpc/include/asm/mmu-book3e.h
> >> >index 936db36..bf422db 100644
> >> >--- a/arch/powerpc/include/asm/mmu-book3e.h
> >> >+++ b/arch/powerpc/include/asm/mmu-book3e.h
> >> >@@ -214,6 +214,11 @@
> >> > #define TLBILX_T_CLASS2			6
> >> > #define TLBILX_T_CLASS3			7
> >> >
> >> >+#ifdef CONFIG_PPC32
> >> >+/* The max size that one tlb can map in a 32bit kernel. */
> >> >+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> >> >+#endif
> >>
> >> That comment is not true for all chips.
> >
> >This is not for the hardware limitation.
>=20
> It's not for a general software limitation, either.  We can use 1G
> mappings for user hugetlb (if the default mmap address is moved out
> of the way) or for the kernel lowmem mapping (if the address is
> moved to 0x80000000 instead of 0xc0000000).
>=20
> It's also possible (although unlikely at this point) that someone
> could make a 32-bit booke chip that cannot handle 256M mappings.

Then I have to agree with you. :-)
Wish I can find a way to drop it.

>=20
> >> Pardon my ignorance about how kdump/kexec works, but I'm a bit
> >> confused by exactly what the situation is with crashkernel.  How do
> >> we know that we are the crash kernel, and that we should limit our
> >> RAM usage to that area?
> >
> >The kexec tool will parse the command line of the boot kernel and get
> >the reserved memory info (such as start address, size) and then pass
> >these informations to the kdump kernel via device tree.
>=20
> Does this alter memstart_addr or just mark the region as reserved?

This will alter memstart_addr since we set memstart_addr based on the
memory node in device tree.

>=20
> >> >+	while (1) {
> >> >+		cam_sz =3D calc_cam_sz(ram, virt, phys);
> >> >+		if (cam_sz + phys > PHYSICAL_START + _end - _stext)
> >> >+			break;
> >> >+		ram =3D 1 << (ilog2(ram) + 1);
> >> >+	}
> >>
> >> The ram that was passed in is as much as you have.  Don't map more.
> >>
> >> What happens if (e.g.) memstart_addr is 512M, with a size of 512M,
> >> and the kernel starts at 768M?  Increasing the size will never get
> >> you a mapping that covers kernstart, because calc_cam_sz will never
> >> return more than 256M.
> >
> >Yes, the current code still can't handle this case. We always assume
> >that the kernel is in the memory region which can be covered by the
> >first tlb entry.
>=20
> Assuming memstart_addr isn't affected by the crashkernel reservation
> (if it is, could you point out where?),

No. The memstart_addr does be affected. For example, for a boot kernel
with the command line with "crashkernel=3D32M@64M", the device tree passed
the kdump kernel will have a memory node like this:
    memory {
            reg =3D <0x0 0x4000000 0x0 0x2000000>;
            device_type =3D "memory";
    }

Then the memstart_addr will be set to 0x4000000 in the kdump kernel.

> you'd then have a problem
> with the crashkernel area going anywhere above 256M.

The kdump kernel can be loaded above 256M memory. It only can not be loaded
above memstart_addr + 256M memory.

Thanks,
Kevin

>=20
> -Scott

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR0kzKAAoJEJNY7TDerrFxPFsIAKU7veAlplkQ3uDd9M2YIHJJ
9xfwt34ECGmpb0poxMeKPpryWte2BiQ6wdYsjoZ5hAV1HzWSsX/ZAfmbY0QZv2EQ
Oh1JOwcquD46CZGEwjw0PTZncEmFiRM0NHDwFLDaQwrvpSfDg0ON5h6SPSqN4/n3
rb6PMsfWFGECy/IiifoXdmuC/pwN7EWZ3BZFpvXWYP6OxOPKs6aGMfPk0Sf7uXdP
JawT00Rx5zz1AJyS7V+QdnyvV5DFdbRoJLWmOKU9AmCmtnX1lk33KiEv+R9gZdzJ
I4hD8qW3OwS4m6imxqxTjD0rSpZuaydHign6j7kK0faxunGAUJLzx4sM8++HodU=
=nns2
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
