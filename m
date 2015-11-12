Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 014311A072B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 08:37:31 +1100 (AEDT)
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C6959141429
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 08:37:29 +1100 (AEDT)
Received: by pabfh17 with SMTP id fh17so76844820pab.0
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 13:37:26 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
In-Reply-To: <5644CABE.3010905@linux.vnet.ibm.com>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <87bnazizkp.fsf@gamma.ozlabs.ibm.com> <5644CABE.3010905@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 08:37:09 +1100
Message-ID: <87pozezypm.fsf@gamma.ozlabs.ibm.com>
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

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

>> <puts on CAPI hat>Yeah, it would be good not to break this.</hat>
>
> I am not familiar with CAPI. Does this affect CAPI?

When a CAPI card experiences an EEH event, any cache lines it holds are
filled with SUEs (Special UEs, interpreted by the kernel the same as
regular UEs). When these are read, we get an MCE. Currently CAPI does
not support virtualisation, but that is actively being worked
on. There's a _very_ good chance it will then be backported to various
distros, which could have old qemu.

Therefore, I'd ideally like to make sure UEs in KVM guests work properly
and continue to do so in all combinations of kernel and qemu. I'm
following up the email from Mahesh that you linked: I'm not sure I quite
follow his logic so I'll try to make sense of that and then get back to
you.

Regards,
Daniel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRQaFAAoJEPC3R3P2I92FBnoQALmoi05ujJ+iZXqG5UXD8JFb
g+EB/pgDCARDhqUEal1jgy2bu1Je8c+YvcX7uhTFkDEMQ7khBFoklGue5kgCSJvh
ijyMOxtA9ab+VD/p7SHMhVj5PLDVt8pGEBbd3MErxMooGuesCm9kH4tcQGrBh99l
in7Hbx7Toko4oq7uc0U4Zo/pp2KwZSuKx99++VITZQfh3sC5dSItmhVEqH46saIp
fFeXA9dnQ+HMyqCTmN9Zdef78r4uQ+S9rzVxBDnTennCwSPlO2O2uusV93xr3Lwb
UzkVh4ocN2bSM6zhmBj5Sdt9CWcg3APGn71nuay1sXTdU1EqYft6xxS18w2q9tyW
AkfBFtFxW8W3Akx+FSGV9JvRIu4ky1DE1WpaxUcqFpySmZT2Bc9UzF4Rcd4Jlvd9
R6g0qFkwvpzKi6lJEWwgbBW26PEDyiy4PjBIPba9i/6AHb9xL4PNnHR5FvVDLZ2z
8b7h2TNEiQzSNHxDK36Wwe8New2pqt03/imsTwQecrwDl7ip/FBKZ0CogeZModZq
Y00uC9d5d/ewuQepVn/O+gBfjer5ecrPYC0FfjG0fCCfe+Azw8JaGCqiHlis0LZu
D7GhokiDGJst4i6joN6S7ps8fT4TKfx3LU/yg+Fw6wV5KLHNFWo/EACWq7qv5yLd
x8kZ8Ig1/IBrNcs6Ir7Y
=H92U
-----END PGP SIGNATURE-----
--=-=-=--
