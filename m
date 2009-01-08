Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 28155474C3
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:13:28 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	Benjiman Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] hvc_console updates was Re: [BUG] hvc_console WARN() on
	current upstream
references: <1231404121.2142.50.camel@pasglop>
	<20090108111116.3f806d67@lxorguk.ukuu.org.uk>
In-Reply-To: <20090108111116.3f806d67@lxorguk.ukuu.org.uk>
Message-Id: <hvc-console-29-3@bga.com>
Date: Thu, 08 Jan 2009 06:12:58 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Joe Peterson <joe@skyrush.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Cox wrote:
> Benjamin Herrenschmidt wrote:
>> Seems that we are in interrupt, doing hvc_poll, which does
>> tty_flip_buffer_push
>
>Which means that someone has tty->low_latency set and is calling
>tty_flip_buffer_push in an IRQ. That has never been allowed or safe, and
>now it hurts ;)
>
>/**
> *      tty_flip_buffer_push    -       terminal
> *      @tty: tty to push
> * 
> *      Queue a push of the terminal flip buffers to the line discipline.
>This
> *      function must not be called from IRQ context if tty->low_latency
>is set *
> *      In the event of the queue being busy for flipping the work will be
> *      held off and retried later.
> *
> *      Locking: tty buffer lock. Driver locks in low latency mode.
> */
>
>
>That comment has been there for some years in varying formats
>

I actually was preparing a patch for this problem after I had encountered
the a deadlock due to this.  That is in the first patch.   I then found
and made a few more cleanups, although I might have reordered the rest.

The history for setting low_latency is in the changelog of the first patch..

milton
