Date: Sat, 2 Sep 2000 12:12:18 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: pppd modem problem (2.4.0-test7 lombard)
Message-ID: <20000902121218.B16589@cheops.usf.Uni-Osnabrueck.DE>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi ppc Developers,
recently tried Pauls devel tree, because I wanted to check=20
fresh code for the Zyxel Omninet USB TA.

Thanks to Ben and Franz for documenting the changes of the input layer
(it took me a bit to get the stuff working, but it would have been
impossible without the hints.)

Anyway I ran into a different problem:
pppd does not work as before. When I boot with the old kernel and run
over the modem, everything is fine.

Using the same config does not work on the new 2.4.0-test7
kernel. To my knowledge the kernel configuration has all the ppp
stuff activated. I did not change this part from Paul's config.

I am using pppd 2.3.10 and
it starts sending the first
	send [LCP ConfReq id=3D0x1 <asyncmap .....

but does not see any result. This message is repeated a couple of time
before it gets a SIGHUP. (Of course the remote probably closed
the connection.) Then pppd tries to send two other user requests
and exits with and Input-Output Error.
This looks like this (without the debug messages):
Sep  2 11:24:04 albunea pppd[597]: pppd 2.3.10 started by root, uid 0
Sep  2 11:24:04 albunea pppd[597]: Using interface ppp0
Sep  2 11:24:04 albunea pppd[597]: Connect: ppp0 <--> /dev/ttyS0

Sep  2 11:24:26 albunea pppd[597]: Hangup (SIGHUP)

Sep  2 11:24:32 albunea pppd[597]: Connection terminated.
Sep  2 11:24:32 albunea pppd[597]: tcflush failed: Input/output error
Sep  2 11:24:32 albunea pppd[597]: Exit.


I also have the problem that after that sometimes, the ttS0 port cannot
be opened anymore.

Am I missing something obvious here?

	Bernhard
--=20
Professional Service around Free Software                (intevation.net) =
=20
The FreeGIS Project				            (freegis.org)
Association for a Free Informational Infrastructure            (ffii.org)

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature
Content-Disposition: inline


--eheScQNz3K90DVRs--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
