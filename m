Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x22b.google.com (mail-qc0-x22b.google.com
 [IPv6:2607:f8b0:400d:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0CEDD2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 03:55:46 +1000 (EST)
Received: by mail-qc0-f171.google.com with SMTP id n1so6631301qcw.30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 10:55:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2013 10:55:35 -0700
From: Tejun Heo <tj@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 22/45] percpu_counter: Use get/put_online_cpus_atomic()
 to prevent CPU offline
Message-ID: <20130624175535.GA1918@mtj.dyndns.org>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134256.19094.99231.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130623134256.19094.99231.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, Al Viro <viro@zeniv.linux.org.uk>, namhyung@kernel.org,
 tglx@linutronix.de, laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 23, 2013 at 07:12:59PM +0530, Srivatsa S. Bhat wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
> offline, while invoking from atomic context.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
...
> @@ -98,6 +98,7 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  	s64 ret;
>  	int cpu;
>  
> +	get_online_cpus_atomic();
>  	raw_spin_lock(&fbc->lock);
>  	ret = fbc->count;
>  	for_each_online_cpu(cpu) {
> @@ -105,6 +106,7 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>  		ret += *pcount;
>  	}
>  	raw_spin_unlock(&fbc->lock);
> +	put_online_cpus_atomic();

I don't think this is necessary.  CPU on/offlining is explicitly
handled via the hotplug callback which synchronizes through fbc->lock.
__percpu_counter_sum() racing with actual on/offlining doesn't affect
correctness and adding superflous get_online_cpus_atomic() around it
can be misleading.

Thanks.

-- 
tejun
