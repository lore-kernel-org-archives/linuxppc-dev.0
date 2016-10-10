Return-Path: <htejun@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st0vm5dJdzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 00:14:28 +1100 (AEDT)
Received: by mail-oi0-x242.google.com with SMTP id e12so1256666oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 06:14:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Oct 2016 09:14:17 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 jiangshanlai@gmail.com, akpm@linux-foundation.org, kernel-team@fb.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Oops on Power8 (was Re: [PATCH v2 1/7] workqueue: make workqueue
 available early during boot)
Message-ID: <20161010131417.GC29742@mtj.duckdns.org>
References: <1473967821-24363-1-git-send-email-tj@kernel.org>
 <1473967821-24363-2-git-send-email-tj@kernel.org>
 <20160917172314.GB10771@mtj.duckdns.org>
 <87twck5wqo.fsf@concordia.ellerman.id.au>
 <20161010130253.GB29742@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161010130253.GB29742@mtj.duckdns.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 09:02:53AM -0400, Tejun Heo wrote:
> Hello, Michael.
> 
> On Mon, Oct 10, 2016 at 09:22:55PM +1100, Michael Ellerman wrote:
> > This patch seems to be causing one of my Power8 boxes not to boot.
> > 
> > Specifically commit 3347fa092821 ("workqueue: make workqueue available
> > early during boot") in linux-next.
> > 
> > If I revert this on top of next-20161005 then the machine boots again.
> > 
> > I've attached the oops below. It looks like the cfs_rq of p->se is NULL?
> 
> Hah, weird that it's arch dependent, or maybe it's just different
> config options.  Most likely, it's caused by workqueue_init() call
> being moved too early.  Can you please try the following patch and see
> whether the problem goes away?

And if it does, can you please post the boot log with kernel boot
option "initcall_debug=1" specified?

Thanks.

-- 
tejun
