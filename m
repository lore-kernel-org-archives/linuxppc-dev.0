Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C5B6E2C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2012 06:45:55 +1000 (EST)
Message-ID: <500F0978.7010201@freescale.com>
Date: Tue, 24 Jul 2012 15:45:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/p5040ds: Add support for P5040DS board
References: <1343148122-4584-1-git-send-email-timur@freescale.com>
 <500EE1BB.6060104@freescale.com>
In-Reply-To: <500EE1BB.6060104@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
>> > +	bus-range = <0x0 0xff>;

> Do we really need this?

I can't find any documentation for this property, but it does appear to be
initialized by U-Boot:

	/* We assume a cfg_addr not being set means we didn't setup the controller */
	if ((hose == NULL) || (hose->cfg_addr == NULL)) {
		fdt_del_node(blob, off);
	} else {
		bus_range[0] = 0;
		bus_range[1] = hose->last_busno - hose->first_busno;
		fdt_setprop(blob, off, "bus-range", &bus_range[0], 2*4);
		fdt_pci_dma_ranges(blob, off, hose);
	}

So I have no idea if it's required in the DTS.

>> > +	clock-frequency = <33333333>;

> I doubt this is accurate.

Every other DTS sets this property to 33333333, and I don't see any code
in U-boot that fixes it up.

-- 
Timur Tabi
Linux kernel developer at Freescale
