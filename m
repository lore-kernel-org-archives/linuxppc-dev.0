Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 3941FDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 08:44:07 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so275572rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 15:44:05 -0700 (PDT)
Message-ID: <9e4733910710241544p673b3f7dnc0c8accf191b4bbd@mail.gmail.com>
Date: Wed, 24 Oct 2007 18:44:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: Tjernlund <tjernlund@tjernlund.se>
Subject: Re: i2c-mpc.c driver issues
In-Reply-To: <019001c81681$b5d449c0$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <019001c81681$b5d449c0$5267a8c0@Jocke>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Tjernlund <tjernlund@tjernlund.se> wrote:
> While browsing the i2c-mpc.c driver I noticed some things that look odd
> to me so I figured I report them. Could not find a maintainer in the MAINTANERS file
> so I sent here, cc:ed linuxppc-dev as well.

There appear to be more issues with this driver. It is still
registering as platform driver instead of a of_platform driver.

On the mpc5200 the probe function for platform drivers is not getting
called, so fsl_i2c_probe never gets called.  It's not clear to me that
this driver is functioning on the mpc5200.

> 1) There are a lot of return -1 error code that is propagated back to
>    userspace. Should be changed to proper -Exxx codes.
>
> 2) mpc_read(), according to the comment below it sends a STOP condition here but
>    this function does not known if this is the last read or not. mpc_xfer is
>    the one that knows when the transaction is over and should send the stop, which it already
>    does.
>
>  /* Generate stop on last byte */
>   if (i == length - 1)
>        writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
>
>  Jocke
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
