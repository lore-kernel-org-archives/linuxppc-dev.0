Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 367AE1A0311
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 12:36:46 +1000 (AEST)
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BF4B140218
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2015 12:36:44 +1000 (AEST)
Received: by pddn5 with SMTP id n5so7373781pdd.2
 for <linuxppc-dev@ozlabs.org>; Thu, 09 Apr 2015 19:36:42 -0700 (PDT)
Message-ID: <1428633388.4486.14.camel@axtens.net>
Subject: Re: [PATCH v3 16/19] powerpc: fsl_pci, swiotlb: Move controller ops
 from ppc_md to controller_ops
From: Daniel Axtens <dja@axtens.net>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 10 Apr 2015 12:36:28 +1000
In-Reply-To: <1428629330.22867.567.camel@freescale.com>
References: <1427778057-9505-17-git-send-email-dja@axtens.net>
 <1428624718-13564-1-git-send-email-dja@axtens.net>
 <1428629330.22867.567.camel@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-4bIY9wTx0TG/uaH6m0IP"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4bIY9wTx0TG/uaH6m0IP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Scott,

This is part of the larger set to move controller ops into a generic
structure. The original cover letter is at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-March/126837.html

The commit message should have been reworded when I sent out version 2.
Apologies. Here's a more accurate summary, which will appear in v4.

powerpc: fsl_pci, swiotlb: Move controller ops from ppc_md to
controller_ops

Move the installation of DMA operations out of swiotlb's subsys
initcall, and into the generic PCI controller operations struct.

These ops are installed conditionally, based on the ppc_swiotlb_enable
global. The global can be set in two places:
 - swiotlb_detect_4g, which is always called at the arch initcall level
 - setup_pci_atmu, which is called as part of the fsl_add_bridge and
fsl_pci_syscore_do_resume. fsl_pci_syscore_do_resume is called late
enough that any changes as a result of that call will have no effect.

As such, if we test the global and set the operations as part of
fsl_add_bridge, after the call to setup_pci_atmu, we can be confident
that it will cover all the PCI implementations affected by the changes
to dma-swiotlb.c.

Regards,
Daniel

On Thu, 2015-04-09 at 20:28 -0500, Scott Wood wrote:
> On Fri, 2015-04-10 at 10:11 +1000, Daniel Axtens wrote:
> > Moves the setup out of swiotlb's subsys init call, and into an new
> > structure.
>=20
> "a new"
>=20
> > fsl_pci.c is the only thing that checks the ppc_swiotlb_enable global,
> > so we can be confident that patching it will cover all the PCI
> > implementations affected by the changes to dma-swiotlb.c.
>=20
> Do you mean the only thing that sets ppc_swiotlb_enable (fsl_pci.c
> doesn't check it)?  It's also set by swiotlb_detect_4g().
>=20
> Where is the rest of this patchset?  What is the problem being solved?
>=20
> -Scott
>=20
>=20


--=-4bIY9wTx0TG/uaH6m0IP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVJzc2AAoJEPC3R3P2I92FjhgP/RywHqgKI5EfAR9s45BpStev
Wlx42dCoQXAZck/7JXrm006tgpeNdRxPVBLC689JJ8cse4vLKHAuc/+XM2qd9np4
1nC5tploOI4T60XeZBz63Cf6yC5cpTkt8d9APZF0X/QrV+e4AF0xWttgvQHC4wSj
0miv9V+pF5qEuOHreEZwthZtPJfWdpB9SQtXr6NXrxjewFj3mx/+jCyT9M4gE5ZP
/YMC0Fa2wNTRqhuN1vl/GTEcfD/RqRV4XPqoDHWC5dzLzP6HMRyOA4ekKSRymgSn
x8/R82NaWx1A9Ssa3xBfP2htkK4f7lrJIB7Y/LLKUGicVu19QatIgMd7PMGSDFYu
p/kgDBEEODGnqJworDqkSgskIflmBzIi/S3/thphMNNdRed4tLvfxTy0KfUooRSp
P5gHmBnfelZx7gnSIukirnqgUAFU/V4MaromKM/FrombUkesLP19Q4mhfAnOA4Ep
vQGatSSq0fwdPIRw0TkiSdZ+H8R0fND7fmUiQiF8+LjJcCUpCk/AGSM/mGfhhL0f
wzKiEpZg7Ni2CbSaReORtrSoQhBpbQEZPUx9mvMoZudiPC7N4dR1miYuzjsErXKA
LKV2F8sxOc57VBui3VWXIwNs2gvwH9zWKuBifMqsv74mtuqOoLa7L4Po47whne5g
aIj3Ifbn8rlki1DkcUyx
=oIzr
-----END PGP SIGNATURE-----

--=-4bIY9wTx0TG/uaH6m0IP--
