Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-105-friday.noc.nerim.net [62.4.17.105])
	by ozlabs.org (Postfix) with ESMTP id 9478FDDE26
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 19:53:32 +1000 (EST)
Date: Fri, 26 Oct 2007 11:53:29 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Tjernlund" <tjernlund@tjernlund.se>
Subject: Re: [i2c] i2c-mpc.c driver issues
Message-ID: <20071026115329.0307e207@hyperion.delvare>
In-Reply-To: <019001c81681$b5d449c0$5267a8c0@Jocke>
References: <019001c81681$b5d449c0$5267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jocke,

On Wed, 24 Oct 2007 23:06:13 +0200, Tjernlund wrote:
> While browsing the i2c-mpc.c driver I noticed some things that look odd
> to me so I figured I report them. Could not find a maintainer in the MAINTANERS file
> so I sent here, cc:ed linuxppc-dev as well.
> 
> 1) There are a lot of return -1 error code that is propagated back to
>    userspace. Should be changed to proper -Exxx codes.

This is true of many Linux i2c bus drivers, unfortunately. While nothing
actually prevents drivers from returning -1 to userspace on error,
meaningful error codes would of course be preferred.

> 2) mpc_read(), according to the comment below it sends a STOP condition here but
>    this function does not known if this is the last read or not. mpc_xfer is
>    the one that knows when the transaction is over and should send the stop, which it already
>    does.
> 
>  /* Generate stop on last byte */
>   if (i == length - 1)
>        writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);

Probably correct, although I am not familiar with this specific
hardware. I guess that the same is true of mpc_write as well, which is
even worse because write + read combined transactions are very common
(while read + write are not.)

I'm not completely sure that mpc_xfer sends the stop. mpc_i2c_stop
doesn't seem to do much.

Now that you've identified these bugs, what about sending patches
to fix them?

-- 
Jean Delvare
