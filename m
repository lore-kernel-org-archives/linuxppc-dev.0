Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6A55CDDF14
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 22:25:35 +1000 (EST)
Date: Mon, 7 Jul 2008 22:25:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: linux-next: scsi tree build failure
Message-Id: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__7_Jul_2008_22_25_28_+1000_ExoozYY/ENnpcRiK"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__7_Jul_2008_22_25_28_+1000_ExoozYY/ENnpcRiK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'map_sg_data':
drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: 'FW_FEATURE_CMO' undeclared (f=
irst use in this function)
drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: (Each undeclared identifier is=
 reported only once
drivers/scsi/ibmvscsi/ibmvscsi.c:431: error: for each function it appears i=
n.)
drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_queuecommand':
drivers/scsi/ibmvscsi/ibmvscsi.c:750: error: 'FW_FEATURE_CMO' undeclared (f=
irst use in this function)
drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'send_mad_adapter_info':
drivers/scsi/ibmvscsi/ibmvscsi.c:864: error: 'FW_FEATURE_CMO' undeclared (f=
irst use in this function)
drivers/scsi/ibmvscsi/ibmvscsi.c: In function 'ibmvscsi_do_host_config':
drivers/scsi/ibmvscsi/ibmvscsi.c:1412: error: 'FW_FEATURE_CMO' undeclared (=
first use in this function)
drivers/scsi/ibmvscsi/ibmvscsi.c: At top level:
drivers/scsi/ibmvscsi/ibmvscsi.c:1769: error: unknown field 'get_io_entitle=
ment' specified in initializer
drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: missing braces around initi=
alizer
drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: (near initialization for 'i=
bmvscsi_driver.driver')
drivers/scsi/ibmvscsi/ibmvscsi.c:1769: warning: initialization from incompa=
tible pointer type

Caused because commit 341b56db6804040aa9559e913865108424e3b18b ("[SCSI]
ibmvscsi: driver enablement for CMO"), which was 15/16 in a series, has
been merged before any of the other patches in the series.  I have
reverted that commit.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Jul_2008_22_25_28_+1000_ExoozYY/ENnpcRiK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyCzgACgkQjjKRsyhoI8yojACcDVtsntcsfDNO7xbqF+W2reIG
yJ0An1et/D1PIvSpeisIrGdELm4zpv0/
=S0yo
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Jul_2008_22_25_28_+1000_ExoozYY/ENnpcRiK--
