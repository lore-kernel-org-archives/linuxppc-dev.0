Date: Mon, 20 Aug 2001 11:47:42 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Airport driver sleep problem and solution
Message-ID: <20010820114742.J22957@localhost.localdomain>
References: <Pine.LNX.4.33.0108200926520.27201-100000@andromeda.dsdk12.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHh0aNzodMFDTGdO"
In-Reply-To: <Pine.LNX.4.33.0108200926520.27201-100000@andromeda.dsdk12.net>; from dpates@dsdk12.net on Mon, Aug 20, 2001 at 09:38:15AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--wHh0aNzodMFDTGdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Derrik Pates spake unto us the following wisdom:
> I recently found that, if the Airport card in an iBook I've been running
> Linux on was not brought "up" at the time the system was put to sleep (by
> putting the lid down), after bringing it back out of sleep, it would no
> longer correctly operate until the driver was removed and reloaded -
> ifconfig would receive an ENODEV error, and iwconfig would report that the
> device had no wireless extensions. I found that the problem is on line 179
> of linux/drivers/net/wireless/airport.c (v0.06f, in 2.4.9-benh0), where
> the driver only calls "netif_device_attach" if card->open is TRUE - but it
> unconditionally calls "netif_device_detach" in the PBOOK_SLEEP_NOW case.
> Line 179 should be changed from "else if (card->open)" to just "else", so
> that the network device is "reattached" to the networking subsystem.

Spectacular!  I've had this trouble as well, and I solved it my just
leaving my Airport card configured all the time, regardless of whether
I was on a network or not.  I'm glad to see a real fix.  :-)
Ethan

--=20
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

--wHh0aNzodMFDTGdO
Content-Type: application/pgp-signature
Content-Disposition: inline


--wHh0aNzodMFDTGdO--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
