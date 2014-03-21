Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D9C72C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 15:55:09 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 21 Mar 2014 14:55:08 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EA2EA2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 15:55:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2L4sqf48716704
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 15:54:52 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2L4t4bF015487
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 15:55:05 +1100
Date: Fri, 21 Mar 2014 10:25:01 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Davidlohr Bueso <davidlohr@hp.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140321045501.GD30295@linux.vnet.ibm.com>
References: <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
 <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> Ok, so a big reason why this patch doesn't apply cleanly after reverting
> is because *most* of the changes were done at the top of the file with
> regards to documenting the ordering guarantees, the actual code changes
> are quite minimal.
> 
> I reverted commits 99b60ce6 (documentation) and b0c29f79 (the offending
> commit), and then I cleanly applied the equivalent ones from v3 of the
> series (which was already *tested* and ready for upstream until you
> suggested looking into the alternative spinlock approach):
> 
> https://lkml.org/lkml/2013/12/19/624
> https://lkml.org/lkml/2013/12/19/630

I reverted commits 99b60ce6 and b0c29f79. Then applied the patches in
the above url. The last one had a reject but it was pretty
straightforward to resolve it. After this, specjbb completes. 

So reverting and applying v3 3/4 and 4/4 patches works for me.

-- 
Thanks and Regards
Srikar Dronamraju
