Return-Path: <stephen@networkplumber.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6662F2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 05:45:15 +1100 (EST)
Received: by mail-pa0-f49.google.com with SMTP id bi1so4207907pad.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 10:45:13 -0800 (PST)
Date: Tue, 22 Jan 2013 10:45:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 01/45] percpu_rwlock: Introduce the global
 reader-writer lock backend
Message-ID: <20130122104506.32b4e581@nehalam.linuxnetplumber.net>
In-Reply-To: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 Jan 2013 13:03:22 +0530
"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> wrote:

> A straight-forward (and obvious) algorithm to implement Per-CPU Reader-Writer
> locks can also lead to too many deadlock possibilities which can make it very
> hard/impossible to use. This is explained in the example below, which helps
> justify the need for a different algorithm to implement flexible Per-CPU
> Reader-Writer locks.
> 
> We can use global rwlocks as shown below safely, without fear of deadlocks:
> 
> Readers:
> 
>          CPU 0                                CPU 1
>          ------                               ------
> 
> 1.    spin_lock(&random_lock);             read_lock(&my_rwlock);
> 
> 
> 2.    read_lock(&my_rwlock);               spin_lock(&random_lock);
> 
> 
> Writer:
> 
>          CPU 2:
>          ------
> 
>        write_lock(&my_rwlock);
> 
> 
> We can observe that there is no possibility of deadlocks or circular locking
> dependencies here. Its perfectly safe.
> 
> Now consider a blind/straight-forward conversion of global rwlocks to per-CPU
> rwlocks like this:
> 
> The reader locks its own per-CPU rwlock for read, and proceeds.
> 
> Something like: read_lock(per-cpu rwlock of this cpu);
> 
> The writer acquires all per-CPU rwlocks for write and only then proceeds.
> 
> Something like:
> 
>   for_each_online_cpu(cpu)
> 	write_lock(per-cpu rwlock of 'cpu');
> 
> 
> Now let's say that for performance reasons, the above scenario (which was
> perfectly safe when using global rwlocks) was converted to use per-CPU rwlocks.
> 
> 
>          CPU 0                                CPU 1
>          ------                               ------
> 
> 1.    spin_lock(&random_lock);             read_lock(my_rwlock of CPU 1);
> 
> 
> 2.    read_lock(my_rwlock of CPU 0);       spin_lock(&random_lock);
> 
> 
> Writer:
> 
>          CPU 2:
>          ------
> 
>       for_each_online_cpu(cpu)
>         write_lock(my_rwlock of 'cpu');
> 
> 
> Consider what happens if the writer begins his operation in between steps 1
> and 2 at the reader side. It becomes evident that we end up in a (previously
> non-existent) deadlock due to a circular locking dependency between the 3
> entities, like this:
> 
> 
> (holds              Waiting for
>  random_lock) CPU 0 -------------> CPU 2  (holds my_rwlock of CPU 0
>                                                for write)
>                ^                   |
>                |                   |
>         Waiting|                   | Waiting
>           for  |                   |  for
>                |                   V
>                 ------ CPU 1 <------
> 
>                 (holds my_rwlock of
>                  CPU 1 for read)
> 
> 
> 
> So obviously this "straight-forward" way of implementing percpu rwlocks is
> deadlock-prone. One simple measure for (or characteristic of) safe percpu
> rwlock should be that if a user replaces global rwlocks with per-CPU rwlocks
> (for performance reasons), he shouldn't suddenly end up in numerous deadlock
> possibilities which never existed before. The replacement should continue to
> remain safe, and perhaps improve the performance.
> 
> Observing the robustness of global rwlocks in providing a fair amount of
> deadlock safety, we implement per-CPU rwlocks as nothing but global rwlocks,
> as a first step.
> 
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

We got rid of brlock years ago, do we have to reintroduce it like this?
The problem was that brlock caused starvation.
