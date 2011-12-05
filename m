Return-Path: <sven@narfation.org>
Received: from v3-1039.vlinux.de (narfation.org [79.140.41.39])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C5F1A100967
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 18:57:43 +1100 (EST)
From: Sven Eckelmann <sven@narfation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Mon, 05 Dec 2011 08:57:27 +0100
Message-ID: <3836467.I5Tqg6MFf9@sven-laptop.home.narfation.org>
In-Reply-To: <1323038515.11728.26.camel@pasglop>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <20111204221850.GC14542@n2100.arm.linux.org.uk>
 <1323038515.11728.26.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1410499.ht9VK84Yej";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Arnd Bergma nn <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-arm-kernel@lists.in,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, user-mode-linux-devel@lists.sourceforge.net,
 Jeff Dike <jdike@addtoit.com>, linux-alpha@vger.kernel.org,
 Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, fradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
 linux-m32r@ml.linux-m32r.org, linux-parisc@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>,
 Kyle McMartin <kyle@mcmartin.ca>, Richard Weinberger <richard@nod.at>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Hirokazu Takata <takata@linux-m32r.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart1410499.ht9VK84Yej
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Monday 05 December 2011 09:41:55 Benjamin Herrenschmidt wrote:
> On Sun, 2011-12-04 at 22:18 +0000, Russell King - ARM Linux wrote:
> 
>  .../...
> 
> > And really, I believe it would be a good cleanup if all the standard
> > definitions for atomic64 ops (like atomic64_add_negative) were also
> > defined in include/linux/atomic.h rather than individually in every
> > atomic*.h header throughout the kernel source, except where an arch
> > wants to explicitly override it.  Yet again, virtually all architectures
> > define these in exactly the same way.
> > 
> > We have more than enough code in arch/ for any architecture to worry
> > about, we don't need schemes to add more when there's simple and
> > practical solutions to avoiding doing so if the right design were
> > chosen (preferably from the outset.)
> > 
> > So, I'm not going to offer my ack for a change which I don't believe
> > is the correct approach.
> 
> I agree with Russell, his approach is a lot easier to maintain long run,
> we should even consider converting existing definitions.

I would rather go with "the existing definitions have to converted" and this 
means "not by this patch". At the moment, the atomic64 stuff exist only as 
separate generic or arch specific implementation. It is fine that Russell King 
noticed that people like Arun Sharma did a lot of work to made it true for 
atomic_t, but atomic64_t is a little bit different right now (at least as I 
understand it).

Kind regards,
	Sven
--nextPart1410499.ht9VK84Yej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO3HlnAAoJEF2HCgfBJntGIwEP+wbmx8RBe4+2rxtioZSWADVS
WTLVEVXMSXyL/WFdHGHydFJouj+fsSCSeLiqUq64xJF0J/zUZiT5YZNcqc67bG0I
D/m3R1NSDP8Rzuxs8xeCpMaG6Iy2AcaHL+FBHotuWZ4bGgvUDZioti3wt9UFJPar
JOUBH3BowE007CtAlEc0i5pMu0YGAvu1Y2OlGuSAdernpzsSkfsL+B9ArK5rrpgT
0YaP8HWLFnjclXES0jgoad5exyh+ItgQltR/yGIOTU0zyIsv/3mtwIUw0/K0ZTGX
U/UgN6KWLyxmDW0wCr6QseA73mqT5SyAxFmCRzsDbyZTSXgEr6qZIWxLzr7kQNet
ki2ZdeyjIWuklCWqvrjStrIY1+Q3dAzh0P7q75/INBCujMio3LqdsmaPaIvyJdzr
R6Q5xzsOtkqUVZYKscBJfHah2fzuEJ04ulfAda7OarzQynA2FvP+Wb7MP+Z1NNby
7lDV1AyhHqiWh6gPey7GJJ5qQqMsJn2ladR68rt74GyULv7XHJ6fhzDx6CUYk35K
2MPFB2O66C6UI1osCbJWxYeuO2myGtRwWo4MLJ6w4UGqBEV4k5x3TBUlHg5fDdJR
lhGVpPrS/1CzOh8tMCyiRWADxN1wYyIGTVMyY7SbF/iLfECGQeqPYDcIhgzjDBB9
eaY9hfOs3nyq/zSRPmrD
=esnW
-----END PGP SIGNATURE-----

--nextPart1410499.ht9VK84Yej--
