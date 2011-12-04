Return-Path: <sven@narfation.org>
Received: from v3-1039.vlinux.de (narfation.org [79.140.41.39])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DC8C01007D6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2011 09:42:57 +1100 (EST)
From: Sven Eckelmann <sven@narfation.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Re: Re: [PATCHv5] atomic: add *_dec_not_zero
Date: Sun, 04 Dec 2011 23:42:47 +0100
Message-ID: <2181790.72pQvQZ7mR@sven-laptop.home.narfation.org>
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
References: <1323013369-29691-1-git-send-email-sven@narfation.org>
 <1699880.NTdz2k3W9O@sven-laptop.home.narfation.org>
 <20111204221850.GC14542@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3657609.EYmP6sRycV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 Helge Deller <deller@gmx.de>, sparclinux@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Hirokazu Takata <takata@linux-m32r.org>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergma nn <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
 linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nextPart3657609.EYmP6sRycV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 December 2011 22:18:50 Russell King - ARM Linux wrote:
> On Sun, Dec 04, 2011 at 10:49:10PM +0100, Sven Eckelmann wrote:
> > On Sunday 04 December 2011 21:33:16 Russell King - ARM Linux wrote:
> > [...]
> > 
> > > > +#define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1LL,
> > > > 0LL)
> > > 
> > > I think this is rather silly - all these definitions are very
> > > similar to each other.  Is there really no way to put this into
> > > include/linux/atomic.h, maybe as something like:
> > > 
> > > #ifndef atomic64_dec_not_zero
> > > #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> > > #endif
> > > 
> > > and avoid having to add essentially the same definition to 12
> > > individual files?
> > > 
> > > Architectures which want to override it can do by the following:
> > > 
> > > #define atomic64_dec_not_zero		atomic64_dec_not_zero
> > > 
> > > which won't have any effect on C nor asm code.
> >  
> >  * https://lkml.org/lkml/2011/5/8/15
> >  * https://lkml.org/lkml/2011/5/8/16
> >  * https://lkml.org/lkml/2011/5/8/321
> 
> I don't see any reason in that set of messages _not_ to do what I suggest.
> Even on SMP architectures, your:
> 
> #define atomic64_dec_not_zero(v)	atomic64_add_unless((v), -1, 0)
> 
> makes total sense - and with the adjustments I've suggested it means
> that architectures (like x86) can still override it if have a more
> optimal way to perform this operation.
> 
> Not only that, but we already do this kind of thing in
> include/linux/atomic.h for the non-64 bit ops, for example:
> 
> #ifndef atomic_inc_unless_negative
> static inline int atomic_inc_unless_negative(atomic_t *p)
> {
>         int v, v1;
>         for (v = 0; v >= 0; v = v1) {
>                 v1 = atomic_cmpxchg(p, v, v + 1);
>                 if (likely(v1 == v))
>                         return 1;
>         }
>         return 0;
> }
> #endif
> 
> And really, I believe it would be a good cleanup if all the standard
> definitions for atomic64 ops (like atomic64_add_negative) were also
> defined in include/linux/atomic.h rather than individually in every
> atomic*.h header throughout the kernel source, except where an arch
> wants to explicitly override it.  Yet again, virtually all architectures
> define these in exactly the same way.
> 
> We have more than enough code in arch/ for any architecture to worry
> about, we don't need schemes to add more when there's simple and
> practical solutions to avoiding doing so if the right design were
> chosen (preferably from the outset.)
> 
> So, I'm not going to offer my ack for a change which I don't believe
> is the correct approach.

Ok, I wanted to say that I just did what is currently done and did not offer a 
redesign. There is just a difference between adding something and replacing 
everything with something else. But I am fine with not getting the ack because 
now somebody at least made a statement.

Kind regards,
	Sven
--nextPart3657609.EYmP6sRycV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO2/dnAAoJEF2HCgfBJntGyQ0QAIBBy0k5Ojh2hoFJjUN3q8eQ
vZBnCgn1UKsHdR+ZzytDM+uRDynaUUdu5UbSIOwJRs+r9rfjWROlRffX3YadvzO4
0jOfcA7SF2pIPmrEKAMr01f3dBtvu6EdTCLm8kZKCUGopEPXGz12MuD2Y+Eil4yD
S/ygNYFug9o3xhSZ7HJ6ms/3KFuS6yOy2lrnr8ASZ18F98/Y970YlBC3yxTDQP31
FHarn2wiNx0GcQh367skpe7Dev0dKT2+NWUQ4kQ8CinG+S9/pk9vGNnx8gByLtd/
pAx3KGF6RhUWD8OoGgZUGkSosJJM18bpgRk7ms5iScbAxX5TGs+DT47nFw6qRyn+
4pAxECzmWoLdnqNxSaFX7D2ow8OIH5eZnRJObWbkjTIGvySlCOzJdfVSZ/HdPq+w
mqvlODmgWrA5dvizMQpYxZ1JdLVoLZ/5tK2OM+r18dw0H9Qn1HMqjJ8yNYCJFlfn
UwfqdOkXi+UxOCDjZhPxjqWl1uTG54TwFQaMsyZP3YtnB9AcIr0NGAYAocl9mW0S
0lrYVt87X9HOtf8ndkDbJu4EWz+vGFIMn1SuWkpbhVKQZ96Q6/RmhTiOzj6NCTY7
sEWiX3ralejgfHqwjxze0zCkNbFFIVyePq0Y63fNq9TTf8/CNpIbCl01YBBZ315v
l+QWfR8ALrDtInryuh9G
=WCs5
-----END PGP SIGNATURE-----

--nextPart3657609.EYmP6sRycV--
