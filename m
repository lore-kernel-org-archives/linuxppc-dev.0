Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYsKP1jn8zDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 01:36:57 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id i12so2187793ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 08:36:57 -0700 (PDT)
Date: Tue, 21 Jun 2016 11:36:51 -0400
From: Tejun Heo <htejun@gmail.com>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Message-ID: <20160621153651.GF3262@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
 <20160615155350.GB24102@mtj.duckdns.org>
 <20160615192844.GA20301@in.ibm.com>
 <20160616193504.GB3262@mtj.duckdns.org>
 <20160621141231.GA30251@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621141231.GA30251@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 07:42:31PM +0530, Gautham R Shenoy wrote:
> > Subject: [PATCH] sched: allow kthreads to fallback to online && !active cpus
> > 
> > During CPU hotplug, CPU_ONLINE callbacks are run while the CPU is
> > online but not active.  A CPU_ONLINE callback may create or bind a
> > kthread so that its cpus_allowed mask only allows the CPU which is
> > being brought online.  The kthread may start executing before the CPU
> > is made active and can end up in select_fallback_rq().
> > 
> > In such cases, the expected behavior is selecting the CPU which is
> > coming online; however, because select_fallback_rq() only chooses from
> > active CPUs, it determines that the task doesn't have any viable CPU
> > in its allowed mask and ends up overriding it to cpu_possible_mask.
> > 
> > CPU_ONLINE callbacks should be able to put kthreads on the CPU which
> > is coming online.  Update select_fallback_rq() so that it follows
> > cpu_online() rather than cpu_active() for kthreads.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> 
> Hi Tejun,
> 
> This patch fixes the issue on POWER. I am able to see the worker
> threads of the unbound workqueues of the newly onlined node with this.
> 
> Tested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Peter?

-- 
tejun
