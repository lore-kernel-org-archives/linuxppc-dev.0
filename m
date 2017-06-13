Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x229.google.com (mail-yb0-x229.google.com
 [IPv6:2607:f8b0:4002:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnMb24cZ8zDqLD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 06:59:42 +1000 (AEST)
Received: by mail-yb0-x229.google.com with SMTP id f192so39400697yba.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 13:59:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Jun 2017 16:59:38 -0400
From: Tejun Heo <tj@kernel.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 mpe <mpe@ellerman.id.au>, sachinp <sachinp@linux.vnet.ibm.com>
Subject: Re: WARNING: CPU: 2 PID: 7 at kernel/workqueue.c:2041 process_one_work
Message-ID: <20170613205938.GC7359@htj.duckdns.org>
References: <1496130846.13350.19.camel@abdul.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496130846.13350.19.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 30, 2017 at 01:24:06PM +0530, Abdul Haleem wrote:
> Hi,
> 
> Test : stress-ng
> Machine : Power 8 Bare Metal
> Kernel : 4.12.0-rc3
> Config : attached
> gcc version: 4.8.5
> 
> 
> In file kernel/workqueue.c at line 2041
> 
>     /* ensure we're on the correct CPU */
>     WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
>              raw_smp_processor_id() != pool->cpu);
> 
> 
> WARN_ON_ONCE() is being triggered on Linus mainline kernel (4.12.0-rc3)
> when running stress-ng test.
> 
> 
> request_module: runaway loop modprobe net-pf-10
> request_module: runaway loop modprobe net-pf-10
> hrtimer: interrupt took 500359 ns
> RT Watchdog Timeout (hard): stress-ng-rlimi[80236]

Paul and Steven reported the same problem a while back.  Debugging on
the following thread.

 http://lkml.kernel.org/r/<20170501165747.GA993@linux.vnet.ibm.com>

Thanks.

-- 
tejun
