Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52CC4DDEEC
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 20:55:44 +1100 (EST)
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions
	with callbacks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <200810131047.12748.borntraeger@de.ibm.com>
References: <200806031444.21945.borntraeger@de.ibm.com>
	<200810130951.31733.borntraeger@de.ibm.com>
	<1223886972.8157.241.camel@pasglop>
	<200810131047.12748.borntraeger@de.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 20:52:59 +1100
Message-Id: <1223891579.8157.251.camel@pasglop>
Mime-Version: 1.0
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Virtualization Mailing List <virtualization@lists.osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 10:47 +0200, Christian Borntraeger wrote:
> > I will try. Of course the risk here is that the interrupt happens
> > after we set hp->tty to NULL, so we probably need to check within the
> > interrupt handler for a NULL tty. I haven't checked if that's the case
> > (I'm not in front of the code right now).
> 
> Even the old code (without my patch) was setting hp->tty to NULL before doing 
> the irq_free, so that should be ok.

Yup, just checked, it should be allright as long as it's cleared with
the spinlock held, which seems to be the case with your patch. I'll test
your fixup patch tomorrow to see if it clears the lockdep error.

Thanks !

Ben.
