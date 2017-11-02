Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySM2L1lzNzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 21:36:24 +1100 (AEDT)
Date: Thu, 2 Nov 2017 11:36:17 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Oleg Nesterov <oleg@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, jpoimboe@redhat.com, jeyu@kernel.org,
 jikos@kernel.org, lpechacek@suse.cz, pavel@ucw.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20171101164314.GA32760@redhat.com>
Message-ID: <alpine.LSU.2.21.1711021128220.19544@san.suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
 <20171101151355.GG20040@pathway.suse.cz> <20171101164314.GA32760@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Nov 2017, Oleg Nesterov wrote:

> On 11/01, Petr Mladek wrote:
> >
> > On Tue 2017-10-31 12:48:52, Miroslav Benes wrote:
> > > +		if (task->flags & PF_KTHREAD) {
> > > +			/*
> > > +			 * Wake up a kthread which still has not been migrated.
> > > +			 */
> > > +			wake_up_process(task);
> >
> > I have just noticed that freezer used wake_up_state(p, TASK_INTERRUPTIBLE);
> > IMHO, we should do so as well.
> 
> I won't argue, but...
> 
> > wake_up_process() wakes also tasks in TASK_UNINTERRUPTIBLE state.
> > These might not be ready for an unexpected wakeup. For example,
> > see concat_dev_erase() in drivers/mtd/mtdcontact.c.
> 
> I'd say that concat_dev_erase() should be fixed, any code should be ready
> for spurious wakeup.

I agree.
 
> Note also that wake_up_state(TASK_INTERRUPTIBLE) won't wakeup the TASK_IDLE
> kthreads, and most of the kthreads which use TASK_INTERRUPTIBLE should use
> TASK_IDLE today, because in most cases TASK_INTERRUPTIBLE was used to not
> contribute to loadavg.

Yes. Unfortunately, we have TASK_IDLE for more than two years now and 
nothing much has happened yet. TASK_IDLE is still used sporadically. I'd 
like to be on the safe side with livepatch and given that 
TASK_INTERRUPTIBLE loops should be prepared for spurious wakeups by 
definition, I think it is better to have wake_up_state(TASK_INTERRUPTIBLE) 
there. At least till all "concat_dev_erase" beauties are fixed (sigh).

Miroslav
