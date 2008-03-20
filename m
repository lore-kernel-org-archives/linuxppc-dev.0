Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 5D0ECDDF98
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 02:18:40 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Date: Thu, 20 Mar 2008 16:18:26 +0100
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<200803201439.59806.laurentp@cse-semaphore.com>
	<20080320150823.GB31587@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080320150823.GB31587@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15080131.JmifM5uyAh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803201618.37051.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart15080131.JmifM5uyAh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 20 March 2008 16:08, Scott Wood wrote:
> On Thu, Mar 20, 2008 at 02:39:56PM +0100, Laurent Pinchart wrote:
> > I'm working on a patch. I'm not sure how to handle the early udbg printk
> > problem, so the first version will just ignore it.
>
> udbg printk is extremely useful... I'd not be fond of it breaking.

I don't want to kill it either. What I meant is that my first patch will no=
t=20
care about udbg so that I can get feedback about the CPM serial driver part=
=2E=20
I'll then see how to make udbg fit into that.

> Perhaps we should stick more initialization into the cpm udbg code, so it
> isn't so dependent on the bootloader setup... though we'd have push the
> CPM reset and SMC allocation earlier in such a case.

When SMC1 is used as a serial console, SMC1 is the first CPM dpram allocati=
on=20
user. This means the CPM dpram allocator will allocate a buffer at the=20
beginning of the dpram. As he SMC controller will already be using the 64=20
first bytes of the dpram, it will not see any difference when being=20
reinitialized.

This of course depends on the boot loader allocating parameter ram at the=20
beginning of the dpram for SMC1, but we already depend on that if I'm not=20
mistaken.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart15080131.JmifM5uyAh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH4oBN8y9gWxC9vpcRAtoXAJ9X3CBwp/n8sRHa9DeC19yO5Zb8KACfVSEj
nqyXqBy0Bn10LeLjSOOeQ+I=
=ILWT
-----END PGP SIGNATURE-----

--nextPart15080131.JmifM5uyAh--
