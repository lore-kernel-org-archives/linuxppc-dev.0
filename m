Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 258B22C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 21:08:57 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 15:38:53 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 08B181258054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:41:10 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2KA8iWt54657184
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:38:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2KA8mDs019615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 15:38:49 +0530
Date: Thu, 20 Mar 2014 15:38:48 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140320100848.GC10406@linux.vnet.ibm.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, paulus@samba.org, tglx@linutronix.de,
 Paul McKenney <paulmck@linux.vnet.ibm.com>, torvalds@linux-foundation.org,
 mingo@kernel.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> This problem suggests that we missed a wakeup for a task that was adding
> itself to the queue in a wait path. And the only place that can happen
> is with the hb spinlock check for any pending waiters. Just in case we
> missed some assumption about checking the hash bucket spinlock as a way
> of detecting any waiters (powerpc?), could you revert this commit and
> try the original atomic operations variant:
> 
> https://lkml.org/lkml/2013/12/19/630

I think the above url and the commit id that I reverted i.e
git://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b0c29f79ecea0b6fbcefc999
are the same.

Or am I missing something? 

-- 
Thanks and Regards
Srikar Dronamraju
