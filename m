Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 508A7DDF31
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:01:42 +1000 (EST)
Date: Thu, 7 Jun 2007 12:08:16 -0500
To: paulus@samba.org
Subject: [PATCH] powerpc: Don't use long for 32-bit temp variables in spin
	lock ops
Message-ID: <20070607170816.GA4273@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The spinlock ops have long as their return type (as well as for some
of the temporary types internally). All locks are 32-bit, so it makes
no sense to do 64-bit ops on them.

For example, this is how my compiler built _spin_lock() for me:

c0000000004b2050:       li      r0,0
c0000000004b2054:       stb     r0,460(r13)
c0000000004b2058:       lwz     r0,8(r13)
c0000000004b205c:       lwarx   r9,0,r3
c0000000004b2060:       cmpwi   r9,0
c0000000004b2064:       bne-    c0000000004b2078 <._spin_lock+0x28>
c0000000004b2068:       stwcx.  r0,0,r3
c0000000004b206c:       nop
c0000000004b2070:       bne+    c0000000004b205c <._spin_lock+0xc>
c0000000004b2074:       isync
c0000000004b2078:       cmpdi   cr7,r9,0
c0000000004b207c:       .long 0x4dfe0020
c0000000004b2080:       mr      r1,r1
c0000000004b2084:       lwz     r0,0(r3)
c0000000004b2088:       cmpdi   cr7,r0,0
c0000000004b208c:       bne+    cr7,c0000000004b2080 <._spin_lock+0x30>
c0000000004b2090:       mr      r2,r2
c0000000004b2094:       b       c0000000004b2058 <._spin_lock+0x8>

Note the cmpdi at ..78 when r9 was loaded with lwarx.

Unfortunately I haven't found a way to get rid of the duplicate
comparison alltogether.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6.21/include/asm-powerpc/spinlock.h
===================================================================
--- 2.6.21.orig/include/asm-powerpc/spinlock.h
+++ 2.6.21/include/asm-powerpc/spinlock.h
@@ -53,9 +53,9 @@
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
  */
-static __inline__ unsigned long __spin_trylock(raw_spinlock_t *lock)
+static __inline__ unsigned int __spin_trylock(raw_spinlock_t *lock)
 {
-	unsigned long tmp, token;
+	unsigned int tmp, token;
 
 	token = LOCK_TOKEN;
 	__asm__ __volatile__(
@@ -179,9 +179,9 @@ extern void __raw_spin_unlock_wait(raw_s
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
  */
-static long __inline__ __read_trylock(raw_rwlock_t *rw)
+static int __inline__ __read_trylock(raw_rwlock_t *rw)
 {
-	long tmp;
+	int tmp;
 
 	__asm__ __volatile__(
 "1:	lwarx		%0,0,%1\n"
@@ -203,9 +203,9 @@ static long __inline__ __read_trylock(ra
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
  */
-static __inline__ long __write_trylock(raw_rwlock_t *rw)
+static __inline__ int __write_trylock(raw_rwlock_t *rw)
 {
-	long tmp, token;
+	int tmp, token;
 
 	token = WRLOCK_TOKEN;
 	__asm__ __volatile__(
@@ -263,7 +263,7 @@ static int __inline__ __raw_write_tryloc
 
 static void __inline__ __raw_read_unlock(raw_rwlock_t *rw)
 {
-	long tmp;
+	int tmp;
 
 	__asm__ __volatile__(
 	"# read_unlock\n\t"
