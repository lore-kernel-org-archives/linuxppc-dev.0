Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0132.outbound.protection.outlook.com [157.56.110.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A5A71A0C56
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 05:32:57 +1000 (AEST)
Message-ID: <1432323162.27761.274.camel@freescale.com>
Subject: Re: [PATCH v3 2/2] powerpc: add support for csum_add()
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Fri, 22 May 2015 14:32:42 -0500
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
 <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CB3D471@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-22 at 15:57 +0000, David Laight wrote:
> From: Linuxppc-dev Christophe Leroy
> > Sent: 19 May 2015 16:19
> ...
> > diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
> > index 5e43d2d..e8d9ef4 100644
> > --- a/arch/powerpc/include/asm/checksum.h
> > +++ b/arch/powerpc/include/asm/checksum.h
> > @@ -130,6 +130,22 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
> >  	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
> >  }
> > 
> > +#define HAVE_ARCH_CSUM_ADD
> > +static inline __wsum csum_add(__wsum csum, __wsum addend)
> > +{
> > +#ifdef __powerpc64__
> > +	u64 res = (__force u64)csum;
> > +
> > +	res += (__force u64)addend;
> > +	return (__force __wsum)((u32)res + (res >> 32));
> > +#else
> > +	asm("addc %0,%0,%1;"
> > +	    "addze %0,%0;"
> > +	    : "+r" (csum) : "r" (addend));
> > +	return csum;
> > +#endif
> 
> I'd have thought it better to test for the cpu type where you want the
> 'asm' variant, and then fall back on the C version for all others.
> I know (well suspect) there are only two cases here.

Usually it's more readable to see "if (x) ... else ..." than "if (!
x) ... else ..." and 64-bit is what has a symbol defined.

> I'd also have thought that the 64bit C version above would be generally 'good'.

It doesn't generate the addc/addze sequence.  At least with GCC 4.8.2,
it does something like:

	mr	tmp0, csum
	li	tmp1, 0
	li	tmp2, 0
	addc	tmp3, addend, tmp0
	adde	csum, tmp2, tmp1
	add	csum, csum, tmp3

-Scott
