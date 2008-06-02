Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A841DDEEC
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jun 2008 17:53:36 +1000 (EST)
Date: Mon, 2 Jun 2008 08:24:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080602072403.GA20222@flint.arm.linux.org.uk>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
	<1211859542.3286.46.camel@pasglop>
	<alpine.LFD.1.10.0805270833060.2958@woody.linux-foundation.org>
	<1211922621.3286.80.camel@pasglop>
	<alpine.LFD.1.10.0805271421570.2958@woody.linux-foundation.org>
	<1211924335.3286.89.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	tpiepho@freescale.com, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 27, 2008 at 02:55:56PM -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > 
> > A problem with __raw_ though is that they -also- don't do byteswap,
> 
> Well, that's why there is __readl() and __raw_readl(), no?
> 
> Neither does ordering, and __raw_readl() doesn't do byte-swap.

This is where the lack of documentation causes arch maintainers a big
problem.  None of the semantics of __raw_readl vs __readl vs readl are
documented _anywhere_.  If you look at x86 as a template, there's no
comments there about what the different variants are supposed to do
or not do.

So it's left up to arch maintainers to literally guess what should be
done.  That's precisely what I did when I implemented ARMs __raw_readl
and friends.  I guessed.

And it was only after I read a few mails on lkml which suggested that
readl and friends should always be LE that ARMs readl implementation
started to use le32_to_cpu()... before that it had always been native
endian.  Again, lack of documentation...

So, can the semantics of what's expected from these IO accessor
functions be documented somewhere.  Please?  Before this thread gets
lost in the depths of time?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
