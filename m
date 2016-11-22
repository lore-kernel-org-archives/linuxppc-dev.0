Return-Path: <ronny.meeus@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNRZh0qK0zDvy2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 00:46:20 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id f201so2607840oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:46:20 -0800 (PST)
MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 22 Nov 2016 14:45:56 +0100
Message-ID: <CAMJ=MEc-QFMjOHiYYnitt0o08bVsL+kNrqsqRb=qTES0Vk44dw@mail.gmail.com>
Subject: Application code deadlock observed.
To: linuxppc-dev@lists.ozlabs.org
Cc: Ronny Meeus <ronny.meeus@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello

We have board running Linux kernel 2.6.36.4 on a Freescale/NXP PPC
P4080 (QorIQ) CPU.
Our 32 bit application uses real-time priority threads with the
Preemptible Kernel (Low-Latency Desktop) scheduling.
Toolchain we use is powerpc-linux-gcc (crosstool-NG 1.19.0) 4.4.3 in
combination with eglibc 2.10.
Although the CPU has multiple cores, all threads are bound to a fixed
core (so no migration of threads over cores).

Next to that we use an open-souce component Xenomai to have a pSOS
skin emulation. This component implements round-robin scheduling for
equal priority threads by running the threads in FIFO mode and
starting a timer per thread (based on CLOCK_THREAD_CPUTIME_ID). In the
signal handler sched_yield is called to release the CPU.

Very sporadically we see an issue that our code enters a deadlock
state because a non-recursive mutex is taken again by the same thread.
This has been confirmed by carefully investigating the coredump that
we could generate when the board was in such a state.
After screening the involved code several times by different people we
were not able to identify a bug in the application SW, so the mutex
was always released correctly before returning from the function, it
was not taken recursively in the code itself etc.

We actually see the same issue in 2 completely distinct places in the
code and in both places the application code looks OK.

During the investigation of the kernel/library code I came across
following comment (in the c-library call setcontext):

        /*
         * If this ucontext refers to the point where we were interrupted
         * by a signal, we have to use the rt_sigreturn system call to
         * return to the context so we get both LR and CTR restored.
         *
         * Otherwise, the context we are restoring is either just after
         * a procedure call (getcontext/swapcontext) or at the beginning
         * of a procedure call (makecontext), so we don't need to restore
         * r0, xer, ctr.  We don't restore r2 since it will be used as
         * the TLS pointer.
         */

It is not completely clear how I should read it, but it made me think
that there could be something wrong here (or in the kernel).

Could it be possible that because of the signals, hitting the
application code at random places, the currently executing function is
just "restarted"?
To be more clear: at the moment the thread wakes up again (after the
sche_yield called from the signal handler), it returns from the signal
handler and jumps back to the beginning of the function instead of to
the place where it got interrupted ...

If this would be possible, the issues that we see could be explained.


Best regards,
Ronny
