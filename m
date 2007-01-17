Return-Path: <rcjenn@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA799DDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 03:50:28 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0HGoLhS025221
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 11:50:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0HGoLUh261376
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 11:50:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0HGoLvH003333
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 11:50:21 -0500
Date: Wed, 17 Jan 2007 10:50:20 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, olof@lixom.net
Subject: Re: [PATCH][v3] atomic_dec_if_positive sign extension fix
Message-ID: <20070117165020.GA26387@austin.ibm.com>
References: <20070114225502.GA21471@austin.ibm.com>
	<20070116181604.GA24756@austin.ibm.com>
	<20070116200838.GA22381@iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070116200838.GA22381@iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank you Gabriel for pointing out the correct constraint.

Paul, 

Here is v3 of the patch.  Please apply for 2.6.20.

If an atomic counter is explicitly set to a negative value the
atomic_dec_if_positive function will decrement and store the next smallest
value in the atomic counter contrary to it's intended operation.

The comparison to determine if the decrement will make the result negative
is done by the "addic." operation which operates on a 64-bit value.
I've changed the addic to an addi (changing "=&r" to "=&b" in the
process so that r0 isn't used, and addi doesn't become li) and done a
cmpwi prior to the add.  By comparing prior to the add I can pick up
the case for 0x80000000, so that it is considered positive.

Also, I clarify the return value in the comments just to make it clear
that the value returned is always the decremented value, even if that
value is not stored back to the atomic counter.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---

 atomic.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


Index: a/include/asm-powerpc/atomic.h
===================================================================
--- a/include/asm-powerpc/atomic.h	2006-11-30 08:57:21.000000000 -0600
+++ b/include/asm-powerpc/atomic.h	2007-01-16 15:10:03.000000000 -0600
@@ -207,7 +207,8 @@
 
 /*
  * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
  */
 static __inline__ int atomic_dec_if_positive(atomic_t *v)
 {
@@ -216,14 +217,15 @@
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
 "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
-	addic.	%0,%0,-1\n\
+	cmpwi	%0,1\n\
+	addi	%0,%0,-1\n\
 	blt-	2f\n"
 	PPC405_ERR77(0,%1)
 "	stwcx.	%0,0,%1\n\
 	bne-	1b"
 	ISYNC_ON_SMP
 	"\n\
-2:"	: "=&r" (t)
+2:"	: "=&b" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
 
