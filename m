Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CADC2C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 04:13:38 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Sun, 3 Mar 2013 03:07:12 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 09A5A2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 04:13:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r22H0rtc50790404
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Mar 2013 04:00:53 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r22HDVCc008885
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Mar 2013 04:13:33 +1100
Message-ID: <513232B6.9060905@linux.vnet.ibm.com>
Date: Sat, 02 Mar 2013 22:41:18 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH V2] lglock: add read-preference local-global rwlock
References: <512BBAD8.8010006@linux.vnet.ibm.com>
 <CACvQF51jCxk5jUqmhD=QBBtUsBkQWZzakacrKO4Gsk=w61rNwQ@mail.gmail.com>
 <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com>	<5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <5131FB4C.7070408@cn.fujitsu.com>
In-Reply-To: <5131FB4C.7070408@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Cc: Lai Jiangshan <eag0628@gmail.com>, linux-doc@vger.kernel.org,
 peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 Michel Lespinasse <walken@google.com>, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, vincent.guittot@linaro.org, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2013 06:44 PM, Lai Jiangshan wrote:
> From 345a7a75c314ff567be48983e0892bc69c4452e7 Mon Sep 17 00:00:00 2001
> From: Lai Jiangshan <laijs@cn.fujitsu.com>
> Date: Sat, 2 Mar 2013 20:33:14 +0800
> Subject: [PATCH] lglock: add read-preference local-global rwlock
> 
> Current lglock is not read-preference, so it can't be used on some cases
> which read-preference rwlock can do. Example, get_cpu_online_atomic().
> 
[...]
> diff --git a/kernel/lglock.c b/kernel/lglock.c
> index 6535a66..52e9b2c 100644
> --- a/kernel/lglock.c
> +++ b/kernel/lglock.c
> @@ -87,3 +87,71 @@ void lg_global_unlock(struct lglock *lg)
>  	preempt_enable();
>  }
>  EXPORT_SYMBOL(lg_global_unlock);
> +
> +#define FALLBACK_BASE	(1UL << 30)
> +
> +void lg_rwlock_local_read_lock(struct lgrwlock *lgrw)
> +{
> +	struct lglock *lg = &lgrw->lglock;
> +
> +	preempt_disable();
> +	if (likely(!__this_cpu_read(*lgrw->reader_refcnt))) {
> +		rwlock_acquire_read(&lg->lock_dep_map, 0, 0, _RET_IP_);
> +		if (unlikely(!arch_spin_trylock(this_cpu_ptr(lg->lock)))) {
> +			read_lock(&lgrw->fallback_rwlock);
> +			__this_cpu_write(*lgrw->reader_refcnt, FALLBACK_BASE);
> +			return;
> +		}
> +	}
> +
> +	__this_cpu_inc(*lgrw->reader_refcnt);
> +}
> +EXPORT_SYMBOL(lg_rwlock_local_read_lock);
> +
> +void lg_rwlock_local_read_unlock(struct lgrwlock *lgrw)
> +{
> +	switch (__this_cpu_read(*lgrw->reader_refcnt)) {
> +	case 1:
> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> +		lg_local_unlock(&lgrw->lglock);
> +		return;

This should be a break, instead of a return, right?
Otherwise, there will be a preempt imbalance...

> +	case FALLBACK_BASE:
> +		__this_cpu_write(*lgrw->reader_refcnt, 0);
> +		read_unlock(&lgrw->fallback_rwlock);
> +		rwlock_release(&lg->lock_dep_map, 1, _RET_IP_);
> +		break;
> +	default:
> +		__this_cpu_dec(*lgrw->reader_refcnt);
> +		break;
> +	}
> +
> +	preempt_enable();
> +}


Regards,
Srivatsa S. Bhat
