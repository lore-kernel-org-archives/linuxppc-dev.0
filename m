Message-Id: <v03110702b5b8b58b5cb8@[216.209.101.72]>
In-Reply-To: <3992EAE6.27CF4490@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 10 Aug 2000 15:43:04 -0400
To: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>,
        Franz.Sirl-kernel@lauterbach.com, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: PPC Versions of Glibc and GCC Status
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

There is a mutex bug in the glibc 15d rpms that Blackdown found and sent to
the libc-alpha list.  It prevented linuxthread 15c and 15d rpms from
working correctly.  Please try with Franz's glibc-2.1.3-5a rpms, they work
fine for the jdk.  I will pass the patch along to Franz and hopefully there
will be a 15e rpm set out that should work fine for you (it does for the
JDK anyway).

I have attached the patch which you can use to make your own 15e rpm until
Franz gets a chance.

Hope this helps.

Kevin

RCS file: /cvs/glibc/libc/linuxthreads/mutex.c,v
retrieving revision 1.9.2.4
diff -u -r1.9.2.4 mutex.c
--- mutex.c     2000/07/31 15:31:21     1.9.2.4
+++ mutex.c     2000/08/09 21:43:57
@@ -109,8 +109,8 @@
 {
   switch (mutex->__m_kind) {
   case PTHREAD_MUTEX_FAST_NP:
-    __pthread_unlock(&mutex->__m_lock);
     mutex->__m_owner = NULL;
+    __pthread_unlock(&mutex->__m_lock);
     return 0;
   case PTHREAD_MUTEX_RECURSIVE_NP:
     if (mutex->__m_count > 0) {


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
