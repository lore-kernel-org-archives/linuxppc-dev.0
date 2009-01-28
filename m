Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 166CFDE006
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 20:31:24 +1100 (EST)
Subject: Re: [PATCH] Restore PCI IO space behind Freescale pseudo-bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <E601679F-F6E5-4DE0-A6AB-B7191F496C49@freescale.com>
References: <200901271813.n0RIDBHq023872@pogo.cesa.opbu.xerox.com>
	<E601679F-F6E5-4DE0-A6AB-B7191F496C49@freescale.com>
Content-Type: text/plain
Date: Wed, 28 Jan 2009 20:31:12 +1100
Message-Id: <1233135072.6963.34.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > We are using the patch I emailed.  It's ugly in that it hard-codes the
> > Freescale vendor ID, but it works for us.
> 
> I guess I'm confused what the actual breakage is beyond some printk  
> messages.
> 
> We "fixup" the resources in fsl_pcibios_fixup_bus() so Ben's change  
> shouldn't have an impact.  Does something actually stop functioning?

I think the problem comes from my patch that "detects" closed bridge
windows, which uses the PCI_COMMAND register as a clue, and it seems
that your bridges don't properly support IO enable in there..

Ben.
