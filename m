Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 854A71A0019
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 03:47:11 +1000 (EST)
Date: Thu, 11 Sep 2014 18:44:09 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v3 0/3] sched: Always check the integrity of the canary
Message-ID: <20140911174408.GA1873@atomlin.usersys.redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <063D6719AE5E284EB5DD2968C1650D6D17490245@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D17490245@AcuExch.aculab.com>
Cc: "dzickus@redhat.com" <dzickus@redhat.com>,
 "jcastillo@redhat.com" <jcastillo@redhat.com>,
 "riel@redhat.com" <riel@redhat.com>, "prarit@redhat.com" <prarit@redhat.com>,
 "mingo@kernel.com" <mingo@kernel.com>,
 "pzijlstr@redhat.com" <pzijlstr@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "bmr@redhat.com" <bmr@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "oleg@redhat.com" <oleg@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "jgh@redhat.com" <jgh@redhat.com>, "akpm@google.com" <akpm@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2014 at 04:02:45PM +0000, David Laight wrote:
> From: Aaron Tomlin
> > Currently in the event of a stack overrun a call to schedule()
> > does not check for this type of corruption. This corruption is
> > often silent and can go unnoticed. However once the corrupted
> > region is examined at a later stage, the outcome is undefined
> > and often results in a sporadic page fault which cannot be
> > handled.
> > 
> > The first patch adds a canary to init_task's end of stack.
> > While the second patch provides a helper to determine the
> > integrity of the canary. The third checks for a stack
> > overrun and takes appropriate action since the damage
> > is already done, there is no point in continuing.
> 
> Clearly you've just been 'bitten' by a kernel stack overflow.
> But a simple 'canary' isn't going to find most of the overflows
> and will give an incorrect 'sense of security'.

Please note that this is not suppose to be a 'perfect' solution.
Rather a worth while check in this particular code path.
Let's assume that the canary is damaged. In this situation it is
rather likely that the thread_info object has been compromised too.

-- 
Aaron Tomlin
