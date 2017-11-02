Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySRld206mzDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 01:08:59 +1100 (AEDT)
Date: Thu, 2 Nov 2017 15:08:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>, jpoimboe@redhat.com, jeyu@kernel.org,
 jikos@kernel.org, lpechacek@suse.cz, pavel@ucw.cz,
 live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
Message-ID: <20171102140853.GB23415@redhat.com>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
 <20171101151355.GG20040@pathway.suse.cz>
 <20171101164314.GA32760@redhat.com>
 <alpine.LSU.2.21.1711021128220.19544@san.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.21.1711021128220.19544@san.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/02, Miroslav Benes wrote:
>
> On Wed, 1 Nov 2017, Oleg Nesterov wrote:
>
> > Note also that wake_up_state(TASK_INTERRUPTIBLE) won't wakeup the TASK_IDLE
> > kthreads, and most of the kthreads which use TASK_INTERRUPTIBLE should use
> > TASK_IDLE today, because in most cases TASK_INTERRUPTIBLE was used to not
> > contribute to loadavg.
>
> Yes. Unfortunately, we have TASK_IDLE for more than two years now and
> nothing much has happened yet. TASK_IDLE is still used sporadically. I'd
> like to be on the safe side with livepatch

OK, as I said I won't argue,

> and given that
> TASK_INTERRUPTIBLE loops should be prepared for spurious wakeups by
> definition,

Not really when it comes to kthreads.

Once again, unless kthread does allow_signal() TASK_INTERRUPTIBLE does
not really differ from TASK_UNINTERRUPTIBLE except the latter contributes
to loadavg. And that is why TASK_INTERRUPTIBLE was commonly used instead
of TASK_UNINTERRUPTIBLE, so I do not think that TASK_INTERRUPTIBLE loops
are more ready in general than TASK_UNINTERRUPTIBLE.

Oleg.
