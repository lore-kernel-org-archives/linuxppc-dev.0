Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 51DD92C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 06:32:37 +1100 (EST)
Message-ID: <1358883152.21576.55.camel@gandalf.local.home>
Subject: Re: [PATCH v5 01/45] percpu_rwlock: Introduce the global
 reader-writer lock backend
From: Steven Rostedt <rostedt@goodmis.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Tue, 22 Jan 2013 14:32:32 -0500
In-Reply-To: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
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

On Tue, 2013-01-22 at 13:03 +0530, Srivatsa S. Bhat wrote:
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

I thought global locks are now fair. That is, a reader will block if a
writer is waiting. Hence, the above should deadlock on the current
rwlock_t types.

We need to fix those locations (or better yet, remove all rwlocks ;-)

-- Steve
