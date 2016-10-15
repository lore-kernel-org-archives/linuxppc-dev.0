Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swmxn50J4zDt4W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 12:25:49 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id qn10so6648977pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 18:25:49 -0700 (PDT)
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
To: Tejun Heo <tj@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
 <20161014150757.GA11102@mtj.duckdns.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, torvalds@linux-foundation.org, kernel-team@fb.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <6b395b55-03a8-38bc-8581-d310e6a0ef65@gmail.com>
Date: Sat, 15 Oct 2016 12:25:50 +1100
MIME-Version: 1.0
In-Reply-To: <20161014150757.GA11102@mtj.duckdns.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 15/10/16 02:07, Tejun Heo wrote:
> Hello, Michael.
> 
> On Tue, Oct 11, 2016 at 10:22:13PM +1100, Michael Ellerman wrote:
>> The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
>> is NULL.
>>
>> The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
>> NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
>> set_task_rq() and happen to get NULL.
>>
>> We never should have done set_task_rq(p, 2048), because 2048 is >=
>> nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
>> doesn't cope with that.
> 
> Hmm... it doesn't reproduce it here and can't see how the commit would
> affect this given that it doesn't really change when the kworker
> kthreads are being created.
> 
>> Presumably we shouldn't be ending up with tsk_cpus_allowed() being
>> empty, but I haven't had time to track down why that's happening.
> 

I think the basic analysis shows the change to creation of unbounded
workqueues from the unbound_hash, but those have a pool cpumask empty.

> Can you please add WARN_ON_ONCE(!tsk_nr_cpus_allowed(p)) to
> select_task_rq() and post what that says?
> 
> Thanks.
> 

Balbir Singh.
