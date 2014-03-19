Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9DB732C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 03:09:41 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Thu, 20 Mar 2014 02:09:39 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AF3812BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 03:09:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2JFnHrh8388990
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 02:49:18 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2JG9aOH006196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 03:09:37 +1100
Date: Wed, 19 Mar 2014 21:39:33 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
Message-ID: <20140319160933.GA30295@linux.vnet.ibm.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140319154705.GB8557@laptop.programming.kicks-ass.net>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 davidlohr@hp.com, paulus@samba.org, tglx@linutronix.de,
 torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > 
> > Infact I can reproduce this if the java_constraint is either node, socket, system.
> > However I am not able to reproduce if java_constraint is set to core.
> 
> What's any of that mean?
> 

Using the constraint, one can specify how many jvm instances should
participate in the specjbb run.

For example on a 4 node box, I can say 2 jvms per constraint with
constraint set to node and specjbb will run with 8 instances of java.

I was running with 1 jvm per constraint. But when I set the constraint
to node/System, I keep seeing this problem. However if I set the
constraint to core (which means running more instances of java), the
problem is not seen. I kind of guess, the lesser the number of java
instances the easier it is to reproduce. 

-- 
Thanks and Regards
Srikar Dronamraju
