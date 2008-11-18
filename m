Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2984FDDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:37:52 +1100 (EST)
Date: Tue, 18 Nov 2008 11:37:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
Message-ID: <20081118103726.GB31146@elte.hu>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<1226963005.7178.248.camel@pasglop>
	<20081118095305.GA24119@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081118095305.GA24119@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Nov 18, 2008 at 10:03:25AM +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2008-11-17 at 15:34 -0500, Steven Rostedt wrote:
> > > Note, I was using a default config that had CONFIG_IRQSTACKS off and
> > > CONFIG_PPC_64K_PAGES on.
> > 
> > For one, we definitely need to turn IRQSTACKS on by default ... In fact,
> > I'm pondering just removing the option.
> 
> It shouldn't be a user-visible option.  It shouldn't on x86 either, 
> but there it always gets into the ideological 4k stacks flameware so 
> people usually gave up after a while instead of doing the sensibke 
> 8k + irqstacks by default, 4k as an option..

yep, i tend to agree that 8k + irqstacks on both 32-bit and 64-bit 
would be the sane default. There's just too much gcc and other noise 
for us to have that cushion by default on 32-bit too. 64-bit is 
already there, on 32-bit we should decouple irqstacks from 4K stacks 
and just turn irqstacks on by default.

Life's too short to fight kernel stack overflows - and now we've got 
the stack-tracer that will record and show the frame of the worst-ever 
kernel stack situation the system was in since bootup. (see Steve's 
tracer output in this thread)

	Ingo
