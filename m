Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQDZS10vZzDvv2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 22:37:20 +1100 (AEDT)
Date: Fri, 25 Nov 2016 22:37:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window creation
Message-ID: <20161125113713.GN12287@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
 <20161125043904.GE12287@umbus.fritz.box>
 <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
In-Reply-To: <2ef5c5f2-fbc7-6d25-93c9-fe225e10669c@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2016 at 05:38:26PM +1100, Alexey Kardashevskiy wrote:
> On 25/11/16 15:39, David Gibson wrote:
> > On Thu, Nov 24, 2016 at 04:48:08PM +1100, Alexey Kardashevskiy wrote:
> >> We are going to allow the userspace to configure container in
> >> one memory context and pass container fd to another so
> >> we are postponing memory allocations accounted against
> >> the locked memory limit. One of previous patches took care of
> >> it_userspace.
> >>
> >> At the moment we create the default DMA window when the first group is
> >> attached to a container; this is done for the userspace which is not
> >> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memo=
ry
> >> pre-registration - such client expects the default DMA window to exist.
> >>
> >> This postpones the default DMA window allocation till one of
> >> the folliwing happens:
> >> 1. first map/unmap request arrives;
> >> 2. new window is requested;
> >> This adds noop for the case when the userspace requested removal
> >> of the default window which has not been created yet.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > Hmm.. it just occurred to me: why do you even need to delay creation
> > of the default window?
>=20
>=20
> Because I want to account the memory it uses in locked_vm of the mm which
> will later be used for map/unmap.

Ah, good point.  How is the locked vm accounted for the non ddw case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYOCJpAAoJEGw4ysog2bOSdBIQANrOKKi/uC93W1Gad6AIIxh4
1CgRHm16drs5qH8nXQahlSfiHa+YM+JPUQ2Fr1NxRrXZ9iOAndr5umXRbTCDHOX1
4oS1M7BWUlk8oo1nTyjMC/AdhRVOnRNnGh1X+pF0Ten40cHQkycL2tMhoIlIgrk3
Cg1dSwSJsTREok3AbN5IHZLnUeQ0DJoeOcOilrUH+UtsLua8hkmqPJUsZDM+GWJW
3ipFlAaZaORbTpgAgspV9nlF3WjyhWdDAYDH+XVvbYDGvwRlX5oKrxp3v+OEXqB2
B+PKk7Kg38MJGPAkRyrqpX3KUSDgtDVxiv81MiIjQdHdB1Ws6/c2HXVc1r0P5anV
Kz4x1Fd43tFn8K8I68czbpNBEcUoocUhcnQJ0RESzQDxZ0FuXMIKGLRTenw92bq+
6gOuxoJz5Do9fmS86zmE3gSBMuRU3zMFdkDFhQJfD3GXN2U95wj1Y2Eql9gg2B4V
xnXSI9E52t7iMoshTiRO5tZKIbHYapSYb0WMjGMBN5eKBD0xm4aZ27eYWx1WOost
GcBlqu01zDFg1EBGOSyqCyayIC1h1eO/cjdEMo0MbUxqfn0qhQ0JwsaMW7kHd9Fp
E5KiezetpslqCiT7YrO1H9OVAowpy9L/wVne+/5h9/BBi+QjJWY+kTHv4orB6SuK
+jK5KA3vJXmwoEUh923i
=X3e1
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
