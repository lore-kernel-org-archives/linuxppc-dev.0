Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A8012DE152
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:45:55 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Freescale QUICC Engine USB Host Controller
Date: Thu, 3 Apr 2008 15:45:47 +0200
References: <20080311191744.GA10518@localhost.localdomain>
In-Reply-To: <20080311191744.GA10518@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2215824.2O4lS3eFIN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804031545.51834.laurentp@cse-semaphore.com>
Cc: linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2215824.2O4lS3eFIN
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Anton,

On Tuesday 11 March 2008 20:17, Anton Vorontsov wrote:
> This is patch adds support for the FHCI USB controller, as found
> in the Freescale MPC836x and MPC832x processors. It can support
> Full or Low speed modes.
>=20
> Quite a lot hardware is doing by itself (SOF generation, CRC generation
> and checking), though scheduling and retransmission is on the software
> shoulders.
>=20
> This controller does not integrate the root hub, so this driver also
> fakes an one-port hub. External hub is required to support more than
> one device.

Would it be possible to use the driver for CPM2-based devices ? The only=20
difference I found between the CPM2 and QE USB controllers is the SOF=20
handling. The QE USB controller increments the frame number itself, while t=
he=20
CPM USB controller requires the host to increment the frame number.

At first sight the driver depends on qe_lib for:

=2D muram allocation (qe_muram_alloc/free, qe_muram_offset/addr)
=2D GPIO access (qe_gpio_set_dedicated)
=2D clock routing (qe_clock_source, qe_usb_clock_set)
=2D QE commands execution (qe_issue_cmd)

It shouldn't be too difficult to abstract those operation in a fashion simi=
lar=20
to the cpm_uart driver.

Have you already worked on CPM2 support, or thought about any particular is=
sue=20
I should pay attention to ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2215824.2O4lS3eFIN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH9N+P8y9gWxC9vpcRAoyhAJsGk3vkbfdQ3mDae5u2HUfxSNhlSQCfS0Vf
IPLqpiJkbM8NWuep3QKiXKE=
=NyX4
-----END PGP SIGNATURE-----

--nextPart2215824.2O4lS3eFIN--
