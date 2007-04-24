Return-Path: <olof@lixom.net>
Date: Tue, 24 Apr 2007 18:07:08 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] 64K page support for kexec
Message-ID: <20070424230708.GA10401@lixom.net>
References: <1177439513.24866.5.camel@luke-laptop>
	<20070424194348.GA8371@lixom.net>
	<1177455014.14873.144.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177455014.14873.144.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 08:50:14AM +1000, Benjamin Herrenschmidt wrote:
> 
> > This assumes that the page sizes are ordered. Why not just iterate from
> > 0 to MMU_PAGE_COUNT?
> 
> You don't want to hit MMU_PAGE_4K which is guaranteed to be 0 ... maybe
> just having an if (size == MMU_PAGE_4K) continue; statement in the loop
> would be better ?

Either that, or from 1 to MMU_PAGE_COUNT (with a comment as to why we're skipping
0).

> > > +	/*
> > > +	 * FIXME, this could be made more efficient by storing the type 
> > > +	 * of hash algorithm in mmu_psize_defs[].  The code below assumes 
> > > +	 * the number of bits in the va representing the offset in the
> > > +	 * page is less than 23. This affects the hash algorithm that is
> > > +	 * used. When 16G pages are supported, a new hash algorithm
> > > +	 * needs to be provided.  See POWER ISA Book III.
> > > +	 *
> > > +	 * The code below works for 16M, 64K, and 4K pages.
> > > +	 */
> > 
> > A BUG_ON() when other sizes are hit could be a good idea?
> 
> a BUG_ON if the B bit is set would be useful too. (that is 1T segment
> HPTE).

Yep.

> > > @@ -408,8 +453,9 @@ static void native_hpte_clear(void)
> > >  		 * already hold the native_tlbie_lock.
> > >  		 */
> > >  		if (hpte_v & HPTE_V_VALID) {
> > > +			hpte_decode(hptep, slot, &psize, &hpte_v);
> > >  			hptep->v = 0;
> > > -			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
> > > +			__tlbie(hpte_v, psize);
> > 
> > Using hpte_v as variable name is a bit misleading.  avpn or va would be
> > a better variable name.
> 
> No. The variable doesn't contain only the va, it contains the whole "V"
> part of the HPTE which includes other things like the valid bit.

Ok. The previous usage was confusing me (given that they did a translation
from hpte_v to va, or at least that's what the function name implies).


-Olof
