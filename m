Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EA69BB6FBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 07:38:15 +1100 (EST)
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc tree related)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110314203827.4b61818e.sfr@canb.auug.org.au>
References: <20110314203827.4b61818e.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 15 Mar 2011 07:37:54 +1100
Message-ID: <1300135074.22236.788.camel@pasglop>
Mime-Version: 1.0
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linux-kernel@vger.kernel.org,
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

On Mon, 2011-03-14 at 20:38 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the final tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/gpio/langwell_gpio.c: In function 'lnw_irq_handler':
> drivers/gpio/langwell_gpio.c:210: error: 'struct irq_desc' has no member named 'chip'
> drivers/gpio/langwell_gpio.c:211: error: 'struct irq_desc' has no member named 'chip'
> 
> Caused by commit 17b9f9e2653a ("powerpc: Enable
> GENERIC_HARDIRQS_NO_DEPRECATED") enabling
> CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED for powerpc without previously
> fixing up the above driver.
> 
> I have reverted that commit for today.

Except that the above driver has nothing to do with powerpc, it's some
Intel Moorestown stuff...

It should be fixed regardless I suppose, CC'ing Thomas.

Cheers,
Ben.
