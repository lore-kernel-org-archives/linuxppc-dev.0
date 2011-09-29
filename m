Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E02071007D6
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2011 10:22:08 +1000 (EST)
Received: by gyb11 with SMTP id 11so1078327gyb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2011 17:22:05 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 29 Sep 2011 16:36:48 -0500
From: Grant Likely <grant.likely@secretlab.ca>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: Handling multiple GPIO controllers in 8xxx GPIO driver
Message-ID: <20110929213648.GA10886@ponder.secretlab.ca>
References: <4E81D6C0.3010201@embedded-sol.com>
	<20110927182912.GA3994@ponder.secretlab.ca>
	<CAOZdJXW7uSSMO2KP7gW9UVQXNvBiYJoDRWsJWtPGXgWY-PXvCQ@mail.gmail.com>
	<20110929172737.GF6800@ponder.secretlab.ca>
	<4E84D36D.3050200@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E84D36D.3050200@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2011 at 08:22:06PM +0000, Tabi Timur-B04825 wrote:
> Grant Likely wrote:
> > A chained handler has an expedited path through the interrupt code for
> > handling it (basically, it skips handling it at the parent controller
> > and passes through to the child, but it cannot handle multiple chained
> > children on a single irq input.
> 
> So you can't do a shared chained handler?  If the chained handler returns 
> IRQ_NONE, the interrupt code just gives up?

No, you can do one or more regular handlers which acks or masks the
irq in the upstream controller, or you can do a single chained handler
which bypasses any ack/mask.  It's an optimization.  The code *could*
be modified to allow multiple chained handlers, but I cannot comment
on if it would be worthwhile.

Basically, a chained handler replaces the regular edge or level irq
handler.  Take a look at __irq_set_handler().  Chained in this case is
really a synonym for a cascaded irq handler.  Also, I believe it only
really works if the irq is level sensitive because an edge sensitive
irq would still need to be acked.  It would also need to be an irq
controller that can be accessed immediately since it depends on the
child controller to ack/mask it's inputs.  Something on an i2c bus
wouldn't work so well because the irq would remain asserted until
after several slow i2c transactions.

g.
