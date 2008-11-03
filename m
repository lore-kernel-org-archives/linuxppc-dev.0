Return-Path: <ben@fluff.org.uk>
Received: from kira.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73709DDDF3
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 12:08:52 +1100 (EST)
Date: Mon, 3 Nov 2008 00:23:28 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Mike Ditto <mditto@consentry.com>
Subject: Re: [PATCH] i2c-cpm: Detect and report NAK right away instead of
	timing out.
Message-ID: <20081103002328.GC30438@fluff.org.uk>
References: <490BA2E5.8010309@consentry.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <490BA2E5.8010309@consentry.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 05:29:25PM -0700, Mike Ditto wrote:
> Make the driver report an ENXIO error immediately upon NAK instead of
> waiting for another interrupt and getting a timeout.
> 
> Signed-off-by: Mike Ditto <mditto@consentry.com>
> ---
> When reading from a device that is not present or declines to respond
> to, e.g., a non-existent register address, CPM immediately reports a
> NAK condition in the TxBD, but the driver kept waiting until a timeout,
> which takes 1 second and causes an ugly console error message.

hmm, that block of text could probably go into the patch description.

It looks ok, I'll merge and push out to linus with the s3c fixes.
 
> Index: linux/drivers/i2c/busses/i2c-cpm.c
> ===================================================================
> retrieving revision 1.3
> diff -u -p -r1.3 i2c-cpm.c
> --- linux/drivers/i2c/busses/i2c-cpm.c	31 Oct 2008 06:36:08 -0000	1.3
> +++ linux/drivers/i2c/busses/i2c-cpm.c	1 Nov 2008 00:12:45 -0000
> @@ -369,6 +369,7 @@ static int cpm_i2c_xfer(struct i2c_adapt
>  		pmsg = &msgs[tptr];
>  		if (pmsg->flags & I2C_M_RD)
>  			ret = wait_event_interruptible_timeout(cpm->i2c_wait,
> +				(in_be16(&tbdf[tptr].cbd_sc) & BD_SC_NAK) ||
>  				!(in_be16(&rbdf[rptr].cbd_sc) & BD_SC_EMPTY),
>  				1 * HZ);
>  		else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
