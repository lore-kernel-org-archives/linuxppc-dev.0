Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070424194348.GA8371@lixom.net>
References: <1177439513.24866.5.camel@luke-laptop>
	<20070424194348.GA8371@lixom.net>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 08:50:14 +1000
Message-Id: <1177455014.14873.144.camel@localhost.localdomain>
Mime-Version: 1.0
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


> This assumes that the page sizes are ordered. Why not just iterate from
> 0 to MMU_PAGE_COUNT?

You don't want to hit MMU_PAGE_4K which is guaranteed to be 0 ... maybe
just having an if (size == MMU_PAGE_4K) continue; statement in the loop
would be better ?

> > +			if (!mmu_psize_defs[size].shift)
> > +				continue;
> 
> A comment to the effect of "unused entries have a shift value of 0" could be
> useful.
> 
> > +			if (penc == mmu_psize_defs[size].penc)
> > +				break;
> > +		}
> > +	}
> >  
> > -		vpi = ((va >> 28) ^ pteg) & htab_hash_mask;
> > +	/*
> > +	 * FIXME, this could be made more efficient by storing the type 
> > +	 * of hash algorithm in mmu_psize_defs[].  The code below assumes 
> > +	 * the number of bits in the va representing the offset in the
> > +	 * page is less than 23. This affects the hash algorithm that is
> > +	 * used. When 16G pages are supported, a new hash algorithm
> > +	 * needs to be provided.  See POWER ISA Book III.
> > +	 *
> > +	 * The code below works for 16M, 64K, and 4K pages.
> > +	 */
> 
> A BUG_ON() when other sizes are hit could be a good idea?

a BUG_ON if the B bit is set would be useful too. (that is 1T segment
HPTE).

> > +	shift = mmu_psize_defs[size].shift;
> > +	if (mmu_psize_defs[size].avpnm)
> > +		avpnm_bits = __ilog2_u64(mmu_psize_defs[size].avpnm) + 1;
> > +	else
> > +		avpnm_bits = 0;
> > +	if (shift - avpnm_bits <= 23) {
> > +		avpn = HPTE_V_AVPN_VAL(hpte_v) << 23;
> > +
> > +		if (shift < 23) {
> > +			unsigned long vpi, pteg;
> > +
> > +			pteg = slot / HPTES_PER_GROUP;
> > +			if (hpte_v & HPTE_V_SECONDARY)
> > +				pteg = ~pteg;
> > +			vpi = ((avpn >> 28) ^ pteg) & htab_hash_mask;
> > +			avpn |= (vpi << mmu_psize_defs[size].shift);
> > +		}
> > +	}
> > +#if 0
> > +	/* 16GB page hash, p > 23 */
> > +	else {
> 
> Same thing here w.r.t. ifdefs
> 
> >  
> > -		va |= vpi << PAGE_SHIFT;
> >  	}
> > +#endif
> >  
> > -	return va;
> > +	*va = avpn;
> > +	*psize = size;
> >  }
> >  
> >  /*
> > @@ -374,8 +420,6 @@ static unsigned long slot2va(unsigned lo
> >   *
> >   * TODO: add batching support when enabled.  remember, no dynamic memory here,
> >   * athough there is the control page available...
> > - *
> > - * XXX FIXME: 4k only for now !
> >   */
> >  static void native_hpte_clear(void)
> >  {
> > @@ -383,6 +427,7 @@ static void native_hpte_clear(void)
> >  	hpte_t *hptep = htab_address;
> >  	unsigned long hpte_v;
> >  	unsigned long pteg_count;
> > +	int psize;
> >  
> >  	pteg_count = htab_hash_mask + 1;
> >  
> > @@ -408,8 +453,9 @@ static void native_hpte_clear(void)
> >  		 * already hold the native_tlbie_lock.
> >  		 */
> >  		if (hpte_v & HPTE_V_VALID) {
> > +			hpte_decode(hptep, slot, &psize, &hpte_v);
> >  			hptep->v = 0;
> > -			__tlbie(slot2va(hpte_v, slot), MMU_PAGE_4K);
> > +			__tlbie(hpte_v, psize);
> 
> Using hpte_v as variable name is a bit misleading.  avpn or va would be
> a better variable name.

No. The variable doesn't contain only the va, it contains the whole "V"
part of the HPTE which includes other things like the valid bit.

Ben.
