Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x22e.google.com (mail-pg0-x22e.google.com
 [IPv6:2607:f8b0:400e:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x63P661YnzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 10:48:57 +1000 (AEST)
Received: by mail-pg0-x22e.google.com with SMTP id t186so57882006pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 17:48:57 -0700 (PDT)
Message-ID: <1499734129.14464.3.camel@gmail.com>
Subject: Re: [PATCH v2 08/10] powerpc/opal: Add
 opal_async_wait_response_interruptible() to opal-async
From: Cyril Bur <cyrilbur@gmail.com>
To: David Laight <David.Laight@ACULAB.COM>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>
Cc: "stewart@linux.vnet.ibm.com" <stewart@linux.vnet.ibm.com>,
 "alistair@popple.id.au"
 <alistair@popple.id.au>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "rlippert@google.com" <rlippert@google.com>
Date: Tue, 11 Jul 2017 10:48:49 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0036C52@AcuExch.aculab.com>
References: <20170710013106.27276-1-cyrilbur@gmail.com>
 <20170710013106.27276-9-cyrilbur@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD0036C52@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-10 at 14:05 +0000, David Laight wrote:
> From: Cyril Bur
> > Sent: 10 July 2017 02:31
> > This patch adds an _interruptible version of opal_async_wait_response().
> > This is useful when a long running OPAL call is performed on behalf of a
> > userspace thread, for example, the opal_flash_{read,write,erase}
> > functions performed by the powernv-flash MTD driver.
> > 
> > It is foreseeable that these functions would take upwards of two minutes
> > causing the wait_event() to block long enough to cause hung task
> > warnings. Furthermore, wait_event_interruptible() is preferable as
> > otherwise there is no way for signals to stop the process which is going
> > to be confusing in userspace.
> 
> ISTM that if you are doing (something like) a flash full device erase
> (that really can take minutes) it isn't actually an interruptible
> operation - the flash chip will still be busy.
> So allowing the user process be interrupted just leaves a big mess.
> 

Agreed.

> OTOH the 'hung task' warning isn't the only problem with uninterruptible
> sleeps - the processes also count towards the 'load average'.
> Some software believes the 'load average' is a meaningful value.
> 

Yes, and because the read write and erase ops are actually calls into
firmware which in some cases completely emulates flash we can mitigate
the mess of allowing the process to be interrupted that you mention
above.

> It would be more generally useful for tasks to be able to sleep
> uninterruptibly without counting towards the 'load average' or triggering
> the 'task stuck' warning.
> (I've code somewhere that sleeps interruptibly unless there is a signal
> pending when it sleeps uninterruptibly.)
> 

I'm not sure what you mean here, if I understand correctly, this is
what I'm doing. In the patch to the powernv_flash driver which uses
opal_async_wait_response_interruptible() I essentially do the
interruptible and if it breaks early the driver determines if it is
safe to return to userspace otherwise it sleeps uninterruptibly
(hopefully not for long). I was hesitant to put that logic here and
prefered to leave it up to the caller to make the decision as to what
to do.

> WRT flash erases, 'whole device' erases aren't significantly quicker
> than sector by sector erases.

Yes, I'm rewriting some of the userspace tools we have to do everything
sector by sector. MTD interfaces allow big reads/writes and erases so
we should still handle it as best we can.

> The latter can be interrupted between sectors.
> I'm not sure you'd want to do writes than lock down enough kernel
> memory to take even a second to complete.
> 

The MTD core actually chunks them up before passing them to the to
backing driver so I don't think holding too much memory is a problem.
Because the time spent in OPAL servicing flash calls is hard to
determine and might not even be that related to the size of the
operation, even smaller ops might still spend 'time' in OPAL.

Cyril

> 	David
> 
