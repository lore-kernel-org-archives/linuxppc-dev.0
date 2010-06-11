Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4148B7D8C
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jun 2010 07:10:13 +1000 (EST)
Subject: Re: [PATCH 2.6.35 & stable (v2)] powerpc: fix logic error in
	fixup_irqs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1276289756.3918.4.camel@jlt3.sipsolutions.net>
References: <1276289669.3918.3.camel@jlt3.sipsolutions.net>
	<1276289756.3918.4.camel@jlt3.sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 11 Jun 2010 23:10:08 +0200
Message-ID: <1276290608.3918.5.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, alastair.bridgewater@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-06-11 at 22:55 +0200, Johannes Berg wrote:
> When SPARSE_IRQ is set, irq_to_desc() can
> return NULL. While the code here has a
> check for NULL, it's not really correct.
> Fix it by separating the check for it.

Incidentally, there's another quirk in fixup_irqs():

...
        alloc_cpumask_var(&mask, GFP_KERNEL);
...
        local_irq_enable();
        mdelay(1);
        local_irq_disable();


Either it's called with IRQs disabled, in which case it shouldn't do
GFP_KERNEL, or it's called with IRQs enabled, in which case it doesn't
need the local_irq_enable(), no?

johannes
