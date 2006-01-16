Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 784C8689C0
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 11:47:36 +1100 (EST)
Date: Mon, 16 Jan 2006 20:41:15 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@gate.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-ID: <20060116224115.GB17275@dmt.cnet>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, dave@cray.org, linux-kernel@vger.kernel.org,
	iinuxppc-embedded@gate.crashing.org, linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static unsigned long wdt_is_open;
> +static spinlock_t wdt_spinlock;
> +
> +static void mpc83xx_wdt_keepalive(void)
> +{
> +	/* Ping the WDT */
> +	spin_lock(&wdt_spinlock);
> +	out_be16(&wd_base->swsrr, 0x556c);
> +	out_be16(&wd_base->swsrr, 0xaa39);
> +	spin_unlock(&wdt_spinlock);
> +}
> +
> +static ssize_t mpc83xx_wdt_write(struct file * file, const char __user * buf,
> +				 size_t count, loff_t * ppos)
> +{
> +	if(count)
> +		mpc83xx_wdt_keepalive();
> +	return count;
> +}
> +
> +static int mpc83xx_wdt_open(struct inode * inode, struct file * file)
> +{
> +	u32 tmp = SWCRR_SWEN;
> +	if (test_and_set_bit(0, &wdt_is_open))
> +		return -EBUSY;

Hi Kumar,

What do you need the spinlock for if the device can't be opened 
by more than one process?
