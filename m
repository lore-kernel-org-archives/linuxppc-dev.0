Return-Path: <rcjenn@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6FCFADDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 05:16:12 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0GIG7vM030957
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 13:16:07 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0GIG7SB276556
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 13:16:07 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0GIG5F5019524
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 13:16:07 -0500
Date: Tue, 16 Jan 2007 12:16:05 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, olof@lixom.net, paulus@samba.org
Subject: Re: [PATCH][v2] atomic_dec_if_positive sign extension fix
Message-ID: <20070116181604.GA24756@austin.ibm.com>
References: <20070114225502.GA21471@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070114225502.GA21471@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Here is v.2 for the patch. 
Please apply for 2.6.20.  If an atomic counter is explicitly set to a
negative value the atomic_dec_if_positive function will decrement and
store the next smallest value in the atomic counter contrary to it's
intended operation.

The comparison to determine if the decrement will make the result
negative is done by the "addic." operation which operates on a 64-bit
value.  I've changed the addic to an addi (changing "=&r" to "=&g" in
the process so that r0 isn't used, and addi doesn't become li) and 
done a cmpwi prior to the add.  By comparing prior to the add I can 
pick up the case for 0x80000000, so that it is considered positive.

Also, I clarify the return value in the comments just to make it clear
that the value returned is always the decremented value, even if that
value is not stored back to the atomic counter.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---

 atomic.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


diff --git a/include/asm-powerpc/atomic.h b/include/asm-powerpc/atomic.h
index 53283e2..f6f7e5f 100644
--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -207,7 +207,8 @@ #define atomic_dec_and_test(v)		(atomic_
 
 /*
  * Atomically test *v and decrement if it is greater than 0.
- * The function returns the old value of *v minus 1.
+ * The function returns the old value of *v minus 1, even if
+ * the atomic variable, v, was not decremented.
  */
 static __inline__ int atomic_dec_if_positive(atomic_t *v)
 {
@@ -216,14 +217,15 @@ static __inline__ int atomic_dec_if_posi
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
+2:"	: "=&g" (t)
 	: "r" (&v->counter)
 	: "cc", "memory");
 
