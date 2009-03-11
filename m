Return-Path: <timur.tabi@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 50EB4DDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 03:31:53 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id k4so25674nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:31:50 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <adaiqmgbq6w.fsf@cisco.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	<adaiqmgbq6w.fsf@cisco.com>
Date: Wed, 11 Mar 2009 11:31:50 -0500
Message-ID: <ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Roland Dreier <rdreier@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 12:09 AM, Roland Dreier <rdreier@cisco.com> wrote:

> Are there really cases where spinning for 1 jiffy is too long of a
> timeout?

If the result is a timeout, then I say no.  A timeout is an error
condition, and the code will usually terminate.

> It might make sense for the parameter passed in to be in terms
> of microseconds but I have a hard time coming up with a case where
> having the real timeout be 40 msecs or whatever 1 jiffy ends up being is
> a real problem -- after all, this helper is intended for the case where
> we expect the condition to become true much sooner than the worst case.

Well, that's the point.  What if the condition takes a long time to
come true.  One argument against this code is that it encourages
developers to use busy-waits for long periods of time.  The only way
to prevent this is to make the timeout really short.  But if we're
using jiffies, then the minimum amount of time needs to be two.  It
can't be one, because what if jiffies increments immediately after
starting the loop?  So you need to use a value of two as a minimum.

Two jiffies can be a very long time.  Besides, if this function is
used when interrupts are disabled, I believe that on some platforms,
jiffies never increments.  If so, we can't use the actual 'jiffies'
variable.

-- 
Timur Tabi
Linux kernel developer at Freescale
