Return-Path: <SRS0+b1a8919817a61a648e9e+1226+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5857DDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:26:16 +1100 (EST)
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1167682254.23340.131.camel@localhost.localdomain>
References: <1167679875.22068.350.camel@pmac.infradead.org>
	<1167682254.23340.131.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 20:26:06 +0000
Message-Id: <1167683166.22068.378.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-02 at 07:10 +1100, Benjamin Herrenschmidt wrote:
> 
> I'm not sure you can switch it to native mode in sw... worth double
> checking though. All boards based on 8111 on powerpc have this problem,
> I think. What of the js20 and js21 with IBM firmware ? Or does it have
> the ide strapped to native mode ?

No idea, but it doesn't implement ppc_md.pci_get_legacy_ide_irq(). Only
Maple does -- maybe the others actually manage to route it to IRQ 14 and
15?

Perhaps we could do that on Maple too -- after all, IRQ numbers in Linux
are just a fiction which don't have to match the hardware documentation
in any way.

-- 
dwmw2
