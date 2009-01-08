Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6795474C3
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 07:36:35 +1100 (EST)
Subject: Re: [BUG] hvc_console WARN() on current upstream
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20090108111116.3f806d67@lxorguk.ukuu.org.uk>
References: <1231391897.2142.40.camel@pasglop>
	<200901080857.44090.borntraeger@de.ibm.com>
	<1231404121.2142.50.camel@pasglop>
	<20090108111116.3f806d67@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Fri, 09 Jan 2009 07:36:12 +1100
Message-Id: <1231446972.2142.55.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Joe Peterson <joe@skyrush.com>, Milton Miller <miltonm@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-01-08 at 11:11 +0000, Alan Cox wrote:
> > > Seems that we are in interrupt, doing hvc_poll, which does
> > > tty_flip_buffer_push
> 
> Which means that someone has tty->low_latency set and is calling
> tty_flip_buffer_push in an IRQ. That has never been allowed or safe, and
> now it hurts ;)

Heh, allright :-) I'll see where that flag is set and clear it when
using IRQs.

> That comment has been there for some years in varying formats

Possibly, I didn't write that code, thanks for pointing me to the
problem.

Cheers,
Ben.
