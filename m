Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3AF9DDDE9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 08:08:00 +1000 (EST)
Subject: Re: [PATCH] the wrong variable checked after request_irq()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20070715220216.GF21668@ftp.linux.org.uk>
References: <E1IAAFp-00053g-Ti@ZenIV.linux.org.uk>
	<1184535638.25235.15.camel@localhost.localdomain>
	<20070715220216.GF21668@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 16 Jul 2007 08:07:49 +1000
Message-Id: <1184537269.25235.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-07-15 at 23:02 +0100, Al Viro wrote:
> On Mon, Jul 16, 2007 at 07:40:38AM +1000, Benjamin Herrenschmidt wrote:
> > On Sun, 2007-07-15 at 20:59 +0100, Al Viro wrote:
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Out of curiosity, how did you pick it up ? You have some automated tool
> > to catch that (or sparse changes) or you just did -lots- of code
> > inspection ?
> 
> While testing sparse changes, actually (comparing pointers to null
> pointer constant spelled without a cast to void *)...  That gave several
> hundred hits, most of them being immediately obvious (picking the lines
> by file and line number and looking through the list had eliminated all
> but about a dozen or two).  Several were not...

Ok. In fact, it would have been nice if gcc had been able to pick it up
for another reason. The old code is:

	if (cascade == NULL)
		return;

	cascade_irq = irq_of_parse_and_map(cascade, 0);
	if (cascade == NO_IRQ) {
		printk(KERN_ERR "mpic: failed to map cascade interrupt");
		return;
	}

And NO_IRQ is 0 on powerpc nowadays. Thus the test can never be true :-)

But it looks like gcc doesn't pick that up.

Ben.
