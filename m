Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6A58DE599
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 22:35:54 +1100 (EST)
Date: Thu, 8 Jan 2009 11:11:16 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG] hvc_console WARN() on current upstream
Message-ID: <20090108111116.3f806d67@lxorguk.ukuu.org.uk>
In-Reply-To: <1231404121.2142.50.camel@pasglop>
References: <1231391897.2142.40.camel@pasglop>
	<200901080857.44090.borntraeger@de.ibm.com>
	<1231404121.2142.50.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Peterson <joe@skyrush.com>, Joe, Milton Miller <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > Seems that we are in interrupt, doing hvc_poll, which does
> > tty_flip_buffer_push

Which means that someone has tty->low_latency set and is calling
tty_flip_buffer_push in an IRQ. That has never been allowed or safe, and
now it hurts ;)

/**
 *      tty_flip_buffer_push    -       terminal
 *      @tty: tty to push
 * 
 *      Queue a push of the terminal flip buffers to the line discipline.
This
 *      function must not be called from IRQ context if tty->low_latency
is set *
 *      In the event of the queue being busy for flipping the work will be
 *      held off and retried later.
 *
 *      Locking: tty buffer lock. Driver locks in low latency mode.
 */


That comment has been there for some years in varying formats
