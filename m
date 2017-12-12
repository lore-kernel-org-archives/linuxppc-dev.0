Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXQ3h1yzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:18 +1100 (AEDT)
In-Reply-To: <20160830171450.GA1890@Karyakshetra>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>,
 Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: ps3: Remove deprecated create_singlethread_workqueue
Message-Id: <3ywyXQ0zsZz9s83@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-30 at 17:14:51 UTC, Bhaktipriya Shridhar wrote:
> The workqueue "ps3av->wq" queues a single work item &ps3av->work and hence
> doesn't require ordering. It is involved in waking up ps3avd to do the
> video mode setting and hence it's not being used on a memory reclaim
> path. Hence, it has been converted to use system_wq.
> 
> System workqueues have been able to handle high level of concurrency
> for a long time now and hence it's not required to have a singlethreaded
> workqueue just to gain concurrency. Unlike a dedicated per-cpu workqueue
> created with create_singlethread_workqueue(), system_wq allows multiple
> work items to overlap executions even on the same CPU; however, a
> per-cpu workqueue doesn't have any CPU locality or global ordering
> guarantee unless the target CPU is explicitly specified and thus the
> increase of local concurrency shouldn't make any difference.
> 
> The work item has been flushed in ps3av_remove to ensure that
> there are no pending tasks while disconnecting the driver.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f0200c02883367f0eb6c9e2f19a8ab

cheers
