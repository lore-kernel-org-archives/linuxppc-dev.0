Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90642DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 03:39:58 +1100 (EST)
Message-ID: <49CA5E45.9070300@freescale.com>
Date: Wed, 25 Mar 2009 11:39:33 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Simon Kagstrom <simon.kagstrom@ericsson.com>
Subject: Re: of_serial and device trees
References: <20090324094959.447a3a31@seasc0532.dyn.rnd.as.sw.ericsson.se>	<20090324155545.GA24778@ld0162-tx32.am.freescale.net>
	<20090325155113.52048fe0@seasc0532.dyn.rnd.as.sw.ericsson.se>
In-Reply-To: <20090325155113.52048fe0@seasc0532.dyn.rnd.as.sw.ericsson.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Kagstrom wrote:
> There are no other versions yet, but I suppose there will be (it's
> implemented in a FPGA after all!). So what is the general handling of
> versions, should it be something like
> 
>   compatible = "ericsson,isf-pic", "ericsson,isf-pic-v2"
> 
> etc if we'd make new revisions of the device?

Looks good.

>> I'm guessing that your FPGA PIC driver isn't getting its register address
>> from the device tree, given that it works without the ranges property?
> 
> It is, but I didn't check it for correctness yet, so I suppose I might
> have mapped the wrong thing. The code looks like this:
> 
>         struct resource phys_addr;
> 
>         if (of_address_to_resource(np, 0, &phys_addr) != 0) {
>                  printk(KERN_ERR": Could not get ISF PIC memory resource\n");
>                  return NULL;
>          }
> 
> 	spin_lock_init(&isf->lock);
> 	isf->ioaddr = ioremap(phys_addr.start,
> 	                phys_addr.end - phys_addr.start);

That looks good -- I'd have expected of_address_to_resource to fail, 
though, when the ranges property was missing.  The kernel's device tree 
parsing code can sometimes be overly tolerant of broken device trees, 
which is probably what happened.

-Scott
