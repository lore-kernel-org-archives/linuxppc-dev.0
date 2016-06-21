Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYypS6ct0zDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 05:44:00 +1000 (AEST)
Received: by mail-yw0-x242.google.com with SMTP id i12so3197682ywa.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 12:44:00 -0700 (PDT)
Date: Tue, 21 Jun 2016 15:43:56 -0400
From: Tejun Heo <htejun@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-team@fb.com
Subject: Re: [PATCH 1/2] workqueue: Move wq_update_unbound_numa() to the
 beginning of CPU_ONLINE
Message-ID: <20160621194356.GU3262@mtj.duckdns.org>
References: <cover.1465311052.git.ego@linux.vnet.ibm.com>
 <6b3c7059ec5d2d6157d23d619e4507692a42a5bd.1465311052.git.ego@linux.vnet.ibm.com>
 <20160615155350.GB24102@mtj.duckdns.org>
 <20160615192844.GA20301@in.ibm.com>
 <20160616193504.GB3262@mtj.duckdns.org>
 <20160621141231.GA30251@in.ibm.com>
 <20160621153651.GF3262@mtj.duckdns.org>
 <20160621193709.GT30154@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621193709.GT30154@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 21, 2016 at 09:37:09PM +0200, Peter Zijlstra wrote:
> Hurm.. So I've applied it, just to get this issue sorted, but I'm not
> entirely sure I like it.
> 
> I think I prefer ego's version because that makes it harder to get stuff
> to run on !active,online cpus. I think we really want to be careful what
> gets to run during that state.

The original patch just did set_cpus_allowed one more time late enough
so that the target kthread (in most cases) doesn't have to go through
fallback rq selection afterwards.  I don't know what the long term
solution is but CPU_ONLINE callbacks should be able to bind kthreads
to the new CPU one way or the other.

Thanks.

-- 
tejun
