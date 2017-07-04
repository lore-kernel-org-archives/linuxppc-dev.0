Return-Path: <eguan@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x22vF2Yx0zDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 22:12:41 +1000 (AEST)
Date: Tue, 4 Jul 2017 20:12:36 +0800
From: Eryu Guan <eguan@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: tj@kernel.org, Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
Message-ID: <20170704121236.GO23360@eguan.usersys.redhat.com>
References: <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <8760fdrdq1.fsf@concordia.ellerman.id.au>
 <20170630114756.GD23360@eguan.usersys.redhat.com>
 <87tw2syayk.fsf@concordia.ellerman.id.au>
 <20170704082101.GM23360@eguan.usersys.redhat.com>
 <87r2xwxxyo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87r2xwxxyo.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 04, 2017 at 09:06:55PM +1000, Michael Ellerman wrote:
> Eryu Guan <eguan@redhat.com> writes:
> 
> > On Tue, Jul 04, 2017 at 04:26:11PM +1000, Michael Ellerman wrote:
> >> Eryu Guan <eguan@redhat.com> writes:
> >> > On Fri, Jun 30, 2017 at 08:07:02PM +1000, Michael Ellerman wrote:
> >> >> 
> >> >> Can you try this patch and see if it changes anything? (with the debug
> >> >> still applied).
> >> >
> >> > This patch fixes the crash for me. After appliying this patch (with all
> >> > other debug patches still applied), kernel didn't print any warnings or
> >> > calltraces or debug messages.
> >> 
> >> OK. It's not meant to fix it :)
> >
> > Understand.
> >
> >> 
> >> I can't form any connection between your bisection result and that
> >> patch, nothing is making any sense TBH.
> >> 
> >> What hardware are you on? And are you doing CPU hotplug or anything like that?
> >
> > It's a "PowerVM" guest (I'm not familiar with powerpc, I don't know what
> > does that mean..) running on Power8 host. I didn't do any CPU hotplug or
> > anything like that.
> 
> OK thanks.
> 
> We might have to try and sync up on irc so we can debug this a bit faster.

Sure, where can I find you? I'm in #xfs at freenode, nick eguan. But
maybe tomorrow, I have to take off today.

> 
> Can you try this hunk also?

This new WARN_ON didn't trigger (I skipped the other warning messages,
they're the same warnings as in my last reply).

Thanks,
Eryu

> 
> cheers
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index c74bf39ef764..7c55721b1f1d 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3902,6 +3906,7 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>  		     "ordering guarantee broken for workqueue %s\n", wq->name);
>  		return ret;
>  	} else {
> +		WARN_ON(cpumask_empty(unbound_std_wq_attrs[highpri]->cpumask));
>  		return apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
>  	}
>  }
> 
> 
