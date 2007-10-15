Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DE254DE1EC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 02:32:19 +1000 (EST)
Date: Mon, 15 Oct 2007 09:32:16 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Message-ID: <20071015163216.GA8127@gate.ebshome.net>
References: <200710151529.11485.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200710151529.11485.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 03:29:11PM +0200, Stefan Roese wrote:

<snip>

> +#ifdef CONFIG_PPC_MERGE
> +static int device_idx = -1;
> +#endif
> +

<snip>

> +	dev->idx = ++device_idx;
> +	adap->nr = dev->idx;

Hmm, this doesn't look right. That mighty powerpc device everybody 
was so excited about for the last years doesn't provide a device 
instance number/index?

I think this approach is wrong, because I want i2c bus numbers for the 
on-chip i2c to be fixed. This code makes it dependent on the order 
devices were described in the device tree; how do you handle a 
situation when only the second i2c adapter is connected? For OCP I 
would just remove ocp_def for the IIC0.

-- 
Eugene
