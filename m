Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBB1DDDF94
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 05:32:44 +1000 (EST)
Date: Fri, 8 Jun 2007 12:32:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH 1/3] [PATCH i386] during VM oom condition, kill all
	threads in process group
Message-Id: <20070608123230.520655f5.akpm@linux-foundation.org>
In-Reply-To: <1181330358.21409.31.camel@farscape.rchland.ibm.com>
References: <20070605174831.21740.33119.stgit@farscape.rchland.ibm.com>
	<20070607153459.2a1b3230.akpm@linux-foundation.org>
	<20070607231621.GB32549@kryten>
	<20070607171018.d51fc5da.akpm@linux-foundation.org>
	<1181330358.21409.31.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, "Eric W.
	Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@tv-sign.ru>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 08 Jun 2007 14:19:18 -0500
Will Schmidt <will_schmidt@vnet.ibm.com> wrote:

> > > > zap_other_threads() requires tasklist_lock.
> 
> Yup, I missed that.   Thanks for pointing it out.
> 
> > > > 
> > > > If we're going to do this then we should probably create some new function
> > > > (with a better name) which takes tasklsit_lock and then calls
> > > > zap_other_threads().
> 
> I expect this will be a write_lock_irq() since zap_other_threads will be
> doing a bit more than just reading the task info.

No, I think read_lock() will be sufficient.

In fact, it's probably the case that rcu_read_lock() is now sufficient
locking coverage for zap_other_threads() (cc's people).

It had better be, because do_group_exit() forgot to take tasklist_lock.  It
is perhaps relying upon spin_lock()'s hidden rcu_read_lock() properties
without so much as a code comment, which would be somewhat nasty of it.

You could perhaps just call do_group_exit() from within the fault handler,
btw.

> This will be down in a do-page-fault failure path (see
> arch/*/mm/fault.c).  I wonder if calling write_lock is going to be safe,
> or if its possible to get into a deadlock?  i.e. should I branch back up
> to the survive: label if I can't take the lock?  Would that even be
> sufficient? or is it not an issue here? 

You can take the lock in the fault handler.  Nobody should be getting
pagefaults while holding tasklist_lock.  (Well, a vmalloc fault might, but
that's a special-case which doesn't allocate memory or anything like that).
