Message-ID: <3C7122FAF06DD5118ED600500473364802649571@esply01.cnt.com>
From: Bret Ketchum <bret_ketchum@cnt.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: PPC pthread_spin_init appears broken.
Date: Fri, 5 Sep 2003 08:17:22 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Scanning through a couple of glibc sources (Redhat 2.3.2-11.9
and Yellow Dog 2.3.1-51a) it appears that pthread_spin_init is broken
for the PPC, at least the 32 bit variety. pthread_spin_init initializes the
lock
to '1' but pthread_spin_lock calls compare_and_wait looking for a '0' as the

old value, to be swapped for a '1' when the old value is read. This can't
happen
(without forcing the lock to '0') as the lock was first set to a '1' in
pthread_spin_init.

	Any enlightenment will be appreciated.

Code fragments from Redhat 2.3.2-11.9 below:

glibc-2.3.2-20030313/linuxthreads/sysdeps/powerpc/powerpc32/pt-machine.h

PT_EI int
__compare_and_swap (long int *p, long int oldval, long int newval)
{
  int ret;

  __asm__ __volatile__ (
           "0:    lwarx %0,0,%1 ;"
           "      xor. %0,%3,%0;"
           "      bne 1f;"
           "      stwcx. %2,0,%1;"
           "      bne- 0b;"
           "1:    "
        : "=&r"(ret)
        : "r"(p), "r"(newval), "r"(oldval)
        : "cr0", "memory");
  /* This version of __compare_and_swap is to be used when acquiring
     a lock, so we don't need to worry about whether other memory
     operations have completed, but we do need to be sure that any loads
     after this point really occur after we have acquired the lock.  */
  __asm__ __volatile__ ("isync" : : : "memory");
  return ret == 0;
}

glibc-2.3.2-20030313/linuxthreads/sysdeps/powerpc/pspinlock.c
int
__pthread_spin_lock (pthread_spinlock_t *lock)
{
  while (! __compare_and_swap ((long int *)lock, 0, 1))
    ;
  return 0;
}

int
__pthread_spin_unlock (pthread_spinlock_t *lock)
{
  MEMORY_BARRIER ();
  *lock = 0;
  return 0;
}

int
__pthread_spin_init (pthread_spinlock_t *lock, int pshared)
{
  /* We can ignore the `pshared' parameter.  Since we are busy-waiting
     all processes which can access the memory location `lock' points
     to can use the spinlock.  */
  *lock = 1;
  return 0;
}


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
