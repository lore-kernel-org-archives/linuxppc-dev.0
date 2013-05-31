Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x229.google.com (mail-pb0-x229.google.com
 [IPv6:2607:f8b0:400e:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 075DF2C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 17:54:01 +1000 (EST)
Received: by mail-pb0-f41.google.com with SMTP id xb12so1796568pbc.14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 00:53:58 -0700 (PDT)
Date: Fri, 31 May 2013 15:53:49 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/mpc85xx: match with the pci bus address used by
 u-boot for all p1_p2_rdb_pc boards
Message-ID: <20130531075349.GA22164@pek-khao-d1.corp.ad.wrs.com>
References: <1368685785-10677-1-git-send-email-haokexin@gmail.com>
 <1369781156.18630.24@snotra>
 <20130530032525.GA18702@pek-khao-d1.corp.ad.wrs.com>
 <1369940262.14679.15@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <1369940262.14679.15@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2013 at 01:57:42PM -0500, Scott Wood wrote:
> On 05/29/2013 10:25:25 PM, Kevin Hao wrote:
> >On Tue, May 28, 2013 at 05:45:56PM -0500, Scott Wood wrote:
> >> On 05/16/2013 01:29:45 AM, Kevin Hao wrote:
> >> >All these boards use the same configuration file p1_p2_rdb_pc.h in
> >> >u-boot. So they have the same pci bus address set by the u-boot.
> >> >But in some of these boards the bus address set in dtb don't match
> >> >the one used by u-boot. And this will trigger a kernel bug in 32bit
> >> >kernel and cause the pci device malfunction. For example, on a
> >> >p2020rdb-pc board the u-boot use the 0xa0000000 as both bus address
> >> >and cpu address for one pci controller and then assign bus address
> >> >such as 0xa00004000 to some pci device. But in the kernel, the dtb
> >> >set the bus address to 0xe0000000 and the cpu address to
> >0xa0000000.
> >> >The kernel assumes mistakenly the assigned bus address 0xa0004000
> >> >in pci device is correct and keep it unchanged. This will
> >definitely
> >> >cause the pci device malfunction. I have made two patches to fix
> >> >this in the pci subsystem.
> >> >http://patchwork.ozlabs.org/patch/243702/
> >> >http://patchwork.ozlabs.org/patch/243703/
> >> >
> >> >But I still think it makes sense to set these bus address to match
> >> >with the u-boot. This issue can't be reproduced on 36bit kernel.
> >> >But I also tweak the 36bit dtb for the above reason.
> >>
> >> IIRC the reason for using 0xe0000000 on all PCIe roots is to
> >> maximize the memory that is DMA-addressable without involving
> >> swiotlb.
> >
> >OK, this sounds reasonable. I can drop the changes for the 36bit
> >dts. But for
> >the 32bit dts, it does cause the kernel hang on my p2020rdb-pca
> >board when the
> >SiI3132 driver probe the on-board pcie to sata controller. I think
> >this issue
> >should apply to all these boards if it has a pci device plugged.
> >So we should
> >fix them ASAP.
>=20
> Is this what your 3.11 patch fixes,

Yes, the patch in the pci next tree fix this issue in a more general
level.

> or does it hang even with that?

No.

>=20
> >> Maybe U-Boot should be fixed?
> >
> >Maybe. I have created patch for kernel to detect this kind of
> >mismatch between
> >kernel and bootloader and then try to reassign the bus address
> >automatically.
> >https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=
=3Dnext&id=3Dcf4d1cf5ac5e7d2b886af6ed906ea0dcdc5b6855
> >
> >So with this patch the kernel should just work even without this
> >patch and
> >the fix for u-boot. But this patch is just queued for 3.11. So I
> >wish we can
> >tweak the 32bit dts to accommodate to the u-boot now so that we
> >can make sure
> >that these boards are at least bootable for 3.10 or previous
> >kernel. Then we
> >can revert this patch for more DMA address space once the pci
> >patch are
> >merged into mainline.
>=20
> Is this a regression, or has it been broken for a while?

It seems that the p2020rdb-pc_32b.dts was not bootable since it
was first introduced into the mainline kernel. The reason is that
the following patch change the method of doing the translation of the
bus->resource and resource->bus and then disclose this mismatch
between bootloader and kernel.

commit 6c5705fec63d83eeb165fe61e34adc92ecc2ce75
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Feb 23 20:19:03 2012 -0700

    powerpc/PCI: get rid of device resource fixups
   =20
    Tell the PCI core about host bridge address translation so it can take
    care of bus-to-resource conversion for us.
   =20
    CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


Thanks,
Kevin

>=20
> -Scott

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRqFcNAAoJEJNY7TDerrFxXH0H/iQ9esscF5MVwsbS18100IGf
7qzgYM3C2kEG8E3BNjeZhIm8bCMb82aoe4p4k+dArEKYoGR65qd54qqP0K/NIPEV
ISCzodlA9BT3NefnaMehgiuSZcbeW/y/xn9gHSQS2vNKj3U41BpWVwWl3fwvbIsL
+WxgjqNG/6lMcLfo+wPOSf6BgugeIZxULE0diai10RzbkktmpAiZmucqdbFM+9mu
TLrXlE3PsTROTnvA6F1vEU5eLdtaz+n7pPqYqAGwKSGZA7l+ZWctz0LVkLd/X/xG
P+RVWV7w647+yUtRRlt+3wyZZK85ng8Pxdh7UXJvHzGwSSDP757VN4M4lPzfF9Q=
=1ItX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
