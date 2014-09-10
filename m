Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46FFA1A018A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 23:32:28 +1000 (EST)
Date: Wed, 10 Sep 2014 14:29:33 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Subject: Re: [PATCH v2 1/3] init/main.c: Give init_task a canary
Message-ID: <20140910132933.GG1436@atomlin.usersys.redhat.com>
References: <20140904161124.GD1436@atomlin.usersys.redhat.com>
 <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410255749-2956-2-git-send-email-atomlin@redhat.com>
 <20140910022654.29abc9f3@as>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140910022654.29abc9f3@as>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, bmr@redhat.com,
 prarit@redhat.com, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, akpm@google.com, hannes@cmpxchg.org,
 jgh@redhat.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
 pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 10, 2014 at 02:26:54AM -0500, Chuck Ebbert wrote:
> On Tue,  9 Sep 2014 10:42:27 +0100
> Aaron Tomlin <atomlin@redhat.com> wrote:
> 
> > +void task_stack_end_magic(struct task_struct *tsk)
> > +{
> > +	unsigned long *stackend;
> > +
> > +	stackend = end_of_stack(tsk);
> > +	*stackend = STACK_END_MAGIC;	/* for overflow detection */
> > +}
> > +
> 
> For clarity this should probably be called set_task_stack_end_magic().

Agreed.

> And has this been tested on parisc and metag, which use STACK_GROWSUP ?
> I can't see how end_of_stack() as it's defined now could work on those archs.

AFAIU, dup_task_struct() has always done this explicitly.
I see no reason why init_task requires special attention.

-- 
Aaron Tomlin
