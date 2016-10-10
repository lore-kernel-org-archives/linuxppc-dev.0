Return-Path: <htejun@gmail.com>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st0RJ3WCFzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 23:53:15 +1100 (AEDT)
Received: by mail-io0-x242.google.com with SMTP id p26so7308984ioo.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 05:53:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Oct 2016 08:53:03 -0400
From: Tejun Heo <tj@kernel.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, torvalds@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 kernel-team@fb.com, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161010125303.GA29742@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <b0622515-61b9-9622-cca3-d475733eb4a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0622515-61b9-9622-cca3-d475733eb4a6@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 10:17:16PM +1100, Balbir Singh wrote:
> rest_init()
> {
> 	...
> 	kernel_thread(kernel_init, NULL, CLONE_FS);
> 	numa_default_policy();
> 	pid = kernel_thread(kthreadd, NULL, CLONE_FS | CLONE_FILES);
> 	rcu_read_lock();
> 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
> 	...
> 
> }
> 
> create_worker() needs kthreadd, it wakes up kthreadd in kthread_create_on_node,
> workqueue_init() is called from kernel_init() , but kthreadd is created after
> the call to kernel_init(), so its touch and go

But the first thing kernel_init_freeable() does is
wait_for_completion(&kthreadd_done).

Thanks.

-- 
tejun
