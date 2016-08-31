Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPSLJ6GcrzDrhc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 00:23:52 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id j12so1995261ywb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 07:23:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 31 Aug 2016 10:23:48 -0400
From: Tejun Heo <tj@kernel.org>
To: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ps3: Remove deprecated create_singlethread_workqueue
Message-ID: <20160831142348.GJ12660@htj.duckdns.org>
References: <20160830171450.GA1890@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160830171450.GA1890@Karyakshetra>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 30, 2016 at 10:44:51PM +0530, Bhaktipriya Shridhar wrote:
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

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
