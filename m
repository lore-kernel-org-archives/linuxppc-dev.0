Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Bug: early_pfn_in_nid() called when not early
Date: Thu, 14 Dec 2006 00:37:51 +0100
References: <200612131920.59270.arnd@arndb.de>
	<20061213231717.GC10708@monkey.ibm.com>
In-Reply-To: <20061213231717.GC10708@monkey.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612140037.53477.arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Michael Kravetz <mkravetz@us.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 December 2006 00:17, Mike Kravetz wrote:
> Thanks for the debug work! =A0Just curious if you really need
> CONFIG_NODES_SPAN_OTHER_NODES defined for your platform? =A0Can you get
> those types of memory layouts? =A0If not, an easy/immediate fix for you
> might be to simply turn off the option.

We want to be able to run the same kernel as pseries, e.g. on
distributions that ship only one kernel. Cell should be able to
live without CONFIG_NODES_SPAN_OTHER_NODES, but that does not solve
the problem for us.

> > --- linux-2.6.orig/mm/page_alloc.c
> > +++ linux-2.6/mm/page_alloc.c
> > @@ -1962,7 +1962,8 @@ void __meminit memmap_init_zone(unsigned
> > =A0=A0=A0=A0=A0=A0for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!early_pfn_valid(pfn))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0conti=
nue;
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!early_pfn_in_nid(pfn, nid))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!slab_is_available() &&
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0!early_pfn_in_nid(pfn, =
nid))
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0conti=
nue;
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0page =3D pfn_to_page(pfn);
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_page_links(page, zone, ni=
d, pfn);
>=20
> I know you don't recommend this as a fix, but it has the interesting
> quality of doing exactly what we want for powerpc. =A0When
> slab_is_available() we are performing a 'memory add' operation
> and there is no need to do the 'pfn_in_nid' check. =A0We know that
> the range of added pages will all be on the same (passed) nid.

Right, that was at least my intention, though I wasn't sure
if pseries can live without the check.

	Arnd <><
