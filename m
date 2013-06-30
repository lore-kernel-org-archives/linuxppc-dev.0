Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22e.google.com (mail-pd0-x22e.google.com
 [IPv6:2607:f8b0:400e:c02::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 965482C0077
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 17:35:35 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id 10so1869619pdc.33
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 00:35:32 -0700 (PDT)
Date: Sun, 30 Jun 2013 15:35:21 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Message-ID: <20130630073521.GC32268@pek-khao-d1.corp.ad.wrs.com>
References: <1372298434-20220-3-git-send-email-haokexin@gmail.com>
 <1372385946.8183.64@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
In-Reply-To: <1372385946.8183.64@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 09:19:06PM -0500, Scott Wood wrote:
> On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> >diff --git a/arch/powerpc/include/asm/mmu-book3e.h
> >b/arch/powerpc/include/asm/mmu-book3e.h
> >index 936db36..bf422db 100644
> >--- a/arch/powerpc/include/asm/mmu-book3e.h
> >+++ b/arch/powerpc/include/asm/mmu-book3e.h
> >@@ -214,6 +214,11 @@
> > #define TLBILX_T_CLASS2			6
> > #define TLBILX_T_CLASS3			7
> >
> >+#ifdef CONFIG_PPC32
> >+/* The max size that one tlb can map in a 32bit kernel. */
> >+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> >+#endif
>=20
> That comment is not true for all chips.

This is not for the hardware limitation.

>=20
> >@@ -177,11 +178,34 @@ unsigned long map_mem_in_cams(unsigned long
> >ram, int max_cam_idx)
> > 	unsigned long virt =3D PAGE_OFFSET;
> > 	phys_addr_t phys =3D memstart_addr;
> > 	unsigned long amount_mapped =3D 0;
> >-
> >+	unsigned long cam_sz;
> >+
> >+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC32)
> >+	/*
> >+	 * For a relocatable kernel, we would not map from
> >memstart_addr.
> >+	 * We first align to PPC_PIN_SIZE (256M), then map the
> >PAGE_OFFSET
> >+	 * from there.
> >+	 */
> >+	phys &=3D ~(PPC_PIN_SIZE - 1);
> >+	ram +=3D memstart_addr & (PPC_PIN_SIZE - 1);
>=20
> You should not map anything before memstart_addr.  If memstart_addr
> isn't 256M-aligned, you'll have to either use smaller pages or
> consider that region to be "high"mem (assuming Linux supports
> highmem existing below lowmem -- I'm skeptical).

OK, I will try to find a another way to resolve this issue.

>=20
> >+	/*
> >+	 * For a kdump kernel, we may use a memory area reserved by the
> >boot
> >+	 * kernel by using a kernel option like this
> >'crashkernel=3D32M@64M'.
> >+	 * In this case, the ram is 96M. The kernel will try to map the
> >first
> >+	 * 64M in the first tlb entry. The kernel will definitely get
> >stuck,
> >+	 * since the kernel is running above the 64M. So we have to make
> >sure
> >+	 * that the first tlb cover the current kernel running address
> >at least.
> >+	 */
>=20
> Maybe we should be running from AS1 when we set this up, to avoid
> problems replacing an entry while it's in use?

I thought about this. The reason that I don't use this method is
we also have to do another relocation if we just want to map
the reserved memory for the kernel.

>=20
> Pardon my ignorance about how kdump/kexec works, but I'm a bit
> confused by exactly what the situation is with crashkernel.  How do
> we know that we are the crash kernel, and that we should limit our
> RAM usage to that area?

The kexec tool will parse the command line of the boot kernel and get
the reserved memory info (such as start address, size) and then pass
these informations to the kdump kernel via device tree.

>  I'm wondering if this code is assuming that
> the crashkernel area is from where the kernel starts to the end of
> RAM.

No. We get these information from device tree.

>=20
> >+	while (1) {
> >+		cam_sz =3D calc_cam_sz(ram, virt, phys);
> >+		if (cam_sz + phys > PHYSICAL_START + _end - _stext)
> >+			break;
> >+		ram =3D 1 << (ilog2(ram) + 1);
> >+	}
>=20
> The ram that was passed in is as much as you have.  Don't map more.
>=20
> What happens if (e.g.) memstart_addr is 512M, with a size of 512M,
> and the kernel starts at 768M?  Increasing the size will never get
> you a mapping that covers kernstart, because calc_cam_sz will never
> return more than 256M.

Yes, the current code still can't handle this case. We always assume
that the kernel is in the memory region which can be covered by the
first tlb entry.

>=20
> When does memory below the rounded-down kernel start get mapped?

This only get mapped via __ioremap when we need to read from it such as
creating the vmcore image.

Thanks,
Kevin

>=20
> -Scott

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRz9+5AAoJEJNY7TDerrFxwI0IAKrCNeTuM9Fnz0Z5zxYqgHvJ
MFk3U6wQSo3/L4jkz+641uR9gb254Pk0FRdzA5wfgwWVpenfna4JjZa2Wjy1wAsD
W9x2JO7S47O1ImfGVdokoGS3rjH9Z40OFMeLsiQ8+rWUkiXIrtCqdhZNT547HidD
zuNI66ML9TfHiXpfksacDvd1n6DXX+vKtK3snw8FAQoAW6xI65lFg96KL1CDCA3u
B7sQsOzyw2LX5HILxVL2j0U/cUn4yprUWrAy0AfQ0SzDrp6xO5fjMHLNyZYu/+iz
Jq5yG6DRSJ7zmZZ7hVdpVcqKiVd4OKqJpeQ1RAfVbmKtesdcjWMyLa5K73FE8lk=
=Dnt2
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
