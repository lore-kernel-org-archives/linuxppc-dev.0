Return-Path: <htejun@gmail.com>
Received: from mail-qc0-x22c.google.com (mail-qc0-x22c.google.com
 [IPv6:2607:f8b0:400d:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 171102C02BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 04:06:47 +1000 (EST)
Received: by mail-qc0-f172.google.com with SMTP id j10so6630684qcx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 11:06:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2013 11:06:36 -0700
From: Tejun Heo <tj@kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 22/45] percpu_counter: Use get/put_online_cpus_atomic()
 to prevent CPU offline
Message-ID: <20130624180636.GB1918@mtj.dyndns.org>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134256.19094.99231.stgit@srivatsabhat.in.ibm.com>
 <20130624175535.GA1918@mtj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130624175535.GA1918@mtj.dyndns.org>
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

On Mon, Jun 24, 2013 at 10:55:35AM -0700, Tejun Heo wrote:
> > @@ -105,6 +106,7 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
> >  		ret += *pcount;
> >  	}
> >  	raw_spin_unlock(&fbc->lock);
> > +	put_online_cpus_atomic();
> 
> I don't think this is necessary.  CPU on/offlining is explicitly
> handled via the hotplug callback which synchronizes through fbc->lock.
> __percpu_counter_sum() racing with actual on/offlining doesn't affect
> correctness and adding superflous get_online_cpus_atomic() around it
> can be misleading.

Ah, okay, so you added a debug feature which triggers warning if
online mask is accessed without synchronization.  Yeah, that makes
sense and while the above is not strictly necessary, it probably is
better to just add it rather than suppressing the warning in a
different way.  Can you please at least add a comment explaining that?

Thanks.

-- 
tejun
