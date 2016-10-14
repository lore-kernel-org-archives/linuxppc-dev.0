Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swWF53C8BzDt3H
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Oct 2016 02:08:03 +1100 (AEDT)
Received: by mail-yb0-x243.google.com with SMTP id 184so2363541yby.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 08:08:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 14 Oct 2016 11:07:57 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161014150757.GA11102@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
 <87a8eb5dwa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87a8eb5dwa.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

On Tue, Oct 11, 2016 at 10:22:13PM +1100, Michael Ellerman wrote:
> The oops happens because we're in enqueue_task_fair() and p->se->cfs_rq
> is NULL.
> 
> The cfs_rq is NULL because we did set_task_rq(p, 2048), where 2048 is
> NR_CPUS. That causes us to index past the end of the tg->cfs_rq array in
> set_task_rq() and happen to get NULL.
> 
> We never should have done set_task_rq(p, 2048), because 2048 is >=
> nr_cpu_ids, which means it's not a valid CPU number, and set_task_rq()
> doesn't cope with that.

Hmm... it doesn't reproduce it here and can't see how the commit would
affect this given that it doesn't really change when the kworker
kthreads are being created.

> Presumably we shouldn't be ending up with tsk_cpus_allowed() being
> empty, but I haven't had time to track down why that's happening.

Can you please add WARN_ON_ONCE(!tsk_nr_cpus_allowed(p)) to
select_task_rq() and post what that says?

Thanks.

-- 
tejun
