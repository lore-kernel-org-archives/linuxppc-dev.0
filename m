Return-Path: <nd@bplan-gmbh.de>
Date: Sun, 5 Nov 2006 11:17:52 +0100 (MET)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
Message-Id: <20061105111753.3e41f6b7.nd@bplan-gmbh.de>
In-Reply-To: <1162683341.28571.82.camel@localhost.localdomain>
References: <454902F9.20206@bplan-gmbh.de>	<1162419138.25682.453.camel@localhost.localdomain>	<454A1C37.5050208@bplan-gmbh.de>	<454A5952.6090801@bplan-gmbh.de>	<1162683341.28571.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 05 Nov 2006 10:35:40 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Thu, 2006-11-02 at 21:47 +0100, Nicolas DET wrote:
> 
> > + *
> > + * Programmable Interrupt Controller functions for the Freescale MPC52xx.
> > + *
> > + * Based on (well, mostly copied from) the code from the 2.4 kernel by
> > + * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
> > + * 
> > + * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
> > + * Copyright (C) 2003 Montavista Software, Inc
> 
> You did significant changes, you should add your (c) before the "Based
> on..." line.

Ok. It now looks likes this:

+/*
+ *
+ * Programmable Interrupt Controller functions for the Freescale MPC52xx.
+ *
+ * Copyright (C) 2006 bplan GmbH
+ *
+ * Based on (well, mostly copied from) the code from the 2.4 kernel by
+ * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.
+ * 
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 Montavista Software, Inc
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ */


> 
> > +	switch (l1irq) {
> > +	case MPC52xx_IRQ_L1_CRIT:
> > +		pr_debug("%s: Critical. l2=%x\n", __func__, l2irq);
> > +
> > +		BUG_ON(l2irq != 0);
> > +
> > +		type = mpc52xx_irqx_gettype(l2irq);
> > +		good_irqchip = &mpc52xx_extirq_irqchip;
> > +		break;
> > +
> > +	case MPC52xx_IRQ_L1_MAIN:
> > +		pr_debug("%s: Main IRQ[1-3] l2=%x\n", __func__, l2irq);
> > +
> > +		if ((l2irq >= 1) && (l2irq <= 3)) {
> > +			type = mpc52xx_irqx_gettype(l2irq);
> > +			good_irqchip = &mpc52xx_extirq_irqchip;
> > +		} else {
> > +			good_irqchip = &mpc52xx_main_irqchip;
> > +		}
> > +		break;
> 
> You have changed the mapping of L1/L2 but not the device-tree
> representation to match them. Which means that you need the ugly hack
> above. That is not goot. Fix your device-tree instead and do the same
> split in the tree for L1/L2 than you do in the code.

There is no option here.

> > +	picnode = find_mpc52xx_picnode();
> > +	sdmanode = find_mpc52xx_sdmanode();
> 
> Any reason why you have those inline 1-line functions and just not put
> the actual of_find_* call in here ?
> 
> You probably also need some of_node_put() in the error case. You are
> doing a whole bunch of "return" that bypass them.

I have done it because other platform may add their how type/compatible/way to find the node. For example, I did not find any bestcomm node in the recent lite5200 device-tree.

http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/024970.html

> The rest looks ok.
> 

;-)

> Please submit the io.h patch separately. Also, you may need to fix the
> default case (which is the one we are using) in there to work with
> CONFIG_PCI not set (by defining PCI_DRAM_BASE to 0 among others).
>

Sylvain was faster than me. :-)

Regards
