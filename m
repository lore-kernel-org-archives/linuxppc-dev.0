Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 836FE1A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 07:47:11 +1100 (AEDT)
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 870C014018C
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2015 07:47:10 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so74784923pad.1
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Dec 2015 12:47:08 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, imunsie@au1.ibm.com
Subject: Re: [PATCH] Revert "powerpc/eeh: Don't unfreeze PHB PE after reset"
In-Reply-To: <1449126972-25400-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1449126972-25400-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 04 Dec 2015 07:46:52 +1100
Message-ID: <87h9jz6z0j.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Andrew and Gavin,

To flesh out Andrew's commit message, and add some surrounding detail to
help in debugging:

Before 527d10ef3a315, all PEs were unfrozen when we called
eeh_reset_device(). That patch changed behaviour to skip the PE
associated with or reserved for the PHB. Indeed, this shouldn't have
made a functional change, because no resources required for the device
should be associated with the PHB's PE.

Obviously, however, it does change behaviour.

We found that not only does it break the cxlflash driver, we can test
for its presence by trying to run cat on the relevant vpd file in /sys/.
Before doing a reset, you can cat the file without issue.
After a reset, catting the file fails with -ENODEV.
Curiously, lspci succeeds both before and after. lspci doesn't try to
read the file from start to end however, it just reads certain bytes. So
there are some bytes in the file that trigger -ENODEV after a reset.

We know that it is failing to read bytes in regular config space (not
CAPI's magic MMIO fake config space for AFUs: we're still in regular PCI
land at this point). What we don't know is precisely what those bytes
are, and why those bytes are (seemingly) being associated with the PHB's
PE.

I had some theories, and maybe Andrew can update this list:
    - CAPI code is doing something wrong.
    - There's a bug in PCI resource allocation or the mapping of
      resources to PEs such that something is hitting space assigned for
      PE0.
    - CAPI is 'special' and requires PE#0 to be unfrozen.

This fix is a fix to the symptom, not the problem; we obviously need to
know the root cause in order to fix the root cause. However, if we are
no closer to figuring it out soon, we should probably take this patch so
as not to release a 4.4 that breaks CAPI.

Congrats to Andrew, btw, for apparently being the only CAPI developer
who is testing CAPI stuff against mainline at the moment.

Regards,
Daniel

> This reverts commit 527d10ef3a315d3cb9dc098dacd61889a6c26439.
>
> The reverted commit breaks cxlflash devices following an EEH reset.
> Attempting to load the cxlflash driver after a reset results in a call to
> pci_read_vpd() returning -ENODEV, causing driver initialisation to fail.
>
> At this stage, we don't fully understand why this is happening, and we
> also haven't tested whether this occurs for other cxl devices. In the
> meantime, though, revert the commit, especially as it was intended to be a
> non-functional change.
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> ---
>
> This issue was identified by bisection following breakage observed in
> 4.4-rc1. I'm continuing to investigate the root cause (and testing on cxl
> devices other than cxlflash), as the commit in question shouldn't have
> caused problems.
> ---
>  arch/powerpc/kernel/eeh_driver.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_d=
river.c
> index 80dfe89..8d14feb 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -590,16 +590,10 @@ static int eeh_reset_device(struct eeh_pe *pe, stru=
ct pci_bus *bus)
>  	eeh_ops->configure_bridge(pe);
>  	eeh_pe_restore_bars(pe);
>=20=20
> -	/*
> -	 * If it's PHB PE, the frozen state on all available PEs should have
> -	 * been cleared by the PHB reset. Otherwise, we unfreeze the PE and its
> -	 * child PEs because they might be in frozen state.
> -	 */
> -	if (!(pe->type & EEH_PE_PHB)) {
> -		rc =3D eeh_clear_pe_frozen_state(pe, false);
> -		if (rc)
> -			return rc;
> -	}
> +	/* Clear frozen state */
> +	rc =3D eeh_clear_pe_frozen_state(pe, false);
> +	if (rc)
> +		return rc;
>=20=20
>  	/* Give the system 5 seconds to finish running the user-space
>  	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
> --=20
> Andrew Donnellan              Software Engineer, OzLabs
> andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
> +61 2 6201 8874 (work)        IBM Australia Limited
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWYKo9AAoJEPC3R3P2I92FxTcP/RJ2hPaxIZbzswK2toN5kEIu
Ma7416Em1rcHUrFVpRHt4xWdy9L9A7b2hxzNNTBzNRkKx0kQiiDwc9cqIKN7ilzW
ZMrRSY6v4DCN7cjMQEcgeMoaUAn15HdwB1I1XlInqLTLq7/0Gg9EFyOjWTb8jqGz
vrKyvpbZ1R5NhZPF6mPRAwKWPZymazKSRjiT/L/7+rSFXzP4Bko2vWfDcgKxJ13q
HQhVgyDldoXMpHTJyh9AKLvGBQ2WuZwqtYzR/26diT0/81ftKTamy6gy2FwqVd4k
nvC+8/NeEzsuD/5JEP+oNYvCHUwfsYS62MiKrXufGRiDgpgb+sFfMj6/G2No5m4G
CFWb1TqHCDOz44rTs+Vn3Xg9ZEqEz988iIFOaFqitvbEm0vA1jPvZ62i39r6cgsl
pQD1VJuy/jgPi3J3ulGCWDjzAkTBq0oLUChv5tm68Skl0HThRpZD9Ly9n8Zs4DRT
EZBvImn3ZYkyMvjuJx/ddRstDDN6M5m/O9mPKC43QMHbdZocBg6BS2vU0pikAQZR
yEM8MvPmKXbPSyYbOVB9d3OcAy52DxGkWeWtbCd1M6hJhSHIdhMrzrSLCO6kG1Jq
Q+uRH25jmgUQz4fc8Hyn7dEe552stBMeBXprMSOiKGC4XQGFlav9mPjg5Dw0rnKZ
B0M9Gy2taEgMa5bKehYk
=f+WY
-----END PGP SIGNATURE-----
--=-=-=--
