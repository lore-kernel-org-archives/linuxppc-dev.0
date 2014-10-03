Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 043B91A03A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 00:44:49 +1000 (EST)
Date: Fri, 3 Oct 2014 15:44:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <20141003144420.GC24441@sirena.org.uk>
References: <20141003125609.5BEA11AB276@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
In-Reply-To: <20141003125609.5BEA11AB276@localhost.localdomain>
Subject: Re: [PATCH 2/2] spi: fsl-spi: Allow dynamic allocation of CPM1
 parameter RAM
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 02:56:09PM +0200, Christophe Leroy wrote:

> +config CPM1_RELOCSPI
> +	bool "Dynamic SPI relocation"
> +	default n
> +	help
> +	  On recent MPC8xx (at least MPC866 and MPC885) SPI can be relocated
> +	  without micropatch. This activates relocation to a dynamically
> +	  allocated area in the CPM Dual port RAM.
> +	  When combined with SPI relocation patch (for older MPC8xx) it avoids
> +	  the "loss" of additional Dual port RAM space just above the patch,
> +	  which might be needed for example when using the CPM QMC.

Something like this shouldn't be a compile time option.  Either it
should be unconditional or it should be triggered in some system
specific manner (from DT, from knowing about other users or similar).

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULrZDAAoJECTWi3JdVIfQbywH/0vlIbyDtXeXSo8Qg0xKxfu+
NmGzbVSizdDFhjhq8+LRSFjKdl6u8cXF+Vuyt+hGXsvAc1c6Vc2XNSWO0eXbq+kg
soGV9Y9UfLx4smuhdcuWqri1qZOJG2k7058AzSZwDWfEwTQ88Sb47cGHv8L69jhn
s7TR2SMnMZ+Gk4JWiZ/lETGbVYspRnKSAnKtu4ubsPRG34wJnhQvc9V9WhGynlKu
hhA/5II3+8grWKmEdWTK/mTQBMoikxJxElN8FPQnogoApnJONM6fsmLH/1O4979K
o/3DAS80NGnPDC23k65b+iOHg2EIXnzfFSYdHXaSUAiWvN5Rjg4hrxyC1IBgxpw=
=cnSl
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
