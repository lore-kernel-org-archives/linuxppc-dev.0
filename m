Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2DE5C2C020A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 18:44:05 +1100 (EST)
Received: by mail-pa0-f49.google.com with SMTP id kx10so2282165pab.36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 23:44:02 -0800 (PST)
Date: Fri, 20 Dec 2013 15:43:39 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 3/7] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20131220074339.GA23977@pek-khao-d1.corp.ad.wrs.com>
References: <1375838315-27797-4-git-send-email-haokexin@gmail.com>
 <20131218234825.GA6959@home.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
In-Reply-To: <20131218234825.GA6959@home.buserror.net>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 05:48:25PM -0600, Scott Wood wrote:
> On Wed, Aug 07, 2013 at 09:18:31AM +0800, Kevin Hao wrote:
> > This is based on the codes in the head_44x.S. The difference is that
> > the init tlb size we used is 64M. With this patch we can only load the
> > kernel at address between memstart_addr ~ memstart_addr + 64M. We will
> > fix this restriction in the following patches.
>=20
> Which following patch fixes the restriction?  With all seven patches
> applied, I was still only successful booting within 64M of memstart_addr.

There is bug in this patch series when booting above the 64M. It seems
that I missed to test this previously. Sorry for that. With the following
change I can boot the kernel at 0x5000000.

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mm=
u.c
index 048d716ae706..ce0c7d7db6c3 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -171,11 +171,10 @@ unsigned long calc_cam_sz(unsigned long ram, unsigned=
 long virt,
 	return 1UL << camsize;
 }
=20
-unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
+static unsigned long map_mem_in_cams_addr(phys_addr_t phys, unsigned long =
virt,
+					unsigned long ram, int max_cam_idx)
 {
 	int i;
-	unsigned long virt =3D PAGE_OFFSET;
-	phys_addr_t phys =3D memstart_addr;
 	unsigned long amount_mapped =3D 0;
=20
 	/* Calculate CAM values */
@@ -195,6 +194,14 @@ unsigned long map_mem_in_cams(unsigned long ram, int m=
ax_cam_idx)
 	return amount_mapped;
 }
=20
+unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
+{
+	unsigned long virt =3D PAGE_OFFSET;
+	phys_addr_t phys =3D memstart_addr;
+
+	return map_mem_in_cams_addr(phys, virt, ram, max_cam_idx);
+}
+
 #ifdef CONFIG_PPC32
=20
 #if defined(CONFIG_LOWMEM_CAM_NUM_BOOL) && (CONFIG_LOWMEM_CAM_NUM >=3D NUM=
_TLBCAMS)
@@ -289,7 +296,11 @@ notrace void __init relocate_init(u64 dt_ptr, phys_add=
r_t start)
 		is_second_reloc =3D 1;
 		n =3D switch_to_as1();
 		/* map a 64M area for the second relocation */
-		map_mem_in_cams(0x4000000UL, CONFIG_LOWMEM_CAM_NUM);
+		if (memstart_addr > start)
+			map_mem_in_cams(0x4000000, CONFIG_LOWMEM_CAM_NUM);
+		else
+			map_mem_in_cams_addr(start, PAGE_OFFSET - offset,
+					0x4000000, CONFIG_LOWMEM_CAM_NUM);
 		restore_to_as0(n, offset, __va(dt_ptr));
 		/* We should never reach here */
 		panic("Relocation error");

I will do more test and then create a new spin to merge this change and reb=
ase
on the latest kernel. Thanks for the review.

Kevin
>=20
> -Scott

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJSs/UrAAoJEJNY7TDerrFxTywH/13OhPHSG4PnGzK6+Lfh1YWZ
APf/DkDj8bajQD2pZr4I3LHRqVrYy+nt1e8Gmq/Tdt38kkMIjE/yDtR3aFdfn7ih
cpa1AoRUxtV3OeygzLrtxpzAKQIqlKQUrQDJkUrp7rYKNNgg5QrxenMIomqBZe1u
jtnqgd0ZELKvHizvS3m74zPGSg/4byWrlIE4g8S7yNsuMoZdjLePKhUt7FkXNpaF
R6vr/rDVNEd+5OXRvTFUIjVxPksOa6g4U4TGE468IsHIoDg42dAOwqpfEAkJJltE
a8FHlIOcw8cdY47IDMtLTFTONm7i//F3UkGRhZuvkF6fHg8AZb248ZY9+Be/E90=
=fO8G
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
