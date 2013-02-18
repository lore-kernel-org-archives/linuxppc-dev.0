Return-Path: <walken@google.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE0B22C0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 02:59:05 +1100 (EST)
Received: by mail-ie0-f178.google.com with SMTP id c13so7259536ieb.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 07:59:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123913.26245.7713.stgit@srivatsabhat.in.ibm.com>
Date: Mon, 18 Feb 2013 23:51:41 +0800
Message-ID: <CANN689Ec4g7jMapv8ChAEom+gEDQ8RDVLa07CKwJ==YO+MUUrA@mail.gmail.com>
Subject: Re: [PATCH v6 07/46] percpu_rwlock: Allow writers to be readers, and
 add lockdep annotations
From: Michel Lespinasse <walken@google.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2013 at 8:39 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> @@ -200,6 +217,16 @@ void percpu_write_lock_irqsave(struct percpu_rwlock *pcpu_rwlock,
>
>         smp_mb(); /* Complete the wait-for-readers, before taking the lock */
>         write_lock_irqsave(&pcpu_rwlock->global_rwlock, *flags);
> +
> +       /*
> +        * It is desirable to allow the writer to acquire the percpu-rwlock
> +        * for read (if necessary), without deadlocking or getting complaints
> +        * from lockdep. To achieve that, just increment the reader_refcnt of
> +        * this CPU - that way, any attempt by the writer to acquire the
> +        * percpu-rwlock for read, will get treated as a case of nested percpu
> +        * reader, which is safe, from a locking perspective.
> +        */
> +       this_cpu_inc(pcpu_rwlock->rw_state->reader_refcnt);

I find this quite disgusting, but once again this may be because I
don't like unfair recursive rwlocks.

In my opinion, the alternative of explicitly not taking the read lock
when one already has the write lock sounds *much* nicer.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
