Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0481667B5E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 02:41:51 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k85GflAq032389
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 12:41:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k85GflFI341722
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 10:41:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k85GfkTr027870
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 10:41:47 -0600
Date: Tue, 5 Sep 2006 11:41:46 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
Message-ID: <20060905164146.GA7139@austin.ibm.com>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060905120817.e52857ee.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 05, 2006 at 12:08:17PM +1000, Stephen Rothwell wrote:
> @@ -273,25 +234,30 @@ #define iobarrier_w()  eieio()
>   * These routines do not perform EEH-related I/O address translation,
>   * and should not be used directly by device drivers.  Use inb/readb
>   * instead.
> + *
> + * For some of these, we force the target/source register to be
> + * r0 to ease decoding on iSeries.

???
Why?

>  static inline int in_8(const volatile unsigned char __iomem *addr)
>  {
> -	int ret;
> +	register unsigned int ret __asm__("r0");

Such as here .. why is this being forced ??

> -	__asm__ __volatile__("lbz%U1%X1 %0,%1; twi 0,%0,0; isync"
> -			     : "=r" (ret) : "m" (*addr));
> +	__asm__ __volatile__("lbzx %0,0,%1; twi 0,%0,0; isync"
> +			     : "=r" (ret) : "r" (addr));

Why make this change? The old code allows the compiler to optimize
better than the new code.  One might argue that, in the grand scheme of
things, i/o is very slow, so a few cycles here doesn't matter much.
But still, I don't understand why this change is needed.

> +static inline void memset_io(volatile void __iomem *addr, int c,
> +                                 unsigned long n)
> +{
> +	if (firmware_has_feature(FW_FEATURE_ISERIES))
> +		iSeries_memset_io(addr, c, n);
> +	else
> +		eeh_memset_io(addr, c, n);
> +}

!! I think it would be much better to have this be a compile-time
check rather than a run-time check. No only does it save cycles, 
but it makes the iSeries kernel smaller (by not needing eeh code 
in it) and the p-series code smaller (by not compiling iseries
code into it. 


--linas
