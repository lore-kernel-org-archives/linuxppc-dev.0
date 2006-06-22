Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A24F6679FF
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 21:35:24 +1000 (EST)
Subject: Re: [linux-pm] windfarm got signal
From: Johannes Berg <johannes@sipsolutions.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <1150974836.16258.29.camel@johannes>
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
	<200606221303.19860.rjw@sisk.pl> <1150974836.16258.29.camel@johannes>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/sAdrAZc/rURMiVNw6hm"
Date: Thu, 22 Jun 2006 13:34:52 +0200
Message-Id: <1150976092.16258.33.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/sAdrAZc/rURMiVNw6hm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-22 at 13:13 +0200, Johannes Berg wrote:

> Thanks, I'll look and submit a patch. It does try_to_freeze() but also
> checks for pending signals.

Ah. The code is just in the wrong order:
while (!kthread_should_stop()) {
  try_to_freeze();
  ...
  schedule_timeout_interruptible(...);
  if (signal_pending())
    break;
}

Would it be correct to just move the try_to_freeze() before the
signal_pending() statement?

johannes

--=-/sAdrAZc/rURMiVNw6hm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARJqAWqVg1VMiehFYAQJ9nBAAttPDJ/s3q+YNip4cXggIdDAh9z6DUh4Y
HDlEpQNf3ZHYRdMPglbdS/qplnNr+IEDSAEU9Q7+yfFiYy61DjtklDFKztIDcdf9
XsSINiqlqgfy4L0zqsBU658m3VAJX9laAp35YbRULCpSFylrXSenWLhdgx3sNSdj
z6oUcAadxkvquG1DzQaTaoGls+7wjw2TFKCh7ihYlOp+QVw/zDdVpCWPoamsrGsE
zMRFf6njisWnXp4HNgLm7otcOlVRPJ8tbN8JrwDcJoSGHCEXqe7vAGVXDE8fWAZN
B05OCOX7CvecdAzWdULNy4oDfmiCfNglQvnMEtW/RgAmeZtw45DooJJLlhreBQKB
d2kUOxGb3kXlFRpyOo/WaYWjAoUFP5ljmg/5Ws6RXcdRTWXVovE0kH28bgF5liRM
eUsVs33GOP9hlZjBX1bxaPslvX6dj0mr3zes+zsH1yULY37NeydwycZZJ/kIh4lj
USwmTuiRlxbBDANZnGVQ7s5V1CC2ix9ppW1fbkHhb0orguyPm3PpUb+oStzcWrhW
rg2GbL7vOJu9PvBIDvhV9+oaHUfOQxBQKZGS1bQ+Fq7B2t1OWzdgNnmFOOpwyLY6
NZolY3sSw4AngWu1gdY+XrfFqr/mSuP9ak2TCSluvwL0ZfMoNRhCYDcPaayxVbAu
vEnm+5/8Cc0=
=RD6p
-----END PGP SIGNATURE-----

--=-/sAdrAZc/rURMiVNw6hm--
