Return-Path: <pwil3058@bigpond.net.au>
Received: from omta05sl.mx.bigpond.com (omta05sl.mx.bigpond.com
	[144.140.93.195]) by ozlabs.org (Postfix) with ESMTP id 5478267A3B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 09:52:50 +1100 (EST)
Message-ID: <4421D541.6090103@bigpond.net.au>
Date: Thu, 23 Mar 2006 09:52:49 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] possible scheduler deadlock in 2.6.16
References: <20060322104143.GC30422@krispykreme>
	<4421307F.8020300@yahoo.com.au>
In-Reply-To: <4421307F.8020300@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin wrote:
> Anton Blanchard wrote:
> 
>> One way to solve this is to always take runqueues in cpu id order. To do
>> this we add a cpu variable to the runqueue and check it in the
>> double runqueue locking functions.
>>
>> Thoughts?
>>
> 
> You're right. I can't think of a better fix, although we've been trying
> to avoid adding cpu to the runqueue structure.

But now that it's there it will enable further optimizations in parts of
sched.c, wouldn't it?  E.g. there's a number of functions that get
passed both the run queue and the CPI id as arguments and these could be
simplified.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
