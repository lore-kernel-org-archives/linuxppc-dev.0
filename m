Return-Path: <simon.kagstrom@ericsson.com>
Received: from mailgw4.ericsson.se (mailgw4.ericsson.se [193.180.251.62])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96A87DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 01:51:22 +1100 (EST)
Date: Wed, 25 Mar 2009 15:51:13 +0100
From: Simon Kagstrom <simon.kagstrom@ericsson.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: of_serial and device trees
Message-ID: <20090325155113.52048fe0@seasc0532.dyn.rnd.as.sw.ericsson.se>
In-Reply-To: <20090324155545.GA24778@ld0162-tx32.am.freescale.net>
References: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>
	<20090324155545.GA24778@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott!

Thanks a lot for all your help with the device tree! As you suspected,
I'm writing for a fairly old kernel (2.6.21, WindRiver). I know, I know.

On Tue, 24 Mar 2009 10:55:45 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Add compatible = "simple-bus".  This lets children of this node be probed
> by of_platform drivers (make sure you list simple-bus when calling
> of_platform_bus_probe), and in a few other places (like legacy_serial.c).

Right, thanks. I've added this of_platform_bus_probe as an initcall,
and it now tries to configure the serial ports as expected (and with
some other issues).

> Compatible should be of the form "vendor,device" -- and does "isf"
> uniquely identify the specific FPGA logic, or are there other versions
> out there (or likely to exist in the future)?  Note that there are some
> bad examples in existing device trees that have yet to be fixed.

There are no other versions yet, but I suppose there will be (it's
implemented in a FPGA after all!). So what is the general handling of
versions, should it be something like

  compatible = "ericsson,isf-pic", "ericsson,isf-pic-v2"

etc if we'd make new revisions of the device?

> I'm guessing that your FPGA PIC driver isn't getting its register address
> from the device tree, given that it works without the ranges property?

It is, but I didn't check it for correctness yet, so I suppose I might
have mapped the wrong thing. The code looks like this:

        struct resource phys_addr;

        if (of_address_to_resource(np, 0, &phys_addr) != 0) {
                 printk(KERN_ERR": Could not get ISF PIC memory resource\n");
                 return NULL;
         }

	spin_lock_init(&isf->lock);
	isf->ioaddr = ioremap(phys_addr.start,
	                phys_addr.end - phys_addr.start);

So I should use the reg property and platform_get_resource() instead?

// Simon
