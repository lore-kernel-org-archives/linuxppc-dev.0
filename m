Return-Path: <rcjenn@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8165DDE05
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jan 2007 09:55:14 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0EMt4AR030418
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 17:55:04 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l0EMt4cW527996
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 15:55:04 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0EMt3P7006728
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 15:55:03 -0700
Date: Sun, 14 Jan 2007 16:55:02 -0600
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] atomic_dec_if_positive sign extension fix
Message-ID: <20070114225502.GA21471@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: olof@lixom.net, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paulus,

Please apply for 2.6.20.  If an atomic counter is explicitly set to a
negative value the atomic_dec_if_positive function will decrement and
store the next smallest value in the atomic counter contrary to it's
intended operation.  

The comparison to determine if the decrement will make the result
negative is done by the "addic." operation which operates on a 64-bit
value.  Since the counter is 32-bit, we need to sign-extend before
the signed 64-bit addition and compare.  Adding 'extsw' just before
'addic.' will correct this.  

Also, I clarify the return value in the comments just to make it clear
that the value returned is always the decremented value, even if that
value is not stored back to the atomic counter.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
---

 atomic.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-powerpc/atomic.h b/include/asm-powerpc/atomic.h
index 53283e2..6238307 100644
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
@@ -216,6 +217,7 @@ static __inline__ int atomic_dec_if_posi
 	__asm__ __volatile__(
 	LWSYNC_ON_SMP
 "1:	lwarx	%0,0,%1		# atomic_dec_if_positive\n\
+	extsw	%0,%0\n\
 	addic.	%0,%0,-1\n\
 	blt-	2f\n"
 	PPC405_ERR77(0,%1)
