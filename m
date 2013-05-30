Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x236.google.com (mail-pb0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1B1EE2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 13:25:36 +1000 (EST)
Received: by mail-pb0-f54.google.com with SMTP id ro12so10183323pbb.41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 20:25:34 -0700 (PDT)
Date: Thu, 30 May 2013 11:25:25 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
Message-ID: <20130530032525.GA18702@pek-khao-d1.corp.ad.wrs.com>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
 <1369781156.18630.24@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <1369781156.18630.24@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 05:45:56PM -0500, Scott Wood wrote:
> On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
> >All these boards use the same configuration file p1_p2_rdb_pc.h in
> >u-boot. So they have the same pci bus address set by the u-boot.
> >But in some of these boards the bus address set in dtb don't match
> >the one used by u-boot. And this will trigger a kernel bug in 32bit
> >kernel and cause the pci device malfunction. For example, on a
> >p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
> >and cpu address for one pci controller and then assign bus address
> >such as 0xa00004000 to some pci device. But in the kernel, the dtb
> >set the bus address to 0xe0000000 and the cpu address to 0xa0000000.
> >The kernel assumes mistakenly the assigned bus address 0xa0004000
> >in pci device is correct and keep it unchanged. This will definitely
> >cause the pci device malfunction. I have made two patches to fix
> >this in the pci subsystem.
> >http://patchwork.ozlabs.org/patch/243702/
> >http://patchwork.ozlabs.org/patch/243703/
> >
> >But I still think it makes sense to set these bus address to match
> >with the u-boot. This issue can't be reproduced on 36bit kernel.
> >But I also tweak the 36bit dtb for the above reason.
>=20
> IIRC the reason for using 0xe0000000 on all PCIe roots is to
> maximize the memory that is DMA-addressable without involving
> swiotlb.

OK, this sounds reasonable. I can drop the changes for the 36bit dts. But f=
or
the 32bit dts, it does cause the kernel hang on my p2020rdb-pca board when =
the
SiI3132 driver probe the on-board pcie to sata controller. I think this iss=
ue
should apply to all these boards if it has a pci device plugged. So we shou=
ld
fix them ASAP.

>=20
> Maybe U-Boot should be fixed?

Maybe. I have created patch for kernel to detect this kind of mismatch betw=
een
kernel and bootloader and then try to reassign the bus address automaticall=
y.
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Dne=
xt&id=3Dcf4d1cf5ac5e7d2b886af6ed906ea0dcdc5b6855

So with this patch the kernel should just work even without this patch and
the fix for u-boot. But this patch is just queued for 3.11. So I wish we can
tweak the 32bit dts to accommodate to the u-boot now so that we can make su=
re
that these boards are at least bootable for 3.10 or previous kernel. Then we
can revert this patch for more DMA address space once the pci patch are
merged into mainline.

Thanks,
Kevin

>=20
> -Scott

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRpsalAAoJEJNY7TDerrFxHAUH/Aj8dGU8JNId9TSIrOCunTQL
UN0ygDhHGIbHA0zBmoT3JFxK415mFDJ3R/OeS23F4XFgfbbK5jbAlPX+iUe3nA74
H0A/bcE/2776TAFWd16u4o//SHZ9p1pLVju50V7rkIYcLjp9RicayZxB2d0D0BGP
2trSGjnqviPDGiZmMmqCBv3BHAi2cbGMv6yKi49+3exmDKzc1JBTv8HASkBonQo0
jVx7grHLV2ZuJQeLknU6SsJFbs3kG85FBsfRhSoIRFvYZdyFMPWGvxj/Zzg7G37P
XkxV/VoAJHYT+PfpcmeV83dTzulh2Uye8MeSX6Vto8PLFw00ri71t+CtkjTQ1uA=
=y8ic
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
