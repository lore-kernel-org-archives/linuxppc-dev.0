Return-Path: <SRS0+21a6785939882875a925+1913+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0981EDDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 20:53:16 +1100 (EST)
Date: Tue, 18 Nov 2008 04:53:05 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Large stack usage in fs code (especially for PPC64)
Message-ID: <20081118095305.GA24119@infradead.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<1226963005.7178.248.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1226963005.7178.248.camel@pasglop>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 18, 2008 at 10:03:25AM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2008-11-17 at 15:34 -0500, Steven Rostedt wrote:
> > Note, I was using a default config that had CONFIG_IRQSTACKS off and
> > CONFIG_PPC_64K_PAGES on.
> 
> For one, we definitely need to turn IRQSTACKS on by default ... In fact,
> I'm pondering just removing the option.

It shouldn't be a user-visible option.  It shouldn't on x86 either, but
there it always gets into the ideological 4k stacks flameware so people
usually gave up after a while instead of doing the sensibke 8k +
irqstacks by default, 4k as an option..
