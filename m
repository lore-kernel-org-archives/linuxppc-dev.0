Return-Path: <oleg@tv-sign.ru>
Received: from mail.screens.ru (mail.screens.ru [213.234.233.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 631ACDDEC7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 03:49:37 +1000 (EST)
Date: Wed, 13 Jun 2007 19:51:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/3] [PATCH i386] during VM oom condition,
	kill all threads in process group
Message-ID: <20070613155124.GA275@tv-sign.ru>
References: <20070605174831.21740.33119.stgit@farscape.rchland.ibm.com>
	<20070607153459.2a1b3230.akpm@linux-foundation.org>
	<20070607231621.GB32549@kryten>
	<20070607171018.d51fc5da.akpm@linux-foundation.org>
	<1181330358.21409.31.camel@farscape.rchland.ibm.com>
	<20070608123230.520655f5.akpm@linux-foundation.org>
	<1181337147.21409.42.camel@farscape.rchland.ibm.com>
	<m1abvarrjq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m1abvarrjq.fsf@ebiederm.dsl.xmission.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	will_schmidt@vnet.ibm.com, Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 06/08, Eric W. Biederman wrote:
>
> Will Schmidt <will_schmidt@vnet.ibm.com> writes:
> 
> > On Fri, 2007-06-08 at 12:32 -0700, Andrew Morton wrote:
> >> On Fri, 08 Jun 2007 14:19:18 -0500
> >> Will Schmidt <will_schmidt@vnet.ibm.com> wrote:
> >> 
> >> > > > > zap_other_threads() requires tasklist_lock.
> >> > 
> >
> >> In fact, it's probably the case that rcu_read_lock() is now sufficient
> >> locking coverage for zap_other_threads() (cc's people).
> >> 
> >> It had better be, because do_group_exit() forgot to take tasklist_lock.  It
> >> is perhaps relying upon spin_lock()'s hidden rcu_read_lock() properties
> >> without so much as a code comment, which would be somewhat nasty of it.
> >
> >> You could perhaps just call do_group_exit() from within the fault
> >> handler,
> >> btw.
> >
> > Yup, so looks like I can actually replace the existing do_exit() call
> > with do_group_exit().   I'll sit on this for a bit to give other folks a
> > chance to comment on which lock call is sufficient, read_lock() or
> > rcu_read_lock(), etc;  and do_group_exit()'s issue with taking
> > tasklist_lock. 
> 
> No.  The rcu_read_lock is not sufficient.
> Yes.  sighand->siglock is enough, and we explicitly take it in
> do_group_exit before calling zap_other_threads.

Yes, we don't need tasklist_lock (or rcu_read_lock).

de_thread() calls zap_other_threads() under tasklist_lock, but this
is because we can change child_reaper.

Oleg.
