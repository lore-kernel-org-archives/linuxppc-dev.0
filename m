Message-ID: <3980DC45.554DB39D@ivey.uwo.ca>
Date: Thu, 27 Jul 2000 21:05:09 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: problems with linuxthreads under your latest glibc 15C rpms
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

Whoops I forgot to attach the patch to fix this (against your latest
glibc-2.1.3-15c src rpm).

--- linuxthreads/mutex.c.prev   Thu Jul 27 20:57:28 2000
+++ linuxthreads/mutex.c        Thu Jul 27 20:59:06 2000
@@ -50,7 +50,9 @@
   switch(mutex->__m_kind) {
   case PTHREAD_MUTEX_FAST_NP:
     retcode = __pthread_trylock(&mutex->__m_lock);
-    mutex->__m_owner = thread_self();
+    if (retcode == 0) {
+      mutex->__m_owner = thread_self();
+    }
     return retcode;
   case PTHREAD_MUTEX_RECURSIVE_NP:
     self = thread_self();


I will let you know if I find any more funny things.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
