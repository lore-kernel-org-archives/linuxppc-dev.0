Return-Path: <cebbert.lkml@gmail.com>
Received: from mail-oa0-x231.google.com (mail-oa0-x231.google.com
 [IPv6:2607:f8b0:4003:c02::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B778A1A009E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 17:27:01 +1000 (EST)
Received: by mail-oa0-f49.google.com with SMTP id m19so1508285oag.22
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 00:26:59 -0700 (PDT)
Date: Wed, 10 Sep 2014 02:26:54 -0500
From: Chuck Ebbert <cebbert.lkml@gmail.com>
To: Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v2 1/3] init/main.c: Give init_task a canary
Message-ID: <20140910022654.29abc9f3@as>
In-Reply-To: <1410255749-2956-2-git-send-email-atomlin@redhat.com>
References: <20140904161124.GD1436@atomlin.usersys.redhat.com>
 <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410255749-2956-2-git-send-email-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue,  9 Sep 2014 10:42:27 +0100
Aaron Tomlin <atomlin@redhat.com> wrote:

> +void task_stack_end_magic(struct task_struct *tsk)
> +{
> +	unsigned long *stackend;
> +
> +	stackend = end_of_stack(tsk);
> +	*stackend = STACK_END_MAGIC;	/* for overflow detection */
> +}
> +

For clarity this should probably be called set_task_stack_end_magic().

And has this been tested on parisc and metag, which use STACK_GROWSUP ?
I can't see how end_of_stack() as it's defined now could work on those archs.
