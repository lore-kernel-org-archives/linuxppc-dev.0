Message-ID: <3D914574.7030300@uow.edu.au>
Date: Wed, 25 Sep 2002 15:11:16 +1000
From: Ben Stanley <bds02@uow.edu.au>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] remove #ifdef __KERNEL__ from atomic.h
Content-Type: multipart/mixed;
 boundary="------------060603060004090505070803"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060603060004090505070803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I was trying to compile sumji (formerly xtunes), which requires
libCommonC++. I found that libCommonC++ would not compile, because it
needs to use the atomic functions declared in include/asm-ppc/atomic.h .
However, this file does not declare these functions unless __KERNEL__ is
defined. I believe that this is incorrect.

I have checked the i386 and s390 versions of atomic.h and they declare
the atomic functions regardless of the status of the __KERNEL__ macro.
Therefore I propose that it should be removed from asm-ppc/atomic.h, and
have attached a patch to effect this.

With this patch applied, I am able to compile libCommonC++.

Ben Stanley.


--------------060603060004090505070803
Content-Type: text/plain;
 name="atomic_ppc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_ppc.patch"

--- include/asm-ppc/atomic.h.orig	Wed Sep 25 07:49:12 2002
+++ include/asm-ppc/atomic.h	Wed Sep 25 07:49:32 2002
@@ -10,8 +10,6 @@

 typedef struct { volatile int counter; } atomic_t;

-#ifdef __KERNEL__
-
 #define ATOMIC_INIT(i)	{ (i) }

 #define atomic_read(v)		((v)->counter)
@@ -181,5 +179,4 @@
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()

-#endif /* __KERNEL__ */
 #endif /* _ASM_PPC_ATOMIC_H_ */

--------------060603060004090505070803--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
