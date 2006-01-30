Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (kleinhenz.com [213.239.205.196])
	by ozlabs.org (Postfix) with ESMTP id 5A4EE68A02
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2006 01:09:28 +1100 (EST)
Message-ID: <43DE181D.7040204@hogyros.de>
Date: Mon, 30 Jan 2006 14:43:57 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] remove check for ELF offset in powerpc bootimage
References: <20060130132803.GA31263@suse.de>
In-Reply-To: <20060130132803.GA31263@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig828BBCB03BDA577BCDEC9CB4"
Cc: linuxppc-dev@ozlabs.org, Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig828BBCB03BDA577BCDEC9CB4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Olaf Hering wrote:

> Is this check really needed, are there PT_LOAD sections with offset
> zero (either zImage or vmlinux)? I see an offset which is always 64k.

Sure, an offset of zero is completely legal (obviously, the start 
address would then be different from the load address of that segment).

Without context, I would say this loop is used to find some loadable 
segment that does not include the ELF header. I cannot think of any 
application for that, as it is certainly acceptable to merge LOAD 
segments, and the segment it is looking for could have been merged with 
the segment that includes the header.

If the current linker scripts specify that loading the header is 
unneeded, this means that all LOAD headers will have nonzero offsets. 
But I wouldn't count on that forever.[1]

    Simon

[1] the Amiga bootloader, for example, assumes that all segments are to 
be loaded, so things broke badly on APUS when the ldscript did not 
remove the .note.gnu-stack section, which has a VMA of zero as it is 
never loaded anyway. So depending on things being a particular way is 
bad. :-)

--------------enig828BBCB03BDA577BCDEC9CB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ94YH1Yr4CN7gCINAQJz9gP+Le52BFj7hseQbqSzVj6IbaZ0WXOr1UvY
RxbrKKfzoSnTKHSVteKAsIXL8XTImvUV7WlkDiAf62MmxrNNaQ8GkKYxQ+iBxtZC
/9S56p55M44MybUD63EaOrFYV640WWMYSE2qFpER0g9TXBXVI6gASWhpgnTxQtG4
mhT6poO4oqc=
=U5h1
-----END PGP SIGNATURE-----

--------------enig828BBCB03BDA577BCDEC9CB4--
