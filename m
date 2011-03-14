Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35156B72F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 08:21:30 +1100 (EST)
Date: Mon, 14 Mar 2011 22:21:25 +0100
From: Lennert Buytenhek <buytenh@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
	tree related)
Message-ID: <20110314212125.GA9616@mail.wantstofly.org>
References: <20110314203827.4b61818e.sfr@canb.auug.org.au>
	<1300135074.22236.788.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300135074.22236.788.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 15, 2011 at 07:37:54AM +1100, Benjamin Herrenschmidt wrote:

> > Hi all,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > drivers/gpio/langwell_gpio.c: In function 'lnw_irq_handler':
> > drivers/gpio/langwell_gpio.c:210: error: 'struct irq_desc' has no member named 'chip'
> > drivers/gpio/langwell_gpio.c:211: error: 'struct irq_desc' has no member named 'chip'
> > 
> > Caused by commit 17b9f9e2653a ("powerpc: Enable
> > GENERIC_HARDIRQS_NO_DEPRECATED") enabling
> > CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED for powerpc without previously
> > fixing up the above driver.
> > 
> > I have reverted that commit for today.
> 
> Except that the above driver has nothing to do with powerpc, it's some
> Intel Moorestown stuff...

I sent this this morning:

	http://marc.info/?l=linux-kernel&m=130009963219374&w=2
