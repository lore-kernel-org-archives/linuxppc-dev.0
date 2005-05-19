Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id B21D2679FE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 23:32:50 +1000 (EST)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mxZW+qiwBP8tegXQfJ3I"
In-Reply-To: <E1DYPVW-0000vS-00@gold.webfusion.co.uk>
Date: Thu, 19 May 2005 09:32:32 -0400
References: <E1DYPVW-0000vS-00@gold.webfusion.co.uk>
Message-ID: <1116509554.9050.127.camel@jmcmullan.timesys>
MIME-Version: 1.0
Date: Thu, 19 May 2005 09:26:25 -0400
Message-ID: <1116509554.9050.127.camel@jmcmullan.timesys>
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: <jmasel@arabellasw.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: Arabella Resource Manager
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-mxZW+qiwBP8tegXQfJ3I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Interesting code, but not generic enough.
What would be nicer would be an API like the following, that can be
easily extended, and work for more than just PQ (and ppc, for that
matter)

enum bres_type {
	BRES_TYPE_CLOCK =3D 0,
	BRES_TYPE_PIN,
	BRES_TYPE_CPM_SRAM,
	...
	BRES_TYPE_MAX,
}

struct bres_pool {
	struct resource *pool;
	int (*set)(int id, ...);
	int (*clear)(int id);
};

/* Board setup will set up the available regions
 * into this array, similar as to how the PCI=20
 * system sets up the iomem areas.
 */
struct bres_pool *board_resource[BRES_TYPE_MAX];

/* Request a resource out of the available pools
 */
int bres_request(enum bres_type type, const struct resource *req);

/* Free a requested resource=20
 * This also calls the 'clear' function of the pool.
 */
int bres_release(enum bres_type type, const struct resource *res);


/* After request completes, you can 'instance'
 * the resource.
 */

/* Wire a pin
 * pin is the same as you requested in the resource
 * pin type is defined in either the board or SoC CPU headers
 *  (ie CPM_PB17_SDL)
 */
static inline int bres_pin_wire_as(int pin, int pin_type)
{  return board_resource[BRES_TYPE_PIN].instance(pin, pin_type); }

/* Wire a clock
 */
static inline int bres_clock_wire_as(int clock, int clock_target,
			int multiplier, int divider)
{  return board_resource[BRES_TYPE_CLOCK].instance(pin, pin_type); }

...etc....



--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-mxZW+qiwBP8tegXQfJ3I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCjJVw8/0vJ5szK6kRAtDaAKC9WFofAOh6m6J/rtlzYyoWYwfkywCcDTGy
KWVnaCb6hInCiW0aTKMmVbQ=
=5+mz
-----END PGP SIGNATURE-----

--=-mxZW+qiwBP8tegXQfJ3I--
