Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBE912C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 13:30:02 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id hz11so6951000pad.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2013 20:30:00 -0700 (PDT)
Date: Wed, 3 Jul 2013 11:29:50 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
Message-ID: <20130703032950.GB25190@pek-khao-d1.corp.ad.wrs.com>
References: <20130702034514.GB26391@pek-khao-d1.corp.ad.wrs.com>
 <1372804865.8183.125@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
In-Reply-To: <1372804865.8183.125@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:41:05PM -0500, Scott Wood wrote:
> On 07/01/2013 10:45:14 PM, Kevin Hao wrote:
> >On Mon, Jul 01, 2013 at 08:00:06PM -0500, Scott Wood wrote:
> >> On 06/30/2013 02:35:21 AM, Kevin Hao wrote:
> >> >On Thu, Jun 27, 2013 at 09:19:06PM -0500, Scott Wood wrote:
> >> >> On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> >> >> >diff --git a/arch/powerpc/include/asm/mmu-book3e.h
> >> >> >b/arch/powerpc/include/asm/mmu-book3e.h
> >> >> >index 936db36..bf422db 100644
> >> >> >--- a/arch/powerpc/include/asm/mmu-book3e.h
> >> >> >+++ b/arch/powerpc/include/asm/mmu-book3e.h
> >> >> >@@ -214,6 +214,11 @@
> >> >> > #define TLBILX_T_CLASS2			6
> >> >> > #define TLBILX_T_CLASS3			7
> >> >> >
> >> >> >+#ifdef CONFIG_PPC32
> >> >> >+/* The max size that one tlb can map in a 32bit kernel. */
> >> >> >+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> >> >> >+#endif
> >> >>
> >> >> That comment is not true for all chips.
> >> >
> >> >This is not for the hardware limitation.
> >>
> >> It's not for a general software limitation, either.  We can use 1G
> >> mappings for user hugetlb (if the default mmap address is moved out
> >> of the way) or for the kernel lowmem mapping (if the address is
> >> moved to 0x80000000 instead of 0xc0000000).
> >>
> >> It's also possible (although unlikely at this point) that someone
> >> could make a 32-bit booke chip that cannot handle 256M mappings.
> >
> >Then I have to agree with you. :-)
> >Wish I can find a way to drop it.
>=20
> At least give it a comment that describes how it's actually used.
>=20
> >> Assuming memstart_addr isn't affected by the crashkernel reservation
> >> (if it is, could you point out where?),
> >
> >No. The memstart_addr does be affected. For example, for a boot kernel
> >with the command line with "crashkernel=3D32M@64M", the device tree
> >passed
> >the kdump kernel will have a memory node like this:
> >    memory {
> >            reg =3D <0x0 0x4000000 0x0 0x2000000>;
> >            device_type =3D "memory";
> >    }
> >
> >Then the memstart_addr will be set to 0x4000000 in the kdump kernel.
>=20
> OK, so then how does the crash kernel know which regions to dump?
> Is that indicated somewhere else in the device tree?

No. We get the dump of the memory via /proc/vmcore in the kdump kernel.

Thanks,
Kevin
>=20
> -Scott

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR05quAAoJEJNY7TDerrFx8scIALMA0otCjJs11t0+E10BsQcS
RBqVoMzyThHANOKch/8xEZRMx0FZZ+OYkqcHbJMk9uK6SqgNAmYvmWc0N+ijT29T
kpNbd+mPEj+DWkLAYadcnAg/ql6YY1xe3NFAsHUcxhaCv0kQL1ZKqeSQ9Epg5YFq
59xzifh2ojlAOf7tp2cIKagaeIx23NhyJQW3dN4R+2GvIocgunBVzI56JKPjIp34
RzRF4DPpmE/q6ZtPJCffkpfuLKD2u+3ZLzY9DNe2TqiM/3TaWGkUAIjz8Hz3bFs/
xh/QYkqKnn7tTrMZc1Rx0IFix7sEiAJog1p2XcFDdvn72S3vcasEfk9+CU6tk7Y=
=7a0c
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
