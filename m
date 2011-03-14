Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09BDAB705F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 08:18:58 +1100 (EST)
Date: Mon, 14 Mar 2011 22:17:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Miller <davem@davemloft.net>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
	tree related)
In-Reply-To: <20110314.135116.112600339.davem@davemloft.net>
Message-ID: <alpine.LFD.2.00.1103142213081.2787@localhost6.localdomain6>
References: <20110314203827.4b61818e.sfr@canb.auug.org.au>
	<1300135074.22236.788.camel@pasglop>
	<20110314.135116.112600339.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Feng Tang <feng.tang@intel.com>,
	buytenh@secretlab.ca, LKML <linux-kernel@vger.kernel.org>,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 14 Mar 2011, David Miller wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 15 Mar 2011 07:37:54 +1100
> 
> > On Mon, 2011-03-14 at 20:38 +1100, Stephen Rothwell wrote:
> >> Hi all,
> >> 
> >> After merging the final tree, today's linux-next build (powerpc
> >> allyesconfig) failed like this:
> >> 
> >> drivers/gpio/langwell_gpio.c: In function 'lnw_irq_handler':
> >> drivers/gpio/langwell_gpio.c:210: error: 'struct irq_desc' has no member named 'chip'
> >> drivers/gpio/langwell_gpio.c:211: error: 'struct irq_desc' has no member named 'chip'
> >> 
> >> Caused by commit 17b9f9e2653a ("powerpc: Enable
> >> GENERIC_HARDIRQS_NO_DEPRECATED") enabling
> >> CONFIG_GENERIC_HARDIRQS_NO_DEPRECATED for powerpc without previously
> >> fixing up the above driver.
> >> 
> >> I have reverted that commit for today.
> > 
> > Except that the above driver has nothing to do with powerpc, it's some
> > Intel Moorestown stuff...
> > 
> > It should be fixed regardless I suppose, CC'ing Thomas.
> 
> I've had to make fixes to this driver in sparc64 allmodconfig builds
> too :-)

Sigh. Yes, this wants to depend on x86 in the first place.

But this is the second instance of blindly and mindlessly changing eoi
to irq_eoi w/o looking at the reason for this change.

Those patches should have been rejected based on their changelog in
the first place:

    Latest kernel has many changes in IRQ subsystem and its interfaces, like
    adding "irq_eoi" for struct irq_chip, this patch is a follow up change
    for that.

When noone beats me to fix that mess, I'll do it tomorrow morning.

Thanks,

	tglx
