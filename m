Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRvD90NLGzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 03:43:20 +1100 (AEDT)
Date: Wed, 1 Nov 2017 17:43:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, jpoimboe@redhat.com, jeyu@kernel.org,
 jikos@kernel.org, lpechacek@suse.cz, pavel@ucw.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
Message-ID: <20171101164314.GA32760@redhat.com>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
 <20171101151355.GG20040@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171101151355.GG20040@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01, Petr Mladek wrote:
>
> On Tue 2017-10-31 12:48:52, Miroslav Benes wrote:
> > +		if (task->flags & PF_KTHREAD) {
> > +			/*
> > +			 * Wake up a kthread which still has not been migrated.
> > +			 */
> > +			wake_up_process(task);
>
> I have just noticed that freezer used wake_up_state(p, TASK_INTERRUPTIBLE);
> IMHO, we should do so as well.

I won't argue, but...

> wake_up_process() wakes also tasks in TASK_UNINTERRUPTIBLE state.
> These might not be ready for an unexpected wakeup. For example,
> see concat_dev_erase() in drivers/mtd/mtdcontact.c.

I'd say that concat_dev_erase() should be fixed, any code should be ready
for spurious wakeup.

Note also that wake_up_state(TASK_INTERRUPTIBLE) won't wakeup the TASK_IDLE
kthreads, and most of the kthreads which use TASK_INTERRUPTIBLE should use
TASK_IDLE today, because in most cases TASK_INTERRUPTIBLE was used to not
contribute to loadavg.

Oleg.
