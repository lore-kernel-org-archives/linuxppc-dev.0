Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A1A8DDF5B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:53:07 +1000 (EST)
Message-ID: <4713551B.9040103@genesi-usa.com>
Date: Mon, 15 Oct 2007 12:55:07 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
In-Reply-To: <20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


My nits:

Grant Likely wrote:
> From: Sylvain Munaut <tnt@246tNt.com>
> +static int __devinit
> +bcom_engine_init(void)

Why "bcom" and not "bestcomm"?

> +	/* Disable COMM Bus Prefetch, apparently it's not reliable yet */
> +	/* FIXME: This should be done on 5200 and not 5200B ... */
> +	out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);

This really, really shouldn't even be here, could it be moved to a platform
init, or switched on a PVR/SVR here?

> +int bcom_sram_init(struct device_node *sram_node, char *owner)
> +{
> +	int rv;
> +	const u32 *regaddr_p;
> +	u64 regaddr64, size64;
> +	unsigned int psize;
> +
> +	/* Create our state struct */
> +	if (bcom_sram) {
> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Already initialiwed !\n", owner);
> +		return -EBUSY;
> +	}

initialised or initialized :)

> +		printk(KERN_ERR "%s: bcom_sram_init: "
> +			"Couln't request region !\n", owner);
> +		rv = -EBUSY;
> +		goto error_free;

Couldn't or could not.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
