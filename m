Return-Path: <latten@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D28CD67B71
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Sep 2006 01:07:22 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7VF7FYS003873
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 11:07:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7VF7Fq8341180
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 09:07:15 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7VF7FKE003771
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 09:07:15 -0600
Date: Thu, 31 Aug 2006 09:55:58 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200608311455.k7VEtwUI011729@faith.austin.ibm.com>
To: paulus@samba.org
Subject: Re: IPSec kernel oops on ppc64
Cc: jmorris@redhat.com, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
	anton@au1.ibm.com, linuxppc-dev@ozlabs.org, gcwilson@us.ibm.com,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It works! I applied the patch to 
linux-2.6.17 + patch-2.6.17-rc1
and tried icmp, tcp and udp as well as sftp with 
ipsec and they all worked. 

Thanks!!!!

Regards,
Joy

>Herbert Xu writes:
>
>> Interesting.  We were previously off by 28 bytes, now we're off by 8 :)
>
>You missed a couple of 'beqlr' instructions (branch if equal to LR).
>I'd be interested to know if it still fails with the patch below.
>
>Thanks,
>Paul.
>
>diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
>index fd66acf..7173ba9 100644
>--- a/arch/powerpc/lib/memcpy_64.S
>+++ b/arch/powerpc/lib/memcpy_64.S
>@@ -11,6 +11,7 @@ #include <asm/ppc_asm.h>
> 
> 	.align	7
> _GLOBAL(memcpy)
>+	std	r3,48(r1)	/* save destination pointer for return value */
> 	mtcrf	0x01,r5
> 	cmpldi	cr1,r5,16
> 	neg	r6,r3		# LS 3 bits = # bytes to 8-byte dest bdry
>@@ -38,7 +39,7 @@ _GLOBAL(memcpy)
> 	stdu	r9,16(r3)
> 	bdnz	1b
> 3:	std	r8,8(r3)
>-	beqlr
>+	beq	3f
> 	addi	r3,r3,16
> 	ld	r9,8(r4)
> .Ldo_tail:
>@@ -53,7 +54,8 @@ _GLOBAL(memcpy)
> 2:	bf	cr7*4+3,3f
> 	rotldi	r9,r9,8
> 	stb	r9,0(r3)
>-3:	blr
>+3:	ld	r3,48(r1)	/* return dest pointer */
>+	blr
> 
> .Lsrc_unaligned:
> 	srdi	r6,r5,3
>@@ -115,7 +117,7 @@ _GLOBAL(memcpy)
> 5:	srd	r12,r9,r11
> 	or	r12,r8,r12
> 	std	r12,24(r3)
>-	beqlr
>+	beq	4f
> 	cmpwi	cr1,r5,8
> 	addi	r3,r3,32
> 	sld	r9,r9,r10
>@@ -167,4 +169,5 @@ _GLOBAL(memcpy)
> 3:	bf	cr7*4+3,4f
> 	lbz	r0,0(r4)
> 	stb	r0,0(r3)
>-4:	blr
>+4:	ld	r3,48(r1)	/* return dest pointer */
>+	blr
