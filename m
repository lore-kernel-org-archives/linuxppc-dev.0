Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[65.172.181.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.osdl.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B76D9DDE4A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 04:13:16 +1000 (EST)
Date: Thu, 10 May 2007 11:12:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Maxim Uvarov <muvarov@ru.mvista.com>
Subject: Re: [PATCH] Performance Stats: Kernel patch
Message-Id: <20070510111242.dd42adae.akpm@linux-foundation.org>
In-Reply-To: <4642FDD6.5090609@ru.mvista.com>
References: <20070508162650.704.83752.stgit@localhost.localdomain>
	<20070508123214.11b4f25c.akpm@linux-foundation.org>
	<4642FDD6.5090609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, wli@holomorphy.com, pavel@ucw.cz,
	dada1@cosmosbay.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007 11:11:18 +0000 Maxim Uvarov <muvarov@ru.mvista.com> wrote:

> >syscall entry is a super-hotpath and there will be a developer revolt
> >if we go adding an incl to that path, sorry.
> >
> >  
> >
> Yes, I know that it is very critical part of code. May be protection with
> ifdef CONFIG_TASKSTATS  in all entry.S can be solution?
> In that case we can be sure that nothing wrong can not happen,
> and if this functionality is needed we can turn on this.

I very much hope that all distributors will enable taskstats, so that won't
help.

I don't think the syscall-counting feature has a future, sorry.  Perhaps
you could do something like hooking it up on-demand by insertion of a kprobe,
dunno.

> >(Did that incl also cover the int 80 entry?)
> >  
> >
> Actually not. But counter increments each time when syscall  calls.
> But it is in very save place, just after
>         SAVE_ALL
>         GET_THREAD_INFO(%ebp)
> So it is very hard to break something.
> 

What I meant was: the code appears to be counting sysenter-invoked syscalls,
but it isn't counting not int 80-invoked syscalls.
