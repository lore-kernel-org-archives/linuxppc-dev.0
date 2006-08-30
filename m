Return-Path: <herbert@gondor.apana.org.au>
Received: from arnor.apana.org.au (rhun.apana.org.au [64.62.148.172])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FB55679E1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 21:42:55 +1000 (EST)
Date: Wed, 30 Aug 2006 21:09:20 +1000
To: Joy Latten <latten@austin.ibm.com>, paulus@au.ibm.com, anton@au.ibm.com,
	linuxppc-dev@ozlabs.org
Subject: Re: IPSec kernel oops on ppc64
Message-ID: <20060830110920.GA19926@gondor.apana.org.au>
References: <200608282225.k7SMPF80022173@faith.austin.ibm.com>
	<20060829013023.GA5865@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060829013023.GA5865@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Cc: jmorris@redhat.com, gcwilson@us.ibm.com, davem@davemloft.net,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi:

Thanks to some excellent info from Joy, I've trakced the problem down to
a broken implementation of memmove on ppc64, which in turn is due to a
broken memcpy.

Both memmove and memcpy need to return the destination pointer as per
the C standard.  The ppc64 version of memcpy returns a pointer to the
last byte copied instead.  Since memmove degenerates into memcpy in
some cases, this makes it broken as well.

Something like the following patch should fix the problem.  Be warned
that I know absolutely nothing about ppc assembly so don't come back
to me if this patch eats your disk :)

BTW, I spotted a couple of typos in memcpy_64.S/copyuser_64.S where
"cmpldi cr1,..." became "cmpldi r1,...".  So please fix that up while
you ppc64 guys are at it.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index fd66acf..9e8d9e7 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -11,6 +11,7 @@ #include <asm/ppc_asm.h>
 
 	.align	7
 _GLOBAL(memcpy)
+	std	r3,-8(r1)
 	mtcrf	0x01,r5
 	cmpldi	cr1,r5,16
 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
@@ -53,7 +54,8 @@ _GLOBAL(memcpy)
 2:	bf	cr7*4+3,3f
 	rotldi	r9,r9,8
 	stb	r9,0(r3)
-3:	blr
+3:	ld	r3,-8(r1)
+	blr
 
 .Lsrc_unaligned:
 	srdi	r6,r5,3
@@ -167,4 +169,5 @@ _GLOBAL(memcpy)
 3:	bf	cr7*4+3,4f
 	lbz	r0,0(r4)
 	stb	r0,0(r3)
-4:	blr
+4:	ld	r3,-8(r1)
+	blr
