Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 124E7B7D98
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 15:06:25 +1000 (EST)
Subject: Re: [PATCH 1/2] powerpc: ipic: use set_irq_chip to ensure irq_chip
	defaults are applied
From: Esben Haabendal <eha@doredevelopment.dk>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1006070141230.2933@localhost.localdomain>
References: <cover.1275686504.git.eha@doredevelopment.dk>
	<1275686717.2970.13.camel@eha.doredevelopment.dk>
	<alpine.LFD.2.00.1006070141230.2933@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Jun 2010 07:06:15 +0200
Message-ID: <1275887175.2970.20.camel@eha.doredevelopment.dk>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-06-07 at 01:45 +0200, Thomas Gleixner wrote:

> This patch has never been tested with spinlock debugging enabled and
> will break SMP as it causes a deadlock on irq_desc->lock.
> 
> Again: See Documentation/Submit*

Ok, will do so.

But do you see the problem?  In __setup_irq(), irq_chip_set_defaults()
is called first, and then __irq_set_trigger(), which calls
chip->set_type(). When you request an edge irq with ipic, you get the
defaults applied to ipic_level_irq_chip, and then it sets
ipic_edge_irq_chip, which now is missing startup(), enable(), and so
on.

Would it be better to change the call order in __setup_irq(), and
call irq_chip_set_defaults after __irq_set_trigger() ?   Or perhaps
even calling it twice (again after __irq_set_trigger()) ?

/Esben
