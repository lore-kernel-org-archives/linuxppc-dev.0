Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5D3A52C03E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 03:43:19 +1100 (EST)
Date: Tue, 5 Mar 2013 17:41:06 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH V2] lglock: add read-preference local-global rwlock
Message-ID: <20130305164106.GA4329@redhat.com>
References: <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <5131FB4C.7070408@cn.fujitsu.com> <20130302172003.GC29769@redhat.com>
 <51360ED1.3030104@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51360ED1.3030104@cn.fujitsu.com>
Cc: Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, fweisbec@gmail.com,
 Michel Lespinasse <walken@google.com>, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, sbw@mit.edu,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/05, Lai Jiangshan wrote:
>
> On 03/03/13 01:20, Oleg Nesterov wrote:
> > On 03/02, Lai Jiangshan wrote:
> >>
> >> +void lg_rwlock_local_read_unlock(struct lgrwlock *lgrw)
> >> +{
> >> +	switch (__this_cpu_read(*lgrw->reader_refcnt)) {
> >> +	case 1:
> >> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> >> +		lg_local_unlock(&lgrw->lglock);
> >> +		return;
> >> +	case FALLBACK_BASE:
> >> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> >> +		read_unlock(&lgrw->fallback_rwlock);
> >> +		rwlock_release(&lg->lock_dep_map, 1, _RET_IP_);
> >
> > I guess "case 1:" should do rwlock_release() too.
>
> Already do it in "lg_local_unlock(&lgrw->lglock);" before it returns.
> (I like reuse old code)

Yes, I was wrong thanks. Another case when I didn't notice that you
re-use the regular lg_ code...

> > We need rwlock_acquire_read() even in the fast-path, and this acquire_read
> > should be paired with rwlock_acquire() in _write_lock(), but it does
> > spin_acquire(lg->lock_dep_map). Yes, currently this is the same (afaics)
> > but perhaps fallback_rwlock->dep_map would be more clean.
>
> I can't tell which one is better. I try to use fallback_rwlock->dep_map later.

I am not sure which one should be better too, please check.

Again, I forgot that _write_lock/unlock use lg_global_*() code.

Oleg.
