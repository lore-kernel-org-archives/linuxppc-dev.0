Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15D8B1A0166
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 22:07:14 +1100 (AEDT)
Date: Mon, 1 Feb 2016 21:55:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 9/9] pseries: Automatically resize HPT for memory hot
 add/remove
Message-ID: <20160201105524.GI23043@voom.redhat.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-10-git-send-email-david@gibson.dropbear.id.au>
 <56AF1CA2.30603@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PaC+lnGZu4KSIdY4"
In-Reply-To: <56AF1CA2.30603@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PaC+lnGZu4KSIdY4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 02:21:46PM +0530, Anshuman Khandual wrote:
> On 01/29/2016 10:54 AM, David Gibson wrote:
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> > +void resize_hpt_for_hotplug(unsigned long new_mem_size)
> > +{
> > +	unsigned target_hpt_shift;
> > +
> > +	if (!ppc_md.resize_hpt)
> > +		return;
> > +
> > +	target_hpt_shift =3D htab_shift_for_mem_size(new_mem_size);
> > +
> > +	/*
> > +	 * To avoid lots of HPT resizes if memory size is fluctuating
> > +	 * across a boundary, we deliberately have some hysterisis
>=20
>=20
> What do you mean by 'memory size is fluctuating across a boundary' ?
> Through memory hotplug interface ? Why some one will do that ?

I was thinking it might be possible to have some management system
that automatically adjusts memory size based on load, and if that
happened to land on a boundary you could get nasty behaviour.

> I
> can understand why we dont have this check in the sysfs debug path
> as we would like to test any memory HPT re sizing scenario we want
> in any sequence of increase or decrease we want.
>=20
> Overall the RFC V2 looks pretty good. Looking forward to see the
> host side of the code for this feature.

The qemu host side has been posted to qemu-devel@nongnu.org already.
I haven't started on a KVM HV implementation yet.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PaC+lnGZu4KSIdY4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWrzmcAAoJEGw4ysog2bOSHNMQAL8Sa2vyEB0Yb5m4S6gDusZS
tBNAj3a4jnlJfT/mD8D4u4CHMCD0OddOwBapieG2PRBeNUU1Qj40WWDJAOe0yyGg
BpP2fSap7qXN1n64rvj9XBiD9BPDg5VSWPPKZUTbqo5seTFfZdkr5wBIwWlCxav0
6P5KmEre4CwfzVH/m+RW3HY5yT3/Jc2rDErZKlAeOkM4QLEp+KG2T/TjmRAvE6ut
Bcl2Z74VmbHxj6/CTVrontokhIPAajZ0wee5je5s1rxF1kVlJF3C7WLSdWEKVplA
JmayqISKGsJCDJ8ABOwJzoJEyvz6PofqQVci0erTZjTRJgvayM9VJiV7vpoKNvTH
4TM1t9AHpzuZEMQlYWhjZ7XDE5O69XSs21TnYAJRCkaK9SSvUsaWG7gDcE9gXHay
TxbCcG2KYczeQdQJui+o1YbHVWXKrsxN/4/maiOq1Uw83N5+I5U1dJFVJK8G8ao5
dpqjX6L4gB4S9KbEmmeCrPQFc2PnRQPyVbIvWDrE8EUXD5gTtDDkTQV136wia6RV
cUA8etiaagcjcKMYBMtJzyGYBg1EJ3klPw4dBH5uPRWzVGo7SNR1brpHCxJs6GsO
p867DUgFiLeC5Q70nq7NtYdxNBWvaRgPOe4cntYEni82Af6jXgxti26SRShBBWIE
0KnT9WeKa3crms9Mr7Vr
=YJY+
-----END PGP SIGNATURE-----

--PaC+lnGZu4KSIdY4--
