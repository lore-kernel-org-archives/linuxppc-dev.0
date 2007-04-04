Return-Path: <Valdis.Kletnieks@vt.edu>
Received: from h80ad278e.async.vt.edu (h80ad278e.async.vt.edu [128.173.39.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "foo-bar-baz.cc.vt.edu",
	Issuer "foo-bar-baz.cc.vt.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 192A2DDE3D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 14:25:27 +1000 (EST)
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
In-Reply-To: Your message of "Tue, 03 Apr 2007 16:09:08 PDT."
	<20070403230908.GA13471@cynthia.pants.nu>
From: Valdis.Kletnieks@vt.edu
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403230908.GA13471@cynthia.pants.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1175652638_3426P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 03 Apr 2007 22:10:38 -0400
Message-ID: <7641.1175652638@turing-police.cc.vt.edu>
Cc: Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--==_Exmh_1175652638_3426P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Apr 2007 16:09:08 PDT, Brad Boyer said:

> an abstraction of "serial port" as far as the user is concerned. On
> Solaris, I can say "/dev/term/a" and know that I will get the first
> serial port if it is available without needing to care if it is the
> zs, se or asy driver talking to the hardware.

This is fine if you're trying to boot and find your system console.

It blows complete chunks if the port you're trying to find is the
first port on the special serial card that supports speeds above 115kbaud
because we have a real-time constraint, and even at 115k you fall short
on the timing budget (actual real-life issue we hit on an SGI running IRIX
a number of years ago. Blowing the budget often resulted in a 3,000 pound
motion base to turn into a 3,000 pound jackhammer:

http://www.sv.vt.edu/future/cave/resprj/crane/crane_thor/2001FebReport.html
http://www.moog.com/Media/1/6D2000E500-395_1102.pdf

--==_Exmh_1175652638_3426P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFGEwkecC3lWbTT17ARAt+/AJsEXZc092CXe711oEorreqIhQ1lgwCgt3oe
G2HMPG6AlTfyN9KI/MszxWM=
=UDo1
-----END PGP SIGNATURE-----

--==_Exmh_1175652638_3426P--
