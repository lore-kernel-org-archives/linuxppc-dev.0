From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org, Andreas Jaeger <aj@suse.de>,
        Jesper Skov <jskov@cygnus.co.uk>
Subject: Bug in glibc 2.1.3 linuxthreads in pthread_cond_timedwait_relative
Date: Fri, 28 Jan 2000 17:45:14 -0500
Content-Type: text/plain
References: <Pine.LNX.3.95.1000128103100.276B-100000@www.mprojects> <00012814071700.05087@localhost.localdomain> <vtou2jy3t2q.fsf@astra.cs.uni-dortmund.de>
In-Reply-To: <vtou2jy3t2q.fsf@astra.cs.uni-dortmund.de>
MIME-Version: 1.0
Message-Id: <00012814481500.18396@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Checkout the following code piece.  reltime is set by pthread_condtimedwait
before it calls pthread_cond_timedwait_relative_new.

That routine calls nanosleep with reltime and NULL.

If this routine gets an interrupt nanosleep is called again with reltime.

But according to the man page for nanosleep reltime is not changed from before.
If the remaining time is needed the NULL should have been changed in the
nanosleep call.

So if enough interrupts hit this thread within the timeout, it will effectively
always restart itself and hang forever.

I will put together a formal patch but this one was nasty to find since there
have to be enogh signals to keep the thread restarting with the old reltime.



Kevin


static int
pthread_cond_timedwait_relative_new(pthread_cond_t *cond,
                                pthread_mutex_t *mutex,
                                const struct timespec * reltime)
{
  volatile pthread_descr self = thread_self();
  sigset_t unblock, initial_mask;
  int retsleep, already_canceled, was_signalled;
  sigjmp_buf jmpbuf;
  pthread_extricate_if extr;

requeue_and_wait_again:

  retsleep = 0;
  already_canceled = 0;
  was_signalled = 0;

  /* Set up extrication interface */
  extr.pu_object = cond;
  extr.pu_extricate_func = cond_extricate_func;

  /* Register extrication interface */
  __pthread_set_own_extricate_if(self, &extr);

  /* Enqueue to wait on the condition and check for cancellation. */
  __pthread_lock(&cond->__c_lock, self);
  if (!(THREAD_GETMEM(self, p_canceled)
      && THREAD_GETMEM(self, p_cancelstate) == PTHREAD_CANCEL_ENABLE))
    enqueue(&cond->__c_waiting, self);
  else
    already_canceled = 1;
  __pthread_unlock(&cond->__c_lock);

  if (already_canceled) {
    __pthread_set_own_extricate_if(self, 0);
    pthread_exit(PTHREAD_CANCELED);
  }

  pthread_mutex_unlock(mutex);

  /* Set up a longjmp handler for the restart signal, unblock
     the signal and sleep. */

  if (sigsetjmp(jmpbuf, 1) == 0) {
    THREAD_SETMEM(self, p_signal_jmp, &jmpbuf);
    THREAD_SETMEM(self, p_signal, 0);
    /* Unblock the restart signal */
    sigemptyset(&unblock);
    sigaddset(&unblock, __pthread_sig_restart);
    sigprocmask(SIG_UNBLOCK, &unblock, &initial_mask);
    /* Sleep for the required duration */
    retsleep = __libc_nanosleep(reltime, NULL);
    /* Block the restart signal again */
    sigprocmask(SIG_SETMASK, &initial_mask, NULL);
    was_signalled = 0;
  } else {
    retsleep = -1;
    was_signalled = 1;
  }
  THREAD_SETMEM(self, p_signal_jmp, NULL);

  /* Now was_signalled is true if we exited the above code
     due to the delivery of a restart signal.  In that case,
     everything is cool. We have been removed from the queue
     by the other thread, and consumed its signal.

     Otherwise we this thread woke up spontaneously, or due to a signal other
     than restart. The next thing to do is to try to remove the thread
     from the queue. This may fail due to a race against another thread
     trying to do the same. In the failed case, we know we were signalled,
     and we may also have to consume a restart signal. */

  if (!was_signalled) {
    int was_on_queue;

    /* __pthread_lock will queue back any spurious restarts that
       may happen to it. */

    __pthread_lock(&cond->__c_lock, self);
    was_on_queue = remove_from_queue(&cond->__c_waiting, self);
    __pthread_unlock(&cond->__c_lock);

    if (was_on_queue) {
      __pthread_set_own_extricate_if(self, 0);
:   /* __pthread_lock will queue back any spurious restarts that
       may happen to it. */

    __pthread_lock(&cond->__c_lock, self);
    was_on_queue = remove_from_queue(&cond->__c_waiting, self);
    __pthread_unlock(&cond->__c_lock);

    if (was_on_queue) {
      __pthread_set_own_extricate_if(self, 0);
      pthread_mutex_lock(mutex);

      if (retsleep == 0)
        return ETIMEDOUT;
      /* Woken by a signal: resume waiting as
         required by Single Unix Specification. */
      goto requeue_and_wait_again;
    }

    /* Eat the outstanding restart() from the signaller */
:   suspend(self);
  }

  __pthread_set_own_extricate_if(self, 0);

  /* The remaining logic is the same as in other cancellable waits,
     such as pthread_join sem_wait or pthread_cond wait. */

  if (THREAD_GETMEM(self, p_woken_by_cancel)
      && THREAD_GETMEM(self, p_cancelstate) == PTHREAD_CANCEL_ENABLE) {
    THREAD_SETMEM(self, p_woken_by_cancel, 0);
    pthread_mutex_lock(mutex);
    pthread_exit(PTHREAD_CANCELED);
  }

  pthread_mutex_lock(mutex);
  return 0;
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
