Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 895642C02AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2013 07:53:01 +1100 (EST)
Received: by mail-wg0-f45.google.com with SMTP id dq12so4920717wgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 12:52:57 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [BUG] irq_dispose_mapping after irq request failure
To: Michael Ellerman <michael@ellerman.id.au>, Baruch Siach <baruch@tkos.co.il>
In-Reply-To: <20130211061949.GA5561@concordia>
References: <20130211053100.GB18462@sapphire.tkos.co.il>
 <20130211061949.GA5561@concordia>
Date: Mon, 11 Feb 2013 20:52:55 +0000
Message-Id: <20130211205255.72B513E3530@localhost>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 11 Feb 2013 17:19:49 +1100, Michael Ellerman <michael@ellerman.id.au> wrote:
> On Mon, Feb 11, 2013 at 07:31:00AM +0200, Baruch Siach wrote:
> > Hi lkml,
> 
> Hi Baruch,
> 
> > The drivers/edac/mpc85xx_edac.c driver contains the following (abbreviated)
> > code snippet it its .probe:
> 
> You dropped an important detail which is the preceeding line:
> 
> 	pdata->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> 
> > 		res = devm_request_irq(&op->dev, pdata->irq,
> > 				       mpc85xx_pci_isr, IRQF_DISABLED,
> > 				       "[EDAC] PCI err", pci);
> > 		if (res < 0) {
> > 			irq_dispose_mapping(pdata->irq);
> > 			goto err2;
> > 		}
> > 
> > Now, since the requested irq is already in use, and IRQF_SHARED is not set,
> > devm_request_irq errors() out, which is OK. Less OK is the
> > irq_dispose_mapping() call, which gives me this:
> > 
> > EDAC PCI1: Giving out device to module 'MPC85xx_edac' controller 'mpc85xx_pci_err': DEV 'ffe0a000.pcie' (INTERRUPT)
> > genirq: Flags mismatch irq 16. 00000020 ([EDAC] PCI err) vs. 00000020 ([EDAC] PCI err)
> 
> The hint here is to notice which other irq you're clashing with          ^^
> ie. yourself. Which is odd, that is the root of the problem.
> 
> The badness you're getting from irq_dispose_mapping() is caused because you're
> disposing of that mapping which is currently still in use, by the same interrupt.
> 
> That is caused by a "feature" in the irq mapping code, where if you ask to map an
> already mapped hwirq, it will give you back the same virq. So in your case when
> you called irq_of_parse_and_map() it noticed that someone had already mapped
> that hwirq, and gave you back an existing (in use) virq.

Really the irq mappings should be using reference counting. The existing
code is naive on this count and just releases the irq on the first call
to irq_dispose_mapping().  I've not gotten around to fixing that. Anyone
want to take that task on?

g.
