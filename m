Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C1BE1DDFFF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:22:00 +1000 (EST)
Message-ID: <470BAAA2.30400@freescale.com>
Date: Tue, 09 Oct 2007 11:21:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe: add function qe_clock_source
References: <1191945199488-git-send-email-timur@freescale.com>
	<B8D11E08-7AC5-4B21-9C40-1068B29B058B@kernel.crashing.org>
	<470BA5DF.5060206@freescale.com>
	<2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>
In-Reply-To: <2E830F97-ADAE-43CA-9BD3-BEBFEFBE1D5C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> is 19 the actual value you'd end up using from the HW? or is it related 
> to some random enum value?

Random enum value.  Here's the code in ucc_geth:

	prop = of_get_property(np, "rx-clock", NULL);
	ug_info->uf_info.rx_clock = *prop;


Here's the data type:

struct ucc_fast_info {
	int ucc_num;
	enum qe_clock rx_clock;
	enum qe_clock tx_clock;
	...

As you can see, it doesn't even validate the property.

My uart driver has this:

	rx-clock-source = "BRG5";
	tx-clock-source = "BRG6";


	sprop = of_get_property(np, "rx-clock-source", NULL);
	if (!sprop) {
		printk(KERN_ERR
		       "ucc-uart: missing rx-clock-source in device tree\n");
		kfree(qe_port);
		return -ENODEV;
	}

	qe_port->us_info.rx_clock = of_clock_source(sprop);
	if ((qe_port->us_info.rx_clock < QE_BRG1) ||
	    (qe_port->us_info.rx_clock > QE_BRG16)) {
		printk(KERN_ERR
		       "ucc-uart: rx-clock-source must be a BRG for UART\n");
		kfree(qe_port);
		return -ENODEV;
	}

I will be submitting patches to ucc_geth to fix this problem.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
