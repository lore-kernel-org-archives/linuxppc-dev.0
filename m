Return-Path: <jdmason@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A3E8679F6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 06:39:42 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4FKdeiU031551
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 16:39:40 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FKddr2273344
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 14:39:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FKdd2u027414
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 14:39:39 -0600
Date: Mon, 15 May 2006 15:38:15 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: jschopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] remove powerpc bitops infavor of existing generic bitops
Message-ID: <20060515203815.GC17646@us.ibm.com>
References: <20060515180108.GB17646@us.ibm.com>
	<4468DCDD.5090609@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4468DCDD.5090609@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 15, 2006 at 02:56:13PM -0500, jschopp wrote:
> >There already exists a big endian safe bitops implementation in
> >lib/find_next_bit.c.  The code in it is 90%+ common with the powerpc
> >specific version, so the powerpc version is redundant.  This patch
> >makes the necessary changes to use the generic bitops in powerpc, and
> >removes the powerpc specific version.
> 
> I like generic as much as the next guy, but I'm also a big fan of fast 
> bitops.  And the function below is fast.  You'll have to explain to me how 
> the generic code is going to find the first zero as fast without explicit 
> calls to ppc assembly.
> 
> >-static inline unsigned int ext2_ilog2(unsigned int x)
> >-{
> >-	int lz;
> >-
> >-	asm("cntlzw %0,%1": "=r"(lz):"r"(x));
> >-	return 31 - lz;
> >-}

Ah but here's the trick, there is the same explicit call to ppc
assembly.  The only function in the file removed is this one you pointed
out, and the only caller of this function is ext2_ffz.  And the only
user of ext2_ffz is find_next_zero_le_bit.  

Now the generic code is very similar to the file removed (`diff -Narup
arch/powerpc/lib/bitops.c lib/find_next_bit.c` to see for yourself).  In
the same place where ext2_ffz is called, ffz is called in the generic
code.  Now if we look at the definition of ffz in
include/asm-powerpc/bitops.h, we see it calls __ilog2 of that same file.
__ilog2 is defined as: 

static __inline__ int __ilog2(unsigned long x)
{
        int lz;

        asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (x));
        return BITS_PER_LONG - 1 - lz;
}

So, its really the same code :)

Thanks,
Jon
