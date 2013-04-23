Return-Path: <devurandom@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by ozlabs.org (Postfix) with ESMTP id 8C6222C012A
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 23:34:32 +1000 (EST)
Received: from mailout-de.gmx.net ([10.1.76.32]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MXkSn-1TyZxR3K11-00Wpz2 for
 <linuxppc-dev@ozlabs.org>; Tue, 23 Apr 2013 15:29:26 +0200
From: Dennis Schridde <devurandom@gmx.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only iterate over online nodes in
 cbe_init_pm_irq()
Date: Tue, 23 Apr 2013 15:29:24 +0200
Message-ID: <4782415.9d2Yfidhkm@ernie>
In-Reply-To: <20130423130218.GD27200@concordia>
References: <1366719291-29414-1-git-send-email-michael@ellerman.id.au>
 <2343936.gRCKd0qRgh@ernie> <20130423130218.GD27200@concordia>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1417025.WQ8pZlOI0N";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart1417025.WQ8pZlOI0N
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello!

Please find an up-to-date dmesg log attached. It was created from a Linux 
3.8.8 kernel with these two patches applied:
-       for_each_node(node) {
+       for_each_online_node(node) {

-		return distance;
+		return ((a == b) ? LOCAL_DISTANCE : REMOTE_DISTANCE);

More information on the setup (incl. config and lspci) can be found in:
Subject: PROBLEM: Only 2 of 4 cores used on IBM Cell blades and no threads 
shown in spufs
Message-ID: <1470334.YUWOQ37ijW@ernie>

Am Dienstag, 23. April 2013, 23:02:19 schrieb Michael Ellerman:
> On Tue, Apr 23, 2013 at 02:45:50PM +0200, Dennis Schridde wrote:
> This is probably not good, but I'll have to compare to an old kernel to
> be sure. Have you noticed that PCI is broken in any way?

How do I find out?

The only thing I noticed (and someone else, who has been contacting me about 
cellminer questions recently) is that there might be something weird going on 
with the network.
For example, on RHEL5 we had issues with NFS loosing connection to the server 
(the x86-64 server directly in the same rack).
And now me and the other guy notice that the connection to the Eligius bitcoin 
mining pool is a bit flakey - apparently not transmitting all our work.
But this might also be caused by bugs in cellminer or Ruby - and the RHEL5 
issue is very certainly not related, since now on Gentoo/Linux, with a current 
kernel, the problem is gone.

--Dennis
--nextPart1417025.WQ8pZlOI0N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEABECAAYFAlF2jLQACgkQjqfyF1DtJW5GSwCcC/T8HGg17abfQcUeAsVUB0KM
jEEAn2drZPG04BJCdlNsPRTr43Bagj0P
=bIjq
-----END PGP SIGNATURE-----

--nextPart1417025.WQ8pZlOI0N--
