Message-ID: <3980DA65.21B92C52@ivey.uwo.ca>
Date: Thu, 27 Jul 2000 20:57:09 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: problems with linuxthreads under your latest glibc 15C rpms
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

I am comparing your src rpms for linuxthreads and noticed that your glibc 2.1.3
-15c has a bug in its implementation of pthread_mutex_trylock.

I don't think anyone *ever* tests the native threads changes made to glibc!

Here is the code snippet:

int __pthread_mutex_trylock(pthread_mutex_t * mutex)
{
  pthread_descr self;
  int retcode;

  switch(mutex->__m_kind) {
  case PTHREAD_MUTEX_FAST_NP:
    retcode = __pthread_trylock(&mutex->__m_lock);
    mutex->__m_owner = thread_self();
    return retcode;
  case PTHREAD_MUTEX_RECURSIVE_NP:
    self = thread_self();
    if (mutex->__m_owner == self) {
      mutex->__m_count++;
      return 0;
    }
    retcode = __pthread_trylock(&mutex->__m_lock);
    if (retcode == 0) {
      mutex->__m_owner = self;
      mutex->__m_count = 0;
    }
    return retcode;
  case PTHREAD_MUTEX_ERRORCHECK_NP:
    retcode = __pthread_trylock(&mutex->__m_lock);
    if (retcode == 0) {
      mutex->__m_owner = thread_self();
    }
    return retcode;
  default:
    return EINVAL;
  }
}


Notice that under the typical mutex case PTHREAD_MUTEX_FAST_NP, the call to
__pthread_trylock is made and the owner is set to be the current thread without
even checking the retcode.  If someone else owns the lock, __pthread_trylock
will return EBUSY and the code shound not change the owner of the lock!!!!!


In fact, the only real differences in linuxthreads code between glibc-2.1.3-5a
and glibc-2.1.3-15c  are to keep track of the owner under the FAST_NP lock.

All of these changes should be removed. Unless, someone has changed the spec,
the lock owner should only be kept track of when using the ERRORCHECK_NP mutex
type.

In fact, that is exactly what the ERRORCHECK mutex type is for.  If you compare
the code from the FAST_NP case and the ERRORCHECK_NP case, you will see the
ERRORCHECK case tests the retcode before setting the owner.

I have not had a chance to check the remainder of the changes in linuxthreads,
but this one screamed at me when I saw it.

Perhaps you could remove the 15c rpms before they get out there too much.

I will check for other mistakes in the changes and send you a patch to fix any
other mistakes I find.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
