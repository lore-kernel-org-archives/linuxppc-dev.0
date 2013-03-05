Return-Path: <laijs@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id A0A7A2C0320
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 02:25:13 +1100 (EST)
Message-ID: <51360ED1.3030104@cn.fujitsu.com>
Date: Tue, 05 Mar 2013 23:27:13 +0800
From: Lai Jiangshan <laijs@cn.fujitsu.com>
MIME-Version: 1.0
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH V2] lglock: add read-preference local-global rwlock
References: <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <5131FB4C.7070408@cn.fujitsu.com> <20130302172003.GC29769@redhat.com>
In-Reply-To: <20130302172003.GC29769@redhat.com>
Content-Type: text/plain; charset=UTF-8
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

On 03/03/13 01:20, Oleg Nesterov wrote:
> On 03/02, Lai Jiangshan wrote:
>>
>> +void lg_rwlock_local_read_unlock(struct lgrwlock *lgrw)
>> +{
>> +	switch (__this_cpu_read(*lgrw->reader_refcnt)) {
>> +	case 1:
>> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
>> +		lg_local_unlock(&lgrw->lglock);
>> +		return;
>> +	case FALLBACK_BASE:
>> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
>> +		read_unlock(&lgrw->fallback_rwlock);
>> +		rwlock_release(&lg->lock_dep_map, 1, _RET_IP_);
> 
> I guess "case 1:" should do rwlock_release() too.

Already do it in "lg_local_unlock(&lgrw->lglock);" before it returns.
(I like reuse old code)

> 
> Otherwise, at first glance looks correct...
> 
> However, I still think that FALLBACK_BASE only adds the unnecessary
> complications. But even if I am right this is subjective of course, please
> feel free to ignore.

OK, I kill FALLBACK_BASE in later patch.

> 
> And btw, I am not sure about lg->lock_dep_map, perhaps we should use
> fallback_rwlock->dep_map ?

Use either one is OK.

> 
> We need rwlock_acquire_read() even in the fast-path, and this acquire_read
> should be paired with rwlock_acquire() in _write_lock(), but it does
> spin_acquire(lg->lock_dep_map). Yes, currently this is the same (afaics)
> but perhaps fallback_rwlock->dep_map would be more clean.
> 

I can't tell which one is better. I try to use fallback_rwlock->dep_map later.

> Oleg.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
