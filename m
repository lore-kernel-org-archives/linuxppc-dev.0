Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH v3 0/3] cpu: pseries: Cpu offline states framework
From: Michael Ellerman <michael@ellerman.id.au>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1253016701.5506.73.camel@laptop>
References: <20090915120629.20523.79019.stgit@sofia.in.ibm.com>
	<1253016701.5506.73.camel@laptop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-43Fv+rqidLdZFoOTn47F"
Date: Tue, 15 Sep 2009 23:21:51 +1000
Message-Id: <1253020911.16213.24.camel@concordia>
Mime-Version: 1.0
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun R Bharadwaj <arun@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	"Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-43Fv+rqidLdZFoOTn47F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-09-15 at 14:11 +0200, Peter Zijlstra wrote:
> On Tue, 2009-09-15 at 17:36 +0530, Gautham R Shenoy wrote:
> > This patchset contains the offline state driver implemented for
> > pSeries. For pSeries, we define three available_hotplug_states. They ar=
e:
> >=20
> >         online: The processor is online.
> >=20
> >         offline: This is the the default behaviour when the cpu is offl=
ined
> >         even in the absense of this driver. The CPU would call make an
> >         rtas_stop_self() call and hand over the CPU back to the resourc=
e pool,
> >         thereby effectively deallocating that vCPU from the LPAR.
> >         NOTE: This would result in a configuration change to the LPAR
> >         which is visible to the outside world.
> >=20
> >         inactive: This cedes the vCPU to the hypervisor with a cede lat=
ency
> >         specifier value 2.
> >         NOTE: This option does not result in a configuration change
> >         and the vCPU would be still entitled to the LPAR to which it ea=
rlier
> >         belong to.
> >=20
> > Any feedback on the patchset will be immensely valuable.
>=20
> I still think its a layering violation... its the hypervisor manager
> that should be bothered in what state an off-lined cpu is in.=20

Yeah it probably is a layering violation, but when has that stopped us
before :)

Is it anticipated that this will be useful on platforms other than
pseries?

cheers



--=-43Fv+rqidLdZFoOTn47F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqvlOwACgkQdSjSd0sB4dIm3gCfXeQEi21cbD6twtUWBS16h2qC
mLkAn2SAGoHcs0X6a24MPAt7qF7JgWyM
=tBxS
-----END PGP SIGNATURE-----

--=-43Fv+rqidLdZFoOTn47F--
